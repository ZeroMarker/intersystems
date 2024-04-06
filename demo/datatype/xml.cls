Class demo.datatype.xml Extends %RegisteredObject
{

ClassMethod XML()
{
    // %XML.GlobalCharacterStream
    // %XML.Adaptor
    #Dim XML As %Stream.GlobalCharacter
    s obj = ##class(demo.entity.Company).%New()
    s obj.Name = "Nvidia"
    d obj.XMLExportToString(.xml)
    q xml
}

ClassMethod Char()
{
    SET gcoref=##class(%Stream.GlobalCharacter).%New()
    DO gcoref.WriteLine("First Line")
    DO gcoref.WriteLine("Second Line")
    KILL ^CacheStream
    WRITE gcoref.%Save(),!
    ZWRITE ^CacheStream
    q 0
}

ClassMethod XML2()
{
    ; Define a variable
    s name = "Mark"
    s age = 13

    ;set writer.Charset="UTF-8"
    
    /*
    Set p=##class(demo.entity.Person).%OpenId(1)
 
    Set w=##class(%XML.Writer).%New()
 
    Set w.Indent=1
 
    Set status=w.RootObject(p)
    */

    //write output to current device
    //simple demo of Element & related methods
    set writer=##class(%XML.Writer).%New()
    set writer.Indent=1
    set status=writer.OutputToDevice()
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.StartDocument()
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.RootElement("root")
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.Element("SampleElement")
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.WriteAttribute("Attribute","12345")
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.Element("subelement")
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.WriteChars("Content")
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.EndElement()
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.Element("subelement")
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.WriteChars("Content")
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.EndElement()
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.EndElement()
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.EndRootElement()
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    set status=writer.EndDocument()
    if $$$ISERR(status) {do $System.Status.DisplayError(status) quit}
    q 0
}

ClassMethod ToString()
{
    s name = "Mark"
    s age = 34

    set writer=##class(%XML.Writer).%New()
    set writer.Indent=1
    set writer.Charset="UTF-8"

    set status=writer.OutputToString()
    
    set status=writer.StartDocument()
    
    set status=writer.RootElement("IDRoot")
    set status=writer.Element("SampleElement")
    set status=writer.WriteAttribute("Attribute","12345")
    
    set status=writer.Element("Name")
    set status=writer.WriteChars(name)
    set status=writer.EndElement()
    
    set status=writer.Element("Age")
    set status=writer.WriteChars(age)
    set status=writer.EndElement()

    set status=writer.EndElement()
    
    set status=writer.EndRootElement()
    
    set status=writer.EndDocument()
    
    s string=writer.GetXMLString()
    q string
}

}
