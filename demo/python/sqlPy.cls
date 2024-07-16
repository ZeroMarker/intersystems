Class demo.sql.sqlPy Extends %RegisteredObject
{

ClassMethod sql() [ Language = python ]
{
    import iris
    rset = iris.sql.exec("SELECT TOP 5 Name, DOB FROM Sample.Person") 
    for row in rset:
        print(row)
}
/**
    *
    * @docs https://docs.intersystems.com/irislatest/csp/docbook/DocBook.UI.Page.cls?KEY=AFL_epython
    * @docs https://docs.intersystems.com/supplychainlatest/csp/docbook/DocBook.UI.Page.cls?KEY=GEPYTHON_reference_gref
    * @docs https://docs.intersystems.com/supplychainlatest/csp/docbook/DocBook.UI.Page.cls?KEY=GEPYTHON_sharedata
    * @debug
        do ##class(%SYS.Python).Shell()
        g = iris.cls('User.Globals')
        g.SetSquares(6)
        g.PrintSquares()
        exit()
        quit()
        square.set([12], 144)
        square[13] = 169
        m = iris.gref('^mlb')
        for key in m.keys([]):
            value = m[key]
            print(f'{key} = {value}')
*/
ClassMethod print() [ Language = python ]
{
    print("Hello World!")
}
ClassMethod SetSquares(x) [ Language = python ]
{
    import iris
    # square[None] = 'Table of squares'
    # root value
    square = iris.gref('^square')
    
    for key in range(1, x):
        value = key * key
        square.set([key], value)
}
ClassMethod PrintSquares() [ Language = python ]
{
    import iris
    square = iris.gref('^square')
    key = ''
    while True:
        key = square.order([key])
        if key == None:
            break
        flag = square.data([key])
        print('The square of ' + str(key) + ' is ' + str(square.get([key])))
}
/**
	* 获取就诊医嘱列表
	* @debug w ##class(web.DHCDocMain).Py(1)
*/
ClassMethod Py(EpisodeID As %String = "") As %Status [ Language = python ]
{
	import iris
	import json
	
	results = []
	g = iris.gref('^OEORD')
	if EpisodeID != "" :
		ord = g.order([0,'Adm',EpisodeID,0])
		item = 0
		while True:
			item = g.order([ord,'I',item])
			if item == None:
				break
			arcim = g.get([ord,'I',item,1]).split('^')[1]
			a = iris.gref('^ARCIM')
			name = a.get([arcim.split('||')[0],arcim.split('||')[1],1]).split('^')[1]
			print(f'{arcim} - {name}')
			results.append({"arcim": arcim, "name": name})  # 将结果添加到列表中

	# 将结果列表转换为JSON格式的字符串
	json_output = json.dumps(results, ensure_ascii=False, indent=4)

    # flag = iris.cls('demo.sql.sqlPy').Python(66)
	# print(flag)
	return json_output
}
/**
	* 判断住院科室
	* @debug w ##class(web.DHCDocMain).Python(66)
*/
ClassMethod Python(LocId) [ Language = python ]
{
	if LocId == '':
		return ''
	import iris
	obj = iris.cls('User.CTLoc')._OpenId(LocId)
	type = obj.CTLOCClinicType
	"""
	obj.CTLOCClinicType = 'I'
	status = obj._Save()
	try:
		iris.check_status(status)
	except Exception as ex:
	print(ex)
	if iris.cls('%SYSTEM.Status').IsError(status):
		iris.cls('%SYSTEM.Status').DisplayError(status)
	"""
	if type == 'I' :
		return 1
	else:
		return 0
}
/**
	* 判断住院科室
	* @debug w ##class(web.DHCDocMain).Java()
*/
ClassMethod Java() [ Language = java ]
{
	/*
	q:LocId="" 0
	s obj = ##class(User.CTLoc).%OpenId(LocId)
	s type = ""
	s:obj'="" type = obj.CTLOCClinicType
	if type = "I" {
		s flag = 1
	}
	else {
		s flag = 0	
	}
	q flag
	*/
	System.out.println("Hello, World!");
}
}
