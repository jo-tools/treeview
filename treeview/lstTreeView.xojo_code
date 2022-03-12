#tag Class
Protected Class lstTreeView
Inherits ListBox
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  #Pragma unused column
		  
		  Return Self.Draw_CellBackground(g, row)
		End Function
	#tag EndEvent

	#tag Event
		Function CellClick(row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  #Pragma unused x
		  #Pragma unused y
		  #Pragma unused column
		  
		  If (row >= 0) And (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    OnExpandCollapseAll_Recursive(CTreeItem(Me.RowTag(row)).TreeMain, CTreeItem(Me.RowTag(row)).PosItem)
		  End If
		  
		End Function
	#tag EndEvent

	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  Return Self.Draw_CellText(g, row, column, x, y)
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Change()
		  Dim row As Integer = Me.ListIndex
		  
		  If (row < Me.ListCount) And (row >= 0) And (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    OnChange(CTreeItem(Me.RowTag(row)).TreeMain, CTreeItem(Me.RowTag(row)).PosItem)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Sub CollapseRow(row As Integer)
		  If (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    
		    CTreeItem(Me.RowTag(row)).Expanded = False
		    
		    Dim oTree As CTreeListedValues = CTreeItem(Me.RowTag(row)).TreeMain
		    If (oTree = Nil) Or (CTreeItem(Me.RowTag(row)).PosItem < 0) Then Return
		    oTree.Expanded(CTreeItem(Me.RowTag(row)).PosItem) = False
		    
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  'select appropriate row
		  eiRowMousePos = Me.RowFromXY(x, y)
		  If (eiRowMousePos >= 0) Then
		    Me.ListIndex = eiRowMousePos
		  End If
		  
		  'only show menu if entries are available
		  If (oTreeStructure <> Nil) And (oTreeStructure.Count > 0) And (Me.ListCount > 0) Then
		    'if clicked on a choice: possible sub-menu
		    Dim bItemIsSelected As Boolean = False
		    Dim bItemIsSelectedAndHasNoSubtree As Boolean = False
		    Dim bItemIsExpanded As Boolean = False
		    If (eiRowMousePos >= 0) And (Me.ListIndex >= 0) And (Me.RowTag(Me.ListIndex) <> Nil) And (Me.RowTag(Me.ListIndex) IsA CTreeItem) Then
		      bItemIsSelected = True
		      bItemIsSelectedAndHasNoSubtree = (CTreeItem(Me.RowTag(Me.ListIndex)).TreeSub = Nil)
		      bItemIsExpanded = CTreeItem(Me.RowTag(Me.ListIndex)).Expanded
		      Dim oChangeMenu As MenuItem = OnRequestStatusChangeMenu(CTreeItem(Me.RowTag(Me.ListIndex)).TreeMain, CTreeItem(Me.RowTag(Me.ListIndex)).PosItem, CTreeItem(Me.RowTag(Me.ListIndex)).Status, CTreeItem(Me.RowTag(Me.ListIndex)).Data)
		      If (oChangeMenu <> Nil) And (oChangeMenu.Count > 0) Then
		        Dim iPos As Integer
		        For iPos = 0 To oChangeMenu.Count - 1
		          //Linux und Cocoa: via MenuItem.Clone
		          #If TargetMacOS Or TargetLinux  Then
		            base.Append(oChangeMenu.Item(iPos).Clone)
		          #Else
		            base.Append(oChangeMenu.Item(iPos))
		          #EndIf
		        Next
		        
		        Dim oSeparator As New MenuItem
		        oSeparator.Name = "mnuSeparator"
		        oSeparator.Text = "-"
		        base.Append(oSeparator)
		      End If
		    End If
		    
		    'Default Menu Entries
		    If bItemIsSelected And (Not bItemIsSelectedAndHasNoSubtree) Then
		      Dim oExpandItem As New MenuItem
		      oExpandItem.Text = Me.constCaption_ExpandItem
		      oExpandItem.Name = "mnuExpandItem"
		      oExpandItem.Enabled = (Not bItemIsExpanded)
		      base.Append(oExpandItem)
		      
		      Dim oCollapseItem As New MenuItem
		      oCollapseItem.Text = Me.constCaption_CollapseItem
		      oCollapseItem.Name = "mnuCollapseItem"
		      oCollapseItem.Enabled = bItemIsExpanded
		      base.Append(oCollapseItem)
		      
		      Dim oSeparatorItem As New MenuItem
		      oSeparatorItem.Name = "mnuSeparatorItem"
		      oSeparatorItem.Text = "-"
		      base.Append(oSeparatorItem)
		    End If
		    
		    For i As Integer = 0 To oTreeStructure.Last
		      If (oTreeStructure.SubList(i) = Nil) Then Continue
		      
		      'at least 1 Sub-Liste available
		      Dim oExpandAll As New MenuItem
		      oExpandAll.Text = Me.constCaption_ExpandAll
		      oExpandAll.Name = "mnuExpandAll"
		      base.Append(oExpandAll)
		      
		      Dim oCollapseAll As New MenuItem
		      oCollapseAll.Text = Me.constCaption_CollapseAll
		      oCollapseAll.Name = "mnuCollapseAll"
		      base.Append(oCollapseAll)
		      
		      Exit
		    Next
		    
		    Return True
		  End If
		  
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  If (hitItem <> Nil) Then
		    Dim iExpandRow As Integer = -1
		    Dim sCurrentKey As String
		    If (eiRowMousePos >= 0) And (Me.ListIndex >= 0) And (eiRowMousePos = Me.ListIndex) Then
		      iExpandRow = eiRowMousePos
		    End If
		    
		    If (Me.ListIndex >= 0) And (Me.RowTag(Me.ListIndex) <> Nil) And (Me.RowTag(Me.ListIndex) IsA CTreeItem) Then
		      sCurrentKey = CTreeItem(Me.RowTag(Me.ListIndex)).Key
		    End If
		    
		    Select Case hitItem.Name
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
		      Dim sKey As String = OnRequestStatusChangeMenuActionKey(hitItem.Name)
		      If Self.Do_KeyDown(sKey, Me.ListIndex) Then
		      End If
		    End Select
		    
		    Return True
		  End If
		  Return False
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub DoubleClick()
		  If OnDoubleClick Then Return
		  
		  If (Me.ListIndex >= 0) And (Me.RowTag(Me.ListIndex) <> Nil) And (Me.RowTag(Me.ListIndex) IsA CTreeItem) Then
		    Self.Data_RequestChange(Me.ListIndex, CTreeItem(Me.RowTag(Me.ListIndex)).TreeMain, CTreeItem(Me.RowTag(Me.ListIndex)).PosItem, CTreeItem(Me.RowTag(Me.ListIndex)).Status, "", CTreeItem(Me.RowTag(Me.ListIndex)).Data)
		  End If
		End Sub
	#tag EndEvent

	#tag Event
		Function DragOver(x As Integer, y As Integer, obj As DragItem, action As Integer) As Boolean
		  Dim row As Integer = Me.RowFromXY(x, y)
		  If (row < Me.ListCount) And (row >= 0) And (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
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
		  
		  If (newPosition < Me.ListCount) And (newPosition >= 0) And (Me.RowTag(newPosition) <> Nil) And (Me.RowTag(newPosition) IsA CTreeItem) Then
		    Return OnDragReorderRow(CTreeItem(Me.RowTag(newPosition)).TreeMain, CTreeItem(Me.RowTag(newPosition)).PosItem, eoDragTreeItem, eiDragTreePos)
		  End If
		  
		  Return False
		End Function
	#tag EndEvent

	#tag Event
		Function DragRow(drag As DragItem, row As Integer) As Boolean
		  eoDragTreeItem = Nil
		  eiDragTreePos = -1
		  If (row < Me.ListCount) And (row >= 0) And (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
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
		Sub ExpandRow(row As Integer)
		  If (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    
		    CTreeItem(Me.RowTag(row)).Expanded = True
		    
		    Dim oTree As CTreeListedValues = CTreeItem(Me.RowTag(row)).TreeMain
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
		Function KeyDown(Key As String) As Boolean
		  Dim iRow As Integer = Me.ListIndex
		  
		  If Do_KeyDown(Key, iRow) Then Return True
		  
		  If OnKeyDown(Key) Then Return True
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  Me.Hierarchical = True
		  
		  Self.Init_Columns
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
		  
		  Me.DeleteAllRows
		  
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
		  
		  If (Me.ListCount < 1) Then Return -1
		  
		  For i As Integer = (Me.ListCount - 1) DownTo 0
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
		  
		  If (poTree = Nil) Or (Me.ListCount < 1) Then Return
		  
		  Dim vKey As Variant = poTree.Key(piPos)
		  
		  If (piRow >= 0) Then
		    'update given row
		    If (Me.RowTag(piRow) <> Nil) And (Me.RowTag(piRow) IsA CTreeItem) And (CTreeItem(Me.RowTag(piRow)).Key = vKey) Then
		      Me.Data_Show_Entry(poTree, piPos, CTreeItem(Me.RowTag(piRow)).Level, CTreeItem(Me.RowTag(piRow)).ParentName, CTreeItem(Me.RowTag(piRow)).PosParent, piRow)
		    End If
		    Return
		  End If
		  
		  'otherwise: search entry
		  For iRowPos As Integer = 0 To Me.ListCount - 1
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
		  
		  Dim bNeedRefresh As Boolean = True
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
		  If (piUpdateRow >= 0) And (Me.ListCount <= piUpdateRow) Then Return
		  
		  Dim oTreeItem As New CTreeItem
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
		      Me.AddFolder ""
		      piUpdateRow = Me.LastIndex
		    Else
		      'Neue Zeile
		      Me.AddRow ""
		      piUpdateRow = Me.LastIndex
		    End If
		  End If
		  
		  If (eaoStatusPictures <> Nil) And eaoStatusPictures.HasKey(oTreeItem.Status) Then
		    Me.RowPicture(piUpdateRow) = eaoStatusPictures.Lookup(oTreeItem.Status, Nil)
		  Else
		    Me.RowPicture(piUpdateRow) = Nil
		  End If
		  
		  Me.Cell(piUpdateRow, constCol_Caption) = oTreeItem.Caption
		  Me.Cell(piUpdateRow, constCol_Hint) = oTreeItem.Hint
		  Me.RowTag(piUpdateRow) = oTreeItem
		  Me.Expanded(piUpdateRow) = oTreeItem.Expanded
		  
		  
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
		  ' Text-Format für Status
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
		    Dim bChangeStatus As Boolean = False
		    
		    'Left
		    If (AscB(Key) = 28) Then
		      If (CTreeItem(Me.RowTag(iRow)).TreeSub <> Nil) Then
		        Me.Expanded(iRow) = False
		        Return True
		      End If
		    End If
		    
		    'Right
		    If (AscB(Key) = 29) Then
		      If (CTreeItem(Me.RowTag(iRow)).TreeSub <> Nil) Then
		        Me.Expanded(iRow) = True
		        Return True
		      End If
		    End If
		    
		    'Status Change
		    If (Me.KeyDown_IsEnter(Me, Key)) Then
		      bChangeStatus = True
		    End If
		    
		    
		    'Expand/Collapse
		    'if (Key = " ") then
		    'if (CTreeItem(me.RowTag(iRow)).TreeSub <> nil) then
		    'Me.Expanded(iRow) = (not Me.Expanded(iRow))
		    'return true
		    'end if
		    'end if
		    
		    
		    'A-Z, 0-9
		    If (Not bChangeStatus) And (InStr("abcdefghijklmnopqrstuvwxyz01234567890 ", Key) > 0) Then
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
		  If (row >= Me.ListCount) Then Return False
		  
		  ' Selection
		  If (row = Me.ListIndex) Then
		    #If TargetMacOS Then
		      'Let Xojo draw the default Selection Background
		      Return False
		    #Else
		      'At least on Windows, Xojo doesn't draw the whole row with a background selection
		      'so we do that here ourselves. Should be improved with Declares to get the correct
		      'colors for the state 'window is not active'...
		      g.foreColor = If(Self.Active, HighlightColor, If(IsDarkMode, &c242424, &cC9C5BB))
		      g.FillRect(0, 0, g.width, g.height)
		      Return True
		    #EndIf
		  End If
		  
		  If (Me.Enabled = False) Then
		    g.foreColor = FillColor
		    g.FillRect(0, 0, g.width, g.height)
		    Return True
		  End If
		  
		  If (row < Me.ListCount) And (Me.RowTag(row) <> Nil) And (Me.RowTag(row) IsA CTreeItem) Then
		    If (eacColorsBackground <> Nil) And eacColorsBackground.HasKey(CTreeItem(Me.RowTag(row)).Status) Then
		      If eacColors.HasKey(CTreeItem(Me.RowTag(row)).Status) Then
		        g.ForeColor = eacColorsBackground.Value(CTreeItem(Me.RowTag(row)).Status)
		        g.FillRect(0, 0, g.width, g.height)
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
		  If (row >= Me.ListCount) Then Return False
		  
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
		    If (row = Me.ListIndex) And (Me.Enabled) Then
		      g.ForeColor = &cFFFFFF
		    Else
		      If (eacColors <> Nil) And eacColors.HasKey(CTreeItem(Me.RowTag(row)).Status) Then
		        g.ForeColor = eacColors.Lookup(CTreeItem(Me.RowTag(row)).Status, TextColor)
		      Else
		        g.ForeColor = TextColor
		      End If
		    End If
		    
		    If (ebTextColorOnlyForHint And (column <> Me.constCol_Hint)) Then
		      ' Selection
		      If (row = Me.ListIndex) And (Me.Enabled) Then
		        g.ForeColor = &cffffff
		      Else
		        g.ForeColor = TextColor
		      End If
		    End If
		    
		    
		    Dim iOffset As Integer = x
		    If (column = Me.constCol_Caption) And (Me.RowPicture(row) <> Nil) Then
		      iOffset = iOffset + eiOffsetXIcon 'Offset Icon - Text
		    End If
		    Dim sText As String = ReplaceLineEndings(Me.Cell(row, column), " ")
		    g.DrawString(sText, iOffset, y, g.Width, True)
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
		  
		  Dim oExpandTree As CTreeListedValues = oTreeStructure
		  If (piRow >= 0) And (piRow <= (Me.ListCount - 1)) Then
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
		  
		  Dim aKeys() As String
		  If (Me.ListCount < 1) Then Return aKeys
		  
		  For i As Integer = (Me.ListCount - 1) DownTo 0
		    
		    If (Not (Me.RowTag(i) IsA CTreeItem)) Then Continue
		    If (Not CTreeItem(Me.RowTag(i)).Expanded) And (CTreeItem(Me.RowTag(i)).TreeSub <> Nil) Then
		      aKeys.Append(CTreeItem(Me.RowTag(i)).Key)
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
		  
		  Me.ColumnType(constCol_Caption) = Listbox.TypeNormal
		  If ebShowHints Then Me.ColumnType(constCol_Hint) = Listbox.TypeNormal
		  Me.ColumnType(constCol_Key) = Listbox.TypeNormal
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function KeyDown_IsEnter(poControl As RectControl, psKey As String) As Boolean
		  '============================================================
		  '
		  ' Enter or Return pressed
		  '
		  '============================================================
		  #Pragma unused poControl
		  
		  #If TargetMacOS Then
		    
		    If ((AscB(psKey) = 13) Or (AscB(psKey) = 3)) Then
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

	#tag Method, Flags = &h1
		Protected Function RowTag(piRow As Integer) As Variant
		  '============================================================
		  '
		  ' RowTag (TreeItem)
		  '
		  '============================================================
		  
		  If (Me.ListCount < (piRow + 1)) Then Return Nil
		  
		  If (Me.CellTag(piRow, constCol_Key) <> Nil) And (Me.CellTag(piRow, constCol_Key) IsA CTreeItem) Then
		    Return Me.CellTag(piRow, constCol_Key)
		  Else
		    Return Nil
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RowTag(piRow As Integer, Assigns poTreeItem As CTreeItem)
		  '============================================================
		  '
		  ' RowTag (TreeItem)
		  '
		  '============================================================
		  
		  Me.CellTag(piRow, constCol_Key) = poTreeItem
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sel_Key() As String
		  
		  If (Me.ListIndex = -1) Then Return ""
		  If Not (Me.RowTag(Me.ListIndex) IsA CTreeItem) Then Return ""
		  
		  Return CTreeItem(Me.RowTag(Me.ListIndex)).Key
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sel_Key_InCurrentView(Assigns psTryToSelKey As String)
		  If (psTryToSelKey = "") Then Return
		  
		  Dim iPos As Integer
		  iPos = Data_PosOfKey(psTryToSelKey)
		  If (iPos >= 0) Then Me.ListIndex = iPos
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sel_Status() As Integer
		  
		  If (Me.ListIndex = -1) Then Return -1
		  If Not (Me.RowTag(Me.ListIndex) IsA CTreeItem) Then Return -1
		  
		  Return CTreeItem(Me.RowTag(Me.ListIndex)).Status
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sel_TreeList(ByRef poTreeList As CTreeListedValues, ByRef piPos As Integer)
		  If (Me.ListIndex = -1) Then Return
		  If (Me.ListIndex > Me.ListCount - 1) Then Return
		  If Not (Me.RowTag(Me.ListIndex) IsA CTreeItem) Then Return
		  
		  poTreeList = CTreeItem(Me.RowTag(Me.ListIndex)).TreeMain
		  piPos = CTreeItem(Me.RowTag(Me.ListIndex)).PosItem
		  
		  
		  
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
		Event OnDragOver(poTreeList As CTreeListedValues, piPos As Integer, drag As DragItem, dragAction As Integer) As Boolean
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
		Event OnRequestStatusChangeMenu(poTreeList As CTreeListedValues, piPos As Integer, piStatus As Integer = -1, pvData As Variant) As MenuItem
	#tag EndHook

	#tag Hook, Flags = &h0
		Event OnRequestStatusChangeMenuActionKey(psMenuName As String) As String
	#tag EndHook


	#tag Note, Name = Example
		Dim oSubSubTree As New CTreeListedValues
		oSubSubTree.Append("Entry 2.3.1", "Hint 2.3.1", "E231", 1, false, nil)
		oSubSubTree.Append("Entry 2.3.2", "Hint 2.3.2", "E232", 1, false, nil)
		
		Dim oSubTree As New CTreeListedValues
		oSubTree.Append("Entry 2.1", "Hint 2.1", "E21", 1, false, nil)
		oSubTree.Append("Entry 2.2", "Hint 2.2", "E22", 2, false, nil)
		oSubTree.Append("Entry 2.3", "Hint 2.3", "E23", 2, false, oSubSubTree)
		oSubTree.Append("Entry 2.4", "Hint 2.4", "E24", 1, false, nil)
		oSubTree.Append("Entry 2.5", "Hint 2.5", "E25", 1, false, nil)
		
		'This is our final example hierarchical list, which will be represented in the TreeView
		'(Entry 2 has a sub-tree, 1 and 3 don't)
		
		Dim oTree As New CTreeListedValues
		oTree.Append("Entry 1.0", "Hint 1.0", "E10", 2, false, nil)
		oTree.Append("Entry 2.0", "Hint 2.0", "E20", 2, true, oSubTree)
		oTree.Append("Entry 3.0", "Hint 3.0", "E30", 2, false, nil)
		
		
		'Define Icons for Status 1, 2
		Dim dictIcons As New Dictionary
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
			Name="Transparent"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
			EditorType="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ShowDropIndicator"
			Visible=true
			Group="Appearance"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDeactivate"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoHideScrollbars"
			Visible=true
			Group="Behavior"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Bold"
			Visible=true
			Group="Font"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Border"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnCount"
			Visible=true
			Group="Appearance"
			InitialValue="1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnsResizable"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ColumnWidths"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataField"
			Visible=true
			Group="Database Binding"
			Type="String"
			EditorType="DataField"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DataSource"
			Visible=true
			Group="Database Binding"
			Type="String"
			EditorType="DataSource"
		#tag EndViewProperty
		#tag ViewProperty
			Name="DefaultRowHeight"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EnableDrag"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="EnableDragReorder"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLinesHorizontal"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - None"
				"2 - ThinDotted"
				"3 - ThinSolid"
				"4 - ThickSolid"
				"5 - DoubleThinSolid"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="GridLinesVertical"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - None"
				"2 - ThinDotted"
				"3 - ThinSolid"
				"4 - ThickSolid"
				"5 - DoubleThinSolid"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="HasHeading"
			Visible=true
			Group="Appearance"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HeadingIndex"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HelpTag"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Hierarchical"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			Type="Integer"
			EditorType="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialParent"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="InitialValue"
			Visible=true
			Group="Appearance"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Italic"
			Visible=true
			Group="Font"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RequiresSelection"
			Visible=true
			Group="Behavior"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollbarHorizontal"
			Visible=true
			Group="Appearance"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ScrollBarVertical"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="SelectionType"
			Visible=true
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType="Enum"
			#tag EnumValues
				"0 - Single"
				"1 - Multiple"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
			EditorType="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabPanelIndex"
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabStop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextFont"
			Visible=true
			Group="Font"
			InitialValue="System"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextSize"
			Visible=true
			Group="Font"
			InitialValue="0"
			Type="Single"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TextUnit"
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
			Name="Top"
			Visible=true
			Group="Position"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Underline"
			Visible=true
			Group="Font"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="UseFocusRing"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue="True"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollOffset"
			Visible=true
			Group="Appearance"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="_ScrollWidth"
			Visible=true
			Group="Appearance"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
