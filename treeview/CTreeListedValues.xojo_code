#tag Class
Class CTreeListedValues
	#tag Method, Flags = &h0
		Sub Append(psName As String, psHint As String, psKey As String, piStatus As Integer, pbExpanded As Boolean, poSubList As CTreeListedValues = nil, pvData As Variant = nil, pbOnlyIfMissing As Boolean = False)
		  '============================================================
		  '
		  ' Listeneintrag hinzufuegen
		  '
		  '============================================================
		  
		  if pbOnlyIfMissing then
		    if (me.PosOfName(psName) >= 0) then return
		  end if
		  
		  easName.Append(psName)
		  easKey.Append(psKey)
		  eaiStatus.Append(piStatus)
		  easHint.Append(psHint)
		  eaoSubList.Append(poSubList)
		  if (poSubList <> nil) then poSubList.ParentList = self
		  eabExpanded.Append(pbExpanded)
		  eavData.Append(pvData)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendList(poList As CTreeListedValues, pbOnlyIfMissing As Boolean = false)
		  '============================================================
		  '
		  ' Listeneinträge von einer anderen Liste hinzufügen
		  '
		  '============================================================
		  
		  if (poList = nil) or (poList.Count < 1) then return
		  
		  Dim iPos As Integer
		  for iPos = 0 to poList.Last
		    'me.Append(poList.Name(iPos), poList.Hint(iPos), poList.Key(iPos), poList.Status(iPos), poList.Expanded(iPos), poList.SubList(iPos), poList.Data(iPos), pbOnlyIfMissing)
		    
		    Dim oSublist As CTreeListedValues
		    if (poList.SubList(iPos) <> nil) then
		      oSublist = New CTreeListedValues
		      oSublist.AppendList(poList.SubList(iPos))
		    end if
		    
		    me.Append(poList.Name(iPos), poList.Hint(iPos), poList.Key(iPos), poList.Status(iPos), poList.Expanded(iPos), oSublist, poList.Data(iPos), pbOnlyIfMissing)
		  next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub AppendListItem(poList As CTreeListedValues, piPos As Integer, pbOnlyIfMissing As Boolean = false)
		  '============================================================
		  '
		  ' Listeneinträge von einer anderen Liste hinzufügen
		  '
		  '============================================================
		  
		  if (poList = nil) or (poList.Last < piPos) then return
		  'me.Append(poList.Name(piPos), poList.Hint(piPos), poList.Key(piPos), poList.Status(piPos), poList.Expanded(piPos), poList.SubList(piPos), poList.Data(piPos), pbOnlyIfMissing)
		  
		  Dim oSublist As CTreeListedValues
		  if (poList.SubList(piPos) <> nil) then
		    oSublist = New CTreeListedValues
		    oSublist.AppendList(poList.SubList(piPos))
		  end if
		  
		  me.Append(poList.Name(piPos), poList.Hint(piPos), poList.Key(piPos), poList.Status(piPos), poList.Expanded(piPos), oSublist, poList.Data(piPos), pbOnlyIfMissing)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Clear()
		  '============================================================
		  '
		  ' Liste loeschen
		  '
		  '============================================================
		  
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
		  '============================================================
		  '
		  ' Anzahl Listeneintraege
		  '
		  '============================================================
		  
		  return me.Last + 1
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Data(piPosition As Integer) As Variant
		  '============================================================
		  '
		  ' Wert
		  '
		  '============================================================
		  
		  return eavData(piPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Data(piPosition As Integer, Assigns pvData As Variant)
		  '============================================================
		  '
		  ' Name
		  '
		  '============================================================
		  
		  eavData(piPosition) = pvData
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Delete(piPosition As Integer)
		  '============================================================
		  '
		  ' Listeneintrag entfernen
		  '
		  '============================================================
		  
		  if (piPosition < 0) then return
		  
		  easName.Remove(piPosition)
		  easKey.Remove(piPosition)
		  eaiStatus.Remove(piPosition)
		  easHint.Remove(piPosition)
		  eaoSubList.Remove(piPosition)
		  eabExpanded.Remove(piPosition)
		  eavData.Remove(piPosition)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteByKey(psKey As String)
		  '============================================================
		  '
		  ' Listeneintrag entfernen
		  '
		  '============================================================
		  
		  me.Delete(me.PosOfKey(psKey))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub DeleteByName(psName As String)
		  '============================================================
		  '
		  ' Listeneintrag entfernen
		  '
		  '============================================================
		  
		  me.Delete(me.PosOfName(psName))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Destructor()
		  ReDim eabExpanded(-1)
		  ReDim eaiStatus(-1)
		  ReDim eaoSubList(-1)
		  ReDim easHint(-1)
		  ReDim easKey(-1)
		  ReDim easName(-1)
		  ReDim eavData(-1)
		  ParentList = nil
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Expanded(piPosition As Integer) As Boolean
		  '============================================================
		  '
		  ' Expandiert
		  '
		  '============================================================
		  
		  return eabExpanded(piPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Expanded(piPosition As Integer, Assigns pbExpanded As Boolean)
		  '============================================================
		  '
		  ' Expandiert
		  '
		  '============================================================
		  
		  eabExpanded(piPosition) = pbExpanded
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Hint(piPosition As Integer) As String
		  '============================================================
		  '
		  ' Hint
		  '
		  '============================================================
		  
		  return easHint(piPosition)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Hint(piPosition As Integer, Assigns psHint As String)
		  '============================================================
		  '
		  ' Hint
		  '
		  '============================================================
		  
		  easHint(piPosition) = psHint
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Key(piPosition As Integer) As String
		  '============================================================
		  '
		  ' Key
		  '
		  '============================================================
		  
		  if (piPosition >= 0) then return easKey(piPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Key(piPosition As Integer, Assigns psKey As String)
		  '============================================================
		  '
		  ' Key
		  '
		  '============================================================
		  
		  easKey(piPosition) = psKey
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Last() As Integer
		  '============================================================
		  '
		  ' Letzte Positon der Listeneintraege (Anzahl - 1)
		  '
		  '============================================================
		  
		  return UBound(easName)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name(piPosition As Integer) As String
		  '============================================================
		  '
		  ' Name
		  '
		  '============================================================
		  
		  if (piPosition >= 0) then return easName(piPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(piPosition As Integer, Assigns psName As String)
		  '============================================================
		  '
		  ' Name
		  '
		  '============================================================
		  
		  easName(piPosition) = psName
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ParentList() As CTreeListedValues
		  if (me.eoParentList <> nil) and (me.eoParentList.Value <> nil) and (me.eoParentList.Value IsA CTreeListedValues) then return CTreeListedValues(me.eoParentList.Value)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub ParentList(Assigns poParentList As CTreeListedValues)
		  me.eoParentList = New WeakRef(poParentList)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PosOfKey(psKey As String) As Integer
		  '============================================================
		  '
		  ' Positon eines Listeneintrags suchen (-1 = nicht gefunden)
		  '
		  '============================================================
		  
		  return easKey.IndexOf(psKey)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function PosOfName(psName As String) As Integer
		  '============================================================
		  '
		  ' Positon eines Listeneintrags suchen (-1 = nicht gefunden)
		  '
		  '============================================================
		  
		  return easName.IndexOf(psName)
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SortByHint()
		  '============================================================
		  '
		  ' Einträge gemäss Name sortieren
		  '
		  '============================================================
		  
		  easHint.SortWith(easKey, eaiStatus, easName, eaoSubList, eabExpanded, eavData)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SortByName()
		  '============================================================
		  '
		  ' Einträge gemäss Name sortieren
		  '
		  '============================================================
		  
		  easName.SortWith(easKey, eaiStatus, easHint, eaoSubList, eabExpanded, eavData)
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Status(piPosition As Integer) As Integer
		  '============================================================
		  '
		  ' Status
		  '
		  '============================================================
		  
		  return eaiStatus(piPosition)
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Status(piPosition As Integer, Assigns piStatus As Integer)
		  '============================================================
		  '
		  ' Status
		  '
		  '============================================================
		  
		  eaiStatus(piPosition) = piStatus
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubList(piPosition As Integer) As CTreeListedValues
		  '============================================================
		  '
		  ' Subliste
		  '
		  '============================================================
		  
		  if eaoSubList(piPosition) IsA CTreeListedValues then
		    return eaoSubList(piPosition)
		  else
		    return nil
		  end if
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubList(piPosition As Integer, Assigns poSubList As CTreeListedValues)
		  '============================================================
		  '
		  ' Subliste
		  '
		  '============================================================
		  
		  eaoSubList(piPosition) = poSubList
		  if (poSubList <> nil) then poSubList.ParentList = self
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected eabExpanded() As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected eaiStatus() As Integer
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected eaoSubList() As CTreeListedValues
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected easHint() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected easKey() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected easName() As String
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected eavData() As Variant
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
