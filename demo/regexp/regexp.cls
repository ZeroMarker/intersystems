Class demo.regexp.regexp Extends %RegisteredObject
{
ClassMethod Match() As %Status
{
    Set testthis="333-99-0000"
    Write testthis ?3N1"-"2N1"-"4N
}

ClassMethod ValidateTime(time As %String) As %Boolean
{
    // Regular expression pattern for hh:mm format
    Set pattern = "^(?:[01][0-9]|2[0-3]):[0-5][0-9]$"
    
    // Use $Match to check if the time string matches the pattern
    If $Match(time, pattern) {
        Return 1  // Valid time format
    } Else {
        Return 0  // Invalid time format
    }
}
}