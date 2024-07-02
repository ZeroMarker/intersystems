Class demo.function.var Extends %RegisteredObject
{

ClassMethod Get(var)
{
    q $get(var, 0)
}

ClassMethod New(a, b)
{
    ;new (a, b)
    ;new x
    q 0
}
}
