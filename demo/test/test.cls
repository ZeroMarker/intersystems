Class demo.test.test Extends %UnitTest.TestCase
{

Method TestSum()
{
    do $$$AssertEquals(##class(demo.test.test).Sum(2,2),4, "Test Add(2,2)=4")
    do $$$AssertNotEquals(##class(demo.test.test).Sum(2,2),5,"Test Add(2,2)'=5")
}

ClassMethod Sum(a, b)
{
    return a + b
}

ClassMethod Debug(a, b)
{
    s x = 1
    break "S" ; step by step
    s y = x + 1
}

}
