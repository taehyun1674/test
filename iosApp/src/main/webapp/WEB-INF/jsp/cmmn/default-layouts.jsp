<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles"  prefix="tiles"%>
<!DOCTYPE html>
<html>
	<head>
		<tiles:insertAttribute name="head"/>
	</head>
  	<body>
  		<div class="wrapper pageWrap">
			<tiles:insertAttribute name="content"/>
		  	<tiles:insertAttribute name="footer"/>
  		</div>
  	</body>
</html>