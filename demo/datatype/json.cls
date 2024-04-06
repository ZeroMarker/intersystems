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
    Set obj = ..Process(jsonObject)

    Write obj.%Get("name"), !
    Write jsonObject.%ToJSON()
}

ClassMethod Process(obj)
{
    Set json = {}
    Set json.owner = "his"
    Set json.deptKey = "3"
    Set json.type = "0"

    // 创建一个空的 screenInfo 数组
    Set json.screenInfo = []

    // 向 screenInfo 数组中添加元素
    Set screenInfoItem = {}
    Set screenInfoItem.doctorKey = "0000001"
    Set screenInfoItem.doctorName = "李二"
    Set screenInfoItem.deptName = "内科"
    Set screenInfoItem.consultName = "诊室1"
    Set screenInfoItem.shiftOut = 0
    Set screenInfoItem.waitPatientInfo = [
        { "registerId": "1", "patientName": "张三", "sort": 0 },
        { "registerId": "2", "patientName": "李四", "sort": 1 },
        { "registerId": "3", "patientName": "王五", "sort": 2 }
    ]

    // 将新创建的元素添加到 screenInfo 数组中
    Do json.screenInfo.%Push(screenInfoItem)

    // 创建第二个 screenInfo 数组元素，然后添加到数组中
    Set screenInfoItem = {}
    Set screenInfoItem.doctorKey = "0000002"
    Set screenInfoItem.doctorName = "张三"
    Set screenInfoItem.deptName = "内科"
    Set screenInfoItem.consultName = "诊室1"
    Set screenInfoItem.shiftOut = 0
    Set screenInfoItem.waitPatientInfo = [
        { "registerId": "1", "patientName": "张三", "sort": 0 },
        { "registerId": "2", "patientName": "李四", "sort": 1 },
        { "registerId": "3", "patientName": "王五", "sort": 2 }
    ]

    // 将新创建的元素添加到 screenInfo 数组中
    Do json.screenInfo.%Push(screenInfoItem)

    // 打印 JSON 对象
    ZWrite json

    ;q obj
}

ClassMethod Parse()
{
    Set json = {}.%FromJSON("{""status"":0,""desc"":""操作成功"",""data"":null}")
    ZWrite json
    ; array
    /*For index=1:1:json.%Size() {
        Set person = json.Get(index)
        Set name = person.name
    }*/
    // Create an array of objects
    Set jsonArray = []
    Set obj1 = {"name":"John", "age":30}
    Set obj2 = {"name":"Jane", "age":25}
    Set obj3 = {"name":"Bob", "age":35}

    // Add objects to the array
    Do jsonArray.%Push(obj1)
    Do jsonArray.%Push(obj2)
    Do jsonArray.%Push(obj3)

    // Convert the array to a JSON string
    Set jsonString = ##class(%ZEN.Auxiliary.jsonProvider).%ObjectToJSON(jsonArray)
    zWrite jsonString

    set array = []
    do array.%Set(array.%Size(), 123).%Set(array.%Size(), 456)
    write "removed "_array.%Remove(array.%Size()-1)_", leaving "_array.%ToJSON()

        //removed 456, leaving [123]

    set array = []
    do array.%Push(123).%Push(456)
    write "removed "_array.%Pop()_", leaving "_array.%ToJSON()

    //456, leaving [123]
}

/// w ##class(web.DHCDocMain).GetOrderChronicDiagJson(412,92)
ClassMethod GetOrderChronicDiagJson(EpisodeID As %String, OrderBillTypeRowid As %String) As %String
{
    s $ZT="GetOrderChronicDiagStrErr"
    q:EpisodeID="" ""
    s BillTypeObj = ##class(demo.Company).%OpenId(OrderBillTypeRowid)
    q:BillTypeObj="" ""
    q:(BillTypeObj.READateTo<+$h)&&(BillTypeObj.READateTo'="") ""
    s BillTypeDesc = BillTypeObj.READesc
    q:BillTypeDesc'["慢病" ""
    s EpisodeObj = ##class(demo.Company).%OpenId(EpisodeID)
    q:EpisodeObj="" ""
    s PatObj = ##class(demo.Company).%OpenId(EpisodeObj.PAADMPAPMIDR.%Id())
    q:PatObj="" ""
    s PatDiagsStr = PatObj.PAPMIChronic
    
    if (PatDiagsStr=""){
        q ""
    }
    s Json=[]
    for i=1:1:$L(PatDiagsStr,"/"){
        s OnePatDiagsStr=$P(PatDiagsStr,"/",i)
        q:OnePatDiagsStr=""
        s OneChronicDiagCode=$P(OnePatDiagsStr,"#m",2)
        s OneChronicDiagDesc=$P(OnePatDiagsStr,"#m",1)
        s Item = {}
        s Item.Code = OneChronicDiagCode
        s Item.Desc = OneChronicDiagDesc
        d Json.%Push(Item)
    }
    s Json = Json.%ToJSON()
    q Json
GetOrderChronicDiagStrErr
    Q ""
}

ClassMethod Len()
{
    set myArray = []
    set myArray = ["apple", "banana", "orange"]
    /*for i=1:1:10 {
        s item = {}
        s item.Code = i
        s item.Desc = i + 1
        do myArray.%Push(item)
    }*/
    zw myArray
    set elementCount = myArray.%Size()
    ;write "Number of elements in array: ", elementCount
    q elementCount
}

}
