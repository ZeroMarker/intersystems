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
    w $now()        ;timezone time
    w $zts          ;global time
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

/**
    *
    * @debug d ##class(demo.example.main).GenerateGetSetMethods("demo.entity.Company")
*/
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
        Set getMethodName = "Get"_propertyName
        Set getMethodCode = "Quit .."_propertyName

        // 生成 set 方法
        Set setMethodName = "Set"_propertyName
        Set setMethodCode = "Set .."_propertyName_" = p"_propertyName

        // 创建并添加 get 方法到类定义
        Set getMethod = ##class(%Dictionary.MethodDefinition).%New()
        Set getMethod.Name = getMethodName
        Do getMethod.ImplementationSet(getMethodCode)
        Set getMethod.ReturnType = propertyType
        Do classDef.Methods.Insert(getMethod)

        // 创建并添加 set 方法到类定义
        Set setMethod = ##class(%Dictionary.MethodDefinition).%New()
        Set setMethod.Name = setMethodName
        Do setMethod.Implementation.WriteLine(setMethodCode)
        Do setMethod.FormalSpecSet("p"_propertyName_":"_propertyType)
        Do classDef.Methods.Insert(setMethod)
    }

    // 保存类定义
    s rtn = classDef.%Save()
    Write "Get and Set methods generated successfully.", !
}
/// w ##class(web.DHCDocMain).diff($zdh("2024-07-18",3),$zth("17:00:00"))
ClassMethod diff(date, time)
{
	s diff = ((+$h - date) * 60 * 60 * 24) + ($p($h,",",2) - time)
	b ;;; diff
	if diff > (60 * 60 * 24) {
		q 0
	}
	else {
		q 1	
	}
}
ClassMethod New()
{
    Set cdef = ##class(%Dictionary.ClassDefinition).%New("Demo.Object.MyClass2")
    Set cdef.Super = "%Persistent,%Populate"
    Set pdef = ##class(%Dictionary.PropertyDefinition).%New("Demo.Object.MyClass:Code")
    Do cdef.Properties.Insert(pdef)
    Set pdef.Type = "%String"
    Do cdef.%Save()
}

/**
    * Get Class Infomation
    * @param Class Location
    * @return void
    * @print Class Infomation
*/
ClassMethod Info(className)
{
    ; Get class information
    Set classInfo = ##class(%Dictionary.ClassDefinition).%OpenId(className)
	
    ; Check if the class exists
    If $IsObject(classInfo) {
        w "Class Type:", !
		w classInfo.Super, !
		
        ; Get properties
        Write "Properties:", !
        For i = 1:1:classInfo.Properties.Count() {
            Set propName = classInfo.Properties.GetAt(i).Name
            Set propType = classInfo.Properties.GetAt(i).Type
            Write propName, ":", propType ,!
        }
        
        ; Get class parameters
        Write "Parameters:", !
        For i = 1:1:classInfo.Parameters.Count() {
            Set paramName = classInfo.Parameters.GetAt(i).Name
            Write paramName, !
        }

        ; Get methods
        Write "Methods:",!
        For i = 1:1:classInfo.Methods.Count() {
            Set methodName = classInfo.Methods.GetAt(i).Name
            Write "Method: ", methodName, !

            ; Get method information
            Set methodInfo = classInfo.Methods.GetAt(i)
            
            w methodInfo.Implementation.Read()
            Write ! ; Add a newline for better readability
        }
        w "Indices:", !
        Set indexList = classInfo.IndicesGet()
        if $ISOBJECT(indexList) {
            For i = 1:1:indexList.Count() {
                Set indexName = indexList.GetAt(i).Name
                Write "Index: ", indexName
                w !
            }
        }
        
        w "Queries:", !
        set QueryList = classInfo.QueriesGet()
        if $ISOBJECT(QueryList) {
            For i = 1:1:QueryList.Count() {
                Set QueryName = QueryList.GetAt(i).Name
                Write "Query: ", QueryName
                w !
            }
        }

    } Else {
        Write "Class not found: ", className, !
    }
    q 0
}

