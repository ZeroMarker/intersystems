Class demo.compile.compile Extends %RegisteredObject
{
/// d ##class(demo.compile.compile).Compile()
ClassMethod Compile()
{
    // compile
    // Do $system.OBJ.ShowFlags()
    d $System.OBJ.Compile("test.cls")
    d $System.OBJ.CompileList("test.mac")
    // have problem
    d ##class(%Routine).CompileList("test.mac")
}
}