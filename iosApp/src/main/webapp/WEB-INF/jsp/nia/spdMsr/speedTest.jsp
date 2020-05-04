<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/cmmn/common_lib.jsp" %>
<script>
	var idx	= 1;
	function fn_chkPoistion(){
		idx = 1;
		$("#internetDownload").text(0);
		$("#internetUpload").text(0);
		$("#internetTerm").text(0);
		$("#internetLoss").text(0);
		
		$('.popupContainer').hide();
		setTimeout(function() { 
			$(".placePopup").show();	
			var popupHeight = $('.popupContainer .popupWrap').not( ":hidden" ).height();
			$('.popupContainer .popupWrap').not( ":hidden" ).css("top","calc(50% - "+(popupHeight+2)/2+"px");
		}, 300);
	}
	
	// 데이터 허용 확인
	function fn_placeSelect(){
		window.location = "niaspeed://getsettings?callback=returnDataAllow";
		$('.popupContainer').hide();
	}
	
	function returnDataAllow(data){
		var resData = JSON.parse(data).result;
		var chk = resData.networkallowed;
		
		$("#NETWORK_TYPE").val(resData.networkType);
		if(chk =="true"){
			GetObject.id("bl").value = "1";
			fn_position($("#place").val());
		}
		else{
			$(".infoPopup").show();
			var popupHeight = $('.popupContainer .popupWrap').not( ":hidden" ).height();
			$('.popupContainer .popupWrap').not( ":hidden" ).css("top","calc(50% - "+(popupHeight+2)/2+"px");
		}
	}
	
	// 취소
	function fn_cancel(){
		$('.popupContainer').hide();
	}
	
	// 설정
	function fn_setting(){
		$('.popupContainer').hide();
		setTimeout(function() { 
			$(".togglePopup").show();	
			var popupHeight = $('.popupContainer .popupWrap').not( ":hidden" ).height();
			$('.popupContainer .popupWrap').not( ":hidden" ).css("top","calc(50% - "+(popupHeight+2)/2+"px");
		}, 300);
	}
	
	function fn_cerfi(){
		$('.popupContainer').hide();
		var toggle = "NO";
		var multi  = "NO";
		if($("#toggle").is(":checked")){
			$("#bl").val("1");
			toggle = "YES";
		}
		if($("#multi").is(":checked")){
			multi = "YES";
		}
		
		window.location = "niaspeed://putsettings?network=" + toggle + "&multicon=" + multi + "&callback=returnDataType";
		
	}
	
	function returnDataType(data){
		var pos = $("#place").val();
		var bl	= $("#bl").val();
		
		if(bl == "1"){	// 데이터허용			
			fn_position(pos);	
		}
	}
	
	// 지연시간 이벤트
	function fn_position(pos){
		$("#speedBtn").val("<spring:message code='ui.message.ActStop'></spring:message>");
		$("#speedBtn").attr("onclick", "");
		$(".title").empty();
		$(".unit").empty();
		$(".title").append("<spring:message code='ui.message.DelayTime'></spring:message>");
		$(".unit").append("ms");
		
		window.location = "niaspeed://callpingtest?sPlace=" + pos +"&buttonstate=NO&callback=returnSpeedTest";	
	}
	
	// 지연시간 콜백
	function returnSpeedTest(data){
		var resData = JSON.parse(data).result;		
		var spChk   = "";
		
		$(".speed").attr("style", "");
		if(idx == 1){
			spChk = resData.delayTime;
			var styleData = "transform: rotate(" + spChk + "deg) scale(1, 1)"
			$(".speed").attr("style", styleData);
			$(".num").empty();			
			$(".num").append(spChk);
			
		}		
		if(idx == 2){
			spChk = resData.downLoadSpeed;		
			var styleData = "transform: rotate(" + (spChk*0.7) + "deg) scale(1, 1)"
			$(".speed").attr("style", styleData);
			$(".num").empty();			
			$(".num").append(spChk);
		}		
		if(idx == 3){
			spChk = resData.upLoadSpeed;			
			var styleData = "transform: rotate(" + spChk + "deg) scale(1, 1)"
			$(".speed").attr("style", styleData);
			$(".num").empty();	
			$(".num").append(spChk);
		}
		
		if(resData == "end"){
			if(idx == 1){
				$(".title").empty();
				$(".unit").empty();
				$(".title").append("<spring:message code='ui.message.Download'></spring:message>");
				$(".unit").append("Mbps");
			}
			if(idx == 2){
				$(".title").empty();
				$(".title").append("<spring:message code='ui.message.Upload'></spring:message>");
			}
			if(idx == 3){
				$("#speedBtn").val("<spring:message code='ui.message.ActStart'></spring:message>");
				$("#speedBtn").attr("onclick", "fn_chkPoistion()");
			}
			idx++;
		}
		
		if(idx == 4 && resData != "end"){
			callbackResult(data);
		}
	}
	
	// 총 결과값 콜백
	function callbackResult(data){
		var resData = JSON.parse(data).result;
		$("#rs_down").text(resData.downLoadSpeed);
		$("#rs_upload").text(resData.upLoadSpeed);
		$("#rs_second").text(resData.delayTime);
		$("#loss").text(resData.lossRate);
		
		$("#internetDownload").text(resData.downLoadSpeed);
		$("#internetUpload").text(resData.upLoadSpeed);
		$("#internetTerm").text(resData.delayTime);
		$("#internetLoss").text(resData.lossRate);
		
		$(".title").empty();
		$(".title").append("<spring:message code='ui.message.Download'></spring:message>");
		$(".num").append("0");
		
		common.ajax("${pageContext.request.contextPath }/SpdMsr/avgData.do", "", "json", avgCallBack);
			
	}
	
	function avgCallBack(data){
		var resData = data.AvgData;
		var type	= $("#NETWORK_TYPE").val();
		
		if(type == "LTE"){
			$("#avg_dn").text(resData.LteDn);
			$("#avg_up").text(resData.LteUp);
			$("#round_dn").text(resData.LocalDn);
			$("#round_up").text(resData.LocalUp);
		}
		else if(type == "Wi-Fi"){
			$("#avg_dn").text(resData.WifiDn);
			$("#avg_up").text(resData.WifiUp);
			$("#round_dn").text(resData.LocalDn);
			$("#round_up").text(resData.LocalUp);
		}
		else{
			$("#avg_dn").text(resData.gDn);
			$("#avg_up").text(resData.gUp);
			$("#round_dn").text(resData.LocalDn);
			$("#round_up").text(resData.LocalUp);
		}
		
		$(".resultPopup").show();
		var popupHeight = $('.popupContainer .popupWrap').not( ":hidden" ).height();
		$('.popupContainer .popupWrap').not( ":hidden" ).css("top","calc(50% - "+(popupHeight+2)/2+"px");
	}
	
