<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/jsp/cmmn/common_lib.jsp" %>
<script>
	function fn_proc(){
		var one = $("#check01").is(":checked");
		var two = $("#check02").is(":checked");
		var proc = $("#check03").is(":checked");
		var text = "";
		var params = "";
		
		$("#web_naver").text("0");
		$("#web_daum").text("0");
		$("#web_proc").text("0");
				
		if(proc){
			text = $("#url_txt").val();	
		}
		
		if(one == false && two == false && proc == false){
			return;
		}
		if(one){
			params = "url1=YES";
			if(two){
				params += "&url2=YES";
			}
			if(proc){
				params += "&url3=" + text;
			}
		}
		if(one == false && two == true){
			params = "url2=YES";
			if(proc){
				params += "&url3=" + text;
			}
		}
		if(one == false && two == false && proc == true){
			params = "url3=" + text;
		}
		
		window.location = "niaspeed://callwebspeedtest?" + params + "&buttonstate=NO&callback=webCallBack";
	}
	
	function webCallBack(data){
		var resData = JSON.parse(data).result;

		$("#web_naver").text(resData.naver);
		$("#web_daum").text(resData.daum);
		$("#web_proc").text(resData.url);
	}
</script>
<div class="contentContainer timeWrap">
	<div class="topTitle">
		<img class="logo" src="${pageContext.request.contextPath }/images/logo.png" width="" height="" alt="" onclick="fn_main()"/>
		<p>${sessionScope.NetType } <spring:message code="ui.message.TabWeb"></spring:message></p>
	</div>
	<div class="contentWrap">
		<div class="timeBg">
		</div>
		<div class="timeResultWrap">
			<p class="title"><spring:message code="ui.message.URL"></spring:message></p>
			<img src="${pageContext.request.contextPath }/images/time.gif" width="" height="" alt="" />	<!--	측정시 이미지 -->
		</div>
		<dl>
			<dt>
				<p class="inputWrap">
					<input type="checkbox" name="naver" id="check01" />
					<label for="check01"><img class="logo" src="${pageContext.request.contextPath }/images/img_naver.png" width="" height="" alt="naver" /></label>
				</p>
			</dt>
			<dd><span id="web_naver">0</span> sec</dd>
			<dt>
				<p class="inputWrap">
					<input type="checkbox" name="daum" id="check02" />
					<label for="check02"><img class="logo" src="${pageContext.request.contextPath }/images/img_daum.png" width="" height="" alt="daum" /></label>
				</p>
			</dt>
			<dd><span id="web_daum">0</span> sec</dd>	<!--	측정 전 클래스 추가 - ready	-->
			<dt>
				<p class="inputWrap url">
					<input type="checkbox" name="input" id="check03" />
					<label for="check03"></label>
					<input type="text" placeholder="<spring:message code='ui.message.URL'></spring:message>" name="url_txt" id="url_txt" value=""/>
				</p>
			</dt>
			<dd><span id="web_proc">0</span> sec</dd>	<!--	측정 전 클래스 추가 - ready	-->
		</dl>
		<div class="btnWrap">
			<input type="button" name="PROC" id="PROC" class="btn" value="<spring:message code='ui.message.ActStart'></spring:message>" onclick="fn_proc()"/>
		</div>
	</div>
</div>