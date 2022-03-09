#tag Class
Protected Class CTreeItem
	#tag Method, Flags = &h0
		Function Caption() As String
		  return me.esCaption
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Caption(Assigns psCaption As String)
		  me.esCaption = psCaption
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Data() As Variant
		  return me.evData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data(Assigns pvData As Variant)
		  me.evData = pvData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  me.eoTreeMain = nil
		  me.eoTreeSub = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Expanded() As Boolean
		  return me.ebExpanded
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Expanded(Assigns pbExpanded As Boolean)
		  me.ebExpanded = pbExpanded
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hint() As String
		  return me.esHint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Hint(Assigns psHint As String)
		  me.esHint = psHint
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As Variant
		  return me.evKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Key(Assigns pvKey As Variant)
		  me.evKey = pvKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Level() As Integer
		  return me.eiLevel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Level(Assigns piLevel As Integer)
		  me.eiLevel = piLevel
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParentName() As String
		  return me.esParentName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ParentName(Assigns psParentName As String)
		  me.esParentName = psParentName
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PosItem() As Integer
		  return me.eiPosItem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PosItem(Assigns piPosItem As Integer)
		  me.eiPosItem = piPosItem
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PosParent() As Integer
		  return me.eiPosParent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PosParent(Assigns piPosParent As Integer)
		  me.eiPosParent = piPosParent
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As Integer
		  return me.eiStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Status(Assigns piStatus As Integer)
		  me.eiStatus = piStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TreeMain() As CTreeListedValues
		  return me.eoTreeMain
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TreeMain(Assigns poMainbTree As CTreeListedValues)
		  me.eoTreeMain = poMainbTree
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TreeSub() As CTreeListedValues
		  return me.eoTreeSub
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TreeSub(Assigns poTreeSub As CTreeListedValues)
		  me.eoTreeSub = poTreeSub
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private ebExpanded As Boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eiLevel As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eiPosItem As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eiPosParent As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eiStatus As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eoTreeMain As CTreeListedValues
	#tag EndProperty

	#tag Property, Flags = &h21
		Private eoTreeSub As CTreeListedValues
	#tag EndProperty

	#tag Property, Flags = &h21
		Private esCaption As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private esHint As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private esParentName As String
	#tag EndProperty

	#tag Property, Flags = &h21
		Private evData As Variant
	#tag EndProperty

	#tag Property, Flags = &h21
		Private evKey As Variant
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
