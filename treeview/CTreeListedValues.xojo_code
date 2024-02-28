#tag Class
Class CTreeListedValues
	#tag Method, Flags = &h0
		Sub Add(psName As String, psHint As String, psKey As String, piStatus As Integer, pbExpanded As Boolean, poSubList As CTreeListedValues = nil, pvData As Variant = nil, pbOnlyIfMissing As Boolean = False)
		  If pbOnlyIfMissing Then
		    If (Me.PosOfName(psName) >= 0) Then Return
		  End If
		  
		  easName.Add(psName)
		  easKey.Add(psKey)
		  eaiStatus.Add(piStatus)
		  easHint.Add(psHint)
		  eaoSubList.Add(poSubList)
		  If (poSubList <> Nil) Then poSubList.ParentList = Self
		  eabExpanded.Add(pbExpanded)
		  eavData.Add(pvData)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddList(poList As CTreeListedValues, pbOnlyIfMissing As Boolean = false)
		  If (poList = Nil) Or (poList.Count < 1) Then Return
		  
		  For iPos As Integer = 0 To poList.Last
		    
		    Var oSublist As CTreeListedValues
		    If (poList.SubList(iPos) <> Nil) Then
		      oSublist = New CTreeListedValues
		      oSublist.AddList(poList.SubList(iPos))
		    End If
		    
		    Me.Add(poList.Name(iPos), poList.Hint(iPos), poList.Key(iPos), poList.Status(iPos), poList.Expanded(iPos), oSublist, poList.Data(iPos), pbOnlyIfMissing)
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AddListItem(poList As CTreeListedValues, piPos As Integer, pbOnlyIfMissing As Boolean = false)
		  If (poList = Nil) Or (poList.Last < piPos) Then Return
		  
		  Var oSublist As CTreeListedValues
		  If (poList.SubList(piPos) <> Nil) Then
		    oSublist = New CTreeListedValues
		    oSublist.AddList(poList.SubList(piPos))
		  End If
		  
		  Me.Add(poList.Name(piPos), poList.Hint(piPos), poList.Key(piPos), poList.Status(piPos), poList.Expanded(piPos), oSublist, poList.Data(piPos), pbOnlyIfMissing)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  Redim easName(-1)
		  Redim easKey(-1)
		  Redim eaiStatus(-1)
		  Redim easHint(-1)
		  Redim eaoSubList(-1)
		  Redim eabExpanded(-1)
		  Redim eavData(-1)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return Me.Last + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Data(piPosition As Integer) As Variant
		  Return eavData(piPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data(piPosition As Integer, Assigns pvData As Variant)
		  eavData(piPosition) = pvData
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete(piPosition As Integer)
		  If (piPosition < 0) Then Return
		  
		  easName.RemoveAt(piPosition)
		  easKey.RemoveAt(piPosition)
		  eaiStatus.RemoveAt(piPosition)
		  easHint.RemoveAt(piPosition)
		  eaoSubList.RemoveAt(piPosition)
		  eabExpanded.RemoveAt(piPosition)
		  eavData.RemoveAt(piPosition)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteByKey(psKey As String)
		  Me.Delete(Me.PosOfKey(psKey))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteByName(psName As String)
		  Me.Delete(Me.PosOfName(psName))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Redim eabExpanded(-1)
		  Redim eaiStatus(-1)
		  Redim eaoSubList(-1)
		  Redim easHint(-1)
		  Redim easKey(-1)
		  Redim easName(-1)
		  Redim eavData(-1)
		  ParentList = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Expanded(piPosition As Integer) As Boolean
		  Return eabExpanded(piPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Expanded(piPosition As Integer, Assigns pbExpanded As Boolean)
		  eabExpanded(piPosition) = pbExpanded
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hint(piPosition As Integer) As String
		  Return easHint(piPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Hint(piPosition As Integer, Assigns psHint As String)
		  easHint(piPosition) = psHint
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key(piPosition As Integer) As String
		  If (piPosition >= 0) Then Return easKey(piPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Key(piPosition As Integer, Assigns psKey As String)
		  easKey(piPosition) = psKey
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Last() As Integer
		  Return easName.LastIndex
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name(piPosition As Integer) As String
		  If (piPosition >= 0) Then Return easName(piPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(piPosition As Integer, Assigns psName As String)
		  easName(piPosition) = psName
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParentList() As CTreeListedValues
		  If (Me.eoParentList <> Nil) And (Me.eoParentList.Value <> Nil) And (Me.eoParentList.Value IsA CTreeListedValues) Then Return CTreeListedValues(Me.eoParentList.Value)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ParentList(Assigns poParentList As CTreeListedValues)
		  Me.eoParentList = New WeakRef(poParentList)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PosOfKey(psKey As String) As Integer
		  Return easKey.IndexOf(psKey)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PosOfName(psName As String) As Integer
		  Return easName.IndexOf(psName)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SortByHint()
		  easHint.SortWith(easKey, eaiStatus, easName, eaoSubList, eabExpanded, eavData)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SortByName()
		  easName.SortWith(easKey, eaiStatus, easHint, eaoSubList, eabExpanded, eavData)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status(piPosition As Integer) As Integer
		  Return eaiStatus(piPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Status(piPosition As Integer, Assigns piStatus As Integer)
		  eaiStatus(piPosition) = piStatus
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubList(piPosition As Integer) As CTreeListedValues
		  If eaoSubList(piPosition) IsA CTreeListedValues Then
		    Return eaoSubList(piPosition)
		  Else
		    Return Nil
		  End If
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubList(piPosition As Integer, Assigns poSubList As CTreeListedValues)
		  eaoSubList(piPosition) = poSubList
		  If (poSubList <> Nil) Then poSubList.ParentList = Self
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private eabExpanded() As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eaiStatus() As Integer
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eaoSubList() As CTreeListedValues
	#tag EndProperty

	#tag Property, Flags = &h21
		Private easHint() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private easKey() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private easName() As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eavData() As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eoParentList As WeakRef
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
