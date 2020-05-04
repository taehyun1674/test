<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ include file="/WEB-INF/jsp/cmmn/common_lib.jsp" %>
<script type="text/javascript">
	$(document).ready(function(){
		$(".bottomMenuWrap > ul > li").on("click","li", function(){
			$('.bottomMenuWrap ul li').removeClass('on');
		});
		
		$(".${agent}").addClass("on");
	});
</script>

		<div class="bottomMenuWrap">
			<ul>
				<li class="speed"><a href="${pageContext.request.contextPath }/SpdMsr/internetSpeed.do"><spring:message code="ui.message.footer.internet"></spring:message></a></li>
				<li class="time"><a href="${pageContext.request.contextPath }/SpdMsr/webSpeed.do"><spring:message code='ui.message.footer.web'></spring:message></a></li>
				<li class="history"><a href="${pageContext.request.contextPath }/SpdMsr/speedList.do"><spring:message code='ui.message.footer.history'></spring:message></a></li>
				<li class="statistics"><a href="${pageContext.request.contextPath }/SpdMsr/statistics.do"><spring:message code='ui.message.footer.statics'></spring:message></a></li>
				<li class="system"><a href="${pageContext.request.contextPath }/SpdMsr/system.do"><spring:message code='ui.message.footer.setting'></spring:message></a></li>
			</ul>
		</div>
	</div>
</div>

<!--	popup - 통화료 부과 안내	-->
<div class="popupContainer chargePopup">
	<div class="popupWrap">
		<div class="popupTopWrap">
			<a class="close">close</a>
		</div>
		<div class="popupContentWrap">
			<div class="popupContent">
				<div class="imgWrap">
					<img src="${pageContext.request.contextPath }/images/img_popup_charge.png" width="" height="" alt="" />
				</div>
				<p id="network">
					<spring:message code="ui.message.chargePopup"></spring:message>
				</p>
				<img src="${pageContext.request.contextPath }/images/img_popup_hr.png" width="" height="" alt="" />
				<p id="lguPlus">
					LGU+<br />
					<spring:message code="ui.message.chargePopup2"></spring:message>
				</p>
			</div>
		</div>
	</div>
	<div class="popupDimmed" id="popup_charge"></div>
</div>
<!--	//	popup - 통화료 부과 안내	-->
<!--	popup - LTE 구간	-->
<div class="popupContainer gpsInfoPopup">
	<div class="popupWrap">
		<div class="popupTopWrap">
			<a class="close">close</a>
		</div>
		<div class="popupContentWrap">
			<div class="popupContent">
				<div class="imgWrap">
					<img src="${pageContext.request.contextPath }/images/img_popup_gpsinfo.png" width="" height="" alt="" />
				</div>
				<p>
					<spring:message code="ui.message.gpsInfoPopup1"></spring:message> <span id="toDayNetStatus"></span> <spring:message code="ui.message.gpsInfoPopup2"></spring:message>
				</p>
				<img src="${pageContext.request.contextPath }/images/img_popup_hr.png" width="" height="" alt="" />
				<p>
					<span id="toDayMonth"></span><br />
					<span id="toDayToDay"></span><br />
					<spring:message code="ui.message.gpsInfoPopup3"></spring:message>
				</p>
			</div>
		</div>
	</div>
	<div class="popupDimmed" id="popup_gpsInfo"></div>
</div>
<!--	//	popup - LTE 구간	-->
<!--	popup - 측정장소 지정	-->
<div class="popupContainer placePopup">
	<div class="popupWrap">
		<div class="popupTopWrap">
			<a class="close">close</a>
		</div>
		<div class="popupContentWrap">
			<div class="popupContent">
				<div class="imgWrap">
					<img src="${pageContext.request.contextPath }/images/img_popup_place.png" width="" height="" alt="" />
				</div>
				<p>
					<span><spring:message code="ui.message.placePopup1"></spring:message></span><br />
					LTE(3G)
				</p>
				<img src="${pageContext.request.contextPath }/images/img_popup_hr.png" width="" height="" alt="" />
				<p>
					<spring:message code="ui.message.placePopup2"></spring:message>
				</p>
				<ul id="placePopup">
					<li id="0"><spring:message code="ui.message.placePopup3"></spring:message></li>
					<li id="1"><spring:message code="ui.message.placePopup4"></spring:message></li>
					<li id="2"><spring:message code="ui.message.placePopup5"></spring:message></li>
				</ul>
			</div>
			<div class="btnWrap">
				<input type="button" name="" id="" class="btn" value="<spring:message code='ui.message.placePopup6'></spring:message>" onclick="fn_placeSelect()"/>
			</div>
		</div>
	</div>
	<div class="popupDimmed"></div>
