Class demo.compile.compile Extends %RegisteredObject
{

/**
    * Compile
    * @param string class or routinue
    * @return void
*/
ClassMethod Compile(class)
{
    // Do $system.OBJ.ShowFlags()
    d $System.OBJ.Compile(class)
    d $System.OBJ.CompileList("test.mac")

    d ##class(%Routine).CompileList("test.mac")
}

/**
    * test for macro
*/
ClassMethod Macro()
{
    // Macros
    #define StringMacro "Hello, World!"
    write !, $$$StringMacro, !
    q 0
}

}
