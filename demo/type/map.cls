Class demo.type.map Extends %RegisteredObject
{

Method Set(key, value)
{
	Set ^||Map(key) = value
	Quit 0
}

Method Get(key)
{
	Quit ^||Map(key)
}

Method Remove(key)
{
	Kill ^||Map(key)
	Quit 0
}

Method Count()
{
	Set count = 0
	Set key = 0
	for {
		Set key = $o(^||Map(key))
		Quit:key=""
		Set count = count + 1
	}
	Quit count
}

Method ToJSON(keyName = "key", valueName = "value")
{
	Set count = 0
	Set json = []
	Set key = 0
	for {
		Set key = $o(^||Map(key))
		Quit:key=""
		Set count = count + 1
		Set value = ^||Map(key)
		Set item = {}
		Do item.%Set(keyName,key)
		DO item.%Set(valueName,value)
		Do json.%Push(item)
	}
	Quit json
}

/// d ##class(web.Map).Map()
ClassMethod Map()
{
	s map = ##class(web.Map).%New()
	d map.Set(1,"apple")
	d map.Set(3,"banana")
	w map.Get(1) ,!
	w map.Count(), !
	d map.Remove(3)
	w map.Count(), !
	w map.ToJSON().%ToJSON() ,!
	w map.ToJSON("id","fruit").%ToJSON() ,!
}

}
