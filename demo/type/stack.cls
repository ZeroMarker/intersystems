Class demo.type.stack Extends %RegisteredObject
{

Property Items As %ListOfDataTypes;

Method Push(value As %String) As %Status
{
    ;向栈中推入一个值
    Do ..Items.Insert(value)  ;Insert 会把元素添加到列表末尾
    Quit $$$OK
}

Method Pop() As %String
{
    ; 弹出栈顶元素并返回
    If '..Items.Count() {
        Quit ""  ; 如果栈为空，则返回空
    }

    Set value = ..Items.GetAt(..Items.Count())  ; 获取栈顶元素
    Do ..Items.RemoveAt(..Items.Count())  ; 移除栈顶元素
    Quit value
}

Method Top() As %String
{
    ; 获取栈顶元素，但不移除
    If '..Items.Count() {
        Quit ""  ; 如果栈为空，则返回空
    }

    Quit ..Items.GetAt(..Items.Count())  ; 返回栈顶元素
}

Method IsEmpty() As %Boolean
{
    ; 检查栈是否为空
    Quit (..Items.Count() = 0)
}

Method Size() As %Integer
{
    ; 返回栈的大小
    Quit ..Items.Count()
}

/// d ##class(web.Stack).Test()
ClassMethod Test()
{
	Set stack = ##class(demo.type.stack).%New()

	; 向栈中添加元素
	Do stack.Push("10")
	Do stack.Push("20")
	Do stack.Push("30")

	; 查看栈顶元素
	Write "Top of stack: ", stack.Top(), !

	; 弹出栈顶元素
	Write "Popped element: ", stack.Pop(), !

	; 查看栈顶元素
	Write "Top of stack: ", stack.Top(), !
	
	; 查看栈是否为空
	If stack.IsEmpty() {
	    Write "Stack is empty.", !
	} Else {
	    Write "Stack is not empty.", !
	}
}

}
