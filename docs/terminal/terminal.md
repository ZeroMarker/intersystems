write #

!ls

halt
```objectscript
w $system.Process.BreakMode(0)
ignore BREAKs
w $system.Process.BreakMode(1)
```