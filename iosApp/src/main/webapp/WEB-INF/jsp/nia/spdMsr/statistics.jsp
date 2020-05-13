<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/cmmn/common_lib.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		setTimeout(function() { 
			window.location = "niaspeed://getdeviceid?callback=myDeviceIdCallBack";
		}, 500);
	});
	
	function myDeviceIdCallBack(data){
		var rs = JSON.parse(data).result;
		GetObject.id("DEVICE_ID").value = rs.device_id;	
		
		setTimeout(function() { 
			fn_topMenu("2");	
		}, 500);
	}

	// 탑 메뉴 선택시
	function fn_topMenu(num){
		GetObject.id("firstTopMenu").value = num;
		
		fn_activeMenuInit();
		GetObject.id("PERIOD").value = "D";
		GetObject.id("NETWORK").value = "LTE";		
		if(num == "1"){
			fn_selectMyStatistics();		
		}
		else if(num == "2"){
			interNetLocalData();
		}
		else if(num == "3"){
			webSpeedStatistics();
		}
		else if(num == "4"){
			networkLocalStatistics();
		}
		
	}
	
	function fn_activeMenuInit(){
		// 내통계
		$("#myMenuBtn li").siblings().removeClass("on");
		$("#myMenuBtn li").eq(0).addClass("on");
		
		// 내통계 기간
		$("#periodType li").siblings().removeClass("on");
		$("#periodType li").eq(0).addClass("on");
		
		// 인터넷  
		$("#interNetMenuBtn li").siblings().removeClass("on");
		$("#interNetMenuBtn li").eq(0).addClass("on");
		$("#INTERNET_PERIOD li").siblings().removeClass("on");
		$("#INTERNET_PERIOD li").eq(0).addClass("on");
		
		// 웹 기간
		$("#WEB_PERIOD li").siblings().removeClass("on");
		$("#WEB_PERIOD li").eq(0).addClass("on");
		
		// 통신사 메뉴
		$("#localMenuBtn li").siblings().removeClass("on");
		$("#localMenuBtn li").eq(0).addClass("on");
		
		// 통신사 기간  
		$("#LOCAL_PERIOD li").siblings().removeClass("on");
		$("#LOCAL_PERIOD li").eq(0).addClass("on");
		
	}
	
	function fn_period(type){
		var topMenu = GetObject.id("firstTopMenu").value;
		GetObject.id("PERIOD").value = type;
		if(topMenu == "1"){
			fn_selectMyStatistics();		
		}
		else if(topMenu == "2"){
			interNetLocalData();
		}
		else if(topMenu == "3"){
			webSpeedStatistics();
		}
		else if(topMenu == "4"){
			networkLocalStatistics();
		}
	}
	
	function fn_network(id){
		var topMenu = GetObject.id("firstTopMenu").value;
		GetObject.id("NETWORK").value = id;
		if(topMenu == "1"){
			fn_selectMyStatistics();		
		}
		else if(topMenu == "2"){
			interNetLocalData();
		}
		else if(topMenu == "3"){
			webSpeedStatistics();
		}
		else if(topMenu == "4"){
			networkLocalStatistics();
		}
	}
	
	function fn_selectMyStatistics(){
		var params = $("form[name=frmStatistics]").serialize();
		
		common.ajax("${pageContext.request.contextPath }/SpdMsr/myStatistics.do", params, "json", myCallBack);
	}
	
	function myCallBack(data){
		var netData = data.myData;
 		$("#myDown").empty();
 		$("#myDown_graph").empty();
 		$("#myUpload").empty();
 		$("#myUpload_graph").empty();
 		$("#myJitter").empty();
 		$("#myJitter_graph").empty();
 		$("#myLoss").empty();
 		$("#myLoss_graph").empty();
		
		if(netData != null){		
			$("#myDown").append(netData.DOWNLOAD);
			$("#myDown_graph").append("<p style='height:" + netData.DOWNLOAD + "%'></p>");			
			$("#myUpload").append(netData.UPLOAD);
			$("#myUpload_graph").append("<p style='height:" + netData.UPLOAD + "%'></p>");
			$("#myJitter").append(netData.JITTER);
			$("#myJitter_graph").append("<p style='height:" + netData.JITTER + "%'></p>");
			$("#myLoss").append(netData.LOSS);
			$("#myLoss_graph").append("<p style='height:" + netData.LOSS + "%'></p>");
		}
		else{
			$("#myDown").append(0);
			$("#myDown_graph").append("<p style='height:0%'></p>");			
			$("#myUpload").append(0);
			$("#myUpload_graph").append("<p style='height:0%'></p>");
			$("#myJitter").append(0);
			$("#myJitter_graph").append("<p style='height:0%'></p>");
			$("#myLoss").append(0);
			$("#myLoss_graph").append("<p style='height:0%'></p>");
		}
	}
	
	// 인터넷
	function interNetLocalData(){
		var params = $("form[name=frmStatistics]").serialize();
		common.ajax("${pageContext.request.contextPath }/SpdMsr/localStatistics.do", params, "json", interNetCallBack);
	}
	
	function interNetCallBack(data){
		var avgData  = data.avgData;
		var interNet = data.interNetData;
		var avgDownload;
		var avgUpload;
		
		$("#LOCAL_MAP ul li").removeClass("sunny").removeClass("foggy").removeClass("cloudy").removeClass("rainy");		
		if(avgData == null){
			avgDownload = 0;
			$("#LOCAL_MAP ul li").addClass("rainy");
		}
		else{
			avgDownload = avgData.AVG_DOWNLOAD;
			avgUpload   = avgData.AVG_UPLOAD;
			$("#internet_down").text(avgDownload);
			$("#internet_up").text(avgUpload);
			
			for(var idx = 0; idx < interNet.length; idx++){
				var name = interNet[idx].LOCALITY;
				var down = interNet[idx].DOWNLOAD;
				var s  = avgDownload * 0.9;
				var f  = avgDownload * 0.7;
				var c  = avgDownload * 0.5;
				
				if(name.indexOf("서울") > -1){
					localType("map01", s, f, c, down);
				}
				if(name.indexOf("강원도") > -1){
					localType("map02", s, f, c, down);
				}
				if(name.indexOf("인천") > -1){
					localType("map03", s, f, c, down);
				}
				if(name.indexOf("경기도") > -1){
					localType("map04", s, f, c, down);
				}
				if(name.indexOf("세종") > -1){
					localType("map05", s, f, c, down);
				}
				if(name.indexOf("대전") > -1){
					localType("map06", s, f, c, down);
				}
				if(name.indexOf("충청남도") > -1){
					localType("map07", s, f, c, down);
				}
				if(name.indexOf("충청북도") > -1){
					localType("map08", s, f, c, down);
				}
				if(name.indexOf("경상북도") > -1){
					localType("map09", s, f, c, down);
				}
				if(name.indexOf("대구") > -1){
					localType("map10", s, f, c, down);
				}
				if(name.indexOf("전라북도") > -1){
					localType("map11", s, f, c, down);
				}
				if(name.indexOf("광주") > -1){
					localType("map12", s, f, c, down);
				}
				if(name.indexOf("전라남도") > -1){
					localType("map13", s, f, c, down);
				}
				if(name.indexOf("경상남도") > -1){
					localType("map14", s, f, c, down);
				}
				if(name.indexOf("울산") > -1){
					localType("map15", s, f, c, down);
				}
				if(name.indexOf("부산") > -1){
					localType("map16", s, f, c, down);
				}
				if(name.indexOf("제주도") > -1){
					localType("map17", s, f, c, down);
				}
			}
		}
	}
	
	function localType(map, s, f, c, down){
		if(s <= down){
			$("." + map).addClass("sunny");
		}
		else if(f <= down){
			$("." + map).addClass("foggy");
		}
		else if(c <= down){
			$("." + map).addClass("cloudy");
		}
		else{
			$("." + map).addClass("rainy");
		}
	}
	
	// 웹
	function webSpeedStatistics(){
		var params = $("form[name=frmStatistics]").serialize();
		common.ajax("${pageContext.request.contextPath }/SpdMsr/webStatistics.do", params, "json", webCallBack);
	}
	
	function webCallBack(data){
		var webData = data.webData;
		$("#lteNaverData").empty();
		$("#lteDaumData").empty();
		$("#lteNaverGraph").empty();
		$("#lteDaumGraph").empty();
		
		$("#3gNaverData").empty();
		$("#3gDaumData").empty();
		$("#3gNaverGraph").empty();
		$("#3gDaumGraph").empty();
		
		$("#wifiNaverData").empty();
		$("#wifiDaumData").empty();
		$("#wifiNaverGraph").empty();
		$("#wifiDaumGraph").empty();
		
		if(webData != null){
			for(var idx = 0; idx < webData.length; idx++){
				var naverData = webData[idx].NAVER;
				var daumData  = webData[idx].DAUM;
				var networkId = webData[idx].NETWORK_ID;
				
				if(networkId == "3"){					
					$("#lteNaverData").append(naverData);
					$("#lteDaumData").append(daumData);
					$("#lteNaverGraph").append('<p style="height:' + (naverData*100) + '%">');
					$("#lteDaumGraph").append('<p style="height:' + (daumData*100) + '%">');
				}
				if(networkId == "2"){					
					$("#wifiNaverData").append(naverData);
					$("#wifiDaumData").append(daumData);
					$("#wifiNaverGraph").append('<p style="height:' + (naverData*100) + '%">');
					$("#wifiDaumGraph").append('<p style="height:' + (daumData*100) + '%">');
				}
				if(networkId == "1"){					
					$("#3gNaverData").append(naverData);
					$("#3gDaumData").append(daumData);
					$("#3gNaverGraph").append('<p style="height:' + (naverData*100) + '%">');
					$("#3gDaumGraph").append('<p style="height:' + (daumData*100) + '%">');
				}
			}
		}
	}
	
	function networkLocalStatistics(){
		var params = $("form[name=frmStatistics]").serialize();
		common.ajax("${pageContext.request.contextPath }/SpdMsr/networkLocalStatistics.do", params, "json", newtworkLocalCallBack);
	}
	
	function newtworkLocalCallBack(data){
		var avgData  = data.avgPeriodData;
		var listData = data.networkLocalData;
		
		if(avgData == null){
			$("#network_down").text("0");
			$("#network_up").text("0");
		}
		else{
			$("#network_down").text(avgData.AVG_DOWNLOAD);
			$("#network_up").text(avgData.AVG_UPLOAD);
		}
		
		$("#LOCAL_LIST").empty();
		if(listData != null){			
			var html = new StringBuffer();
			var idx = 0;
			var chkName = "";
			
			for(var i = 0; i < listData.length; i++){
				var avgDown = avgData.AVG_DOWNLOAD;
				var sDown	= avgDown * 0.9;
				var fDown	= avgDown * 0.7;
				var cDown	= avgDown * 0.5;
				var local   = listData[i].LOCALITY;				
				
				if(typeof local == 'undefined'){
					local = "";
				}
				html.append("<tr>");
				html.append("<<td>" + local + "</td>");
				html.append("<td>");
				
				
				if(listData[i].SKT == "0"){
					html.append('NO_DATA');
				}
				else if(sDown <= listData[i].SKT){
					html.append('<img src="${pageContext.request.contextPath }/images/ico_sunny.png" width="" height="" alt="" />');
				}
				else if(fDown <= listData[i].SKT){
					html.append('<img src="${pageContext.request.contextPath }/images/ico_foggy.png" width="" height="" alt="" />');
				}
				else if(cDown <= listData[i].SKT){
					html.append('<img src="${pageContext.request.contextPath }/images/ico_cloudy.png" width="" height="" alt="" />');
				}
				else{
					html.append('<img src="${pageContext.request.contextPath }/images/ico_rainy.png" width="" height="" alt="" />');
				}
				
				html.append("</td>");
				html.append("<td>");
				
				if(listData[i].KT == "0"){
					html.append('NO_DATA');
				}				
				else if(sDown <= listData[i].KT){
					html.append('<img src="${pageContext.request.contextPath }/images/ico_sunny.png" width="" height="" alt="" />');
				}
				else if(fDown <= listData[i].KT){
					html.append('<img src="${pageContext.request.contextPath }/images/ico_foggy.png" width="" height="" alt="" />');
				}
				else if(cDown <= listData[i].KT){
					html.append('<img src="${pageContext.request.contextPath }/images/ico_cloudy.png" width="" height="" alt="" />');
				}
				else{
					html.append('<img src="${pageContext.request.contextPath }/images/ico_rainy.png" width="" height="" alt="" />');
				}
					
				html.append("</td>");
				html.append("<td>");					
				
				if(listData[i].LGU == "0"){
					html.append('NO_DATA');
				}
				else if(sDown <= listData[i].LGU){
					html.append('<img src="${pageContext.request.contextPath }/images/ico_sunny.png" width="" height="" alt="" />');
				}
				else if(fDown <= listData[i].LGU){
					html.append('<img src="${pageContext.request.contextPath }/images/ico_foggy.png" width="" height="" alt="" />');
				}
				else if(cDown <= listData[i].LGU){
					html.append('<img src="${pageContext.request.contextPath }/images/ico_cloudy.png" width="" height="" alt="" />');
				}
				else{
					html.append('<img src="${pageContext.request.contextPath }/images/ico_rainy.png" width="" height="" alt="" />');
				}
					
				html.append("</td>");
				html.append("</tr>");
			}
			
			$("#LOCAL_LIST").append(html.toString());
		}
		
	}
