Class demo.example.main Extends %RegisteredObject
{

Property Name As %String;

Parameter ADDRESS = "123 Main St.";

/// w ##class(demo.example.main).Square(var)
/// pass value
/// w ##class(demo.example.main).Square(.var)
/// pass address
ClassMethod Square(input As %Integer) As %Integer
{
    set answer=input*input
    b ;--
    set input=input + 10
    return answer
}

ClassMethod Match() As %Status
{
    Set testthis="333-99-0000"
    Write testthis ?3N1"-"2N1"-"4N
}

Method Hello() [ Language = python ]
{
    # implementation details written in Python
    print("Hello World!")
}

ClassMethod AddressWrapper() As %String [ Language = objectscript ]
{
    return ..#ADDRESS
}

ClassMethod OfficeLocation() [ Language = python ]
{
    import iris
    location=iris.cls("demo.example.main").AddressWrapper()
    print("This office is located at", location)

    arg1="this"
    arg2=iris.ref("peanut butter")
    arg3="mark"
    MyMethod(arg1,arg2,arg3)
}

Method EmployeeLocation() [ Language = python ]
{
    # ..AddressWrapper()
    location=self.AddressWrapper()
    print("This employee works at", location)
}

Method MethodThis(arg As demo.example.main)
{
    Set obj=##class(demo.example.main).%New()
    Set name=obj.MethodThis($this)

    Set arg1 = "this"
    Set arg2 = "is"
    Set arg3 = "a"
    // pass address
    Do MyMethod(arg1, .arg2, .arg3)
    return arg.Name
}

Method MyMethod(argument1, ByRef argument2 As %String, Output argument3 As %String)
{
    Write "argument1=", argument1
    Write "argument2=", argument2
    Write "argument3=", argument3
}

ClassMethod MultiArg(Arg1... As %List) [ Language = objectscript ]
{
    Set args = $GET(Arg1, 0)
    Write "Invocation has ",
        args,
        " element",
        $SELECT((args=1):"", 1:"s"), !
    For i = 1 : 1 : args
    {
        Write "Argument[", i , "]: ", $GET(Arg1(i), "<NULL>"), !
    }
}

/// d ##class(demo.example.main).MultiArgPy(1,3)
ClassMethod MultiArgPy(Arg1... As %List) [ Language = python ]
{
    print("Invocation has", len(Arg1), "elements")
    for i in range(len(Arg1)):
        print("Argument[" + str(i+1) + "]: " + str(Arg1[i]))
}

ClassMethod RunClassMethod()
{
    set obj=$CLASSMETHOD("demo.example.main","%OpenId",1)
}

}
