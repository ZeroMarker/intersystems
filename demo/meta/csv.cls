Class CSVExporter.Person Extends (%Persistent, %XML.Adaptor)
{

Property Name As %String;

Property Age As %Integer;

Property City As %String;

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Age</Value>
</Value>
<Value name="4">
<Value>City</Value>
</Value>
</Data>
<DataLocation>^CSVExporter.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<ExtentSize>2</ExtentSize>
<IdLocation>^CSVExporter.PersonD</IdLocation>
<IndexLocation>^CSVExporter.PersonI</IndexLocation>
<Property name="%%CLASSNAME">
<AverageFieldSize>2</AverageFieldSize>
<Selectivity>100.0000%</Selectivity>
</Property>
<Property name="%%ID">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>1</Selectivity>
</Property>
<Property name="Age">
<AverageFieldSize>3</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="City">
<AverageFieldSize>11</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<Property name="Name">
<AverageFieldSize>11</AverageFieldSize>
<Selectivity>50.0000%</Selectivity>
</Property>
<SQLMap name="IDKEY">
<BlockCount>-4</BlockCount>
</SQLMap>
<StreamLocation>^CSVExporter.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

/// Create sample records
/// d ##class(CSVExporter.Person).CreateSampleData()
ClassMethod CreateSampleData()
{
    // Clear existing data
    Do ##class(CSVExporter.Person).%KillExtent()
    
    // Create first person
    Set person1 = ##class(CSVExporter.Person).%New()
    Set person1.Name = "John Doe"
    Set person1.Age = 30
    Set person1.City = "New York, NY"
    Set sc = person1.%Save()
    If $$$ISERR(sc) Do $System.Status.DisplayError(sc)
    
    // Create second person
    Set person2 = ##class(CSVExporter.Person).%New()
    Set person2.Name = "Jane Smith"
    Set person2.Age = 25
    Set person2.City = "London"
    Set sc = person2.%Save()
    If $$$ISERR(sc) Do $System.Status.DisplayError(sc)
    
    Write !,"Sample data created!"
}

/// Export Person data to CSV
/// d ##class(CSVExporter.Person).ExportToCSV()
ClassMethod ExportToCSV(filePath As %String = "/tmp/output.csv")
{
    Set file = ##class(%Library.File).%New(filePath)
    Set status = file.Open("WSN")
    If 'status {
        Write !,"Error opening file: ",filePath
        Quit $$$ERROR(status)
    }
    
    // Write CSV header
    Do file.WriteLine("Name,Age,City")
    
    // Get data
    Set rs = ##class(%SQL.Statement).%ExecDirect(,
        "SELECT Name, Age, City FROM CSVExporter.Person")
    
    If (rs.%SQLCODE '= 0) {
        Do file.Close()
        Write !,"SQL Error: ",rs.%Message
        Quit $$$ERROR($$$SQLError, rs.%SQLCODE, rs.%Message)
    }
    
    // Write records
    While rs.%Next() {
        Set name = ..EscapeCSV(rs.%Get("Name"))
        Set age = rs.%Get("Age")
        Set city = ..EscapeCSV(rs.%Get("City"))
        Do file.WriteLine(name _ "," _ age _ "," _ city)
    }
    
    Do file.Close()
    Write !,"CSV exported to: ",filePath
    Quit $$$OK
}

/// Escape CSV values
ClassMethod EscapeCSV(value As %String) As %String
{
    If value [ "," || (value [ """") {
        Set value = $Replace(value, """", """""")
        Return """" _ value _ """"
    }
    Return value
}

}
