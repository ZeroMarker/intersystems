Class demo.compile.indirect Extends %RegisteredObject
{

ClassMethod indirect()
{
    d Start
Start
 READ !,"Enter choice (1, 2, or 3): ",num
 SET loc = "Choice"_num 
 DO @loc
 RETURN
Choice1()
 ; ...
Choice2()
 ; ...
Choice3()
 ; ...


Starts
 READ !,"Output Name, Street, and City info.",!
 READ !,"Name of array to access: ",name
 READ !,"Global or local (G or L): ",gl
 READ !,"Start with record number: ",start
 READ !,"End with record number: ",end
 IF (gl["L")!(gl["l") {SET array = name}
 ELSEIF (gl["G")!(gl["g") {SET array = "^"_name}
 SET x = 1,y = 1
 FOR i = start:1:end {DO Output}
 RETURN
Output()
 WRITE !,@array@(i)
 WRITE !,@array@(i,x)
 WRITE !,@array@(i,x,y)
 QUIT
}

}
