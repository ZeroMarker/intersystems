Include test
Class demo.include.test Extends %RegisteredObject
{
ClassMethod Test() As %Status
{
    Write $$$StringMacro
    Write $$$add(2*2,2*5),!
    q $$$OK
}
}