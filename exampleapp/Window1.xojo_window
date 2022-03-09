#tag Window
Begin Window Window1
   BackColor       =   &cFFFFFF00
   Backdrop        =   0
   CloseButton     =   True
   Compatibility   =   ""
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   FullScreenButton=   False
   HasBackColor    =   False
   Height          =   500
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   True
   MaxWidth        =   32000
   MenuBar         =   57315327
   MenuBarVisible  =   True
   MinHeight       =   300
   MinimizeButton  =   True
   MinWidth        =   450
   Placement       =   0
   Resizeable      =   True
   Title           =   "TreeView"
   Visible         =   True
   Width           =   600
   Begin lstTreeView lstTree
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   False
      Border          =   True
      ColumnCount     =   1
      ColumnsResizable=   False
      ColumnWidths    =   ""
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   False
      EnableDragReorder=   False
      GridLinesHorizontal=   0
      GridLinesVertical=   0
      HasHeading      =   False
      HeadingIndex    =   -1
      Height          =   245
      HelpTag         =   ""
      Hierarchical    =   False
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   False
      Scope           =   2
      ScrollbarHorizontal=   False
      ScrollBarVertical=   True
      SelectionType   =   0
      ShowDropIndicator=   False
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   115
      Transparent     =   True
      Underline       =   False
      UseFocusRing    =   True
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin Label labClickLast
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Last Click on Tree:"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   370
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   140
   End
   Begin Label labClick
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   172
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   9
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "..."
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   370
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   408
   End
   Begin RadioButton radShowHintColumn
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   "Show Hint Column"
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   279
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   13
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   445
      Transparent     =   True
      Underline       =   False
      Value           =   True
      Visible         =   True
      Width           =   200
   End
   Begin Label labInfo
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   64
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Switch Status with:\n  - Contextual Menu\n  - Keys: b, g, o, r, y\n  - Change: Double-Click, <space>"
      TextAlign       =   0
      TextColor       =   &c00000000
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   416
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   247
   End
   Begin Separator sepBottom
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   4
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   400
      Transparent     =   True
      Visible         =   True
      Width           =   600
   End
   Begin RadioButton radShowCaptionColumn
      AutoDeactivate  =   True
      Bold            =   False
      Caption         =   " Caption Column only "
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   279
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Scope           =   2
      TabIndex        =   12
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   415
      Transparent     =   True
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   200
   End
   Begin Canvas cnvAppIcon
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   64
      HelpTag         =   "#constWebsiteUrl"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   20
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   20
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   64
   End
   Begin Canvas cnvPayPal
      AcceptFocus     =   False
      AcceptTabs      =   False
      AutoDeactivate  =   True
      Backdrop        =   0
      DoubleBuffer    =   False
      Enabled         =   True
      EraseBackground =   True
      Height          =   30
      HelpTag         =   "https://paypal.me/jotools"
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   474
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   54
      Transparent     =   True
      UseFocusRing    =   True
      Visible         =   True
      Width           =   106
   End
   Begin Label labAppName
      AutoDeactivate  =   True
      Bold            =   True
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   30
      HelpTag         =   "#constWebsiteUrl"
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   100
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "AppName"
      TextAlign       =   1
      TextColor       =   &c0072D800
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   True
      Underline       =   True
      Visible         =   True
      Width           =   160
   End
   Begin Label labAppVersion
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   30
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   100
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "AppVersion"
      TextAlign       =   1
      TextColor       =   &c00000000
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   54
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   160
   End
   Begin Label labContact
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   30
      HelpTag         =   "xojo@jo-tools.ch"
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   394
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Contact"
      TextAlign       =   1
      TextColor       =   &c0072CE00
      TextFont        =   "System"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   54
      Transparent     =   True
      Underline       =   True
      Visible         =   True
      Width           =   70
   End
   Begin Label labThanks
      AutoDeactivate  =   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   30
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   371
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Would you like to say 'Thank you'?"
      TextAlign       =   2
      TextColor       =   &c66666600
      TextFont        =   "SmallSystem"
      TextSize        =   0.0
      TextUnit        =   0
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   209
   End
   Begin Separator sepTop
      AutoDeactivate  =   True
      Enabled         =   True
      Height          =   3
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      Top             =   100
      Transparent     =   True
      Visible         =   True
      Width           =   600
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  self.Title = constAppName
		  
		  self.Tree_Setup()
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function ColorValue(piIconColor As IconColor) As Color
		  Dim oColor As Color = &c000000
		  select case piIconColor
		  case IconColor.Blue
		    oColor = &c1F417B00
		  case IconColor.Green
		    oColor = &c73A86000
		  case IconColor.Orange
		    oColor = &cCC752F00
		  case IconColor.Red
		    oColor = &cBB372400
		  case IconColor.Yellow
		    oColor = &cD4CF5100
		  end select
		  
		  return oColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Icon(piIconColor As IconColor) As Picture
		  Dim pa() As Picture
		  
		  Dim oColor As Color = me.ColorValue(piIconColor)
		  
		  Dim oIcon As New Picture(12, 12)
		  oIcon.Graphics.ForeColor = oColor
		  oIcon.Graphics.FillOval(0, 0, 12, 12)
		  oIcon.Graphics.ForeColor = &c000000
		  oIcon.Graphics.DrawOval(0, 0, 12, 12)
		  pa.Append(oIcon)
		  
		  oIcon = New Picture(24, 24)
		  oIcon.Graphics.ForeColor = oColor
		  oIcon.Graphics.FillOval(0, 0, 24, 24)
		  oIcon.Graphics.ForeColor = &c000000
		  oIcon.Graphics.DrawOval(0, 0, 24, 24)
		  pa.Append(oIcon)
		  
		  return new Picture(12, 12, pa)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function StatusValue(piIconColor As IconColor) As Integer
		  return Integer(piIconColor)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Tree_Init(psSelectKey As String)
		  'clear first
		  lstTree.Data_Clear
		  'assign our hierarchical list of CTreeListedValues
		  lstTree.Data_TreeStructure = eoTree
		  'show with/without the Hints-Column?
		  lstTree.Data_Init(radShowHintColumn.Value)
		  
		  if (psSelectKey <> "") then
		    'select this item
		    lstTree.Sel_Key_InCurrentView = psSelectKey
		  end if
		  
		  lstTree.SetFocus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Tree_Setup()
		  'Helper Variables to make example more readable
		  Dim bIsExpanded As Boolean = true
		  Dim bIsNotExpanded As Boolean = false
		  
		  'Build a hierarchical list (CTreeListedValues)
		  '(we do it backwards here - you can of course do this in a recursive manner)
		  
		  Dim oSubTree13 As New CTreeListedValues
		  oSubTree13.Append("Name 1.3.1", "Hint 1.3.1", "Key 1.3.1", me.StatusValue(IconColor.Green), bIsNotExpanded, nil, "Data 1.3.1")
		  oSubTree13.Append("Name 1.3.2", "Hint 1.3.2", "Key 1.3.2", me.StatusValue(IconColor.Blue), bIsNotExpanded, nil, "Data 1.3.2")
		  
		  Dim oSubTree12 As New CTreeListedValues
		  oSubTree12.Append("Name 1.2.1", "Hint 1.2.1", "Key 1.2.1", me.StatusValue(IconColor.Red), bIsNotExpanded, nil, "Data 1.2.1")
		  oSubTree12.Append("Name 1.2.2", "Hint 1.2.2", "Key 1.2.2", me.StatusValue(IconColor.Green), bIsNotExpanded, nil, "Data 1.2.2")
		  
		  Dim oSubTree11 As New CTreeListedValues
		  oSubTree11.Append("Name 1.1.1", "Hint 1.1.1", "Key 1.1.1", me.StatusValue(IconColor.Blue), bIsNotExpanded, nil, "Data 1.1.1")
		  oSubTree11.Append("Name 1.1.2", "Hint 1.1.2", "Key 1.1.2", me.StatusValue(IconColor.Orange), bIsNotExpanded, nil, "Data 1.1.2")
		  
		  
		  Dim oSubTree1 As New CTreeListedValues
		  oSubTree1.Append("Name 1.1", "Hint 1.1", "Key 1.1", Self.constNoStatus, bIsExpanded, oSubTree11, "Data 1.1")
		  oSubTree1.Append("Name 1.2", "Hint 1.2", "Key 1.2", Self.constNoStatus, bIsNotExpanded, oSubTree12, "Data 1.2")
		  oSubTree1.Append("Name 1.3", "Hint 1.3", "Key 1.3", self.constNoStatus, bIsNotExpanded, oSubTree13, "Data 1.3")
		  
		  Dim oSubTree3 As New CTreeListedValues
		  oSubTree3.Append("Name 3.1", "Hint 3.1", "Key 3.1", me.StatusValue(IconColor.Green), bIsNotExpanded, nil, "Data 3.1")
		  oSubTree3.Append("Name 3.2", "Hint 3.2", "Key 3.2", me.StatusValue(IconColor.Blue), bIsNotExpanded, nil, "Data 3.2")
		  oSubTree3.Append("Name 3.3", "Hint 3.3", "Key 3.3", me.StatusValue(IconColor.Red), bIsNotExpanded, nil, "Data 3.3")
		  
		  'This is our final example hierarchical list, which will be represented in the TreeView
		  '(Item 1 and 3 have a sub-tree, 2 doesn't)
		  eoTree = New CTreeListedValues
		  eoTree.Append("Name 1", "Hint 1", "Key 1", self.constNoStatus, bIsExpanded, oSubTree1, "Data 1")
		  eoTree.Append("Name 2", "Hint 2", "Key 2", Self.constNoStatus, bIsNotExpanded, nil, "Data 2")
		  eoTree.Append("Name 3", "Hint 3", "Key 3", self.constNoStatus, bIsExpanded, oSubTree3, "Data 3")
		  
		  
		  'Setup Icons and Colors for the TreeView
		  Dim dictIcons As New Dictionary
		  dictIcons.Value(1) = me.Icon(IconColor.Blue)
		  dictIcons.Value(2) = me.Icon(IconColor.Green)
		  dictIcons.Value(3) = me.Icon(IconColor.Orange)
		  dictIcons.Value(4) = me.Icon(IconColor.Red)
		  dictIcons.Value(5) = me.Icon(IconColor.Yellow)
		  lstTree.Data_StatusIcons(dictIcons)
		  
		  Dim dictColors As New Dictionary
		  dictColors.Value(1) = me.ColorValue(IconColor.Blue)
		  dictColors.Value(2) = me.ColorValue(IconColor.Green)
		  dictColors.Value(3) = me.ColorValue(IconColor.Orange)
		  dictColors.Value(4) = me.ColorValue(IconColor.Red)
		  dictColors.Value(5) = me.ColorValue(IconColor.Yellow)
		  lstTree.Data_StatusColors(dictColors, true)
		  
		  'Show the Tree
		  me.Tree_Init("")
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private eoTree As CTreeListedValues
	#tag EndProperty


	#tag Constant, Name = constAppName, Type = String, Dynamic = False, Default = \"Tree View", Scope = Private
	#tag EndConstant

	#tag Constant, Name = constNoStatus, Type = Double, Dynamic = False, Default = \"0", Scope = Private
	#tag EndConstant

	#tag Constant, Name = constWebsiteUrl, Type = String, Dynamic = False, Default = \"https://www.jo-tools.ch/xojo/treeview/", Scope = Private
	#tag EndConstant


	#tag Enum, Name = IconColor, Type = Integer, Flags = &h21
		Blue=1
		  Green=2
		  Orange=3
		  Red=4
		Yellow=5
	#tag EndEnum


