Class demo.csp.Hello Extends %CSP.Page
{

ClassMethod OnPage() As %Status
{
	&html<<html>
	<head>
	</head>
	<body>>
		; To do...
		Write "<b>Hello, World</b>",!
		w "<ul>",!
		for i = 1 : 1 : 10 {
			w "<LI> This is item ", i,!
		}
		w "</ul>",!
		&html<</body>
	</html>>
		Quit $$$OK
}

}
