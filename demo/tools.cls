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

}
