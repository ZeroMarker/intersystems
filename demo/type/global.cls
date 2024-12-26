Class demo.type.global Extends %RegisteredObject
{

Method Set(value, nodes...)
{
	for i=1:1:nodes {
		Set $list(list,i) = nodes(i)
	}
	Set ref = "^temp(" _ $lts(list,",") _ ")"
	Set @ref = value
	Quit 0
}

Method Get(nodes...)
{
	for i=1:1:nodes {
		Set $list(list,i) = nodes(i)
	}
	Set ref = "^temp(" _ $lts(list,",") _ ")"
	Set value = @ref
	Quit value
}

Method Order(nodes...)
{
	for i=1:1:nodes {
		Set $list(list,i) = nodes(i)
	}
	Set ref = "Set Value = $Order(^temp(" _ $lts(list,",") _ "))"
	Xecute ref
	Set value = @"Value"
	Quit value
}

ClassMethod Test()
{
	Set global = ##class(demo.type.global).%New()
	Do global.Set("apple",3,4)
	Write global.Get(3,4) , !
	Write global.Order(3,0) , !
}

}
