Class demo.example.datatype Extends %RegisteredObject
{

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
