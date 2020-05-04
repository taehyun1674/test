<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/cmmn/common_lib.jsp" %>


<meta http-equiv="X-UA-Compatible" content="IE=Edge">
<meta charset="UTF-8">
<meta name="viewport" content="height=device-height, width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0">
<title><c:out value="${MENU_TITLE}"/></title>
<meta name="keywords" content="">
<meta name="description" content="">

<link rel="stylesheet" href="<c:url value="/css/common.css"/>" media="screen" />
   
<script type="text/javascript" src="<c:url value="/js/jquery-3.4.1.min.js"/>"></script>
<script type="text/javascript" src="<c:url value="/js/common.js"/>"></script>
<script type="text/javascript">
	$(document).ready(function(){
		var yn = "${first}";
		
		if(yn == "Y"){
			$(".chargePopup").show();		
			var popupHeight = $('.popupContainer .popupWrap').not( ":hidden" ).height();
			$('.popupContainer .popupWrap').not( ":hidden" ).css("top","calc(50% - "+(popupHeight+2)/2+"px");
			
			$("#popup_charge").on("click", function(){//$(this).parent().hide();				
				window.location = "niaspeed://getintromsgdata?callback=returnTotalCount"
					$(this).parent().hide();
				setTimeout(function() { 
					$(".gpsInfoPopup").show();	
					var popupHeight = $('.popupContainer .popupWrap').not( ":hidden" ).height();
					$('.popupContainer .popupWrap').not( ":hidden" ).css("top","calc(50% - "+(popupHeight+2)/2+"px");
				}, 300);
			});
			
			// 오늘 날짜 통계 팝업
			$(".chargePopup").on("click",".close", function(){
				window.location = "niaspeed://getintromsgdata?callback=returnTotalCount"
				$('.popupContainer').hide();
				setTimeout(function() { 
					$(".gpsInfoPopup").show();	
					var popupHeight = $('.popupContainer .popupWrap').not( ":hidden" ).height();
					$('.popupContainer .popupWrap').not( ":hidden" ).css("top","calc(50% - "+(popupHeight+2)/2+"px");
				}, 300);
				
			});
			
			// 오늘 날짜 통계 팝업 닫기
			$(".gpsInfoPopup").on("click",".close", function(){
				$('.popupContainer').hide();
			});
			
			$("#popup_gpsInfo").on("click", function(){
				$(this).parent().hide();
			});
		}
		
		$(".resultPopup").on("click",".close", function(){
			$('.popupContainer').hide();
		});
		
		$(".companyPopup").on("click",".close", function(){
			$('.popupContainer').hide();
		});
		
		$(".wifiPopup").on("click",".close", function(){
			$('.popupContainer').hide();
		});
		
		$("#popup_resultPopup").on("click", function(){
			$(this).parent().hide();
		});
		
		$("#popup_companyPopup").on("click", function(){
			$(this).parent().hide();
		});
		
		$("#placePopup li").on("click", function(){
			$("#placePopup li").removeClass("on");
			$(this).addClass("on");
			$("#place").val($(this).attr("id"));
		});
	});
		
	// 당일 / 월 측정 카운트
	function returnTotalCount(data){
		var resData = JSON.parse(data);
		var rs		= resData.result;
		var toDay   = rs.todayDate;
		
		$("#toDayNetStatus").append(rs.netType);
		$("#toDayMonth").append("<spring:message code='ui.message.tot'></spring:message>"+ rs.totalCount +"  <spring:message code='ui.message.seq'></spring:message>");
		$("#toDayToDay").append(toDay + " / " + rs.todayCount + "<spring:message code='ui.message.seq'></spring:message>");
	}
	
	function fn_main(){
		document.location.href = "${pageContext.request.contextPath }/SpdMsr/internetSpeed.do";
	}
</script>
