Class demo.type.set Extends %RegisteredObject
{

Property Items As %ListOfDataTypes;

// 添加元素

Method Add(element As %String) As %Boolean
{
    If ..Exists(element) {
        Return 0  // 元素已存在
    }
    Do ..Items.Insert(element)
    Return 1  // 添加成功
}

// 删除元素

Method Remove(element As %String) As %Boolean
{
    If ..Exists(element) {
        Set index = ..Items.Find(element)
        If index > 0 {
            Do ..Items.RemoveAt(index)
            Return 1  // 删除成功
        }
    }
    Return 0  // 元素不存在
}

// 检查元素是否在集合中

Method Exists(element As %String) As %Boolean
{
    Quit ..Items.Find(element) > 0
}

// 获取集合元素列表

Method ToList() As %String
{
    Set i=1
    Quit:..Items.Count()=0 ""
	While (i <= ..Items.Count()) {
	    Set item = ..Items.GetAt(i)
	    s $list(list, i) = item
	    Set i = i + 1
	}
	Quit $ListToString(list)
}

/// Description
ClassMethod Test() As %Status
{
    Set mySet = ##class(demo.type.set).%New()
    Write mySet.Add("apple")  // 输出 1
    Write mySet.Add("banana") // 输出 1
    Write mySet.Add("apple")  // 输出 0，因重复

    Write mySet.Exists("apple")  // 输出 1
    Write mySet.Exists("orange") // 输出 0

    Write mySet.Remove("banana") // 输出 1
    Write mySet.Remove("grape")  // 输出 0，因不存在

    Set list = mySet.ToList()
    
    Quit list
}
}