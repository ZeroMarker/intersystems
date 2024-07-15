Class demo.function.lock Extends %RegisteredObject
{

/**
    * lock something
*/
ClassMethod lock()
{
    s id = 0
    lock +^Order(id):3      // lock in 3s
    if $TEST {
        // lock successfully
        s id = 1
    }
    lock -^Order(id)
    q id
}

}