</div>
<!--	//	popup - 측정장소 지정	-->
<!--	popup - 측정결과	-->
<div class="popupContainer resultPopup">
	<div class="popupWrap">
		<div class="popupTopWrap">
			<a class="close">close</a>
		</div>
		<div class="popupContentWrap">
			<div class="popupContent">
				<p class="title">
					<spring:message code="ui.message.resultPopup1"></spring:message>
				</p>
				<ul>
					<li>
						<dl>
							<dt><spring:message code="ui.message.resultPopup2"></spring:message><span>Mbps</span></dt>
							<dd id="rs_down"></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><spring:message code="ui.message.resultPopup3"></spring:message><span>Mbps</span></dt>
							<dd id="rs_upload"></dd>
						</dl>
					</li>
				</ul>
				<ul class="average">
					<li>
						<p id="avg_dn">0</p>
						<p><spring:message code="ui.message.resultPopup4"></spring:message></p>
						<p id="avg_up">0</p>
					</li>
					<li>
						<p id="round_dn">0</p>
						<p><spring:message code="ui.message.resultPopup5"></spring:message></p>
						<p id="round_up">0</p>
					</li>
				</ul>
				<ul>
					<li>
						<dl>
							<dt><spring:message code="ui.message.resultPopup6"></spring:message><span>ms</span></dt>
							<dd id="rs_second"></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><spring:message code="ui.message.resultPopup7"></spring:message><span>%</span></dt>
							<dd id="loss">0</dd>
						</dl>
					</li>
				</ul>
				<p>
					<spring:message code="ui.message.resultPopup8"></spring:message>
				</p>
				<div class="btnWrap">
					<input type="button" name="" id="" class="btn" value="<spring:message code="ui.message.resultPopup9"></spring:message>" onclick="fn_cancel()"/>
				</div>
			</div>
		</div>
	</div>
	<div class="popupDimmed"></div>
</div>
<!--	//	popup - 측정결과	-->
<!--	191123 popup - 토글버튼 팝업	-->
<div class="popupContainer togglePopup">
	<div class="popupWrap systemWrap">
		<div class="popupTopWrap">
			<a class="close">close</a>
		</div>
		<div class="popupContentWrap">
			<div class="popupContent">
				<p class="title">
					 <spring:message code="ui.message.togglePopup1"></spring:message>
				</p>
				<div class="contentWrap">
					<div class="topmenu">
						<ul>
							<li>
								<p class="title"><spring:message code="ui.message.togglePopup2"></spring:message></p>
								<div class="toggleWrap">
									<input type="checkbox" id="toggle" value="1"/>
									<label for="toggle"></label>
								</div>
							</li>
							<!-- <li>
								<p class="title">다중 접속 허용</p>
								<div class="toggleWrap">
									<input type="checkbox" id="multi" value="1"/>
									<label for="multi"></label>
								</div>
							</li> -->
						</ul>
					</div>
				</div>
				<div class="btnWrap">
					<ul>
						<li><a class="btn close" onclick="fn_cancel()"><spring:message code="ui.message.togglePopup3"></spring:message></a></li>
						<li><a class="btn" onclick="fn_cerfi()"><spring:message code="ui.message.togglePopup4"></spring:message></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="popupDimmed"></div>
</div>
<!--	//	191123 popup - 토글버튼 팝업	-->
<!--	191123 popup - 안내문구 팝업	-->
<div class="popupContainer infoPopup">
	<div class="popupWrap">
		<div class="popupTopWrap">
			<a class="close">close</a>
		</div>
		<div class="popupContentWrap">
			<div class="popupContent">
				<p class="title">
					 <spring:message code="ui.message.infoPopup1"></spring:message>
				</p>
				<div class="contentWrap">
					<p><spring:message code="ui.message.infoPopup2"></spring:message></p>
				</div>
				<div class="btnWrap">
					<ul>
						<li><a class="btn close" onclick="fn_cancel()"><spring:message code="ui.message.infoPopup3"></spring:message></a></li>
						<li><a class="btn" onclick="fn_setting()"><spring:message code="ui.message.infoPopup4"></spring:message></a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<div class="popupDimmed"></div>
</div>
<!--	//	191123 popup - 안내문구 팝업	-->
<!--	popup - wifi info	-->
<div class="popupContainer wifiPopup">
	<div class="popupWrap">
		<div class="popupTopWrap">
			<a class="close">close</a>
		</div>
		<div class="popupContentWrap">
			<div class="popupContent">
				<p class="title">
					WiFi Info
				</p>
				<dl>
					<dt>네트워크 타입</dt>
					<dd>WiFi</dd>
					<dt>내부 IP </dt>
					<dd>192.168.0.4</dd>
					<dt>BSSID </dt>
					<dd>64:e5:99:6b:f5:a4</dd>
					<dt>RSSI</dt>
					<dd>-38 dBm</dd>
					<dt>MAC Addr </dt>
					<dd>02:00:00:00:00:00</dd>
					<dt>Supplicant State</dt>
					<dd>COMPLETED</dd>
				</dl>
				<span></span>
			</div>
		</div>
	</div>
	<div class="popupDimmed"></div>
</div>
<!--	//	popup - wifi info	-->
<!--	popup - 회사소개	-->
	<div class="popupContainer companyPopup">
		<div class="popupWrap">
			<div class="popupTopWrap">
				<a class="close">close</a>
			</div>
			<div class="popupContentWrap">
				<div class="popupContent">
					<p class="title">
						<spring:message code="ui.message.companyPopup1"></spring:message>
					</p>
					<dl>
						<dt><spring:message code="ui.message.companyPopup2"></spring:message></dt>
						<dd><spring:message code="ui.message.companyPopup3"></spring:message></dd>
						<dt><spring:message code="ui.message.companyPopup4"></spring:message></dt>
						<dd><spring:message code="ui.message.companyPopup5"></spring:message></dd>
						<dt><spring:message code="ui.message.companyPopup6"></spring:message></dt>
						<dd><spring:message code="ui.message.companyPopup7"></spring:message></dd>
					</dl>
					<span>http://speed.nia.or.kr</span>
				</div>
			</div>
		</div>
		<div class="popupDimmed" id="popup_companyPopup"></div>
	</div>