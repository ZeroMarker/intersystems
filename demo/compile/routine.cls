Class demo.routine.routine Extends %RegisteredObject
{

ClassMethod Routine(a As %String, b As %String) As %Status
{
    Set sc = $$$OK
    // do something
    d hello^demo.First(a,b)
    Return sc
}

}
