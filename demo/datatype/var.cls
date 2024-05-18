Class demo.datatype.var Extends %RegisteredObject
{

/// Description
ClassMethod MethodName() As %Status
{
    Set sc = $$$OK
    #Dim x As %CacheString
    s x = $g(^|"%sys"|x)
    // do something
    Return sc
}

}
