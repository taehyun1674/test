<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/cmmn/common_lib.jsp" %>
<script>
	$(document).ready(function(){
		setTimeout(function() { 
			fn_typeList("1");	
		}, 500);
	});
	
	function fn_typeList(num){
		if(num == "1"){
			window.location = "niaspeed://getinternetspeedlist?callback=internetCallbackfunction";
		}
		else{
			window.location = "niaspeed://getwebspeedlist?callback=webCallbackfunction";
		}
	}
	
	function internetCallbackfunction(data){
		var rs = JSON.parse(data).result;
		$("#internetList").empty();
		
		var html = new StringBuffer();
		for(var i = 0; i < rs.length; i++){
			
			html.append("<tr>");
			html.append("<td>");
			html.append(rs[i].dateTime.substring(0, 10));
			html.append("<br/>");
			html.append(rs[i].dateTime.substring(10));
			html.append("</td>");
			html.append("<td>" + rs[i].down + "</td>");
			html.append("<td>" + rs[i].up + "</td>");
			html.append("<td>" + rs[i].rtt + "</td>");
			html.append("<td>" + rs[i].loss + "</td>");
			html.append("<td>" + rs[i].netType + "</td>");
			html.append("</tr>");
		}
		
		$("#internetList").append(html.toString());
	}
	
	function webCallbackfunction(data){
		var rs = JSON.parse(data).result;
		$("#webList").empty();
		
		var html = new StringBuffer();
		for(var i = 0; i < rs.length; i++){
			var url = "";
			if(rs[i].userUrl != "undefined"){
				url = rs[i].userUrl;	
			}
			
			html.append("<tr>");
			html.append("<td>");
			html.append(rs[i].dateTime.substring(0, 10));
			html.append("<br/>");
			html.append(rs[i].dateTime.substring(10));
			html.append("</td>");
			html.append("<td>" + rs[i].naver + "</td>");
			html.append("<td>" + rs[i].daum + "</td>");
			html.append("<td>" + rs[i].url + "<span>" + url + "</span></td>");
			html.append("<td>" + rs[i].netType + "</td>");
			html.append("</tr>");
		}
		
		$("#webList").append(html.toString());
	}
</script>
<div class="contentContainer historyWrap">
	<div class="topTitle">
		<img class="logo" src="${pageContext.request.contextPath }/images/logo.png" width="" height="" alt="" onclick="fn_main()"/>
		<p><spring:message code="ui.message.ResultSubTitle"></spring:message></p>
	</div>
	<div class="contentWrap">
		<ul class="tabBtn">
			<li class="on" id="table_speed" onclick="fn_typeList('1')"><spring:message code="ui.message.SpeedTitle"></spring:message></li>
			<li id="table_time" onclick="fn_typeList('2')"><spring:message code="ui.message.WebTitle"></spring:message></li>
		</ul>
		<div class="tableWrap table_speed" style="display:block;">
			<table summary="인터넷 속도">
				<caption class="blind"><spring:message code="ui.message.SpeedTitle"></spring:message></caption>
				<colgroup>
					<col />
					<col span="5" style="width:16.6%"/>
				</colgroup>
				<thead>
					<tr>
						<th><spring:message code="ui.message.TableDate"></spring:message></th>
						<th><spring:message code="ui.message.TableDown"></spring:message><span>Mbps</span></th>
						<th><spring:message code="ui.message.TableUp"></spring:message><span>Mbps</span></th>
						<th><spring:message code="ui.message.TableRtt"></spring:message><span>ms</span></th>
						<th><spring:message code="ui.message.TableLoss"></spring:message><span>%</span></th>
						<th><spring:message code="ui.message.TableNet"></spring:message></th>
					</tr>
				</thead>
			</table>
			<div class="scrollWrap">
				<table summary="인터넷 속도">
					<caption class="blind"><spring:message code="ui.message.SpeedTitle"></spring:message></caption>
					<colgroup>
						<col />
						<col span="5" style="width:16.6%"/>
					</colgroup>
					<tbody id="internetList"></tbody>
				</table>	
			</div>
		</div>
		<div class="tableWrap table_time">
			<table summary="웹 접속 시간">
				<caption class="blind"><spring:message code="ui.message.WebTitle"></spring:message></caption>
				<colgroup>
					<col />
					<col span="4" style="width:20%"/>
				</colgroup>
				<thead>
					<tr>
						<th><spring:message code="ui.message.TableDate"></spring:message></th>
						<th><spring:message code="ui.message.TableWeb1"></spring:message><span>ms</span></th>
						<th><spring:message code="ui.message.TableWeb2"></spring:message><span>ms</span></th>
						<th><spring:message code="ui.message.TableWeb3"></spring:message><span>ms</span></th>
						<th><spring:message code="ui.message.TableNet"></spring:message></th>
					</tr>
				</thead>
			</table>
			<div class="scrollWrap">
				<table summary="웹 접속 시간">
					<caption class="blind"><spring:message code="ui.message.WebTitle"></spring:message></caption>
					<colgroup>
						<col />
						<col span="4" style="width:20%"/>
					</colgroup>
					<tbody id="webList"></tbody>
				</table>		
			</div>
		</div>
	</div>
</div>