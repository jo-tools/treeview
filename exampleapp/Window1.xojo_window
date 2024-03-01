#tag DesktopWindow
Begin DesktopWindow Window1
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   0
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   True
   HasMinimizeButton=   True
   Height          =   500
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   57315327
   MenuBarVisible  =   True
   MinimumHeight   =   400
   MinimumWidth    =   450
   Resizeable      =   True
   Title           =   "TreeView"
   Type            =   0
   Visible         =   True
   Width           =   600
   Begin lstTreeView lstTree
      AllowAutoDeactivate=   True
      AllowAutoHideScrollbars=   True
      AllowExpandableRows=   False
      AllowFocusRing  =   True
      AllowResizableColumns=   False
      AllowRowDragging=   False
      AllowRowReordering=   False
      Bold            =   False
      ColumnCount     =   1
      ColumnWidths    =   ""
      DefaultRowHeight=   -1
      DropIndicatorVisible=   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      GridLineStyle   =   0
      HasBorder       =   True
      HasHeader       =   False
      HasHorizontalScrollbar=   False
      HasVerticalScrollbar=   True
      HeadingIndex    =   -1
      Height          =   245
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
      RowSelectionType=   0
      Scope           =   2
      TabIndex        =   7
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   115
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   560
      _ScrollOffset   =   0
      _ScrollWidth    =   -1
   End
   Begin DesktopLabel labSelectionCurrentTitle
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   False
      Scope           =   2
      Selectable      =   False
      TabIndex        =   8
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Current Selection:"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   370
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   140
   End
   Begin DesktopLabel labSelectionCurrent
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   370
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   408
   End
   Begin DesktopRadioButton radShowHintColumn
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   " Show Hint Column "
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      Tooltip         =   ""
      Top             =   445
      Transparent     =   True
      Underline       =   False
      Value           =   True
      Visible         =   True
      Width           =   200
   End
   Begin DesktopLabel labInfo
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   84
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   False
      LockTop         =   False
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   11
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "Switch Status with:\n  - Contextual Menu\n  - Keys: b, g, o, r, y\n  - Change: Double-Click, <space>"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   415
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   247
   End
   Begin DesktopSeparator sepBottom
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   4
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   10
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   400
      Transparent     =   True
      Visible         =   True
      Width           =   600
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
   Begin DesktopRadioButton radShowCaptionColumn
      AllowAutoDeactivate=   True
      Bold            =   False
      Caption         =   " Caption Column only "
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
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
      Tooltip         =   ""
      Top             =   415
      Transparent     =   True
      Underline       =   False
      Value           =   False
      Visible         =   True
      Width           =   200
   End
   Begin DesktopCanvas cnvAppIcon
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   64
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
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Visible         =   True
      Width           =   64
   End
   Begin DesktopCanvas cnvPayPal
      AllowAutoDeactivate=   True
      AllowFocus      =   False
      AllowFocusRing  =   True
      AllowTabs       =   False
      Backdrop        =   0
      Enabled         =   True
      Height          =   30
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
      Tooltip         =   ""
      Top             =   54
      Transparent     =   True
      Visible         =   True
      Width           =   106
   End
   Begin DesktopLabel labAppName
      AllowAutoDeactivate=   True
      Bold            =   True
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   30
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   100
      LockBottom      =   False
      LockedInPosition=   False
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
      TextAlignment   =   0
      TextColor       =   &c0072D800
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Underline       =   True
      Visible         =   True
      Width           =   120
   End
   Begin DesktopLabel labAppVersion
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   30
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   100
      LockBottom      =   False
      LockedInPosition=   False
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
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   54
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   120
   End
   Begin DesktopLabel labContact
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   30
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
      TextAlignment   =   0
      TextColor       =   &c0072CE00
      Tooltip         =   ""
      Top             =   54
      Transparent     =   True
      Underline       =   True
      Visible         =   True
      Width           =   70
   End
   Begin DesktopLabel labThanks
      AllowAutoDeactivate=   True
      Bold            =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   30
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
      TextAlignment   =   0
      TextColor       =   &c66666600
      Tooltip         =   ""
      Top             =   20
      Transparent     =   True
      Underline       =   False
      Visible         =   True
      Width           =   209
   End
   Begin DesktopSeparator sepTop
      Active          =   False
      AllowAutoDeactivate=   True
      AllowTabStop    =   True
      Enabled         =   True
      Height          =   3
      Index           =   -2147483648
      InitialParent   =   ""
      Left            =   0
      LockBottom      =   False
      LockedInPosition=   True
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      PanelIndex      =   0
      Scope           =   2
      TabIndex        =   6
      TabPanelIndex   =   0
      Tooltip         =   ""
      Top             =   100
      Transparent     =   True
      Visible         =   True
      Width           =   600
      _mIndex         =   0
      _mInitialParent =   ""
      _mName          =   ""
      _mPanelIndex    =   0
   End
