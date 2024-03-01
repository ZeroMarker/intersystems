/// web.Service
Class web.Service Extends %SOAP.WebService [ ProcedureBlock ]
{

/// Name of the WebService.
Parameter SERVICENAME = "Service";

/// TODO: change this to actual SOAP namespace.
/// SOAP Namespace for the WebService
Parameter NAMESPACE = "http://tempuri.org";

/// Namespaces of referenced classes will be used in the WSDL.
Parameter USECLASSNAMESPACES = 1;

/// TODO: add arguments and implementation.
/// Test
Method Test() As %String [ WebMethod ]
{
	Quit "Test"
}

Method GetPatientBirthday(RowId As %String) As %String [ WebMethod ]
{
    quit:RowId="" ""
    set PatientStr = $Get(^["DHC-APP"]PAPER(RowId,"ALL"))  // 获取数据串
    set PaperDob = $Piece(PatientStr,"^",6)     // 截取所需字段
    s:PaperDob'="" PaperDob=$ZDATE(PaperDob, 3)
    quit "RowId为"_RowId_"的病人的生日"_PaperDob
}

Method Forecast(StockName As %String) As %Integer [ WebMethod ]
{
    // apply patented, nonlinear, heuristic to find new price
    Set price = $Random(1000)
    Quit price
}

ClassMethod Post()
{
    Set httprequest = ##class(%Net.HttpRequest).%New()

    // Set the target URL
    Set httprequest.Server = "https://example.com/api/endpoint"

    // Set the request method to POST
    Set httprequest.HttpMethod = "POST"

    // Insert form data
    Set data("name") = "John Doe"
    Set data("age") = 30
    do httprequest.InsertFormData("gender","male")
    Do httprequest.InsertFormData(.data)

    // Execute the request
    Set status = httprequest.Execute()

    // Check for success
    If $$$ISOK(status) {
        Write "Request successful"
        // Handle the response if needed
        Set responseBody = httprequest.HttpResponse.Data
        Write "Response: ", responseBody
    } else {
        Write "Request failed, status code: ", status
        Write "Error: ", httprequest.HttpResponse.ReasonPhrase
    }
}

ClassMethod Log()
{
    ; https://community.intersystems.com/post/zinvokeclient208soapwebclient1
    set ^ISCSOAP("LogFile") = "/root/a.log"
    Set ^ISCSOAP("Log")="ios"
    /*
    *   debug websevice
    */
    ; clear
    Set ^ISCSOAP("Log")=""
}
}



}
