Class demo.tools Extends %RegisteredObject
{

/// d ##class(demo.tools).SayHello("Mark")
ClassMethod SayHello(Name As %String) As %Status
{
    Set sc = $$$OK
    // do something
    write "Hello " _ Name _ "!" , !
    Return sc
}

/// Description
ClassMethod FileExist() As %Status
{
    Set sc = $$$OK
    // do something
    If ##class(%File).Exists("file.txt") Write "It exists",!
    Return sc
}

/// Description
ClassMethod Routine(a As %String, b As %String) As %Status
{
    Set sc = $$$OK
    // do something
    d hello^demo.First(a,b)
    Return sc
}

ClassMethod Sum(a, b)
{
    Set sum = a + b
    Return sum
}

ClassMethod Test()
{
    s ^Student("Code", "01",1) = ""
    s ^Student("Code", "02",3) = ""
    s ^Student("Code", "04",5) = ""
    s code = "04"
    s stu = $o(^Student("Code", code, 0))
    q $CLASSMETHOD("demo.tools","For")
    q stu
}

ClassMethod For()
{
    s ^StudentI("Code", "02",1) = ""
    s ^StudentI("Code", "02",3) = ""
    s ^StudentI("Code", "02",5) = ""
    s ^StudentD(1) = "1^Y"
    s ^StudentD(3) = "3^N"
    s ^StudentD(5) = "5^N"
    s code = "02"
    s id = ""
    s ret = ""
    for {
        s id = $o(^StudentI("Code",code,id))
        q:id=""
        s flag = $p(^StudentD(id),"^",2)
        continue:flag'="N"
        s:$g(ret)'="" ret = ret_","
        s ret = $g(ret)_flag
    }
    q ret
}

ClassMethod write(Package, Class)
{
    Set className = "demo.entity.Student"

    ; Get class information
    Set classInfo = ##class(%Dictionary.ClassDefinition).%OpenId(className)

    ; Check if the class exists
    If $IsObject(classInfo) {
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
            Write methodName, !
            Set methodName = classInfo.Methods.GetAt(i).Name
            Write "Method: ", methodName, !

            ; Get method information
            Set methodInfo = classInfo.Methods.GetAt(i)

            ; Check if the method exists
            /*If $IsObject(methodInfo) {
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

        ; Loop through all indices
        For i = 1:1:classInfo.IndexCount() {
            Set indexInfo = classInfo.GetIndex(i)
            If $IsObject(indexInfo) {
                Write "Index Name: ", indexInfo.Name, !
                Write "Type: ", indexInfo.Type, !
                Write "Properties:", !
                For j = 1:1:indexInfo.Properties.Count() {
                    Set propertyName = indexInfo.Properties.GetAt(j).Name
                    Write "  ", propertyName
                }
                Write ! ; Add a newline for better readability
            } Else {
                Write "Index not found at position ", i, !
            }
        }

    } Else {
        Write "Class not found: ", className, !
    }

    
    w "Hello", !, !
    q "Hello"_$c(13,10)
}

}
