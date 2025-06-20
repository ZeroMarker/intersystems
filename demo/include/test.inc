ROUTINE test.inc

#define add(%x,%y) ((%x)+(%y))

#define StringMacro "Hello, World!"
#Include %cspInclude
$$$URLENCODE
    /*

    s original = "http://www.google.com/search?q=hello+world"
    s text = $REPLACE(original,"/","%2f")

    // for unicode
	s bin=$ZCONVERT(a,"O","UTF8")
	s b = $System.Encryption.Base64Encode(bin)
    */
    