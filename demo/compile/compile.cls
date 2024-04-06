Class demo.compile.compile Extends %RegisteredObject
{

/**
    * Compiles
    * @param string package
    * @param string class
    * @return void
*/
ClassMethod Compile()
{
    // compile
    // Do $system.OBJ.ShowFlags()
    d $System.OBJ.Compile("test.cls")
    d $System.OBJ.CompileList("test.mac")

    d ##class(%Routine).CompileList("test.mac")
}

ClassMethod Exist()
{
    s rtn1 = ##class(%Dictionary.MethodDefinition).%ExistsId("demo.compile.compile||Compile")
    s rtn2 = ##class(%Dictionary.CompiledMethod).%ExistsId("demo.compile.compile||Compile")
    q $lb(rtn1, rtn2)
}

ClassMethod GetInfo(Package, Class)
{
    Set className = "demo.entity.Person"

    ; Get class information
    Set classInfo = ##class(%Dictionary.ClassDefinition).%OpenId(className)

    ; Check if the class exists
    If $IsObject(classInfo) {
        
        w "Class Type:", !
        w classInfo.ClassType, !
        ; Get properties
        Write "Properties:", !
        For i = 1:1:classInfo.Properties.Count() {
            Set propName = classInfo.Properties.GetAt(i).Name
            Write propName, !
        }
        ; Get class parameters
        Write "Parameters:", !
        For i = 1:1:classInfo.Parameters.Count() {
            Set paramName = classInfo.Parameters.GetAt(i).Name
            Write paramName, !
        }

        ; Get methods
        Write "Methods:",!
        For i = 1:1:classInfo.Methods.Count() {
            Set methodName = classInfo.Methods.GetAt(i).Name
            Write "Method: ", methodName, !

            ; Get method information
            Set methodInfo = classInfo.Methods.GetAt(i)
            /*
            ; Check if the method exists
            If $IsObject(methodInfo) {
                ; Print parameters for the method
                Write "  Parameters:", !
                For j = 1:1:methodInfo.Parameters.Count() {
                    Set paramName = methodInfo.Parameters.GetAt(j).Name
                    Write "    ", paramName
                }
            } Else {
                Write "    Method not found: ", methodName
            }*/

            Write ! ; Add a newline for better readability
        }
        w "Indices:", !
        Set indexList = classInfo.IndicesGet()
        if $ISOBJECT(indexList) {
            For i = 1:1:indexList.Count() {
                Set indexName = indexList.GetAt(i).Name
                Write "Index: ", indexName
                w !
            }
        }
        
        w "Queries:", !
        set QueryList = classInfo.QueriesGet()
        if $ISOBJECT(QueryList) {
            For i = 1:1:QueryList.Count() {
                Set QueryName = QueryList.GetAt(i).Name
                Write "Query: ", QueryName
                w !
            }
        }

    } Else {
        Write "Class not found: ", className, !
    }
    q 0
}

ClassMethod ClassMethod()
{
    q $CLASSMETHOD("demo.compile.compile","GetInfo")
}

ClassMethod NameSpace()
{
    zn "HSLIB"
    new $NAMESPACE
    set $NAMESPACE = "User"
    q $zv
}

ClassMethod Symbol()
{
    w "Hello", !, !
    w "Hello"_$c(13,10)
    s x = 1, y = 0
    if (x = 1 ! y = 0) {
        w "Hello"
    }
    q 0
}

ClassMethod Macro()
{
    // Macros
    #define StringMacro "Hello, World!"
    write !, $$$StringMacro, !
    q 0
}

}
