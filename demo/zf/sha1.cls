Class demo.zf.sha1 Extends %RegisteredObject
{
/// w ##class(web.DHCDocMain).SHA1("姚鑫",123456)
ClassMethod SHA1(text, id)
{
	; 写入文件
	s home = "/dthealth/cachesys/mgr/"
	set tempFile = home_id_".new"
	set fs=##class(%Stream.FileCharacter).%New()
    set fs.Filename=tempFile
    set fs.TranslateTable="UTF8"
    do fs.Write(text)
    do fs.%Close()
    set sc=fs.%Save()
    ; bash
	set status = $ZF(-100,"/SHELL","bash","./user/sha1.sh",id_".new")
	s ^QueryURL("zf") = status_","_$USERNAME
	q:status'=0 text
	; 读取文件
	set tempFile = home_id_".out"
	set file = ##class(%File).%New(tempFile)
    set sc = file.Open("R")
    if $$$ISERR(sc) quit sc
	s hex = ""
    while 'file.AtEnd {
        set str=file.ReadLine() 
        set hex = hex _ str
    }
    do file.Close()
    ; 移除文件
	set status = $ZF(-100,"/SHELL","rm",id_".new",id_".out")
	s hex = $zcvt(hex,"U")
    q hex
}
}