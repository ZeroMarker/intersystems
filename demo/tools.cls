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
    s code = "03"
    s stu = $o(^Student("Code", code, 0))
    q stu
}

}