</script>
<form name="frmStatistics">
	<input type="hidden" name="firstTopMenu" id="firstTopMenu" value="${topMenu }" />
	<input type="hidden" name="PERIOD" id="PERIOD" value="${PERIOD }" />
	<input type="hidden" name="NETWORK" id="NETWORK" value="${NETWORK }" />
	<input type="hidden" name="DEVICE_ID" id="DEVICE_ID" value="" />
</form>
<div class="contentContainer statisticsWrap">
		<div class="topTitle">
			<img class="logo" src="${pageContext.request.contextPath }/images/logo.png" width="" height="" alt="" onclick="fn_main()"/>
			<p><spring:message code="ui.message.footer.statics"></spring:message></p>
		</div>
		<div class="contentWrap">
			<ul class="tabBtn">
				<li id="table_my" onclick="fn_topMenu('1')"><spring:message code="ui.statics.my"></spring:message></li>
				<li class="on"  id="table_speed"  onclick="fn_topMenu('2')"><spring:message code="ui.message.SpeedTitle"></spring:message></li>
				<li id="table_time"  onclick="fn_topMenu('3')"><spring:message code="ui.message.WebTitle"></spring:message></li>
			</ul>
			<div class="tableWrap table_my" style="height:calc(100vh - 154px) !important;">
				<ul class="menuBtn" id="myMenuBtn">
					<li class="on" onclick="fn_network('LTE')">LTE</li>
					<li  onclick="fn_network('3G')">3G</li>
					<li  onclick="fn_network('WIFI')">WiFi</li>                                                                                 
				</ul>
				<div class="dateWrap">
					<p><spring:message code="ui.statics.date"></spring:message> ${standard }</p>
					<ul id="periodType">
						<li class="on" onclick="fn_period('D')"><spring:message code="ui.statics.day"></spring:message></li>
						<li onclick="fn_period('W')"><spring:message code="ui.statics.week"></spring:message></li>
						<li onclick="fn_period('M')"><spring:message code="ui.statics.month"></spring:message></li>
					</ul>
				</div>
				<div class="graphWrap">                                                                                                                                        
					<ul>                                    
						<li>                                                                                                                                                                                                      
							<ul>                   
								<li class="data" id="myDown">0</li>
								<li class="graph" id="myDown_graph"></li>
								<!-- <li class="title">다운로드<span>Mbps</span></li> -->
								<li class="title"><spring:message code="ui.message.TableDown"></spring:message><span>Mbps</span></li>
							</ul>
						</li>
						<li>
							<ul>                              
								<li class="data" id="myUpload">0</li>
								<li class="graph" id="myUpload_graph"></p></li>
								<!--  <li class="title">업로드<span> Mbps</span></li> -->
								<li class="title"><spring:message code="ui.message.TableUp"></spring:message><span> Mbps</span></li>
							</ul>
						</li>                          
						<li>
							<ul>
								<li class="data" id="myJitter">0</li>
								<li class="graph" id="myJitter_graph"></p></li>
								<!-- <li class="title">지연시간<span> ms</span></li> -->
								<li class="title"><spring:message code="ui.message.DelayTime"></spring:message><span> ms</span></li>
							</ul>
						</li>
						<li>
							<ul>
								<li class="data" id="myLoss">0</li>
								<li class="graph" id="myLoss_graph"></p></li>
								<!-- <li class="title">손실률<span>%</span></li>  -->
								<li class="title"><spring:message code="ui.message.Loss"></spring:message><span>%</span></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<div class="tableWrap table_speed"  style="display:block;">
				<ul class="menuBtn" id="interNetMenuBtn">
					<li class="on" onclick="fn_network('LTE')">LTE</li>
					<li onclick="fn_network('3G')">3G</li>
					<li onclick="fn_network('WIFI')">WiFi</li>
				</ul>
				<div class="dateWrap">
					<p><spring:message code="ui.statics.standard"></spring:message><span><spring:message code="ui.statics.date"></spring:message> ${standard }</span></p>
					<ul id="INTERNET_PERIOD">
						<li class="on" onclick="fn_period('D')"><spring:message code="ui.statics.day"></spring:message></li>
						<li onclick="fn_period('W')"><spring:message code="ui.statics.week"></spring:message></li>
						<li onclick="fn_period('M')"><spring:message code="ui.statics.month"></spring:message></li>
					</ul>
				</div>
				<div class="scrollWrap">
					<div class="summaryWrap">
						<ul class="summary">
							<li>
								<dl>
									<dt><spring:message code="ui.statics.download"></spring:message><span>Mbps</span></dt>
									<dd id="internet_down"></dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt><spring:message code="ui.statics.upload"></spring:message><span>Mbps</span></dt>
									<dd id="internet_up"></dd>
								</dl>
							</li>
						</ul>
						<p><spring:message code="ui.statics.allStandard"></spring:message></p>
					</div>
					<div class="mapWrap" ID="LOCAL_MAP">
						<ul>
							<li class="map01 sunny"></li>	<!-- 서울 -->
							<li class="map02 foggy"></li>	<!-- 강원도 -->
							<li class="map03 cloudy"></li>	<!-- 인천 -->
							<li class="map04 rainy"></li>	<!-- 경기도 -->
							<li class="map05 sunny"></li>	<!-- 세종시 -->
							<li class="map06 sunny"></li>	<!-- 대전 -->
							<li class="map07 sunny"></li>	<!-- 충남 -->
							<li class="map08 sunny"></li>	<!-- 충북 -->
							<li class="map09 sunny"></li>	<!-- 경북 -->
							<li class="map10 sunny"></li>	<!-- 대구 -->
							<li class="map11 sunny"></li>	<!-- 전북 -->
							<li class="map12 sunny"></li>	<!-- 광주 -->
							<li class="map13 sunny"></li>	<!-- 전남 -->
							<li class="map14 sunny"></li>	<!-- 경남 -->
							<li class="map15 sunny"></li>	<!-- 울산 -->
							<li class="map16 sunny"></li>	<!-- 부산 -->
							<li class="map17 sunny"></li>	<!-- 제주도 -->
						</ul>
						<div class="legendWrap">
							<ul>
								<li><img src="${pageContext.request.contextPath }/images/ico_sunny.png" width="" height="" alt="" />90% 이상</li>
								<li><img src="${pageContext.request.contextPath }/images/ico_foggy.png" width="" height="" alt="" />70% 이상</li>
								<li><img src="${pageContext.request.contextPath }/images/ico_cloudy.png" width="" height="" alt="" />50% 이상</li>
								<li><img src="${pageContext.request.contextPath }/images/ico_rainy.png" width="" height="" alt="" />50% 미만</li>
							</ul>
							<p><spring:message code="ui.statics.threeCompany"></spring:message></p>
						</div>
					</div>
					
					<p class="tableViewBtn" style="text-align: center;"><img src="${pageContext.request.contextPath }/images/btn_tableview.png" width="" height="" alt="" onclick="fn_topMenu('4')"/></p>
				</div>
			</div>
			<div class="tableWrap time table_time">
				<div class="dateWrap">
					<p><spring:message code="ui.statics.date"></spring:message> ${standard }</p>
					<ul id="WEB_PERIOD">
						<li class="on" onclick="fn_period('D')"><spring:message code="ui.statics.day"></spring:message></li>
						<li onclick="fn_period('W')"><spring:message code="ui.statics.week"></spring:message></li>
						<li onclick="fn_period('M')"><spring:message code="ui.statics.month"></spring:message></li>
					</ul>
				</div>
				<div class="legendWrap">
					<dl>
						<c:choose>
							<c:when test="${sessionScope.lang eq 'ko'}">
								<dt class="naver">NAVER</dt>
								<dd class="naver"></dd>
								<dt class="daum">DAUM</dt>
								<dd class="daum"></dd>
							</c:when>
							<c:otherwise>
								<dt class="google">Google</dt>
								<dd class="google"></dd>
								<dt class="youtube">Youtube</dt>
								<dd class="youtube"></dd>
							</c:otherwise>
						</c:choose>
					</dl>
				</div>
				<div class="graphWrap">
					<ul>
						<li>
							<ul>
								<li class="data" id="webLteData">
									<ul>
										<li id="lteNaverData">0</li>
										<li id="lteDaumData">0</li>
									</ul>
								</li>
								<li class="graph" id="webLteGraph">
									<ul>
										<c:choose>
											<c:when test="${sessionScope.lang eq 'ko'}">
												<li class="naver" id="lteNaverGraph"></li>
												<li class="daum" id="lteDaumGraph"></li>
											</c:when>
											<c:otherwise>
												<li class="google" id="lteNaverGraph"></li>
												<li class="youtube" id="lteDaumGraph"></li>
											</c:otherwise>
										</c:choose>
									</ul>								
								</li>
								<li class="title">LTE</li>
							</ul>
						</li>
						<li>
							<ul>
								<li class="data" id="web3gData">
									<ul>
										<li id="3gNaverData"></li>
										<li id="3gDaumData"></li>
									</ul>
								</li>
								<li class="graph" id="web3gGraph">
									<ul>
										<c:choose>
											<c:when test="${sessionScope.lang eq 'ko'}">
												<li class="naver" id="3gNaverGraph"></li>
												<li class="daum" id="3gDaumGraph"></li>
											</c:when>
											<c:otherwise>
												<li class="google" id="3gNaverGraph"></li>
												<li class="youtube" id="3gDaumGraph"></li>
											</c:otherwise>
										</c:choose>
										
									</ul>								
								</li>
								<li class="title">3G</li>
							</ul>
						</li>
						<li>
							<ul>
								<li class="data" id="webWifiData">
									<ul>
										<li id="wifiNaverData"></li>
										<li id="wifiDaumData"></li>
									</ul>
								</li>
								<li class="graph" id="webWifiGraph">
									<ul>
										<c:choose>
											<c:when test="${sessionScope.lang eq 'ko'}">
												<li class="naver" id="wifiNaverGraph"></li>
												<li class="daum" id="wifiDaumGraph"></li>
											</c:when>
											<c:otherwise>
												<li class="google" id="wifiNaverGraph"></li>
												<li class="youtube" id="wifiDaumGraph"></li>
											</c:otherwise>
										</c:choose>
									</ul>								
								</li>
								<li class="title">WiFi</li>
							</ul>
						</li>
					</ul>
				</div>
				<p class="info"><spring:message code="ui.message.TableWeb1"></spring:message> . <spring:message code="ui.message.TableWeb2"></spring:message> <spring:message code="ui.statics.connect"></spring:message> (sec)</p>
			</div>
			<div class="tableWrap speed_table">
				<ul class="menuBtn" id="localMenuBtn">
					<li class="on" onclick="fn_network('LTE')">LTE</li>
					<li onclick="fn_network('3G')">3G</li>
					<li onclick="fn_network('WIFI')">WiFi</li>
				</ul>
				<div class="dateWrap">
					<p style="line-height: 6.6vw !important;"><spring:message code="ui.statics.standard"></spring:message> <span><spring:message code="ui.statics.date"></spring:message> ${standard }</span></p>
					<ul id="LOCAL_PERIOD">
						<li class="on" onclick="fn_period('D')"><spring:message code="ui.statics.day"></spring:message></li>
						<li onclick="fn_period('W')"><spring:message code="ui.statics.week"></spring:message></li>
						<li onclick="fn_period('M')"><spring:message code="ui.statics.month"></spring:message></li>
					</ul>
				</div>
				<div class="scrollWrap">
					<div class="summaryWrap">
						<ul class="summary">
							<li>
								<dl>
									<dt><spring:message code="ui.statics.download"></spring:message><span>Mbps</span></dt>
									<dd id="network_down"></dd>
								</dl>
							</li>
							<li>
								<dl>
									<dt><spring:message code="ui.statics.upload"></spring:message><span>Mbps</span></dt>
									<dd id="network_up"></dd>
								</dl>
							</li>
						</ul>
						<p><spring:message code="ui.statics.allStandard"></spring:message></p>
					</div>
					<div class="table">
						<table summary="웹 접속 시간">
							<caption class="blind"><spring:message code="ui.message.WebTitle"></spring:message></caption>
							<colgroup>
								<col />
								<col span="3" style="width:23%"/>
							</colgroup>
							<thead>
								<tr>
									<th><spring:message code="ui.statics.locale"></spring:message></th>
									<th>SKT</th>
									<th>KT</th>
									<th>LGU+</th>
								</tr>
							</thead>
							<tbody id="LOCAL_LIST">
							</tbody>
						</table>
					</div>
					<p class="mapViewBtn"><img src="${pageContext.request.contextPath }/images/btn_mapview.png" width="" height="" alt="" onclick="fn_topMenu('2')"/></p>
				</div>
			</div>
		</div>
</div>