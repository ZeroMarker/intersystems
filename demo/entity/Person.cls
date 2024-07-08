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
