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


ClassMethod Second()
{
    w $now()     ;timezone time
    w $zts()    ;global time
    w $zdt($zts,3,1,6)
    w $zdt($now(),3,1,6)
}
/**
    * 获取Global中的值
    * @author Mark Chen
    * @param type
                value   $piece()
                order   $order()
                value list $listget()
    * @param global
    * @param piece
    * @param nodes
    * @return value
    * @debug
        s Arcim = $p($g(^OEORD(1,"I",1,1)),"^",2)
        w ##class(web.DHCDocMain).Comm("value","OEORD",2,1,"I",1,1)
        w ##class(web.DHCDocMain).Comm("order","OEORD",1,1,"I",1)
        w ##class(web.DHCDocMain).Comm("value list","User.DHCRegistrationFeeD",7,11)
*/
ClassMethod Comm(type As %String, global As %String, piece As %Integer, ByRef nodes...) As %String
{
    // 构建全局变量位置
    s location = "^"_global
    s nodeString = ""
    
    // 遍历节点参数并构建位置字符串
    f i=1:1:nodes {
        s nodeString = nodeString_","""_nodes(i)_""""
        return:nodes(i)="" ""
    }
    
    // 构建最终的全局变量引用
    if type [ "value" {
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
    if type = "value list" {
	    s rtn = $lg(value,piece)
	}
	
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
/// w ##class(web.DHCDocMain).Show("discharge","", 44)
ClassMethod Show(global, zw = "", nodes...)
{
    // 构建全局变量位置
    s location = "^"_global
    s nodeString = ""
    
    // 遍历节点参数并构建位置字符串
    f i=1:1:nodes {
        s nodeString = nodeString_","""_nodes(i)_""""
        return:nodes(i)="" ""
    }

    // 构建最终的全局变量引用
  
    s location = "$o("_location_"("_$e(nodeString,2,*)_",sub"_")"_")"
    
    s zwLocation = "^"_global_"("_$e(nodeString,2,*)_")"
    if zw = "Y" {
		s exe = "zw "_zwLocation
		x exe    
	}
    
    // 遍历子节点并构建结果字符串
    s @"sub" = 0
    s exe = "s sub = "_location
    s result = ""
    s sub = ""
    for {
	    x exe
        s sub = @"sub"
        quit:sub=""
        s result = result_$c(13,10)_sub
    }
    // 返回结果字符串，去掉开头的逗号
    q $EXTRACT(result, 3, *)
}
ClassMethod Stack()
{
	s PLACE="",MCODE=""
	kill tmpStackAry
	s levelDeep=$STACK(-1)
	FOR loop=0:1:levelDeep { 
		s tp=$STACK(loop)
		continue:(tp="")||(tp="XECUTE")
		s cp=$STACK(loop,"PLACE")
		continue:(cp="")||(cp["%SYS")||(cp["%CSP")
		s stackCls=$p($p(cp,"^",2)," ",1)
		continue:$p($p(cp,"^",2)," ",1)=$zn
		;s cs=$STACK(loop,"MCODE")
		i stackCls'="" {
			continue:$d(tmpStackAry(stackCls))
			s tmpStackAry(stackCls)=""
		}
		;调用的标准插医嘱程序,则后续不记录
		s stackMthName=$p(cp,"+",1)
		i ((stackMthName="zInsertOrderItem")||(stackMthName="zSaveOrderItems"))&&(cp["web.DHCOEOrdItem") {
			s cp="标准"_stackMthName
			i PLACE="" s PLACE=$tr(cp,"^",",")
			e  s PLACE=PLACE_"!!"_$tr(cp,"^",",")
			quit
		}else{
			i PLACE="" s PLACE=$tr(cp,"^",",")
			e  s PLACE=PLACE_"!!"_$tr(cp,"^",",")
		}
		;s ^tmpgry("stack",+$h,$i(^tmpgry))=tp_","_cp ;_","_cs
    }
    ;只获取600长度的堆栈信息
    s PlaceLen=$l(PLACE)
    i PlaceLen>600 s PLACE=$e(PLACE,1,600)
	q PLACE
}
ClassMethod GenerateGetSetMethods(className As %String)
{
    // 获取类定义
    Set classDef = ##class(%Dictionary.ClassDefinition).%OpenId(className)
    If classDef = "" {
        Write "Class not found", !
        Quit
    }

    // 遍历类的属性
    Set properties = classDef.Properties
    For i=1:1:properties.Count() {
        Set property = properties.GetAt(i)
        Set propertyName = property.Name
        Set propertyType = property.Type

        // 生成 get 方法
        Set getMethod = "Method Get"_propertyName_"() As "_propertyType_" { Quit .."_propertyName_" }"
        
        // 生成 set 方法
        Set setMethod = "Method Set"_propertyName_"(p"_propertyName_" As "_propertyType_") { Set .."_propertyName_" = p"_propertyName_" }"

        // 添加方法到类定义
        Do classDef.Methods.Insert(##class(%Dictionary.MethodDefinition).%New(getMethod))
        Do classDef.Methods.Insert(##class(%Dictionary.MethodDefinition).%New(setMethod))
    }

    // 保存类定义
    Do classDef.%Save()
    Write "Get and Set methods generated successfully.", !
}
}
