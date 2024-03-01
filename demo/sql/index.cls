Class demo.sql.index Extends %Persistent
{

Property AdmDR As %String [ Required, SqlColumnNumber = 2 ];

Index AdmDRIndex On AdmDR As Exact;

Property ARCIM As %String [ Required, SqlColumnNumber = 3 ];

Index AdmArcim On (AdmDR As Exact, ARCIM As Exact);

Storage Default
{
<Data name="indexDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>AdmDR</Value>
</Value>
<Value name="3">
<Value>ARCIM</Value>
</Value>
</Data>
<DataLocation>^demo.sql.indexD</DataLocation>
<DefaultData>indexDefaultData</DefaultData>
<IdLocation>^demo.sql.indexD</IdLocation>
<IndexLocation>^demo.sql.indexI</IndexLocation>
<StreamLocation>^demo.sql.indexS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

ClassMethod Index()
{
    /*
    ^User.CMMaxLimitI("AdmArcim",411,"430||1",2)=""
    ^User.CMMaxLimitI("AdmArcim",483,"1062||1",3)=""
    ^User.CMMaxLimitI("AdmArcim",483,"1062||1",4)=""
    ^User.CMMaxLimitI("AdmArcim",483,"1062||1",5)=""
    ^User.CMMaxLimitI("AdmArcim",483,"430||1",6)=""
    ^User.CMMaxLimitI("AdmDRIndex",411,1)=""
    ^User.CMMaxLimitI("AdmDRIndex",411,2)=""
    ^User.CMMaxLimitI("AdmDRIndex",483,3)=""
    ^User.CMMaxLimitI("AdmDRIndex",483,4)=""
    ^User.CMMaxLimitI("AdmDRIndex",483,5)=""
    ^User.CMMaxLimitI("AdmDRIndex",483,6)=""
    */
}

}
