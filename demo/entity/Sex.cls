Class demo.entity.Sex Extends (%Persistent, %Library.Populate)
{

Property Desc As %String;

Storage Default
{
<Data name="SexDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Desc</Value>
</Value>
</Data>
<DataLocation>^demo.entity.SexD</DataLocation>
<DefaultData>SexDefaultData</DefaultData>
<IdLocation>^demo.entity.SexD</IdLocation>
<IndexLocation>^demo.entity.SexI</IndexLocation>
<StreamLocation>^demo.entity.SexS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
