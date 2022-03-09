#tag Class
Protected Class lstTreeView
Inherits ListBox
	#tag Event
		Function CellBackgroundPaint(g As Graphics, row As Integer, column As Integer) As Boolean
		  #pragma unused column
		  
		  return self.Draw_CellBackground(g, row)
		End Function
	#tag EndEvent

	#tag Event
		Function CellClick(row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  #pragma unused x
		  #pragma unused y
		  #pragma unused column
		  
		  if (row >= 0) and (me.RowTag(row) <> nil) and (me.RowTag(row) IsA CTreeItem) then
		    OnTreeClick(CTreeItem(me.RowTag(row)).TreeMain, CTreeItem(me.RowTag(row)).PosItem)
		  end if
		  
		End Function
	#tag EndEvent

	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  return Self.Draw_CellText(g, row, column, x, y)
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Change()
		  Dim row As Integer
		  row = me.ListIndex
		  
		  if (row < me.ListCount) and (row >= 0) and (me.RowTag(row) <> nil) and (me.RowTag(row) IsA CTreeItem) then
		    OnChange(CTreeItem(me.RowTag(row)).TreeMain, CTreeItem(me.RowTag(row)).PosItem)
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Sub CollapseRow(row As Integer)
		  if (me.RowTag(row) <> nil) and (me.RowTag(row) IsA CTreeItem) then
		    
		    CTreeItem(me.RowTag(row)).Expanded = false
		    
		    Dim oTree As CTreeListedValues
		    oTree = CTreeItem(me.RowTag(row)).TreeMain
		    if (oTree = nil) or (CTreeItem(me.RowTag(row)).PosItem < 0) then return
		    oTree.Expanded(CTreeItem(me.RowTag(row)).PosItem) = false
		    
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Function ConstructContextualMenu(base as MenuItem, x as Integer, y as Integer) As Boolean
		  'richtige Zeile markieren
		  eiRowMousePos = me.RowFromXY(x, y)
		  if (eiRowMousePos >= 0) then
		    me.ListIndex = eiRowMousePos
		  end if
		  
		  'Nur ein Menu wenn Einträge vorhanden
		  if (oTreeStructure <> nil) and (oTreeStructure.Count > 0) and (me.ListCount > 0) then
		    'Wenn auf einer Auswahl geklickt: mögliches Sub-Menu
		    Dim bItemIsSelected As Boolean = false
		    Dim bItemIsSelectedAndHasNoSubtree As Boolean = false
		    Dim bItemIsExpanded As Boolean = false
		    if (eiRowMousePos >= 0) and (me.ListIndex >= 0) and (me.RowTag(me.ListIndex) <> nil) and (me.RowTag(me.ListIndex) IsA CTreeItem) then
		      bItemIsSelected = true
		      bItemIsSelectedAndHasNoSubtree = (CTreeItem(me.RowTag(me.ListIndex)).TreeSub = nil)
		      bItemIsExpanded = CTreeItem(me.RowTag(me.ListIndex)).Expanded
		      Dim oChangeMenu As MenuItem
		      oChangeMenu = OnRequestStatusChangeMenu(CTreeItem(me.RowTag(me.ListIndex)).TreeMain, CTreeItem(me.RowTag(me.ListIndex)).PosItem, CTreeItem(me.RowTag(me.ListIndex)).Status, CTreeItem(me.RowTag(me.ListIndex)).Data)
		      if (oChangeMenu <> nil) and (oChangeMenu.Count > 0) then
		        Dim iPos As Integer
		        for iPos = 0 to oChangeMenu.Count - 1
		          //Linux und Cocoa: via MenuItem.Clone
		          #if TargetCocoa or TargetLinux  then
		            base.Append(oChangeMenu.Item(iPos).Clone)
		          #else
		            base.Append(oChangeMenu.Item(iPos))
		          #endif
		        next
		        
		        Dim oSeparator As New MenuItem
		        oSeparator.Name = "mnuSeparator"
		        oSeparator.Text = "-"
		        base.Append(oSeparator)
		      end if
		    end if
		    
		    'Standard-Menueinträge
		    if bItemIsSelected and (not bItemIsSelectedAndHasNoSubtree) then
		      Dim oExpandItem As New MenuItem
		      oExpandItem.Text = me.constCaption_ExpandItem
		      oExpandItem.Name = "mnuExpandItem"
		      oExpandItem.Enabled = (not bItemIsExpanded)
		      base.Append(oExpandItem)
		      
		      Dim oCollapseItem As New MenuItem
		      oCollapseItem.Text = me.constCaption_CollapseItem
		      oCollapseItem.Name = "mnuCollapseItem"
		      oCollapseItem.Enabled = bItemIsExpanded
		      base.Append(oCollapseItem)
		      
		      Dim oSeparatorItem As New MenuItem
		      oSeparatorItem.Name = "mnuSeparatorItem"
		      oSeparatorItem.Text = "-"
		      base.Append(oSeparatorItem)
		    end if
		    
		    for i As Integer = 0 to oTreeStructure.Last
		      if (oTreeStructure.SubList(i) = nil) then continue
		      
		      'mind. 1 Sub-Liste vorhanden
		      Dim oExpandAll As New MenuItem
		      oExpandAll.Text = me.constCaption_ExpandAll
		      oExpandAll.Name = "mnuExpandAll"
		      base.Append(oExpandAll)
		      
		      Dim oCollapseAll As New MenuItem
		      oCollapseAll.Text = me.constCaption_CollapseAll
		      oCollapseAll.Name = "mnuCollapseAll"
		      base.Append(oCollapseAll)
		      
		      exit
		    next
		    
		    return true
		  end if
		  
		  return false
		End Function
	#tag EndEvent

	#tag Event
		Function ContextualMenuAction(hitItem as MenuItem) As Boolean
		  if (hitItem <> nil) then
		    Dim iExpandRow As Integer
		    iExpandRow = -1
		    Dim sCurrentKey As String
		    if (eiRowMousePos >= 0) and (me.ListIndex >= 0) and (eiRowMousePos = me.ListIndex) then
		      iExpandRow = eiRowMousePos
		    end if
		    
		    if (me.ListIndex >= 0) and (me.RowTag(me.ListIndex) <> nil) and (me.RowTag(me.ListIndex) IsA CTreeItem) then
		      sCurrentKey = CTreeItem(me.RowTag(me.ListIndex)).Key
		    end if
		    
		    select case hitItem.Name
		    case "mnuExpandAll"
		      Self.ExpandCollapseAll(-1, true)
		      if (sCurrentKey <> "") then self.Sel_Key_InCurrentView = sCurrentKey
		    case "mnuCollapseAll"
		      Self.ExpandCollapseAll(-1, false)
		      if (sCurrentKey <> "") then self.Sel_Key_InCurrentView = sCurrentKey
		    case "mnuExpandItem"
		      Self.ExpandCollapseAll(iExpandRow, true)
		      if (sCurrentKey <> "") then self.Sel_Key_InCurrentView = sCurrentKey
		    case "mnuCollapseItem"
		      Self.ExpandCollapseAll(iExpandRow, false)
		      if (sCurrentKey <> "") then self.Sel_Key_InCurrentView = sCurrentKey
		    else
		      Dim sKey As String
		      sKey = OnRequestStatusChangeMenuActionKey(hitItem.Name)
		      if Self.Do_KeyDown(sKey, me.ListIndex) then
		      end if
		    end select
		    
		    return true
		  end if
		  return false
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub DoubleClick()
		  if OnDoubleClick then return
		  if (me.ListIndex >= 0) and (me.RowTag(me.ListIndex) <> nil) and (me.RowTag(me.ListIndex) IsA CTreeItem) then
		    
		    Self.Data_RequestChange(me.ListIndex, CTreeItem(me.RowTag(me.ListIndex)).TreeMain, CTreeItem(me.RowTag(me.ListIndex)).PosItem, CTreeItem(me.RowTag(me.ListIndex)).Status, "", CTreeItem(me.RowTag(me.ListIndex)).Data)
		    
		  end if
		End Sub
	#tag EndEvent

	#tag Event
		Function DragOver(x As Integer, y As Integer, obj As DragItem, action As Integer) As Boolean
		  Dim row As Integer
		  row = me.RowFromXY(x, y)
		  if (row < me.ListCount) and (row >= 0) and (me.RowTag(row) <> nil) and (me.RowTag(row) IsA CTreeItem) then
		    return OnDragOver(CTreeItem(me.RowTag(row)).TreeMain, CTreeItem(me.RowTag(row)).PosItem, obj, action)
		  end if
		  
		  'nicht erlauben
		  return true
		End Function
	#tag EndEvent

	#tag Event
		Function DragReorderRows(newPosition as Integer, parentRow as Integer) As Boolean
		  if (eoDragTreeItem = nil) or (eiDragTreePos < 0) then return false
		  
		  if (newPosition < me.ListCount) and (newPosition >= 0) and (me.RowTag(newPosition) <> nil) and (me.RowTag(newPosition) IsA CTreeItem) then
		    return OnDragReorderRow(CTreeItem(me.RowTag(newPosition)).TreeMain, CTreeItem(me.RowTag(newPosition)).PosItem, eoDragTreeItem, eiDragTreePos)
		  end if
		  
		  return false
		End Function
	#tag EndEvent

	#tag Event
		Function DragRow(drag As DragItem, row As Integer) As Boolean
		  eoDragTreeItem = nil
		  eiDragTreePos = -1
		  if (row < me.ListCount) and (row >= 0) and (me.RowTag(row) <> nil) and (me.RowTag(row) IsA CTreeItem) then
		    'Event OnChange manuell auslösen (folgt sonst später)
		    OnChange(CTreeItem(me.RowTag(row)).TreeMain, CTreeItem(me.RowTag(row)).PosItem)
		    if OnDragRow(CTreeItem(me.RowTag(row)).TreeMain, CTreeItem(me.RowTag(row)).PosItem, drag) then
		      eoDragTreeItem = CTreeItem(me.RowTag(row)).TreeMain
		      eiDragTreePos = CTreeItem(me.RowTag(row)).PosItem
		      return true
		    else
		      return false
		    end if
		  end if
		  
		  return false
		End Function
	#tag EndEvent

	#tag Event
		Sub ExpandRow(row As Integer)
		  if (me.RowTag(row) <> nil) and (me.RowTag(row) IsA CTreeItem) then
		    
		    CTreeItem(me.RowTag(row)).Expanded = true
		    
		    Dim oTree As CTreeListedValues
		    oTree = CTreeItem(me.RowTag(row)).TreeMain
		    if (oTree = nil) or (CTreeItem(me.RowTag(row)).PosItem < 0) then return
		    oTree.Expanded(CTreeItem(me.RowTag(row)).PosItem) = true
		    oTree = CTreeItem(me.RowTag(row)).TreeSub
		    if (oTree = nil) or (oTree.Count < 1) then return
		    
		    Dim iPos As Integer
		    for iPos = 0 to oTree.Last
		      Self.Data_Show_Entry(oTree, iPos, CTreeItem(me.RowTag(row)).Level + 1, CTreeItem(me.RowTag(row)).Caption, CTreeItem(me.RowTag(row)).PosItem)
		    next
		    
		  end if
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function KeyDown(Key As String) As Boolean
		  Dim iRow As Integer
		  iRow = me.ListIndex
		  
		  if Do_KeyDown(Key, iRow) then return true
		  
		  if OnKeyDown(Key) then return true
		  
		End Function
	#tag EndEvent

	#tag Event
		Sub Open()
		  me.Hierarchical = true
		  
		  Self.Init_Columns()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub Data_BackgroundColors(pdictColors As Dictionary)
		  '============================================================
		  '
		  ' Status-Farben
		  '
		  '============================================================
		  
		  eacColors = pdictColors
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_Clear(pbKeepTreeStructure As Boolean = false)
		  '============================================================
		  '
		  ' Alle Zeilen loeschen
		  '
		  '============================================================
		  
		  if (not pbKeepTreeStructure) then
		    me.eoDragTreeItem = nil
		    me.oTreeStructure = nil
		  end if
		  
		  Me.DeleteAllRows
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_Init(pbShowHints As Boolean = true)
		  '============================================================
		  '
		  ' ListBox und Tree initialisieren
		  '
		  '============================================================
		  
		  ebShowHints = pbShowHints
		  Self.Init_Columns
		  
		  if (me.oTreeStructure = nil) then
		    me.Data_Clear
		    return
		  end if
		  
		  Dim iPos As Integer
		  for iPos = 0 to me.oTreeStructure.Last
		    me.Data_Show_Entry(me.oTreeStructure, iPos, 1, "", -1)
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Data_PosOfKey(psKey As String) As Integer
		  if (psKey = "") then return -1
		  
		  if (me.ListCount < 1) then return -1
		  
		  for i As Integer = (me.ListCount - 1) DownTo 0
		    if (not (me.RowTag(i) IsA CTreeItem)) then continue
		    if (CTreeItem(me.RowTag(i)).Key = psKey) then
		      return i
		    end if
		  next
		  
		  return -1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_RefreshEntry(poTree As CTreeListedValues, piPos As Integer, piRow As Integer = - 1)
		  '============================================================
		  '
		  ' Eintrag aktualisieren (nach den Events RequestChange)
		  '
		  '============================================================
		  
		  if (poTree = nil) or (Me.ListCount < 1) then return
		  
		  Dim vKey As Variant
		  vKey = poTree.Key(piPos)
		  
		  if (piRow >= 0) then
		    'gegebene Zeile aktualisieren
		    if (me.RowTag(piRow) <> nil) and (me.RowTag(piRow) IsA CTreeItem) and (CTreeItem(me.RowTag(piRow)).Key = vKey) then
		      Me.Data_Show_Entry(poTree, piPos, CTreeItem(me.RowTag(piRow)).Level, CTreeItem(me.RowTag(piRow)).ParentName, CTreeItem(me.RowTag(piRow)).PosParent, piRow)
		    end if
		    return
		  end if
		  
		  'sonst: Eintrag suchen
		  Dim iRowPos As Integer
		  for iRowPos = 0 to Me.ListCount - 1
		    if (me.RowTag(iRowPos) <> nil) and (me.RowTag(iRowPos) IsA CTreeItem) and (CTreeItem(me.RowTag(iRowPos)).Key = vKey) then
		      Me.Data_Show_Entry(poTree, piPos, CTreeItem(me.RowTag(iRowPos)).Level, CTreeItem(me.RowTag(iRowPos)).ParentName, CTreeItem(me.RowTag(iRowPos)).PosParent, irowPos)
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Data_RequestChange(piRow As Integer, poTreeList As CTreeListedValues, piPos As Integer, piCurrentStatus As Integer = - 1, psKeyPressed As String = "", pvData As Variant = nil)
		  '============================================================
		  '
		  ' Status-Änderung vom Benutzer
		  '
		  '============================================================
		  
		  Dim bNeedRefresh As Boolean = true
		  OnRequestStatusChange(poTreeList, piPos, bNeedRefresh, piCurrentStatus, psKeyPressed, pvData)
		  
		  if bNeedRefresh then
		    Me.Data_RefreshEntry(poTreeList, piPos, piRow)
		    OnAfterRequestStatusChange
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Data_Show_Entry(poTree As CTreeListedValues, piPos As Integer, piLevel As Integer, psParentName As String, piParentPos As Integer, piUpdateRow As Integer = - 1)
		  '============================================================
		  '
		  ' Eintrag/Zeile darstellen
		  '
		  '============================================================
		  
		  if (poTree = nil) or (piPos < 0) then return
		  if (piUpdateRow >= 0) and (me.ListCount <= piUpdateRow) then return
		  
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
		  
		  if (piUpdateRow < 0) then
		    if (poTree.SubList(piPos) <> nil) then
		      'Neuer Level
		      me.AddFolder ""
		      piUpdateRow = Me.LastIndex
		    else
		      'Neue Zeile
		      me.AddRow ""
		      piUpdateRow = Me.LastIndex
		    end if
		  end if
		  
		  if (eaoStatusPictures <> nil) and eaoStatusPictures.HasKey(oTreeItem.Status) then
		    me.RowPicture(piUpdateRow) = eaoStatusPictures.Lookup(oTreeItem.Status, nil)
		  else
		    me.RowPicture(piUpdateRow) = nil
		  end if
		  
		  me.Cell(piUpdateRow, constCol_Caption) = oTreeItem.Caption
		  me.Cell(piUpdateRow, constCol_Hint) = oTreeItem.Hint
		  me.RowTag(piUpdateRow) = oTreeItem
		  me.Expanded(piUpdateRow) = oTreeItem.Expanded
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_StatusColors(pdictColors As Dictionary, pbTextColorOnlyForHint As Boolean)
		  '============================================================
		  '
		  ' Status-Farben
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
		  ' Status-Farben
		  '
		  '============================================================
		  
		  eacColorsBackground = pdictColorsBackground
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_StatusIcons(pdictPictures As Dictionary, piOffsetX As Integer = 1)
		  '============================================================
		  '
		  ' Status-Icons
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
		  ' Tree zurückliefern
		  '
		  '============================================================
		  
		  return me.oTreeStructure
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data_TreeStructure(Assigns oTree As CTreeListedValues)
		  '============================================================
		  '
		  ' Tree
		  '
		  '============================================================
		  
		  me.oTreeStructure = oTree
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  eacColors = nil
		  eacColorsBackground = nil
		  eaoStatusPictures = nil
		  eaoStatusTextStyle = nil
		  eoDragTreeItem = nil
		  oTreeStructure = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Do_KeyDown(Key As String, iRow As Integer) As Boolean
		  '============================================================
		  '
		  ' Event: OnKeyDown
		  '
		  '============================================================
		  
		  if (Key = "") then return true
		  
		  if (iRow >= 0) and (me.RowTag(iRow) <> nil) and (me.RowTag(iRow) IsA CTreeItem) then
		    Dim bChangeStatus As Boolean = false
		    
		    'Left
		    if (AscB(Key) = 28) then
		      if (CTreeItem(me.RowTag(iRow)).TreeSub <> nil) then
		        Me.Expanded(iRow) = false
		        return true
		      end if
		    end if
		    
		    'Right
		    if (AscB(Key) = 29) then
		      if (CTreeItem(me.RowTag(iRow)).TreeSub <> nil) then
		        Me.Expanded(iRow) = true
		        return true
		      end if
		    end if
		    
		    'Status Change
		    if (me.KeyDown_IsEnter(me, Key)) then
		      bChangeStatus = true
		    end if
		    
		    
		    'Expand/Collapse
		    'if (Key = " ") then
		    'if (CTreeItem(me.RowTag(iRow)).TreeSub <> nil) then
		    'Me.Expanded(iRow) = (not Me.Expanded(iRow))
		    'return true
		    'end if
		    'end if
		    
		    
		    'A-Z, 0-9 an Modul weitergeben
		    
		    if (not bChangeStatus) and (InStr("abcdefghijklmnopqrstuvwxyz01234567890 ", Key) > 0) then
		      bChangeStatus = true
		    end if
		    
		    
		    
		    if bChangeStatus then
		      Self.Data_RequestChange(iRow, CTreeItem(me.RowTag(iRow)).TreeMain, CTreeItem(me.RowTag(iRow)).PosItem, CTreeItem(me.RowTag(iRow)).Status, Key, CTreeItem(me.RowTag(iRow)).Data)
		      return true
		    end if
		    
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Draw_CellBackground(g As Graphics, row As Integer) As Boolean
		  '============================================================
		  '
		  ' Hintergrund einer Zeile zeichnen
		  '
		  '============================================================
		  
		  ' Kein Listeneintrag
		  if (row >= me.ListCount) then return false
		  
		  ' Selektion
		  if (row = me.ListIndex)  then
		    g.foreColor = HighlightColor
		    g.FillRect(0, 0, g.width, g.height)
		    return true
		  end if
		  
		  if (me.Enabled = false) then
		    g.foreColor = FillColor
		    g.FillRect(0, 0, g.width, g.height)
		    return true
		  end if
		  
		  if (row < me.ListCount) and (me.RowTag(row) <> nil) and (me.RowTag(row) IsA CTreeItem) then
		    if (eacColorsBackground <> nil) and eacColorsBackground.HasKey(CTreeItem(me.RowTag(row)).Status) then
		      if eacColors.HasKey(CTreeItem(me.RowTag(row)).Status) then
		        g.ForeColor = eacColorsBackground.Value(CTreeItem(me.RowTag(row)).Status)
		        g.FillRect(0, 0, g.width, g.height)
		      end if
		      return true
		    end if
		  end if
		  
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function Draw_CellText(g As Graphics, row As Integer, column As Integer, x As Integer, y As Integer) As Boolean
		  '============================================================
		  '
		  ' Text einer Zeile zeichnen
		  '
		  '============================================================
		  
		  ' Kein Listeneintrag
		  if (row >= me.ListCount) then return false
		  
		  if (me.RowTag(row) <> nil) and (me.RowTag(row) IsA CTreeItem) then
		    Dim cDefault As Color
		    cDefault = g.ForeColor
		    
		    g.Bold = false
		    g.Italic = false
		    g.Underline = false
		    if (eaoStatusTextStyle <> nil) and eaoStatusTextStyle.HasKey(CTreeItem(me.RowTag(row)).Status) then
		      select case eaoStatusTextStyle.Lookup(CTreeItem(me.RowTag(row)).Status, me.constTreeView_TextFormat_Normal)
		      case me.constTreeView_TextFormat_Italic
		        g.Italic = true
		      case me.constTreeView_TextFormat_Bold
		        g.Bold = true
		      case me.constTreeView_TextFormat_BoldItalic
		        g.Bold = true
		        g.Italic = true
		      end select
		    end if
		    
		    ' Selektion
		    if (row = me.ListIndex) and (me.Enabled) then
		      g.ForeColor = &cFFFFFF
		    else
		      if (eacColors <> nil) and eacColors.HasKey(CTreeItem(me.RowTag(row)).Status) then
		        g.ForeColor = eacColors.Lookup(CTreeItem(me.RowTag(row)).Status, TextColor)
		      else
		        g.ForeColor = TextColor
		      end if
		    end if
		    
		    if (ebTextColorOnlyForHint and (column <> me.constCol_Hint)) then
		      ' Selektion
		      if (row = me.ListIndex) and (me.Enabled) then
		        g.ForeColor = &cffffff
		      else
		        g.ForeColor = TextColor
		      end if
		    end if
		    
		    
		    Dim iOffset As Integer
		    iOffset = x
		    if (column = me.constCol_Caption) and (me.RowPicture(row) <> nil) then
		      iOffset = iOffset + eiOffsetXIcon 'Abstand vom Icon zum Text
		    end if
		    Dim sText As String
		    sText = ReplaceLineEndings(me.Cell(row, column), " ")
		    g.DrawString(sText, iOffset, y, g.Width, true)
		    return true
		    
		  end if
		  
		  return false
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ExpandCollapseAll(piRow As Integer = - 1, pbExpand As Boolean = true)
		  '============================================================
		  '
		  ' Alles ein/ausklappen
		  '
		  '============================================================
		  
		  if (oTreeStructure = nil) then return
		  if (oTreeStructure.Count < 0) then return
		  
		  Dim oExpandTree As CTreeListedValues
		  oExpandTree = oTreeStructure
		  if (piRow >= 0) and (piRow <= (me.ListCount - 1)) then
		    if (me.RowTag(piRow) <> nil) and (me.RowTag(piRow) IsA CTreeItem) then
		      'diesen Eintrag expandieren
		      oExpandTree = CTreeItem(me.RowTag(piRow)).TreeMain
		      if (oExpandTree.SubList(CTreeItem(me.RowTag(piRow)).PosItem) <> nil) then
		        oExpandTree.Expanded(CTreeItem(me.RowTag(piRow)).PosItem) = pbExpand
		      end if
		      'Sub-Tree rekursiv
		      oExpandTree = oExpandTree.SubList(CTreeItem(me.RowTag(piRow)).PosItem)
		    end if
		  end if
		  
		  me.ExpandCollapseAll_Rekursiv(oExpandTree, pbExpand)
		  me.Data_Clear(true)
		  me.Data_Init(ebShowHints)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub ExpandCollapseAll_Rekursiv(poTree As CTreeListedValues, pbExpand As Boolean)
		  '============================================================
		  '
		  ' Alles ein/ausklappen
		  '
		  '============================================================
		  
		  if (poTree = nil) then return
		  if (poTree.Count < 1) then return
		  
		  Dim iPos As Integer
		  for iPos = 0 to poTree.Last
		    if (poTree.SubList(iPos) <> nil) then
		      poTree.Expanded(iPos) = pbExpand
		      Me.ExpandCollapseAll_Rekursiv(poTree.SubList(iPos), pbExpand)
		    end if
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function GetCollapsedKeys() As String()
		  
		  Dim aKeys() As String
		  if (me.ListCount < 1) then return aKeys
		  
		  for i As Integer = (me.ListCount - 1) DownTo 0
		    
		    if (not (me.RowTag(i) IsA CTreeItem)) then continue
		    if (not CTreeItem(me.RowTag(i)).Expanded) and (CTreeItem(me.RowTag(i)).TreeSub <> nil) then
		      aKeys.Append(CTreeItem(me.RowTag(i)).Key)
		    end if
		    
		  next
		  
		  return aKeys
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Init_Columns()
		  '============================================================
		  '
		  ' ListBox mit 2/3 Spalten initialisieren
		  '
		  '============================================================
		  
		  me.ColumnCount = 3
		  if ebShowHints then
		    #if TargetWin32 then
		      me.ColumnWidths = "60%, 40%, 0"
		    #else
		      me.ColumnWidths = "50%, 50%, 0"
		    #endif
		  else
		    me.ColumnWidths = "100%, 0, 0"
		  end if
		  
		  Me.ColumnType(constCol_Caption) = Listbox.TypeNormal
		  if ebShowHints then Me.ColumnType(constCol_Hint) = Listbox.TypeNormal
		  Me.ColumnType(constCol_Key) = Listbox.TypeNormal
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function KeyDown_IsEnter(poControl As RectControl, psKey As String) As Boolean
		  '============================================================
		  '
		  ' Enter oder Returntaste gedrückt
		  '
		  '============================================================
		  #pragma unused poControl
		  
		  #if TargetMacOS then
		    
		    if ((AscB(psKey) = 13) or (AscB(psKey) = 3)) then
		      return true
		    end if
		    
		  #else
		    'Enter oder Return
		    If (psKey <> "") and (Keyboard.AsyncKeyDown(&h4C) or Keyboard.AsyncKeyDown(&h24)) then
		      return true
		    end if
		    
		  #endif
		  
		  return false
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RowTag(piRow As Integer) As Variant
		  '============================================================
		  '
		  ' RowTag (TreeItem)
		  '
		  '============================================================
		  
		  if (me.ListCount < (piRow + 1)) then return nil
		  
		  if (me.CellTag(piRow, constCol_Key) <> nil) and (me.CellTag(piRow, constCol_Key) IsA CTreeItem) then
		    return me.CellTag(piRow, constCol_Key)
		  else
		    return nil
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub RowTag(piRow As Integer, Assigns poTreeItem As CTreeItem)
		  '============================================================
		  '
		  ' RowTag (TreeItem)
		  '
		  '============================================================
		  
		  me.CellTag(piRow, constCol_Key) = poTreeItem
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sel_Key() As String
		  
		  if (me.ListIndex = -1) then return ""
		  if not (me.RowTag(me.ListIndex) IsA CTreeItem) then return ""
		  
		  return CTreeItem(me.RowTag(me.ListIndex)).Key
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sel_Key_InCurrentView(Assigns psTryToSelKey As String)
		  if (psTryToSelKey = "") then return
		  
		  Dim iPos As Integer
		  iPos = Data_PosOfKey(psTryToSelKey)
		  if (iPos >= 0) then me.ListIndex = iPos
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Sel_Status() As Integer
		  
		  if (me.ListIndex = -1) then return -1
		  if not (me.RowTag(me.ListIndex) IsA CTreeItem) then return -1
		  
		  return CTreeItem(me.RowTag(me.ListIndex)).Status
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Sel_TreeList(ByRef poTreeList As CTreeListedValues, ByRef piPos As Integer)
		  if (me.ListIndex = -1) then return
		  if (me.ListIndex > me.ListCount - 1) then return
		  if not (me.RowTag(me.ListIndex) IsA CTreeItem) then return
		  
		  poTreeList = CTreeItem(me.RowTag(me.ListIndex)).TreeMain
		  piPos = CTreeItem(me.RowTag(me.ListIndex)).PosItem
		  
		  
		  
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

	#tag Hook, Flags = &h0
		Event OnTreeClick(poTreeList As CTreeListedValues, piPos As Integer)
	#tag EndHook


	#tag Note, Name = Beispiel
		
		
		Dim oSubSubTree As New CTreeListedValues
		oSubSubTree.Append("Eintrag 2.3.1", "Hint 2.3.1", "E231", 1, false, nil)
		oSubSubTree.Append("Eintrag 2.3.2", "Hint 2.3.2", "E232", 1, false, nil)
		
		Dim oSubTree As New CTreeListedValues
		oSubTree.Append("Eintrag 2.1", "Hint 2.1", "E21", 1, false, nil)
		oSubTree.Append("Eintrag 2.2", "Hint 2.2", "E22", 2, false, nil)
		oSubTree.Append("Eintrag 2.3", "Hint 2.3", "E23", 2, false, oSubSubTree)
		oSubTree.Append("Eintrag 2.4", "Hint 2.4", "E24", 1, false, nil)
		oSubTree.Append("Eintrag 2.5", "Hint 2.5", "E25", 1, false, nil)
		
		Dim oTree As New CTreeListedValues
		oTree.Append("Eintrag 1.0", "Hint 1.0", "E10", 2, false, nil)
		oTree.Append("Eintrag 2.0", "Hint 2.0", "E20", 2, true, oSubTree)
		oTree.Append("Eintrag 3.0", "Hint 3.0", "E30", 2, false, nil)
		
		lstAenderungen.Data_Clear
		lstAenderungen.Data_StatusIcons(picGrid_RoundDown_12, picGrid_RoundUp_12)
		lstAenderungen.Data_TreeStructure = oTree
		lstAenderungen.Data_Init()
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

	#tag Constant, Name = constCol_Caption, Type = Double, Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = constCol_Hint, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = constCol_Key, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
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