</script>
<form name="frmTest">
	<input type="hidden" name="place" id="place" value=""/>
	<input type="hidden" name="bl" id="bl" value=""/>
	<input type="hidden" name="NETWORK_TYPE" id="NETWORK_TYPE" value=""/>
</form>
<div class="contentContainer speedWrap">
	<div class="topTitle">
		<img class="logo" src="<c:url value="/images/logo.png"/>" width="" height="" alt="" onclick="fn_main()"/>
		<!-- <p>${sessionScope.NetType } 인터넷 속도 측정1</p> -->
		<p>${sessionScope.NetType } <spring:message code="ui.message.SpeedSubTitle"></spring:message></p>
	</div>
	<div class="contentWrap">

		<div class="speedBg">
			<img class="speed" src="<c:url value="/images/img_speed.png"/>" width="" height="" alt="">
			<img class="ruler" src="<c:url value="/images/img_ruler.png"/>" width="" height="" alt="">
		</div>
		<div class="speedResultWrap">	<!--	측정 전 클래스 추가 - ready	-->
			<!-- <p class="title">다운로드</p> -->
			<p class="title"><spring:message code="ui.message.Download"></spring:message></p>
			<p class="num">0</p>
			<p class="unit">Mbps</p>
		</div>
		<dl>
			<!-- <dt>다운로드<span>Mbps</span></dt> -->
			<dt><spring:message code="ui.message.Download"></spring:message><span>Mbps</span></dt>
			<dd id="internetDownload">0</dd>	<!--	측정 전 클래스 추가 - ready	-->
			<!-- <dt>업로드<span>Mbps</span></dt> -->
			<dt><spring:message code="ui.message.Upload"></spring:message><span>Mbps</span></dt>
			<dd id="internetUpload">0</dd>
			<!-- <dt>지연시간<span>ms</span></dt> -->
			<dt><spring:message code="ui.message.DelayTime"></spring:message><span>ms</span></dt>
			<dd id="internetTerm">0</dd>
			<!-- <dt>손실률<span>%</span></dt> -->
			<dt><spring:message code="ui.message.Loss"></spring:message><span>%</span></dt>
			<dd id="internetLoss">0</dd>
		</dl>
		<div class="btnWrap">
			<input type="button" name="speed" id="speedBtn" class="btn" value="<spring:message code='ui.message.ActStart'></spring:message>" onclick="fn_chkPoistion()"/>
		</div>
	</div>
</div>