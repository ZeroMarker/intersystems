Class demo.compile.compile Extends %RegisteredObject
{

/**
    * Compile
    * @param string class or routinue
    * @return void
*/
ClassMethod Compile(class)
{
    // Do $system.OBJ.ShowFlags()
    d $System.OBJ.Compile(class)
    d $System.OBJ.CompileList("test.mac")

    d ##class(%Routine).CompileList("test.mac")
}

/**
    * Get Class Infomation
    * @param Class Location
    * @return void
    * @print Class Infomation
*/
ClassMethod GetInfo(className)
{
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


/**
    * test for macro
*/
ClassMethod Macro()
{
    // Macros
    #define StringMacro "Hello, World!"
    write !, $$$StringMacro, !
    q 0
}

}
