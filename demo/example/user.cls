Class demo.example.user Extends %RegisteredObject
{

/// Generate a random number.
/// This method can be called from outside the class.
ClassMethod Random() [ Language = objectscript ]
{
    set rand=$RANDOM(10)+1        ; rand is an integer in the range 1-10
    write "Your random number: "_rand
    set name=..GetNumberName(rand)
    write !, "Name of this number: "_name
}

/// Input a number.
/// This method can be called from outside the class.
ClassMethod Input() [ Language = objectscript ]
{
    read "Enter a number from 1 to 10: ", input
    set name=..GetNumberName(input)
    write !, "Name of this number: "_name
}

/// Given an number, return the name.
/// This method can be called only from within this class.
ClassMethod GetNumberName(number As %Integer) As %Integer [ Language = objectscript, Private ]
{
    set name=$CASE(number,1:"one",2:"two",3:"three",
        4:"four",5:"five",6:"six",7:"seven",8:"eight",
        9:"nine",10:"ten",:"other")
    quit name
}

/// Write some interesting values.
/// This method can be called from outside the class.
ClassMethod Interesting() [ Language = objectscript ]
{
    write "Today's date: "_$ZDATE($HOROLOG,3)
    write !,"Your installed version: "_$ZVERSION
    write !,"Your username: "_$USERNAME
    write !,"Your security roles: "_$ROLES
}

ClassMethod Transaction()
{
    Set tSC = $$$OK

    Try {
        // Start a new transaction
        Set tSC = %SYS.Transaction.Start()
        If $$$ISERR(tSC) {
            // Handle error starting the transaction
            Write "Error starting transaction: ", tSC, !
            Quit
        }

        // Your transaction logic goes here

        // Commit the transaction
        Set tSC = %SYS.Transaction.Commit()
        If $$$ISERR(tSC) {
            // Handle error committing the transaction
            Write "Error committing transaction: ", tSC, !
        }
    } Catch ex {
        // Handle exception
        Write "Exception: ", ex.Name, " - ", ex.Message, !
        Set tSC = %SYS.Transaction.Rollback()
    }

    // Check for uncommitted transactions
    Set status = %SYS.Transaction.Status()
    If status = 1 {
        Write "There are uncommitted transactions.", !
    } ElseIf status = 0 {
        Write "No uncommitted transactions.", !
    } Else {
        Write "Error checking transaction status.", !
    }
}

ClassMethod Calc()
{
    // Birthdate in $h format
    Set birthdate = 50133

    // Current date in $h format
    Set currentDate = +$h

    // Get year, month, and day components
    Set birthYear = ..format(birthdate, 1, 4)
    Set birthMonth = ..format(birthdate, 5, 6)
    Set birthDay = ..format(birthdate, 7, 8)

    Set currentYear = ..format(currentDate, 1, 4)
    Set currentMonth = ..format(currentDate, 1, 4)
    Set currentDay = ..format(currentDate, 1, 4)

    // Calculate age
    Set ageYears = currentYear - birthYear
    If (currentMonth < birthMonth) || ((currentMonth = birthMonth) && (currentDay < birthDay)) {
        Set ageYears = ageYears - 1
    }

    Write "Birthdate: ", $zd(birthdate, 3), !
    Write "Current Date: ", $zd(currentDate, 3), !
    Write "Age: ", ageYears, " years", !
    // Format dates to "YYYYMMDD"
}

ClassMethod format(date, start, end)
{
    q $Extract($ZD(date, 3), start, end)
}

}