#tag EndWindowCode

#tag Events lstTree
	#tag Event
		Sub OnTreeClick(poTreeList As CTreeListedValues, piPos As Integer)
		  labClick.Text = "Status: " + Str(poTreeList.Status(piPos)) + ", Data: " + Str(poTreeList.Data(piPos)) + ", Key: " + Str(poTreeList.Key(piPos))
		End Sub
	#tag EndEvent
	#tag Event
		Sub OnRequestStatusChange(poTreeList As CTreeListedValues, piPos As Integer, ByRef pbDoRefresh As Boolean, piStatus As Integer = -1, psKeyPressed As String = "", pvData As Variant)
		  #pragma unused piStatus
		  #pragma unused pvData
		  'no changes for items with a sublist or status <= 0
		  if (poTreeList.Status(piPos) <= 0) then
		    'if item has a sublist, do a change -> expand it
		    if (poTreeList.SubList(piPos) <> nil) then
		      poTreeList.Expanded(piPos) = (not poTreeList.Expanded(piPos))
		      pbDoRefresh = true
		    end if
		    return
		  end if
		  
		  'only changes allowed for entries
		  if (psKeyPressed <> "") and (psKeyPressed <> " ") then
		    
		    pbDoRefresh = true
		    
		    select case psKeyPressed
		      
		    case "b"
		      poTreeList.Status(piPos) = 1
		    case "g"
		      poTreeList.Status(piPos) = 2
		    case "o"
		      poTreeList.Status(piPos) = 3
		    case "r"
		      poTreeList.Status(piPos) = 4
		    case "y"
		      poTreeList.Status(piPos) = 5
		      
		    else
		      pbDoRefresh = false
		    end select
		    
		    return
		  end if
		  
		  'Space (not handled above) or Double-Click: Switch Status
		  Dim iStatus As Integer = poTreeList.Status(piPos)
		  select case iStatus
		  case 1
		    iStatus = 2
		  case 2
		    iStatus = 3
		  case 3
		    iStatus = 4
		  case 4
		    iStatus = 5
		  else '5
		    iStatus = 1
		  end select
		  poTreeList.Status(piPos) = iStatus
		  pbDoRefresh = true
		  return
		End Sub
	#tag EndEvent
	#tag Event
		Function OnRequestStatusChangeMenu(poTreeList As CTreeListedValues, piPos As Integer, piStatus As Integer = -1, pvData As Variant) As MenuItem
		  #pragma unused piStatus
		  #pragma unused pvData
		  
		  'no changes for items with a sublist or status <= 0
		  if (poTreeList.SubList(piPos) <> nil) or (poTreeList.Status(piPos) <= 0) then
		    return nil
		  end if
		  
		  Dim oMenu As New MenuItem
		  
		  Dim oMenuItemBlue As New MenuItem
		  oMenuItemBlue.Text = "Blue"
		  oMenuItemBlue.Name = "mnuBlue"
		  oMenuItemBlue.Checked = (poTreeList.Status(piPos) = 1)
		  oMenu.Append(oMenuItemBlue)
		  
		  Dim oMenuItemGreen As New MenuItem
		  oMenuItemGreen.Text = "Green"
		  oMenuItemGreen.Name = "mnuGreen"
		  oMenuItemGreen.Checked = (poTreeList.Status(piPos) = 2)
		  oMenu.Append(oMenuItemGreen)
		  
		  Dim oMenuItemOrange As New MenuItem
		  oMenuItemOrange.Text = "Orange"
		  oMenuItemOrange.Name = "mnuOrange"
		  oMenuItemOrange.Checked = (poTreeList.Status(piPos) = 3)
		  oMenu.Append(oMenuItemOrange)
		  
		  Dim oMenuItemRed As New MenuItem
		  oMenuItemRed.Text = "Red"
		  oMenuItemRed.Name = "mnuRed"
		  oMenuItemRed.Checked = (poTreeList.Status(piPos) = 4)
		  oMenu.Append(oMenuItemRed)
		  
		  Dim oMenuItemYellow As New MenuItem
		  oMenuItemYellow.Text = "Yellow"
		  oMenuItemYellow.Name = "mnuYellow"
		  oMenuItemYellow.Checked = (poTreeList.Status(piPos) = 5)
		  oMenu.Append(oMenuItemYellow)
		  
		  return oMenu
		End Function
	#tag EndEvent
	#tag Event
		Function OnRequestStatusChangeMenuActionKey(psMenuName As String) As String
		  select case psMenuName
		    
		  case "mnuBlue"
		    return "b"
		    
		  case "mnuGreen"
		    return "g"
		    
		  case "mnuOrange"
		    return "o"
		    
		  case "mnuRed"
		    return "r"
		    
		  case "mnuYellow"
		    return "y"
		    
		  end select
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events radShowHintColumn
	#tag Event
		Sub Action()
		  Dim sSelectedKey As String = lstTree.Sel_Key()
		  self.Tree_Init(sSelectedKey)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events radShowCaptionColumn
	#tag Event
		Sub Action()
		  Dim sSelectedKey As String = lstTree.Sel_Key()
		  self.Tree_Init(sSelectedKey)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events cnvAppIcon
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma unused areas
		  
		  g.DrawPicture(AppIcon_64, 0, 0)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If (x >= 0) And (x < Me.Width) And (y > 0) And (y < Me.Height) Then
		    ShowURL(constWebsiteUrl)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #Pragma unused X
		  #Pragma unused Y
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  Me.MouseCursor = Nil
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  Me.MouseCursor = System.Cursors.FingerPointer
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events cnvPayPal
	#tag Event
		Sub Paint(g As Graphics, areas() As REALbasic.Rect)
		  #Pragma unused areas
		  
		  g.ForeColor = &cFFFFFF
		  #If (XojoVersion >= 2018.03) Then
		    If IsDarkMode Then g.ForeColor = &cD0D0D0
		  #EndIf
		  g.FillRect(0, 0, g.Width, g.Height)
		  g.ForeColor = &c909090
		  g.DrawRect(0, 0, g.Width, g.Height)
		  g.DrawPicture(PayPal, 3, 2, 100, 26, 0, 0, PayPal.Width, PayPal.Height)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  Me.MouseCursor = Nil
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  Me.MouseCursor = System.Cursors.FingerPointer
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If (x >= 0) And (x < Me.Width) And (y > 0) And (y < Me.Height) Then
		    ShowURL("https://paypal.me/jotools")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #Pragma unused X
		  #Pragma unused Y
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events labAppName
	#tag Event
		Sub Open()
		  Me.Text = constAppName
		  Me.TextSize = 18
		  Me.Bold = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If (x >= 0) And (x < Me.Width) And (y > 0) And (y < Me.Height) Then
		    ShowURL(constWebsiteUrl)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #Pragma unused X
		  #Pragma unused Y
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseExit()
		  Me.MouseCursor = Nil
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  Me.MouseCursor = System.Cursors.FingerPointer
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events labAppVersion
	#tag Event
		Sub Open()
		  If (App.ShortVersion <> "") Then
		    Me.Text = App.ShortVersion
		    Return
		  End If
		  
		  Me.Text = Str(App.MajorVersion) + "." + Str(App.MinorVersion) + "." + Str(App.BugVersion)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events labContact
	#tag Event
		Sub MouseExit()
		  Me.MouseCursor = Nil
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseEnter()
		  Me.MouseCursor = System.Cursors.FingerPointer
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(X As Integer, Y As Integer) As Boolean
		  #Pragma unused X
		  #Pragma unused Y
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseUp(X As Integer, Y As Integer)
		  If (x >= 0) And (x < Me.Width) And (y > 0) And (y < Me.Height) Then
		    ShowURL("mailto:xojo@jo-tools.ch")
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="Name"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Interfaces"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Super"
		Visible=true
		Group="ID"
		Type="String"
		EditorType="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaxHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Frame"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Document"
			"1 - Movable Modal"
			"2 - Modal Dialog"
			"3 - Floating Window"
			"4 - Plain Box"
			"5 - Shadowed Box"
			"6 - Rounded Window"
			"7 - Global Floating Window"
			"8 - Sheet Window"
			"9 - Metal Window"
			"11 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
	#tag EndViewProperty
	#tag ViewProperty
		Name="CloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Placement"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Integer"
		EditorType="Enum"
		#tag EnumValues
			"0 - Default"
			"1 - Parent Window"
			"2 - Main Screen"
			"3 - Parent Window Screen"
			"4 - Stagger"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="LiveResize"
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasBackColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="Color"
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		Type="Picture"
		EditorType="Picture"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		Type="MenuBar"
		EditorType="MenuBar"
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType="Boolean"
	#tag EndViewProperty
#tag EndViewBehavior
