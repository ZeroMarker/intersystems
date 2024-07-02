Class demo.routine.routine Extends %RegisteredObject
{

ClassMethod Routine(a As %String, b As %String) As %Status
{
    Set sc = $$$OK
    d hello^demo.compile.First(a,b)
    Return sc
}

}
