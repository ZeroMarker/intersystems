Class demo.sys.sys Extends %RegisteredObject
{
    
/// https://docs.intersystems.com/iris20233/csp/docbook/DocBook.UI.Page.cls?KEY=RCOS_sroutine
/// https://docs.intersystems.com/iris20233/csp/docbook/Doc.View.cls?KEY=ITECHREF_routine
ClassMethod sys()
{
    WRITE ##class(%SYS.Namespace).Exists("USER"),!  ; an existing namespace
    WRITE ##class(%SYS.Namespace).Exists("LOSER")   ; a non-existent namespace
}
}