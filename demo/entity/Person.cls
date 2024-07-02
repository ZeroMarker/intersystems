Class demo.entity.Person Extends (%Persistent, %Library.Populate)
{

/// Planet
Parameter PLANET = "Earth";

/// name
Property Name As %String [ Required ];

/// phone
Property Phone As %String;

/// age
Property Age As %Integer;

/// phone index
Index PhoneIdx On Phone As Exact;

ClassMethod DQuery()
{
    SET myquery = "SELECT top 40 * FROM demo.Person"
    SET tStatement = ##class(%SQL.Statement).%New()
    SET tStatus = tStatement.%Prepare(myquery)
    SET rset = tStatement.%Execute()
    DO rset.%Display()
    WRITE !,"End of data"
}

/// Others: d ##class(Demo.Person).GetPatientBirthday(3)
ClassMethod GetPatientBirthday(RowId As %String) As %String
{
    quit:RowId="" ""
    set PatientStr = $Get(^["USER"]demo.PersonD(RowId))  // 获取数据串
    set PaperDob = $Piece(PatientStr,"^",6)     // 截取所需字段
    s:PaperDob'="" PaperDob=$ZDATE(PaperDob, 3)
    quit PaperDob
}

Method GetName()
{
    q $this.Name
}

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
<Value>Phone</Value>
</Value>
<Value name="4">
<Value>Age</Value>
</Value>
</Data>
<DataLocation>^demo.entity.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^demo.entity.PersonD</IdLocation>
<IndexLocation>^demo.entity.PersonI</IndexLocation>
<StreamLocation>^demo.entity.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
