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

ClassMethod Tests()
{
    k x
    d ..init(.x)
    s y = 2
    d Init(2)
Init(Para)
    w $g(x), !
    w $g(Para), !
}

ClassMethod init(x)
{
    s x = 1
}
/// w ##class(web.DHCDocMain).Comm("OEORD",2,1,"I",1,1)
ClassMethod Comm(global As %String, piece As %Integer, ByRef nodes...) As %String
{
    /*
	s @"global" = "OEORD"
	s @"node" = "I"
	s @"de" = "^"
	;s exe = "rtn=$p(^OEORD(1,node,1,1),de,2)"
	s exe = "rtn=$p($g(^"_global_"(1,"""_node_""",1,1)),""^"",2)"
	s @exe
	q $g(rtn)
	*/
	/*
	// 设置全局变量
    s global = "OEORD"
    s node = "I"

    // 调试输出：打印全局变量
    w !,"Global: ", global
    w !,"Node: ", node

    // 构建执行字符串
    s exe = "s rtn=$p($g(^"_global_"(1,"""_node_""",1,1)),""^"",2)"
    
    // 调试输出：打印执行字符串
    w !,"Executable: ", exe

    // 执行字符串
    x exe
    ;s @exe
    s rtn = @"rtn"
    
    // 调试输出：打印结果
    w !,"Result: ", $g(rtn)
	
	
    // 返回结果
    q $g(rtn)
    */
    // 构建全局变量位置
    s location = "^"_global
    s nodeString = ""
    // 遍历节点参数并构建位置字符串
    f i=1:1:nodes {
        s nodeString = nodeString_","""_nodes(i)_""""
    }
    
    // 构建最终的全局变量引用
    s location = "$g(" _ location_"("_$e(nodeString,2,*)_")" _")"
    
    // 提取值
    ;s value = $g(@location)
    s exe = "s rtn = " _ location
    x exe
    s value = @"rtn"
    
    // 从值中提取指定部分
    s rtn = $p(value, "^", piece)
    
    // 输出调试信息
    ;w !,"Global: ", global
    ;w !,"Piece: ", piece
    ;w !,"Nodes: ", $zh(nodes)
    ;w !,"Location: ", location
    ;w !,"Value: ", value
    ;w !,"Result: ", rtn
    
    // 返回结果
    q rtn
}
}
