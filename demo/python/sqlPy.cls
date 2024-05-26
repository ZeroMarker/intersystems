Class demo.sql.sqlPy Extends %RegisteredObject
{

ClassMethod sql() [ Language = python ]
{
    import iris
    rset = iris.sql.exec("SELECT TOP 5 Name, DOB FROM Sample.Person") 
    for row in rset:
        print(row)
}

ClassMethod print() [ Language = python ]
{
    print("Hello World!")
}

}
