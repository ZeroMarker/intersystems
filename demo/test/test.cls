Class demo.test.test Extends %UnitTest.TestCase
{

Method TestSum()
{
    do $$$AssertEquals(##class(demo.tools).Sum(2,2),4, "Test Add(2,2)=4")
    do $$$AssertNotEquals(##class(demo.tools).Sum(2,2),5,"Test Add(2,2)'=5")
}

}
