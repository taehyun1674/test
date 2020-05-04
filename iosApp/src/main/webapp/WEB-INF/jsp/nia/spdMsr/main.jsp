<!doctype html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=Edge">
    <meta charset="UTF-8">
    <meta name="viewport" content="height=device-height, width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
	<title>opening</title>
	<meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="stylesheet" href="css/common.css" media="screen" />
	<script type="text/javascript" src="js/jquery-3.4.1.min.js"></script>
	<script type="text/javascript" src="js/common.js"></script>
</head>
<body>
<div class="wrapper pageWrap">
	<div class="openingWrap">
		<img class="logo" src="images/logo_opening.png" width="" height="" alt="" />
		<img class="opening" src="images/main.gif" width="" height="" alt="" />
	</div>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		window.location = "niaspeed://getsettings?callback=returnDataAllow";
	});
	
	function returnDataAllow(data){
		var resData = JSON.parse(data).result;
		var type 	= resData.networkType;
		var lang	= resData.Locale;
		
		if(lang.indexOf("ko") == 0){
			lang = "ko";
		}
		else if(lang.indexOf("en") == 0){
			lang = "en";
		}
		else if(lang.indexOf("ja") == 0){
			lang = "jp";
		}
		else{
			lang = "ko";
		}
		
		setTimeout(function() { 
			location.href = "${pageContext.request.contextPath }/SpdMsr/speedTest.do?NETWORK_TYPE=" + type + "&lang="+lang;
		}, 2000);
	}
</script>
</body>
</html>