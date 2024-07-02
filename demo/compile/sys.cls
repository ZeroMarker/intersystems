Class demo.sys.sys Extends %RegisteredObject
{

/// https://docs.intersystems.com/iris20233/csp/docbook/DocBook.UI.Page.cls?KEY=RCOS_sroutine
/// https://docs.intersystems.com/iris20233/csp/docbook/Doc.View.cls?KEY=ITECHREF_routine
ClassMethod sys()
{
    WRITE ##class(%SYS.Namespace).Exists("USER"),!  ; an existing namespace
    WRITE ##class(%SYS.Namespace).Exists("LOSER")   ; a non-existent namespace
}

ClassMethod Exist()
{
    s rtn1 = ##class(%Dictionary.MethodDefinition).%ExistsId("demo.compile.compile||Compile")
    s rtn2 = ##class(%Dictionary.CompiledMethod).%ExistsId("demo.compile.compile||Compile")
    q $lb(rtn1, rtn2)
}

ClassMethod NameSpace()
{
    zn "HSLIB"
    new $NAMESPACE
    set $NAMESPACE = "User"
    q $zv
}

ClassMethod Routine(a As %String, b As %String) As %Status
{
    Set sc = $$$OK
    // do something
    d hello^demo.First(a,b)
    Return sc
}

}
