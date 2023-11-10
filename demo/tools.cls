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
    Set state = ##class(%File)Exists("D:\work\hello.txt")
    Return sc
}

}
