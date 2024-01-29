Class demo.sql.lock Extends %RegisteredObject
{

ClassMethod lock()
{
    s id = 0
    lock +^Order(id):3      // 3s
    lock -^Order(id)
}

}