End
#tag EndDesktopWindow

#tag WindowCode
	#tag Event
		Sub Opening()
		  Self.Title = constAppName
		  
		  #If TargetMacOS Then
		    Var rect As Xojo.Rect = Self.Bounds
		    rect.Top = DesktopDisplay.DisplayAt(0).AvailableTop
		    Self.Bounds = rect
		  #EndIf
		  
		  Self.Tree_Setup
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Function ColorValue(piIconColor As IconColor) As Color
		  Var oColor As Color = &c000000
		  
		  Select Case piIconColor
		  Case IconColor.Blue
		    oColor = &c1F417B00
		  Case IconColor.Green
		    oColor = &c73A86000
		  Case IconColor.Orange
		    oColor = &cCC752F00
		  Case IconColor.Red
		    oColor = &cBB372400
		  Case IconColor.Yellow
		    oColor = &cD4CF5100
		  End Select
		  
		  Return oColor
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function Icon(piIconColor As IconColor) As Picture
		  Var pa() As Picture
		  
		  Var oColor As Color = Me.ColorValue(piIconColor)
		  
		  Var oIcon As New Picture(12, 12)
		  oIcon.Graphics.DrawingColor = oColor
		  oIcon.Graphics.FillOval(0, 0, 12, 12)
		  oIcon.Graphics.DrawingColor = &c000000
		  oIcon.Graphics.DrawOval(0, 0, 12, 12)
		  pa.Add(oIcon)
		  
		  oIcon = New Picture(24, 24)
		  oIcon.Graphics.DrawingColor = oColor
		  oIcon.Graphics.FillOval(0, 0, 24, 24)
		  oIcon.Graphics.DrawingColor = &c000000
		  oIcon.Graphics.DrawOval(0, 0, 24, 24)
		  pa.Add(oIcon)
		  
		  Return New Picture(12, 12, pa)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function StatusValue(piIconColor As IconColor) As Integer
		  Return Integer(piIconColor)
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
		  
		  If (psSelectKey <> "") Then
		    'select this item
		    lstTree.Sel_Key_InCurrentView = psSelectKey
		  End If
		  
		  lstTree.SetFocus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Tree_Setup()
		  'Helper Variables to make example more readable
		  Var bIsExpanded As Boolean = True
		  Var bIsNotExpanded As Boolean = False
		  
		  'Build a hierarchical list (CTreeListedValues)
		  '(we do it backwards here - you can of course do this in a recursive manner)
		  
		  Var oSubTree13 As New CTreeListedValues
		  oSubTree13.Add("Name 1.3.1", "Hint 1.3.1", "Key 1.3.1", Me.StatusValue(IconColor.Green), bIsNotExpanded, Nil, "Data 1.3.1")
		  oSubTree13.Add("Name 1.3.2", "Hint 1.3.2", "Key 1.3.2", Me.StatusValue(IconColor.Blue), bIsNotExpanded, Nil, "Data 1.3.2")
		  
		  Var oSubTree12 As New CTreeListedValues
		  oSubTree12.Add("Name 1.2.1", "Hint 1.2.1", "Key 1.2.1", Me.StatusValue(IconColor.Red), bIsNotExpanded, Nil, "Data 1.2.1")
		  oSubTree12.Add("Name 1.2.2", "Hint 1.2.2", "Key 1.2.2", Me.StatusValue(IconColor.Green), bIsNotExpanded, Nil, "Data 1.2.2")
		  
		  Var oSubTree11 As New CTreeListedValues
		  oSubTree11.Add("Name 1.1.1", "Hint 1.1.1", "Key 1.1.1", Me.StatusValue(IconColor.Blue), bIsNotExpanded, Nil, "Data 1.1.1")
		  oSubTree11.Add("Name 1.1.2", "Hint 1.1.2", "Key 1.1.2", Me.StatusValue(IconColor.Orange), bIsNotExpanded, Nil, "Data 1.1.2")
		  
		  
		  Var oSubTree1 As New CTreeListedValues
		  oSubTree1.Add("Name 1.1", "Hint 1.1", "Key 1.1", Self.constNoStatus, bIsExpanded, oSubTree11, "Data 1.1")
		  oSubTree1.Add("Name 1.2", "Hint 1.2", "Key 1.2", Self.constNoStatus, bIsNotExpanded, oSubTree12, "Data 1.2")
		  oSubTree1.Add("Name 1.3", "Hint 1.3", "Key 1.3", Self.constNoStatus, bIsNotExpanded, oSubTree13, "Data 1.3")
		  
		  Var oSubTree3 As New CTreeListedValues
		  oSubTree3.Add("Name 3.1", "Hint 3.1", "Key 3.1", Me.StatusValue(IconColor.Green), bIsNotExpanded, Nil, "Data 3.1")
		  oSubTree3.Add("Name 3.2", "Hint 3.2", "Key 3.2", Me.StatusValue(IconColor.Blue), bIsNotExpanded, Nil, "Data 3.2")
		  oSubTree3.Add("Name 3.3", "Hint 3.3", "Key 3.3", Me.StatusValue(IconColor.Red), bIsNotExpanded, Nil, "Data 3.3")
		  
		  'This is our final example hierarchical list, which will be represented in the TreeView
		  '(Item 1 and 3 have a sub-tree, 2 doesn't)
		  eoTree = New CTreeListedValues
		  eoTree.Add("Name 1", "Hint 1", "Key 1", Self.constNoStatus, bIsExpanded, oSubTree1, "Data 1")
		  eoTree.Add("Name 2", "Hint 2", "Key 2", Self.constNoStatus, bIsNotExpanded, Nil, "Data 2")
		  eoTree.Add("Name 3", "Hint 3", "Key 3", Self.constNoStatus, bIsExpanded, oSubTree3, "Data 3")
		  
		  
		  'Setup Icons and Colors for the TreeView
		  Var dictIcons As New Dictionary
		  dictIcons.Value(1) = Me.Icon(IconColor.Blue)
		  dictIcons.Value(2) = Me.Icon(IconColor.Green)
		  dictIcons.Value(3) = Me.Icon(IconColor.Orange)
		  dictIcons.Value(4) = Me.Icon(IconColor.Red)
		  dictIcons.Value(5) = Me.Icon(IconColor.Yellow)
		  lstTree.Data_StatusIcons(dictIcons)
		  
		  Var dictColors As New Dictionary
		  dictColors.Value(1) = Me.ColorValue(IconColor.Blue)
		  dictColors.Value(2) = Me.ColorValue(IconColor.Green)
		  dictColors.Value(3) = Me.ColorValue(IconColor.Orange)
		  dictColors.Value(4) = Me.ColorValue(IconColor.Red)
		  dictColors.Value(5) = Me.ColorValue(IconColor.Yellow)
		  lstTree.Data_StatusColors(dictColors, True)
		  
		  'Show the Tree
		  Me.Tree_Init("Key 1")
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
		Sub OnExpandCollapseAll_Recursive(poTreeList As CTreeListedValues, piPos As Integer)
		  labSelectionCurrent.Text = "Status: " + Str(poTreeList.Status(piPos)) + ", Data: " + Str(poTreeList.Data(piPos)) + ", Key: " + Str(poTreeList.Key(piPos))
		End Sub
	#tag EndEvent
	#tag Event
		Sub OnRequestStatusChange(poTreeList As CTreeListedValues, piPos As Integer, ByRef pbDoRefresh As Boolean, piStatus As Integer = -1, psKeyPressed As String = "", pvData As Variant)
		  #Pragma unused piStatus
		  #Pragma unused pvData
		  'no changes for items with a sublist or status <= 0
		  If (poTreeList.Status(piPos) <= 0) Then
		    'if item has a sublist, do a change -> expand it
		    If (poTreeList.SubList(piPos) <> Nil) Then
		      poTreeList.Expanded(piPos) = (Not poTreeList.Expanded(piPos))
		      pbDoRefresh = True
		    End If
		    Return
		  End If
		  
		  'only changes allowed for entries
		  If (psKeyPressed <> "") And (psKeyPressed <> " ") Then
		    
		    pbDoRefresh = True
		    
		    Select Case psKeyPressed
		      
		    Case "b"
		      poTreeList.Status(piPos) = 1
		    Case "g"
		      poTreeList.Status(piPos) = 2
		    Case "o"
		      poTreeList.Status(piPos) = 3
		    Case "r"
		      poTreeList.Status(piPos) = 4
		    Case "y"
		      poTreeList.Status(piPos) = 5
		      
		    Else
		      pbDoRefresh = False
		    End Select
		    
		    Return
		  End If
		  
		  'Space (not handled above) or Double-Click: Switch Status
		  Var iStatus As Integer = poTreeList.Status(piPos)
		  Select Case iStatus
		  Case 1
		    iStatus = 2
		  Case 2
		    iStatus = 3
		  Case 3
		    iStatus = 4
		  Case 4
		    iStatus = 5
		  Else '5
		    iStatus = 1
		  End Select
		  poTreeList.Status(piPos) = iStatus
		  pbDoRefresh = True
		  Return
		End Sub
	#tag EndEvent
	#tag Event
		Function OnRequestStatusChangeMenu(poTreeList As CTreeListedValues, piPos As Integer, piStatus As Integer = -1, pvData As Variant) As DesktopMenuItem
		  #Pragma unused piStatus
		  #Pragma unused pvData
		  
		  'no changes for items with a sublist or status <= 0
		  If (poTreeList.SubList(piPos) <> Nil) Or (poTreeList.Status(piPos) <= 0) Then
		    Return Nil
		  End If
		  
		  Var oMenu As New DesktopMenuItem
		  
		  Var oMenuItemBlue As New DesktopMenuItem
		  oMenuItemBlue.Text = "Blue"
		  oMenuItemBlue.Name = "mnuBlue"
		  oMenuItemBlue.HasCheckMark = (poTreeList.Status(piPos) = 1)
		  oMenu.AddMenu(oMenuItemBlue)
		  
		  Var oMenuItemGreen As New DesktopMenuItem
		  oMenuItemGreen.Text = "Green"
		  oMenuItemGreen.Name = "mnuGreen"
		  oMenuItemGreen.HasCheckMark = (poTreeList.Status(piPos) = 2)
		  oMenu.AddMenu(oMenuItemGreen)
		  
		  Var oMenuItemOrange As New DesktopMenuItem
		  oMenuItemOrange.Text = "Orange"
		  oMenuItemOrange.Name = "mnuOrange"
		  oMenuItemOrange.HasCheckMark = (poTreeList.Status(piPos) = 3)
		  oMenu.AddMenu(oMenuItemOrange)
		  
		  Var oMenuItemRed As New DesktopMenuItem
		  oMenuItemRed.Text = "Red"
		  oMenuItemRed.Name = "mnuRed"
		  oMenuItemRed.HasCheckMark = (poTreeList.Status(piPos) = 4)
		  oMenu.AddMenu(oMenuItemRed)
		  
		  Var oMenuItemYellow As New DesktopMenuItem
		  oMenuItemYellow.Text = "Yellow"
		  oMenuItemYellow.Name = "mnuYellow"
		  oMenuItemYellow.HasCheckMark = (poTreeList.Status(piPos) = 5)
		  oMenu.AddMenu(oMenuItemYellow)
		  
		  Return oMenu
		End Function
	#tag EndEvent
	#tag Event
		Function OnRequestStatusChangeMenuActionKey(psMenuName As String) As String
		  Select Case psMenuName
		    
		  Case "mnuBlue"
		    Return "b"
		    
		  Case "mnuGreen"
		    Return "g"
		    
		  Case "mnuOrange"
		    Return "o"
		    
		  Case "mnuRed"
		    Return "r"
		    
		  Case "mnuYellow"
		    Return "y"
		    
		  End Select
		End Function
	#tag EndEvent
	#tag Event
		Sub OnChange(poTreeList As CTreeListedValues, piPos As Integer)
		  labSelectionCurrent.Text = "Status: " + Str(poTreeList.Status(piPos)) + ", Data: " + Str(poTreeList.Data(piPos)) + ", Key: " + Str(poTreeList.Key(piPos))
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events radShowHintColumn
	#tag Event
		Sub ValueChanged()
		  Var sSelectedKey As String = lstTree.Sel_Key
		  Self.Tree_Init(sSelectedKey)
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events radShowCaptionColumn
	#tag Event
		Sub ValueChanged()
		  Var sSelectedKey As String = lstTree.Sel_Key
		  Self.Tree_Init(sSelectedKey)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events cnvAppIcon
	#tag Event
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma unused areas
		  
		  g.DrawPicture(AppIcon_64, 0, 0)
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  If (x >= 0) And (x < Me.Width) And (y > 0) And (y < Me.Height) Then
		    System.GotoURL(constWebsiteUrl)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
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
		Sub Paint(g As Graphics, areas() As Rect)
		  #Pragma unused areas
		  
		  g.DrawingColor = &cFFFFFF
		  If Color.IsDarkMode Then g.DrawingColor = &cD0D0D0
		  g.FillRectangle(0, 0, g.Width, g.Height)
		  g.DrawingColor = &c909090
		  g.DrawRectangle(0, 0, g.Width, g.Height)
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
		Sub MouseUp(x As Integer, y As Integer)
		  If (x >= 0) And (x < Me.Width) And (y > 0) And (y < Me.Height) Then
		    System.GotoURL("https://paypal.me/jotools")
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  #Pragma unused X
		  #Pragma unused Y
		  
		  Return True
		End Function
	#tag EndEvent
