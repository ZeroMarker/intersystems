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
*/
ClassMethod print() [ Language = python ]
{
    print("Hello World!")
}
ClassMethod SetSquares(x) [ Language = python ]
{
    import iris
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
        print('The square of ' + str(key) + ' is ' + str(square.get([key])))
}
/**
	* 获取就诊医嘱列表
	* @debug w ##class(web.DHCDocMain).Py(2)
*/
ClassMethod Py(EpisodeID) As %Status [ Language = python ]
{
	import iris
	g = iris.gref('^OEORD')
	ord = g.order([0,'Adm',EpisodeID,0])
	item = 0
	while True:
		item = g.order([ord,'I',item])
		if item == None:
			break
		arcim = g.get([ord,'I',item,1]).split('^')[1]
		a = iris.gref('^ARCIM')
		name = a.get([arcim.split('||')[0],arcim.split('||')[1],1]).split('^')[1]
		print(arcim + ' ' + name)
}
}
