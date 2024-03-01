Class demo.datatype.xml Extends %RegisteredObject
{

ClassMethod XML()
{
    // %XML.GlobalCharacterStream
    // %XML.Adaptor
    s obj = ##class(demo.entity.Company).%New()
    s obj.Name = "Nvidia"
    d obj.XMLExportToStream(.xml)
    q xml
}

}
