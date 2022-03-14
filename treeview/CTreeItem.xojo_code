#tag Class
Protected Class CTreeItem
	#tag Method, Flags = &h0
		Function Caption() As String
		  Return Me.esCaption
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Caption(Assigns psCaption As String)
		  Me.esCaption = psCaption
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Data() As Variant
		  Return Me.evData
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data(Assigns pvData As Variant)
		  Me.evData = pvData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  Me.eoTreeMain = Nil
		  Me.eoTreeSub = Nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Expanded() As Boolean
		  Return Me.ebExpanded
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Expanded(Assigns pbExpanded As Boolean)
		  Me.ebExpanded = pbExpanded
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hint() As String
		  Return Me.esHint
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Hint(Assigns psHint As String)
		  Me.esHint = psHint
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key() As Variant
		  Return Me.evKey
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Key(Assigns pvKey As Variant)
		  Me.evKey = pvKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Level() As Integer
		  Return Me.eiLevel
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Level(Assigns piLevel As Integer)
		  Me.eiLevel = piLevel
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParentName() As String
		  Return Me.esParentName
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ParentName(Assigns psParentName As String)
		  Me.esParentName = psParentName
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PosItem() As Integer
		  Return Me.eiPosItem
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PosItem(Assigns piPosItem As Integer)
		  Me.eiPosItem = piPosItem
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PosParent() As Integer
		  Return Me.eiPosParent
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PosParent(Assigns piPosParent As Integer)
		  Me.eiPosParent = piPosParent
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status() As Integer
		  Return Me.eiStatus
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Status(Assigns piStatus As Integer)
		  Me.eiStatus = piStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TreeMain() As CTreeListedValues
		  Return Me.eoTreeMain
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TreeMain(Assigns poMainbTree As CTreeListedValues)
		  Me.eoTreeMain = poMainbTree
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TreeSub() As CTreeListedValues
		  Return Me.eoTreeSub
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TreeSub(Assigns poTreeSub As CTreeListedValues)
		  Me.eoTreeSub = poTreeSub
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
