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
    s jsonObject."father_in_law" = 13
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
    ;b ;;;;
    Set json."code_d" = "sss"
    
    ;Set first = json.%Get(0)
    ;Set name = first.patientName
    
    // 打印 JSON 对象
    
    q json
}

ClassMethod Len()
{
    Set myArray = []
    Set myArray = ["apple", "banana", "orange"]
    /*for i=1:1:10 {
        s item = {}
        s item.Code = i
        s item.Desc = i + 1
        do myArray.%Push(item)
    }*/
    ZWrite myArray
    Set elementCount = myArray.%Size()
    ;write "Number of elements in array: ", elementCount
    Quit elementCount
}

}