/**
    * @desc		生成方法
    * @debug d ##class(User.Main).GenMethod("User.Test")
*/
ClassMethod GenMethod(className As %String)
{
    // 获取类定义
    Set classDef = ##class(%Dictionary.ClassDefinition).%OpenId(className)
    
    If classDef = "" {
        Write "Class not found", !
        Quit
    }
	
	// 清理 getter setter
	d ..DelMethod(className)
    // 遍历类的属性
    Set properties = classDef.Properties
    For i=1:1:properties.Count() {
        Set property = properties.GetAt(i)
        Set propertyName = property.Name
        Set propertyType = property.Type

        // 生成 get 方法
        Set getMethodName = "Get"_propertyName
        Set getMethodCode = "	Quit .."_propertyName

        // 生成 set 方法
        Set setMethodName = "Set"_propertyName
        Set setMethodCode = "	Set .."_propertyName_" = p"_propertyName
		
        // 创建并添加 get 方法到类定义
        Set getMethod = ##class(%Dictionary.MethodDefinition).%New()
        Set getMethod.Name = getMethodName
        Do getMethod.Implementation.WriteLine(getMethodCode)
        Set getMethod.ReturnType = propertyType
        s rtn = classDef.Methods.Insert(getMethod)
        
        // 创建并添加 set 方法到类定义
        Set setMethod = ##class(%Dictionary.MethodDefinition).%New()
        Set setMethod.Name = setMethodName
        Do setMethod.Implementation.WriteLine(setMethodCode)
        Do setMethod.FormalSpecSet("p"_propertyName_":"_propertyType)
        s rtn = classDef.Methods.Insert(setMethod)
    }

    // 保存类定义
    s rtn = classDef.%Save()
    d ..Compile(className)
    Write rtn , !
}

/**
    *
    * @debug d ##class(User.Main).GenMethod("User.Test")
*/
ClassMethod DelMethod(className As %String)
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
        Set getMethodName = "Get"_propertyName
        Set getMethodCode = "	Quit .."_propertyName_" + 1"

        // 生成 set 方法
        Set setMethodName = "Set"_propertyName
        Set setMethodCode = "	Set .."_propertyName_" = p"_propertyName

		Set obj = ##class(%Dictionary.MethodDefinition).%OpenId(className_"||"_setMethodName)
		if obj '= "" {
			s rtn = classDef.Methods.Remove(obj)
		}
		
		Set obj = ##class(%Dictionary.MethodDefinition).%OpenId(className_"||"_getMethodName)
		if obj '= "" {
			s rtn = classDef.Methods.Remove(obj)	
		}
    }

    // 保存类定义
    s rtn = classDef.%Save()
    d ..Compile(className)
    Write rtn , !
}

/**
    *
    * @debug d ##class(User.Main).CreateClass("User.Test")
*/
ClassMethod CreateClass(className As %String)
{
	// 获取类定义
    Set classDef = ##class(%Dictionary.ClassDefinition).%OpenId(className)
    If classDef '= "" {
        d ..DeleteClass(className)
    }
    
    // 创建类
    Set classDef = ##class(%Dictionary.ClassDefinition).%New(className)
	Set rnt = classDef.SuperSet("%RegisteredObject")
	
	// 保存属性
    Set newProperty = ##class(%Dictionary.PropertyDefinition).%New()
    s rtn = newProperty.NameSet("Sex")
    s rtn = newProperty.TypeSet("%String")
    s rtn = classDef.Properties.Insert(newProperty)
	
	// 保存方法
	s method = ##class(%Dictionary.MethodDefinition).%New(className_":"_"Print")
	s rtn = method.FormalSpecSet("x1:%String,x2:%String")
	s rtn = method.ReturnTypeSet("%String")
	;s rtn = method.NameSet("Print")
	// unknown
	s rtn = method.CodeModeSet("code")
	// class method
	s rtn = method.ClassMethodSet(1)
	s rtn = method.Implementation.WriteLine("	w x1,x2,!")
	s rtn = method.Implementation.WriteLine("	w x1,x2,!")
	s rtn = classDef.Methods.Insert(method)
	
    // 保存类定义
    s rtn = classDef.%Save()
    
    d ..Compile(className)
    Write rtn
}

/**
    *
    * @debug d ##class(User.Main).DeleteClass("User.Test")
*/
ClassMethod DeleteClass(className As %String)
{
    // 删除类
    Set rtn = ##class(%Dictionary.ClassDefinition).%DeleteId(className)
    Write rtn
}

/// w ##class(web.DHCDocMain).ConvertCTLocType("E")
ClassMethod ConvertCTLocType(type)
{
	q:type="" ""
	// 获取类定义
    Set classDef = ##class(%Dictionary.ClassDefinition).%OpenId("User.CTLoc")
    If classDef = "" {
        Quit "Class not found"
    }

    // 遍历类的属性
    Set properties = classDef.Properties
    For i=1:1:properties.Count() {
        Set property = properties.GetAt(i)
        Set propertyName = property.Name
        Set propertyType = property.Type

        
		if propertyName="CTLOCType" {
			s display =  property.Parameters.GetAt("DISPLAYLIST")
			s value = property.Parameters.GetAt("VALUELIST")
			s displayList = $lfs(display,",")
			s valueList = $lfs(value,",")
		}
    }
    s desc = ""
    for i = 1:1:$ll(valueList) {
		s item = $lg(valueList,i)
		if item = type {
			s desc = $lg(displayList,i)	
		}    
	}
	q desc
}
}
