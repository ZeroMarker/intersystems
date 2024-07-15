Class demo.file.file Extends %RegisteredObject
{

/**
    * if file exist
    * @param file location
*/
ClassMethod FileExist(file) As %Status
{
    Set sc = $$$OK
    // do something
    If ##class(%File).Exists(file) Write "It exists",!
    Return sc
}

}
