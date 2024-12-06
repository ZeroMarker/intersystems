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

/**
	* @debug d ##class(web.DHCDocMain).ParseXML()
	* @docs http://dl.icdst.org/pdfs/files3/28a5ac210f6dc33355a580690a71fe4c.pdf
	*		MoveToFirstChild()
			MoveToLastChild()
			MoveToNextSibling()
			MoveToPreviousSibling()
*/
ClassMethod ParseXML()
{
	Set xml = ..ToString()
	
    // Create an instance of the XML.Reader
    Set reader = ##class(%XML.Reader).%New()
    
    // Load the XML string into the reader
    Do reader.OpenString(xml)
    s document = reader.Document
    s node = document.GetDocumentElement()
    
    //	skip whithspace
	    d node.MoveToFirstChild(1)
	    Set count=node.GetNumberAttributes()
		Write !, "Number of attributes: ", count
		Set first=node.FirstAttributeName()
		// color="red"
		Write !, "First attribute is: ", first
		Write !, " Its value is: ",node.GetAttributeValue(first)
		Set next=node.NextAttributeName(first)
		
	    w !,node.LocalName
	    Write !,"HasChildNodes returns "_node.HasChildNodes()
	    w !,node.NodeData
	    
	    	d node.MoveToFirstChild(1)
		    // text
		    d node.GetText(.text)
		    w !,text
		    w !,node.LocalName
		    // <tag/>
		    Write !,"HasChildNodes returns "_node.HasChildNodes()
		    w !,node.NodeData
		    
		    	// 最后一层节点是标签里的值
		    	d node.MoveToFirstChild(1)
			    w !,node.LocalName
			    Write !,"HasChildNodes returns "_node.HasChildNodes()
			    w !,node.NodeData
	
	// Close the reader
    Do reader.Close()

    
    
    Set reader = ##class(%XML.Reader).%New()
    
    Do reader.OpenString(xml)    //将XML字符串加载到读取器中
    s node = reader.Document.GetDocumentElement()    //获取根节点
    d node.GetText(.text)
    
    if (node.HasChildNodes()){
	    s text=""
	    d node.MoveToFirstChild(1)
	    d node.GetText(.text)
	    s status = text
    	While node.MoveToNextSibling(1) {
	    	s text=""
        	d node.GetText(.text)
        	s message = text
   		}
	}
}
}
