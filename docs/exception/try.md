# Exception Handling

```objectscript
TRY {
    // Code that might throw an exception
    // For example, divide by zero
    SET x = 1 / 0
} CATCH ex {
    // Code to handle the exception
    // Print the exception message
    WRITE "Exception occurred: ", ex.Name, " - ", ex.Message, !
} FINALLY {
    // Optional block
    // Code that should be executed regardless of whether an exception occurred or not
    // For example, clean-up code
    WRITE "Finally block executed", !
}

TRY {
    // Code that might throw an exception
    SET x = $RANDOM(-5,5)
    IF x < 0 {
        THROW ##class(%Exception.General).Create("Negative number found")
    } ELSEIF x = 0 {
        THROW ##class(%Exception.General).Create("Zero found")
    } ELSE {
        WRITE "Positive number: ", x, !
    }
} CATCH ex IF ex.Name = "General" {
    // Handle exceptions of type %Exception.General
    WRITE "General exception occurred: ", ex.Message, !
} CATCH ex IF ex.Name = "SQLCODE" {
    // Handle exceptions of type %Exception.SQLCODE
    WRITE "SQL error occurred: ", ex.Message, !
} FINALLY {
    // Optional block
    // Code that should be executed regardless of whether an exception occurred or not
    // For example, clean-up code
    WRITE "Finally block executed", !
}

```
