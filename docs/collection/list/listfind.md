```objectscript
Set valueToCheck = "yourValue"
Set array = "value1,value2,value3,value4"

If $LISTFIND(array, valueToCheck, ",") > 0 {
    Write "Value is present in the array"
} Else {
    Write "Value is not present in the array"
}
```