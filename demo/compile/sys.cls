Class demo.sys.sys Extends %RegisteredObject
{

/**
    * if Namespace exist
    * @param namespace
*/
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

/**
    * switch namespace
*/
ClassMethod NameSpace()
{
    zn "HSLIB"
    new $NAMESPACE
    set $NAMESPACE = "User"
    q $zv
}

/**
    * Run ClassMethod
    * @param class
    * @param method
    * @param args
    * @return value
    * @debug w ##class(demo.compile.compile).ClassMethod("demo.compile.compile","GetInfo")
*/
ClassMethod ClassMethod(class, method, args...)
{
    q $CLASSMETHOD(class,method,args)
}
/**
    * print system information
*/
ClassMethod Interesting() [ Language = objectscript ]
{
    write "Today's date: "_$ZDATE($HOROLOG,3)
    write !,"Your installed version: "_$ZVERSION
    write !,"Your username: "_$USERNAME
    write !,"Your security roles: "_$ROLES
}
}
