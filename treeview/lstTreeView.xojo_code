#tag Class
Protected Class lstTreeView
Inherits DesktopListBox
	#tag Event
		Function CellPressed(row As Integer, column As Integer, x As Integer, y As Integer) As Boolean
		  #Pragma unused x
		  #Pragma unused y
		  #Pragma unused column
		  
		  If (row >= 0) And (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    OnExpandCollapseAll_Recursive(CTreeItem(Me.RowTag(row)).TreeMain, CTreeItem(Me.RowTag(row)).PosItem)
		  End If
		  
		End Function
	#tag EndEvent

	#tag Event
		Function ConstructContextualMenu(base As DesktopMenuItem, x As Integer, y As Integer) As Boolean
		  'select appropriate row
		  eiRowMousePos = Me.RowFromXY(x, y)
		  If (eiRowMousePos >= 0) Then
		    Me.SelectedRowIndex = eiRowMousePos
		  End If
		  
		  'only show menu if entries are available
		  If (oTreeStructure <> Nil) And (oTreeStructure.Count > 0) And (Me.RowCount > 0) Then
		    'if clicked on a choice: possible sub-menu
		    Var bItemIsSelected As Boolean = False
		    Var bItemIsSelectedAndHasNoSubtree As Boolean = False
		    Var bItemIsExpanded As Boolean = False
		    If (eiRowMousePos >= 0) And (Me.SelectedRowIndex >= 0) And (Me.RowTag(Me.SelectedRowIndex) <> Nil) And (Me.RowTag(Me.SelectedRowIndex) IsA CTreeItem) Then
		      bItemIsSelected = True
		      bItemIsSelectedAndHasNoSubtree = (CTreeItem(Me.RowTag(Me.SelectedRowIndex)).TreeSub = Nil)
		      bItemIsExpanded = CTreeItem(Me.RowTag(Me.SelectedRowIndex)).Expanded
		      Var oChangeMenu As DesktopMenuItem = OnRequestStatusChangeMenu(CTreeItem(Me.RowTag(Me.SelectedRowIndex)).TreeMain, CTreeItem(Me.RowTag(Me.SelectedRowIndex)).PosItem, CTreeItem(Me.RowTag(Me.SelectedRowIndex)).Status, CTreeItem(Me.RowTag(Me.SelectedRowIndex)).Data)
		      If (oChangeMenu <> Nil) And (oChangeMenu.Count > 0) Then
		        Var iPos As Integer
		        For iPos = 0 To oChangeMenu.Count - 1
		          //Linux und Cocoa: via MenuItem.Clone
		          #If TargetMacOS Or TargetLinux  Then
		            base.AddMenu(oChangeMenu.MenuAt(iPos).Clone)
		          #Else
		            base.AddMenu(oChangeMenu.MenuAt(iPos))
		          #EndIf
		        Next
		        
		        Var oSeparator As New DesktopMenuItem
		        oSeparator.Name = "mnuSeparator"
		        oSeparator.Text = "-"
		        base.AddMenu(oSeparator)
		      End If
		    End If
		    
		    'Default Menu Entries
		    If bItemIsSelected And (Not bItemIsSelectedAndHasNoSubtree) Then
		      Var oExpandItem As New DesktopMenuItem
		      oExpandItem.Text = Me.constCaption_ExpandItem
		      oExpandItem.Name = "mnuExpandItem"
		      oExpandItem.Enabled = (Not bItemIsExpanded)
		      base.AddMenu(oExpandItem)
		      
		      Var oCollapseItem As New DesktopMenuItem
		      oCollapseItem.Text = Me.constCaption_CollapseItem
		      oCollapseItem.Name = "mnuCollapseItem"
		      oCollapseItem.Enabled = bItemIsExpanded
		      base.AddMenu(oCollapseItem)
		      
		      Var oSeparatorItem As New DesktopMenuItem
		      oSeparatorItem.Name = "mnuSeparatorItem"
		      oSeparatorItem.Text = "-"
		      base.AddMenu(oSeparatorItem)
		    End If
		    
		    For i As Integer = 0 To oTreeStructure.Last
		      If (oTreeStructure.SubList(i) = Nil) Then Continue
		      
		      'at least 1 Sub-Liste available
		      Var oExpandAll As New DesktopMenuItem
		      oExpandAll.Text = Me.constCaption_ExpandAll
		      oExpandAll.Name = "mnuExpandAll"
		      base.AddMenu(oExpandAll)
		      
		      Var oCollapseAll As New DesktopMenuItem
		      oCollapseAll.Text = Me.constCaption_CollapseAll
		      oCollapseAll.Name = "mnuCollapseAll"
		      base.AddMenu(oCollapseAll)
		      
		      Exit
		    Next
		    
		    Return True
		  End If
		  
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuItemSelected(selectedItem As DesktopMenuItem) As Boolean
		  If (selectedItem <> Nil) Then
		    Var iExpandRow As Integer = -1
		    Var sCurrentKey As String
		    If (eiRowMousePos >= 0) And (Me.SelectedRowIndex >= 0) And (eiRowMousePos = Me.SelectedRowIndex) Then
		      iExpandRow = eiRowMousePos
		    End If
		    
		    If (Me.SelectedRowIndex >= 0) And (Me.RowTag(Me.SelectedRowIndex) <> Nil) And (Me.RowTag(Me.SelectedRowIndex) IsA CTreeItem) Then
		      sCurrentKey = CTreeItem(Me.RowTag(Me.SelectedRowIndex)).Key
		    End If
		    
		    Select Case selectedItem.Name
		    Case "mnuExpandAll"
		      Self.ExpandCollapseAll(-1, True)
		      If (sCurrentKey <> "") Then Self.Sel_Key_InCurrentView = sCurrentKey
		    Case "mnuCollapseAll"
		      Self.ExpandCollapseAll(-1, False)
		      If (sCurrentKey <> "") Then Self.Sel_Key_InCurrentView = sCurrentKey
		    Case "mnuExpandItem"
		      Self.ExpandCollapseAll(iExpandRow, True)
		      If (sCurrentKey <> "") Then Self.Sel_Key_InCurrentView = sCurrentKey
		    Case "mnuCollapseItem"
		      Self.ExpandCollapseAll(iExpandRow, False)
		      If (sCurrentKey <> "") Then Self.Sel_Key_InCurrentView = sCurrentKey
		    Else
		      Var sKey As String = OnRequestStatusChangeMenuActionKey(selectedItem.Name)
		      If Self.Do_KeyDown(sKey, Me.SelectedRowIndex) Then
		      End If
		    End Select
		    
		    Return True
		  End If
		  Return False
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub DoublePressed()
		  If OnDoubleClick Then Return
		  
		  If (Me.SelectedRowIndex >= 0) And (Me.RowTag(Me.SelectedRowIndex) <> Nil) And (Me.RowTag(Me.SelectedRowIndex) IsA CTreeItem) Then
		    Self.Data_RequestChange(Me.SelectedRowIndex, CTreeItem(Me.RowTag(Me.SelectedRowIndex)).TreeMain, CTreeItem(Me.RowTag(Me.SelectedRowIndex)).PosItem, CTreeItem(Me.RowTag(Me.SelectedRowIndex)).Status, "", CTreeItem(Me.RowTag(Me.SelectedRowIndex)).Data)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function DragOver(x As Integer, y As Integer, obj As DragItem, action As DragItem.Types) As Boolean
		  Var row As Integer = Me.RowFromXY(x, y)
		  If (row < Me.RowCount) And (row >= 0) And (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    Return OnDragOver(CTreeItem(Me.RowTag(row)).TreeMain, CTreeItem(Me.RowTag(row)).PosItem, obj, action)
		  End If
		  
		  'don't allow
		  Return True
		End Function
	#tag EndEvent

	#tag Event
		Function DragReorderRows(newPosition as Integer, parentRow as Integer) As Boolean
		  #Pragma unused parentRow
		  
		  If (eoDragTreeItem = Nil) Or (eiDragTreePos < 0) Then Return False
		  
		  If (newPosition < Me.RowCount) And (newPosition >= 0) And (Me.RowTag(newPosition) <> Nil) And (Me.RowTag(newPosition) IsA CTreeItem) Then
		    Return OnDragReorderRow(CTreeItem(Me.RowTag(newPosition)).TreeMain, CTreeItem(Me.RowTag(newPosition)).PosItem, eoDragTreeItem, eiDragTreePos)
		  End If
		  
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Function DragRow(drag As DragItem, row As Integer) As Boolean
		  eoDragTreeItem = Nil
		  eiDragTreePos = -1
		  If (row < Me.RowCount) And (row >= 0) And (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    'trigger Event OnChance manually
		    OnChange(CTreeItem(Me.RowTag(row)).TreeMain, CTreeItem(Me.RowTag(row)).PosItem)
		    If OnDragRow(CTreeItem(Me.RowTag(row)).TreeMain, CTreeItem(Me.RowTag(row)).PosItem, drag) Then
		      eoDragTreeItem = CTreeItem(Me.RowTag(row)).TreeMain
		      eiDragTreePos = CTreeItem(Me.RowTag(row)).PosItem
		      Return True
		    Else
		      Return False
		    End If
		  End If
		  
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Function KeyDown(key As String) As Boolean
		  Var iRow As Integer = Me.SelectedRowIndex
		  
		  If Do_KeyDown(Key, iRow) Then Return True
		  
		  If OnKeyDown(Key) Then Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening()
		  Me.AllowExpandableRows = True
		  
		  Self.Init_Columns
		End Sub
	#tag EndEvent

	#tag Event
		Function PaintCellBackground(g As Graphics, row As Integer, column As Integer) As Boolean
		  #Pragma unused column
		  
		  Return Self.Draw_CellBackground(g, row)
		End Function
	#tag EndEvent

	#tag Event
		Function PaintCellText(g as Graphics, row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  Return Self.Draw_CellText(g, row, column, x, y)
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub RowCollapsed(row As Integer)
		  If (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    
		    CTreeItem(Me.RowTag(row)).Expanded = False
		    
		    Var oTree As CTreeListedValues = CTreeItem(Me.RowTag(row)).TreeMain
		    If (oTree = Nil) Or (CTreeItem(Me.RowTag(row)).PosItem < 0) Then Return
		    oTree.Expanded(CTreeItem(Me.RowTag(row)).PosItem) = False
		    
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub RowExpanded(row As Integer)
		  If (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    
		    CTreeItem(Me.RowTag(row)).Expanded = True
		    
		    Var oTree As CTreeListedValues = CTreeItem(Me.RowTag(row)).TreeMain
		    If (oTree = Nil) Or (CTreeItem(Me.RowTag(row)).PosItem < 0) Then Return
		    oTree.Expanded(CTreeItem(Me.RowTag(row)).PosItem) = True
		    oTree = CTreeItem(Me.RowTag(row)).TreeSub
		    If (oTree = Nil) Or (oTree.Count < 1) Then Return
		    
		    For iPos As Integer = 0 To oTree.Last
		      Self.Data_Show_Entry(oTree, iPos, CTreeItem(Me.RowTag(row)).Level + 1, CTreeItem(Me.RowTag(row)).Caption, CTreeItem(Me.RowTag(row)).PosItem)
		    Next
		    
		  End If
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub SelectionChanged()
		  Var row As Integer = Me.SelectedRowIndex
		  
		  If (row < Me.RowCount) And (row >= 0) And (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    OnChange(CTreeItem(Me.RowTag(row)).TreeMain, CTreeItem(Me.RowTag(row)).PosItem)
		  End If
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Data_BackgroundColors(pdictColors As Dictionary)
		  '============================================================
		  '
		  ' Status Colors
		  '
		  '============================================================
		  
		  eacColors = pdictColors
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_Clear(pbKeepTreeStructure As Boolean = false)
		  '============================================================
		  '
		  ' Delete all Rows
		  '
		  '============================================================
		  
		  If (Not pbKeepTreeStructure) Then
		    Me.eoDragTreeItem = Nil
		    Me.oTreeStructure = Nil
		  End If
		  
		  Me.RemoveAllRows
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_Init(pbShowHints As Boolean = true)
		  '============================================================
		  '
		  ' Init ListBox and Tree
		  '
		  '============================================================
		  
		  ebShowHints = pbShowHints
		  Self.Init_Columns
		  
		  If (Me.oTreeStructure = Nil) Then
		    Me.Data_Clear
		    Return
		  End If
		  
		  For iPos As Integer = 0 To Me.oTreeStructure.Last
		    Me.Data_Show_Entry(Me.oTreeStructure, iPos, 1, "", -1)
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Data_PosOfKey(psKey As String) As Integer
		  If (psKey = "") Then Return -1
		  
		  If (Me.RowCount < 1) Then Return -1
		  
		  For i As Integer = (Me.RowCount - 1) DownTo 0
		    If (Not (Me.RowTag(i) IsA CTreeItem)) Then Continue
		    If (CTreeItem(Me.RowTag(i)).Key = psKey) Then
		      Return i
		    End If
		  Next
		  
		  Return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_RefreshEntry(poTree As CTreeListedValues, piPos As Integer, piRow As Integer = - 1)
		  '============================================================
		  '
		  ' Refresh Entry (after Event RequestChange)
		  '
		  '============================================================
		  
		  If (poTree = Nil) Or (Me.RowCount < 1) Then Return
		  
		  Var vKey As Variant = poTree.Key(piPos)
		  
		  If (piRow >= 0) Then
		    'update given row
		    If (Me.RowTag(piRow) <> Nil) And (Me.RowTag(piRow) IsA CTreeItem) And (CTreeItem(Me.RowTag(piRow)).Key = vKey) Then
		      Me.Data_Show_Entry(poTree, piPos, CTreeItem(Me.RowTag(piRow)).Level, CTreeItem(Me.RowTag(piRow)).ParentName, CTreeItem(Me.RowTag(piRow)).PosParent, piRow)
		    End If
		    Return
		  End If
		  
		  'otherwise: search entry
		  For iRowPos As Integer = 0 To Me.RowCount - 1
		    If (Me.RowTag(iRowPos) <> Nil) And (Me.RowTag(iRowPos) IsA CTreeItem) And (CTreeItem(Me.RowTag(iRowPos)).Key = vKey) Then
		      Me.Data_Show_Entry(poTree, piPos, CTreeItem(Me.RowTag(iRowPos)).Level, CTreeItem(Me.RowTag(iRowPos)).ParentName, CTreeItem(Me.RowTag(iRowPos)).PosParent, irowPos)
		    End If
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Data_RequestChange(piRow As Integer, poTreeList As CTreeListedValues, piPos As Integer, piCurrentStatus As Integer = - 1, psKeyPressed As String = "", pvData As Variant = nil)
		  '============================================================
		  '
		  ' Request Status Change by User
		  '
		  '============================================================
		  
		  Var bNeedRefresh As Boolean = True
		  OnRequestStatusChange(poTreeList, piPos, bNeedRefresh, piCurrentStatus, psKeyPressed, pvData)
		  
		  If bNeedRefresh Then
		    Me.Data_RefreshEntry(poTreeList, piPos, piRow)
		    OnAfterRequestStatusChange
		  End If
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Data_Show_Entry(poTree As CTreeListedValues, piPos As Integer, piLevel As Integer, psParentName As String, piParentPos As Integer, piUpdateRow As Integer = - 1)
		  '============================================================
		  '
		  ' Show an Entry/Row
		  '
		  '============================================================
		  
		  If (poTree = Nil) Or (piPos < 0) Then Return
		  If (piUpdateRow >= 0) And (Me.RowCount <= piUpdateRow) Then Return
		  
		  Var oTreeItem As New CTreeItem
		  oTreeItem.TreeMain = poTree
		  oTreeItem.PosItem = piPos
		  
		  oTreeItem.TreeSub = poTree.SubList(piPos)
		  
		  oTreeItem.ParentName = psParentName
		  oTreeItem.PosParent = piParentPos
		  
		  oTreeItem.Caption = poTree.Name(piPos)
		  oTreeItem.Hint = poTree.Hint(piPos)
		  oTreeItem.Key = poTree.Key(piPos)
		  oTreeItem.Level = piLevel
		  oTreeItem.Status = poTree.Status(piPos)
		  oTreeItem.Expanded = poTree.Expanded(piPos)
		  oTreeItem.Data = poTree.Data(piPos)
		  
		  If (piUpdateRow < 0) Then
		    If (poTree.SubList(piPos) <> Nil) Then
		      'Neuer Level
		      Me.AddExpandableRow ""
		      piUpdateRow = Me.LastAddedRowIndex
		    Else
		      'Neue Zeile
		      Me.AddRow ""
		      piUpdateRow = Me.LastAddedRowIndex
		    End If
		  End If
		  
		  If (eaoStatusPictures <> Nil) And eaoStatusPictures.HasKey(oTreeItem.Status) Then
		    Me.RowImageAt(piUpdateRow) = eaoStatusPictures.Lookup(oTreeItem.Status, Nil)
		  Else
		    Me.RowImageAt(piUpdateRow) = Nil
		  End If
		  
		  Me.CellTextAt(piUpdateRow, constCol_Caption) = oTreeItem.Caption
		  Me.CellTextAt(piUpdateRow, constCol_Hint) = oTreeItem.Hint
		  Me.RowTag(piUpdateRow) = oTreeItem
		  Me.RowExpandedAt(piUpdateRow) = oTreeItem.Expanded
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_StatusColors(pdictColors As Dictionary, pbTextColorOnlyForHint As Boolean)
		  '============================================================
		  '
		  ' Status Colors
		  '
		  '============================================================
		  
		  eacColors = pdictColors
		  ebTextColorOnlyForHint = pbTextColorOnlyForHint
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_StatusColorsBackground(pdictColorsBackground As Dictionary)
		  '============================================================
		  '
		  ' Status Colors
		  '
		  '============================================================
		  
		  eacColorsBackground = pdictColorsBackground
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_StatusIcons(pdictPictures As Dictionary, piOffsetX As Integer = 1)
		  '============================================================
		  '
		  ' Status Icons
		  '
		  '============================================================
		  
		  eaoStatusPictures = pdictPictures
		  eiOffsetXIcon = piOffsetX
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_StatusTextStyle(pdictTextStyles As Dictionary)
		  '============================================================
		  '
		  ' Text-Format for Status
		  '
		  '============================================================
		  
		  eaoStatusTextStyle = pdictTextStyles
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Data_TreeStructure() As CTreeListedValues
		  '============================================================
		  '
		  ' Return Tree
		  '
		  '============================================================
		  
		  Return Me.oTreeStructure
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_TreeStructure(Assigns oTree As CTreeListedValues)
		  '============================================================
		  '
		  ' Assign Tree
		  '
		  '============================================================
		  
		  Me.oTreeStructure = oTree
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  eacColors = Nil
		  eacColorsBackground = Nil
		  eaoStatusPictures = Nil
		  eaoStatusTextStyle = Nil
		  eoDragTreeItem = Nil
		  oTreeStructure = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Do_KeyDown(Key As String, iRow As Integer) As Boolean
		  '============================================================
		  '
		  ' Event: OnKeyDown
		  '
		  '============================================================
		  
		  If (Key = "") Then Return True
		  
		  If (iRow >= 0) And (Me.RowTag(iRow) <> Nil) And (Me.RowTag(iRow) IsA CTreeItem) Then
		    Var bChangeStatus As Boolean = False
		    
		    'Left
		    If (Key.AscByte = 28) Then
		      If (CTreeItem(Me.RowTag(iRow)).TreeSub <> Nil) Then
		        Me.RowExpandedAt(iRow) = False
		        Return True
		      End If
		    End If
		    
		    'Right
		    If (Key.AscByte = 29) Then
		      If (CTreeItem(Me.RowTag(iRow)).TreeSub <> Nil) Then
		        Me.RowExpandedAt(iRow) = True
		        Return True
		      End If
		    End If
		    
		    'Status Change
		    If (Me.KeyDown_IsEnter(Me, Key)) Then
		      bChangeStatus = True
		    End If
		    
		    'A-Z, 0-9
		    Var chars As String = "abcdefghijklmnopqrstuvwxyz01234567890 "
		    If (Not bChangeStatus) And (chars.IndexOf(Key) > 0) Then
		      bChangeStatus = True
		    End If
		    
		    
		    If bChangeStatus Then
		      Self.Data_RequestChange(iRow, CTreeItem(Me.RowTag(iRow)).TreeMain, CTreeItem(Me.RowTag(iRow)).PosItem, CTreeItem(Me.RowTag(iRow)).Status, Key, CTreeItem(Me.RowTag(iRow)).Data)
		      Return True
		    End If
		    
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Draw_CellBackground(g As Graphics, row As Integer) As Boolean
		  '============================================================
		  '
		  ' Draw Row Background
		  '
		  '============================================================
		  
		  ' No List Entry
		  If (row >= Me.RowCount) Then Return False
		  
		  ' Selection
		  If (row = Me.SelectedRowIndex) Then
		    #If TargetMacOS Then
		      'Let Xojo draw the default Selection Background
		      Return False
		    #Else
		      'At least on Windows, Xojo doesn't draw the whole row with a background selection
		      'so we do that here ourselves. Should be improved with Declares to get the correct
		      'colors for the state 'window is not active'...
		      g.DrawingColor = If(Self.Active, Color.HighlightColor, If(Color.IsDarkMode, &c242424, &cC9C5BB))
		      g.FillRectangle(0, 0, g.width, g.height)
		      Return True
		    #EndIf
		  End If
		  
		  If (Me.Enabled = False) Then
		    g.DrawingColor = Color.FillColor
		    g.FillRectangle(0, 0, g.width, g.height)
		    Return True
		  End If
		  
		  If (row < Me.RowCount) And (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    If (eacColorsBackground <> Nil) And eacColorsBackground.HasKey(CTreeItem(Me.RowTag(row)).Status) Then
		      If eacColors.HasKey(CTreeItem(Me.RowTag(row)).Status) Then
		        g.DrawingColor = eacColorsBackground.Value(CTreeItem(Me.RowTag(row)).Status)
		        g.FillRectangle(0, 0, g.width, g.height)
		      End If
		      Return True
		    End If
		  End If
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Draw_CellText(g As Graphics, row As Integer, column As Integer, x As Integer, y As Integer) As Boolean
		  '============================================================
		  '
		  ' Draw Cell Text
		  '
		  '============================================================
		  
		  ' No List Entry
		  If (row >= Me.RowCount) Then Return False
		  
		  If (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    g.Bold = False
		    g.Italic = False
		    g.Underline = False
		    If (eaoStatusTextStyle <> Nil) And eaoStatusTextStyle.HasKey(CTreeItem(Me.RowTag(row)).Status) Then
		      Select Case eaoStatusTextStyle.Lookup(CTreeItem(Me.RowTag(row)).Status, Me.constTreeView_TextFormat_Normal)
		      Case Me.constTreeView_TextFormat_Italic
		        g.Italic = True
		      Case Me.constTreeView_TextFormat_Bold
		        g.Bold = True
		      Case Me.constTreeView_TextFormat_BoldItalic
		        g.Bold = True
		        g.Italic = True
		      End Select
		    End If
		    
		    ' Selection
		    If (row = Me.SelectedRowIndex) And (Me.Enabled) Then
		      g.DrawingColor = &cFFFFFF
		    Else
		      If (eacColors <> Nil) And eacColors.HasKey(CTreeItem(Me.RowTag(row)).Status) Then
		        g.DrawingColor = eacColors.Lookup(CTreeItem(Me.RowTag(row)).Status, Color.TextColor)
		      Else
		        g.DrawingColor = Color.TextColor
		      End If
		    End If
		    
		    If (ebTextColorOnlyForHint And (column <> Me.constCol_Hint)) Then
		      ' Selection
		      If (row = Me.SelectedRowIndex) And (Me.Enabled) Then
		        g.DrawingColor = &cffffff
		      Else
		        g.DrawingColor = Color.TextColor
		      End If
		    End If
		    
		    
		    Var iOffset As Integer = x
		    If (column = Me.constCol_Caption) And (Me.RowImageAt(row) <> Nil) Then
		      iOffset = iOffset + eiOffsetXIcon 'Offset Icon - Text
		    End If
		    Var sText As String = Me.CellTextAt(row, column).ReplaceLineEndings(" ")
		    g.DrawText(sText, iOffset, y, g.Width, True)
		    Return True
		    
		  End If
		  
		  Return False
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExpandCollapseAll(piRow As Integer = - 1, pbExpand As Boolean = true)
		  '============================================================
		  '
		  ' Expand/Collape all
		  '
		  '============================================================
		  
		  If (oTreeStructure = Nil) Then Return
		  If (oTreeStructure.Count < 0) Then Return
		  
		  Var oExpandTree As CTreeListedValues = oTreeStructure
		  If (piRow >= 0) And (piRow <= (Me.RowCount - 1)) Then
		    If (Me.RowTag(piRow) <> Nil) And (Me.RowTag(piRow) IsA CTreeItem) Then
		      'expand this entry
		      oExpandTree = CTreeItem(Me.RowTag(piRow)).TreeMain
		      If (oExpandTree.SubList(CTreeItem(Me.RowTag(piRow)).PosItem) <> Nil) Then
		        oExpandTree.Expanded(CTreeItem(Me.RowTag(piRow)).PosItem) = pbExpand
		      End If
		      'Sub-Tree recursive
		      oExpandTree = oExpandTree.SubList(CTreeItem(Me.RowTag(piRow)).PosItem)
		    End If
		  End If
		  
		  Me.ExpandCollapseAll_Recursive(oExpandTree, pbExpand)
		  Me.Data_Clear(True)
		  Me.Data_Init(ebShowHints)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExpandCollapseAll_Recursive(poTree As CTreeListedValues, pbExpand As Boolean)
		  '============================================================
		  '
		  ' Expand/Collape all
		  '
		  '============================================================
		  
		  If (poTree = Nil) Then Return
		  If (poTree.Count < 1) Then Return
		  
		  For iPos As Integer = 0 To poTree.Last
		    If (poTree.SubList(iPos) <> Nil) Then
		      poTree.Expanded(iPos) = pbExpand
		      Me.ExpandCollapseAll_Recursive(poTree.SubList(iPos), pbExpand)
		    End If
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCollapsedKeys() As String()
		  Var aKeys() As String
		  If (Me.RowCount < 1) Then Return aKeys
		  
		  For i As Integer = (Me.RowCount - 1) DownTo 0
		    
		    If (Not (Me.RowTag(i) IsA CTreeItem)) Then Continue
		    If (Not CTreeItem(Me.RowTag(i)).Expanded) And (CTreeItem(Me.RowTag(i)).TreeSub <> Nil) Then
		      aKeys.Add(CTreeItem(Me.RowTag(i)).Key)
		    End If
		    
		  Next
		  
		  Return aKeys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Init_Columns()
		  '============================================================
		  '
		  ' Init ListBox with 2/3 Columns
		  '
		  '============================================================
		  
		  Me.ColumnCount = 3
		  If ebShowHints Then
		    #If TargetWindows Then
		      Me.ColumnWidths = "60%, 40%, 0"
		    #Else
		      Me.ColumnWidths = "50%, 50%, 0"
		    #EndIf
		  Else
		    Me.ColumnWidths = "100%, 0, 0"
		  End If
		  
		  Me.ColumnTypeAt(constCol_Caption) = DesktopListbox.CellTypes.Normal
		  If ebShowHints Then Me.ColumnTypeAt(constCol_Hint) = DesktopListbox.CellTypes.Normal
		  Me.ColumnTypeAt(constCol_Key) = DesktopListbox.CellTypes.Normal
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function KeyDown_IsEnter(poControl As DesktopUIControl, psKey As String) As Boolean
		  '============================================================
		  '
		  ' Enter or Return pressed
		  '
		  '============================================================
		  #Pragma unused poControl
		  
		  #If TargetMacOS Then
		    
		    If (psKey.AscByte = 13) Or (psKey.AscByte = 3) Then
		      Return True
		    End If
		    
		  #Else
		    'Enter or Return
		    If (psKey <> "") And (Keyboard.AsyncKeyDown(&h4C) Or Keyboard.AsyncKeyDown(&h24)) Then
		      Return True
		    End If
		    
		  #EndIf
		  
		  Return False
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function RowTag(piRow As Integer) As Variant
		  '============================================================
		  '
		  ' RowTag (TreeItem)
		  '
		  '============================================================
		  
		  If (Me.RowCount < (piRow + 1)) Then Return Nil
		  
		  If (Me.CellTagAt(piRow, constCol_Key) <> Nil) And (Me.CellTagAt(piRow, constCol_Key) IsA CTreeItem) Then
		    Return Me.CellTagAt(piRow, constCol_Key)
		  Else
		    Return Nil
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub RowTag(piRow As Integer, Assigns poTreeItem As CTreeItem)
		  '============================================================
		  '
		  ' RowTag (TreeItem)
		  '
		  '============================================================
		  
		  Me.CellTagAt(piRow, constCol_Key) = poTreeItem
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sel_Key() As String
		  If (Me.SelectedRowIndex = -1) Then Return ""
		  If Not (Me.RowTag(Me.SelectedRowIndex) IsA CTreeItem) Then Return ""
		  
		  Return CTreeItem(Me.RowTag(Me.SelectedRowIndex)).Key
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sel_Key_InCurrentView(Assigns psTryToSelKey As String)
		  If (psTryToSelKey = "") Then Return
		  
		  Var iPos As Integer
		  iPos = Data_PosOfKey(psTryToSelKey)
		  If (iPos >= 0) Then Me.SelectedRowIndex = iPos
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sel_Status() As Integer
		  If (Me.SelectedRowIndex = -1) Then Return -1
		  If Not (Me.RowTag(Me.SelectedRowIndex) IsA CTreeItem) Then Return -1
		  
		  Return CTreeItem(Me.RowTag(Me.SelectedRowIndex)).Status
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sel_TreeList(ByRef poTreeList As CTreeListedValues, ByRef piPos As Integer)
		  If (Me.SelectedRowIndex = -1) Then Return
		  If (Me.SelectedRowIndex > Me.RowCount - 1) Then Return
		  If Not (Me.RowTag(Me.SelectedRowIndex) IsA CTreeItem) Then Return
		  
		  poTreeList = CTreeItem(Me.RowTag(Me.SelectedRowIndex)).TreeMain
		  piPos = CTreeItem(Me.RowTag(Me.SelectedRowIndex)).PosItem
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Hook, Flags = &h0
		Event OnAfterRequestStatusChange()
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OnChange(poTreeList As CTreeListedValues, piPos As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OnDoubleClick() As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OnDragOver(poTreeList As CTreeListedValues, piPos As Integer, drag As DragItem, dragAction As DragItem.Types) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OnDragReorderRow(poNewTreeList As CTreeListedValues, piNewPos As Integer, poOldTreeList As CTreeListedValues, piOldPos As Integer) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OnDragRow(poTreeList As CTreeListedValues, piPos As Integer, drag As DragItem) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OnExpandCollapseAll_Recursive(poTreeList As CTreeListedValues, piPos As Integer)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OnKeyDown(Key As String) As Boolean
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OnRequestStatusChange(poTreeList As CTreeListedValues, piPos As Integer, ByRef pbDoRefresh As Boolean, piStatus As Integer = -1, psKeyPressed As String = "", pvData As Variant)
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OnRequestStatusChangeMenu(poTreeList As CTreeListedValues, piPos As Integer, piStatus As Integer = -1, pvData As Variant) As DesktopMenuItem
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OnRequestStatusChangeMenuActionKey(psMenuName As String) As String
	#tag EndHook


	#tag Note, Name = Example
		Var oSubSubTree As New CTreeListedValues
		oSubSubTree.Add("Entry 2.3.1", "Hint 2.3.1", "E231", 1, false, nil)
		oSubSubTree.Add("Entry 2.3.2", "Hint 2.3.2", "E232", 1, false, nil)
		
		Var oSubTree As New CTreeListedValues
		oSubTree.Add("Entry 2.1", "Hint 2.1", "E21", 1, false, nil)
		oSubTree.Add("Entry 2.2", "Hint 2.2", "E22", 2, false, nil)
		oSubTree.Add("Entry 2.3", "Hint 2.3", "E23", 2, false, oSubSubTree)
		oSubTree.Add("Entry 2.4", "Hint 2.4", "E24", 1, false, nil)
		oSubTree.Add("Entry 2.5", "Hint 2.5", "E25", 1, false, nil)
		
		'This is our final example hierarchical list, which will be represented in the TreeView
		'(Entry 2 has a sub-tree, 1 and 3 don't)
		
		Var oTree As New CTreeListedValues
		oTree.Add("Entry 1.0", "Hint 1.0", "E10", 2, false, nil)
		oTree.Add("Entry 2.0", "Hint 2.0", "E20", 2, true, oSubTree)
		oTree.Add("Entry 3.0", "Hint 3.0", "E30", 2, false, nil)
		
		
		'Define Icons for Status 1, 2
		Var dictIcons As New Dictionary
		dictIcons.Value(1) = iconOne
		dictIcons.Value(2) = iconTwo
		lstTree.Data_StatusIcons(dictIcons)
		
		'Show our CTreeListedValues Structure in the Listbox
		lstTree.Data_Clear
		lstTree.Data_TreeStructure = oTree
		lstTree.Data_Init()
		
		'select this item
		lstTree.Sel_Key_InCurrentView = "E21"
	#tag EndNote


	#tag Property, Flags = &h21
		Private eacColors As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eacColorsBackground As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eaoStatusPictures As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eaoStatusTextStyle As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ebShowHints As Boolean = true
	#tag EndProperty

	#tag Property, Flags = &h21
		Private ebTextColorOnlyForHint As Boolean = true
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eiDragTreePos As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eiOffsetXIcon As Integer = 10
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eiRowMousePos As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eoDragTreeItem As CTreeListedValues
	#tag EndProperty

	#tag Property, Flags = &h21
		Private oTreeStructure As CTreeListedValues
	#tag EndProperty


	#tag Constant, Name = constCaption_CollapseAll, Type = String, Dynamic = False, Default = \"Collapse All", Scope = Private
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Alle einklappen"
	#tag EndConstant

	#tag Constant, Name = constCaption_CollapseItem, Type = String, Dynamic = False, Default = \"Collapse", Scope = Private
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Einklappen"
	#tag EndConstant

	#tag Constant, Name = constCaption_ExpandAll, Type = String, Dynamic = False, Default = \"Expand All", Scope = Private
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Alle aufklappen"
	#tag EndConstant

	#tag Constant, Name = constCaption_ExpandItem, Type = String, Dynamic = False, Default = \"Expand", Scope = Private
		#Tag Instance, Platform = Any, Language = de, Definition  = \"Aufklappen"
	#tag EndConstant

	#tag Constant, Name = constCol_Caption, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = constCol_Hint, Type = Double, Dynamic = False, Default = \"1", Scope = Private
	#tag EndConstant

	#tag Constant, Name = constCol_Key, Type = Double, Dynamic = False, Default = \"2", Scope = Private
	#tag EndConstant

	#tag Constant, Name = constTreeView_TextFormat_Bold, Type = Double, Dynamic = False, Default = \"1", Scope = Public
	#tag EndConstant

	#tag Constant, Name = constTreeView_TextFormat_BoldItalic, Type = Double, Dynamic = False, Default = \"3", Scope = Public
	#tag EndConstant

	#tag Constant, Name = constTreeView_TextFormat_Italic, Type = Double, Dynamic = False, Default = \"2", Scope = Public
	#tag EndConstant

	#tag Constant, Name = constTreeView_TextFormat_Normal, Type = Double, Dynamic = False, Default = \"0", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="GridLineStyle"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="GridLineStyles"
			EditorType="Enum"
			#tag EnumValues
				"0 - None"
				"1 - Horizontal"
				"2 - Vertical"
				"3 - Both"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasBorder"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeader"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Tooltip"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHorizontalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasVerticalScrollbar"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="DropIndicatorVisible"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontName"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontUnit"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="FontUnits"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Pixel"
				"2 - Point"
				"3 - Inch"
				"4 - Millimeter"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowAutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowResizableColumns"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowDragging"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowRowReordering"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AllowExpandableRows"
			Visible=true
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RowSelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="RowSelectionTypes"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=true
			Group="Behavior"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Visible=false
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollOffset"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
