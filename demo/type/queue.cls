Class demo.type.queue Extends %RegisteredObject
{

Property Items As %ListOfDataTypes;

Method Enqueue(value As %String) As %Status
{
    ; 将一个元素添加到队列末尾
    Do ..Items.Insert(value)
    Quit $$$OK
}

Method Dequeue() As %String
{
    ; 从队列前端移除并返回一个元素
    If '..Items.Count() {
        Quit ""  ; 如果队列为空，则返回空
    }

    Set value = ..Items.GetAt(1)  ; 获取队首元素
    Do ..Items.RemoveAt(1)  ; 从队列中移除队首元素
    Quit value
}

Method Front() As %String
{
    ; 获取队列前端的元素，但不移除
    If '..Items.Count() {
        Quit ""  ; 如果队列为空，则返回空
    }

    Quit ..Items.GetAt(1)  ; 返回队首元素
}

Method IsEmpty() As %Boolean
{
    ; 检查队列是否为空
    Quit (..Items.Count() = 0)
}

Method Size() As %Integer
{
    ; 返回队列的大小
    Quit ..Items.Count()
}

ClassMethod Test()
{
	Set queue = ##class(demo.type.queue).%New()

	; 向队列中添加元素
	Do queue.Enqueue("10")
	Do queue.Enqueue("20")
	Do queue.Enqueue("30")

	; Size
	Write "Size of queue: ", queue.Size(),!
	; 查看队列前端元素
	Write "Front of queue: ", queue.Front(), !

	; 出队一个元素
	Write "Dequeued element: ", queue.Dequeue(), !

	; Size
	Write "Size of queue: ", queue.Size(),!
	; 查看队列是否为空
	If queue.IsEmpty() {
	    Write "Queue is empty.", !
	} Else {
	    Write "Queue is not empty.", !
	}
}


}
