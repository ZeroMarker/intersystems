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
/// 获取Global中的值
/// 兼容$piece, $order
/// "order" 获取 $o
/// "value"	获取 $p
/// s Arcim = $p($g(^OEORD(1,"I",1,1)),"^",2)
/// s Arcim = ##class(web.DHCDocMain).Comm("value","OEORD",2,1,"I",1,1)
/// s Arcim = $p($g(^OEORD(ord,"I",item,1)),"^",2)
/// s Arcim = ##class(web.DHCDocMain).Comm("value","OEORD",2,ord,"I",item,1)
/// -------------------------------
/// s item=$o(^OEORD(ord,"I",item))
/// s item=##class(web.DHCDocMain).Comm("order","OEORD",1,ord,"I",item)
/// -------------------------------
/// (type类型, global名称, piece位置, nodes节点列表)
/// debug: w ##class(web.DHCDocMain).Comm("value","OEORD",2,1,"I",1,1)
/// debug: w ##class(web.DHCDocMain).Comm("order","OEORD",1,1,"I",1)
ClassMethod Comm(type As %String, global As %String, piece As %Integer, ByRef nodes...) As %String
{
    // 构建全局变量位置
    s location = "^"_global
    s nodeString = ""
    
    // 遍历节点参数并构建位置字符串
    f i=1:1:nodes {
        s nodeString = nodeString_","""_nodes(i)_""""
    }
    
    // 构建最终的全局变量引用
    if type = "value" {
    	s location = "$g(" _ location_"("_$e(nodeString,2,*)_")" _")"
    }
    if type = "order" {
    	s location = "$o(" _ location_"("_$e(nodeString,2,*)_")" _")"
    }

    // 提取值
    s exe = "s rtn = " _ location
    x exe
    s value = @"rtn"
    
    // 从值中提取指定部分
    s rtn = $p(value, "^", piece)
    
    // 返回结果
    q rtn
}
/// debug: w ##class(web.DHCDocMain).Call("web.DHCDocMain","Call","web.DHCDocMain","Call","web.DHCDocMain","Comm","value","OEORD",2,1,"I",1,1)
/// debug: w ##class(web.DHCDocMain).Call("web.DHCDocMain","Comm","value","OEORD",2,1,"I",1,1)
ClassMethod Call(class As %String, method As %String, ByRef nodes...) As %String
{
    // 构建全局变量位置
    s location = "##class("_class_")."_method
    s nodeString = ""
    
    // 遍历节点参数并构建位置字符串
    f i=1:1:nodes {
        s nodeString = nodeString_","""_nodes(i)_""""
    }
    
   
    s location = location_"("_$e(nodeString,2,*)_")"
    

    // 提取值
    s exe = "s rtn = " _ location
    x exe
    s value = @"rtn"
    
    // 从值中提取指定部分
    s rtn = value
    
    // 返回结果
    q rtn
}
}
