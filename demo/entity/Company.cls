Class demo.entity.Company Extends (%Persistent, %Populate, %XML.Adaptor) [ SqlTableName = Company ]
{

Property Name As %String [ Required ];

Property YearActived As %Integer;

Property Industry As %String;

Parameter COUNTRY = "USA";

ClassMethod QuarterlyProfits(Earning As %Integer, Expenses As %Integer) As %Integer
{
    set profit = Earning - Expenses
    return profit
}

/// Description
Method PrintCompany() As %Status
{
    write !, "The company is named ", ..Name , "."
    write !, ..Name, " has actived in ", ..Industry, " for ", ..YearActived, " years."
    write !, "This company is at ", ..#COUNTRY 

    return $$$OK
}

Storage Default
{
<Data name="CompanyDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>YearActived</Value>
</Value>
<Value name="4">
<Value>Industry</Value>
</Value>
</Data>
<DataLocation>^demo.entity.CompanyD</DataLocation>
<DefaultData>CompanyDefaultData</DefaultData>
<IdLocation>^demo.entity.CompanyD</IdLocation>
<IndexLocation>^demo.entity.CompanyI</IndexLocation>
<StreamLocation>^demo.entity.CompanyS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
