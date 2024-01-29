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

}
