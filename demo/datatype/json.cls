Class demo.datatype.json Extends %RegisteredObject
{

ClassMethod Json()
{
    Set name = "Mark"
    Set age = 20
    Set gender = "male"

    Set jsonObject = {}
    Do jsonObject.%Set("name", name)
    Do jsonObject.%Set("age", age)
    Do jsonObject.%Set("gender", gender)
    s obj = ..Process(jsonObject)

    w obj.%Get("name"), !
    Write jsonObject.%ToJSON()
}

ClassMethod Process(obj)
{
    q obj
}

}