#tag EndEvents
#tag Events labAppName
	#tag Event
		Sub Opening()
		  Me.Text = constAppName
		  Me.FontSize = 18
		  Me.Bold = True
		End Sub
	#tag EndEvent
	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  If (x >= 0) And (x < Me.Width) And (y > 0) And (y < Me.Height) Then
		    System.GotoURL(constWebsiteUrl)
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Function MouseDown(x As Integer, y As Integer) As Boolean
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
		Sub Opening()
		  If (App.Version <> "") Then
		    Me.Text = App.Version
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
		Function MouseDown(x As Integer, y As Integer) As Boolean
		  #Pragma unused X
		  #Pragma unused Y
		  
		  Return True
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseUp(x As Integer, y As Integer)
		  If (x >= 0) And (x < Me.Width) And (y > 0) And (y < Me.Height) Then
		    System.GotoURL("mailto:xojo@jo-tools.ch")
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag ViewBehavior
	#tag ViewProperty
		Name="MinimumWidth"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MinimumHeight"
		Visible=true
		Group="Size"
		InitialValue="64"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumWidth"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MaximumHeight"
		Visible=true
		Group="Size"
		InitialValue="32000"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Type"
		Visible=true
		Group="Frame"
		InitialValue="0"
		Type="Types"
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
			"9 - Modeless Dialog"
		#tag EndEnumValues
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasCloseButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMaximizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasMinimizeButton"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="HasFullScreenButton"
		Visible=true
		Group="Frame"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="DefaultLocation"
		Visible=true
		Group="Behavior"
		InitialValue="0"
		Type="Locations"
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
		Name="HasBackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="BackgroundColor"
		Visible=true
		Group="Background"
		InitialValue="&hFFFFFF"
		Type="ColorGroup"
		EditorType="ColorGroup"
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
		Name="Interfaces"
		Visible=true
		Group="ID"
		InitialValue=""
		Type="String"
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
		Name="Width"
		Visible=true
		Group="Size"
		InitialValue="600"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Height"
		Visible=true
		Group="Size"
		InitialValue="400"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Title"
		Visible=true
		Group="Frame"
		InitialValue="Untitled"
		Type="String"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Resizeable"
		Visible=true
		Group="Frame"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Composite"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MacProcID"
		Visible=false
		Group="OS X (Carbon)"
		InitialValue="0"
		Type="Integer"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="ImplicitInstance"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Visible"
		Visible=true
		Group="Behavior"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="FullScreen"
		Visible=false
		Group="Behavior"
		InitialValue="False"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="Backdrop"
		Visible=true
		Group="Background"
		InitialValue=""
		Type="Picture"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBar"
		Visible=true
		Group="Menus"
		InitialValue=""
		Type="DesktopMenuBar"
		EditorType=""
	#tag EndViewProperty
	#tag ViewProperty
		Name="MenuBarVisible"
		Visible=true
		Group="Deprecated"
		InitialValue="True"
		Type="Boolean"
		EditorType=""
	#tag EndViewProperty
#tag EndViewBehavior
