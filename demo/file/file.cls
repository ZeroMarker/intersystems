Class demo.file.file Extends %RegisteredObject
{

/// Description
ClassMethod FileExist() As %Status
{
    Set sc = $$$OK
    // do something
    If ##class(%File).Exists("file.txt") Write "It exists",!
    Return sc
}

}
