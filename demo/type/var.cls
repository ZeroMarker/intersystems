Class demo.datatype.var Extends %RegisteredObject
{

/// Description
ClassMethod MethodName() As %Status
{
    Set sc = $$$OK
    #Dim x As %CacheString
    s x = $g(^|"%sys"|x)
    s y = $g(^["DHC-APP"]PAPER(1))
    // do something
    Return sc
}

}
