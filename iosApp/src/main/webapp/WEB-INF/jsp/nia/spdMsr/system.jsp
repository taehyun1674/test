<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/cmmn/common_lib.jsp" %>
<script type="text/javascript">

	$(document).ready(function(){
		setTimeout(function() { 
			window.location = "niaspeed://getsettings?callback=settingCallbackfunction";	
		}, 500);		
	});
	
	function settingCallbackfunction(data){
		var resData = JSON.parse(data);
		var rs = resData.result;
		
		if(rs.networkallowed =="true"){
			$("input:checkbox[id='toggle']").prop("checked", rs.networkallowed);
		}
		if(rs.multiConnect =="true"){
			$("input:checkbox[id='multi']").prop("checked", rs.multiConnect);
		}
						
		$("#modelNm").text(rs.deviceModel);
		$("#osVer").text(rs.deviceVersion);
		$("#cpuType").text(rs.cpuType);
		$("#networkType").text(rs.networkType);
		$("#ipType").text(rs.localIP);
		$("#Latitude").text(rs.lat);
		$("#longitude").text(rs.lon);
		$("#appVer").text(rs.appVer);
	}
	
	function fn_dataAllow(){
		var toggle = "NO";
		var multi  = "NO";
		if($("#toggle").is(":checked")){
			toggle = "YES";
		}
		if($("#multi").is(":checked")){
			multi = "YES";
		}
		
		window.location =  "niaspeed://putsettings?network=" + toggle + "&multicon=" + multi + "&callback=dataCallbackfunction";
	}
	
	function dataCallbackfunction(data){
		var resData = JSON.parse(data);
		var rs = resData.result;
		
		if(rs.networkallowed =="true"){
			$("input:checkbox[id='toggle']").prop("checked", rs.networkallowed);
		}
		if(rs.multiConnect =="true"){
			$("input:checkbox[id='multi']").prop("checked", rs.multiConnect);
		}
	}
</script>
<div class="contentContainer systemWrap">
	<div class="topTitle">
		<img class="logo" src="${pageContext.request.contextPath }/images/logo.png" width="" height="" alt="" onclick="fn_main()"/>
		<p><spring:message code="ui.message.footer.setting"></spring:message></p>
	</div>
	<div class="contentWrap">			
	<!--	191123	-->
		<div class="topmenu">
			<ul>
				<li>
					<p class="title"><spring:message code="ui.message.EnableNet"></spring:message></p>
					<div class="toggleWrap">
						<input type="checkbox" id="toggle" value="" onclick="fn_dataAllow()"/>
						<label for="toggle"></label>
					</div>
				</li>
				<!-- 
				<li>
					<p class="title">다중 접속 허용</p>
					<div class="toggleWrap">
						<input type="checkbox" id="multi" value="" onclick="fn_dataAllow()"/>
						<label for="multi"></label>
					</div>
				</li>
				 -->
			</ul>
		</div>
	<!--	//191123	-->
		<dl>
			<dt><spring:message code="ui.message.Model"></spring:message></dt>
			<dd id="modelNm"></dd>
			<dt><spring:message code="ui.message.OS"></spring:message></dt>
			<dd id="osVer"></dd>
			<dt><spring:message code="ui.message.CPU"></spring:message></dt>
			<dd id="cpuType"></dd>
			<dt><spring:message code="ui.message.Network"></spring:message></dt>
			<dd id="networkType"></dd>
			<dt><spring:message code="ui.message.InIP"></spring:message></dt>
			<dd id="ipType"></dd>
			<dt><spring:message code="ui.message.Lat"></spring:message></dt>
			<dd id="Latitude"></dd>
			<dt><spring:message code="ui.message.Lon"></spring:message></dt>
			<dd id="longitude"></dd>
			<dt><spring:message code="ui.message.AppVer"></spring:message></dt>
			<dd id="appVer"></dd>
		</dl>
		<!--<p class="popupBtn" id="wifiPopup">WiFi Info</p>-->
		<p class="popupBtn" id="companyPopup"><spring:message code="ui.message.company"></spring:message></p>
	</div>
</div>