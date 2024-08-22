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
ClassMethod Read()
{
    s reader = ##class(%XML.Reader).%New()
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
                /*
                set status=writer.Element("Name")
                set status=writer.WriteChars(name)
                set status=writer.EndElement()
                */
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
