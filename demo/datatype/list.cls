Class demo.datatype.list Extends %RegisteredObject
{

ClassMethod Find()
{
    set myList = $lb("apple","orange","banana","grape")
    set searchValue = "banana"

    set position = $LISTFIND(myList, searchValue)
    if position > 0 {
        write "值 '", searchValue, "' 在列表中的位置是 ", position
    } else {
        write "值 '", searchValue, "' 未在列表中找到"
    }
}

ClassMethod ListToString()
{
    s Diagnosis = "sss(ss);sss;iiii();ssjjsj"
    s DiagStr = ""
    f i=1:1:$l(Diagnosis,";"){
		s diag = $p($g(Diagnosis),";",i)
		set start = $FIND(diag, "(")  // Find the position of the opening parenthesis
		set end = $FIND(diag, ")", start)  // Find the position of the closing parenthesis starting from the position of the opening parenthesis

		if (start > 0) && (end > start) {  // Ensure both the opening and closing parentheses are found
		    set Diag = $EXTRACT(diag, start, end-2)  // Extract the content between the parentheses
		}
		s:($g(Diag)'="")&&(DiagStr'="") DiagStr = DiagStr_";"_$g(Diag)
        s:($g(Diag)'="")&&(DiagStr="") DiagStr = $g(Diag)
	}
    q DiagStr
}

ClassMethod ListFind()
{
    SET list=$LB(1,4,5)
    SET value=5
    SET index=$LISTFIND(list,value)
    IF index=0 {
        WRITE "Value not found in the list"
    } ELSE {
        WRITE "Value found at index: ",index
    }
    Q ""
}

ClassMethod List()
{
    set Colors = ##class(%Library.ListOfDataTypes).%New()
    do Colors.Insert("Red")
    do Colors.Insert("Green")
    do Colors.Insert("Blue")

    write "Number of list items: ", Colors.Count()
    write !, "Second list item: ", Colors.GetAt(2)

    do Colors.SetAt("Yellow",2)
    write !, "New second item: ", Colors.GetAt(2)

    write !, "Third item before insertion: ", Colors.GetAt(3)
    do Colors.InsertAt("Purple",3)
    write !, "Number of items after insertion: ", Colors.Count()
    write !, "Third item after insertion: ", Colors.GetAt(3)
    write !, "Fourth item after insertion: ", Colors.GetAt(4)

    do Colors.RemoveAt(3)
    write "Number of items after removing item 3: ", Colors.Count()

    write "List items:"
    for i = 1:1:Colors.Count() write Colors.GetAt(i),!
}

ClassMethod ListPy() [ Language = python ]
{
    import iris

    Colors=iris.cls("%Library.ListOfDataTypes")._New()
    Colors.Insert("Red")
    Colors.Insert("Green")
    Colors.Insert("Blue")

    print("Number of list items:", Colors.Count())
    print("Second list item:", Colors.GetAt(2))

    Colors.SetAt("Yellow",2)
    print("New second item: ", Colors.GetAt(2))

    print("Third item before insertion: ", Colors.GetAt(3))
    Colors.InsertAt("Purple",3)
    print("Number of items after insertion: ", Colors.Count())
    print("Third item after insertion: ", Colors.GetAt(3))
    print("Fourth item after insertion: ", Colors.GetAt(4))

    Colors.RemoveAt(3)
    print("Number of items after removing item 3: ", Colors.Count())

    print("List items:")
    for i in range(1, Colors.Count() + 1):
        print(Colors.GetAt(i))
}

}
