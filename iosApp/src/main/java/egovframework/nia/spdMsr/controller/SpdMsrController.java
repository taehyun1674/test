package egovframework.nia.spdMsr.controller;

import java.net.URLDecoder;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.i18n.SessionLocaleResolver;

import egovframework.core.anotation.UrlCheck;
import egovframework.nia.spdMsr.service.SpdMsrService;
import egovframework.nia.spdMsr.util.Utility;

/**
 * 
 * @작성일     : 2019. 10. 30.
 * @작성자     : kgy
 * @프로그램설명 : 속도측정 컨트롤러
 */
@Controller
public class SpdMsrController {
	
	@Autowired
	private SpdMsrService spdMsrService;
	
	@Autowired
	SessionLocaleResolver localeResolver;
	
	/**
	 * 인트로화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/main.do")
	@UrlCheck(AuthCheck = false, SessionCheck = true)
	public String indexMain(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {	
		return "spdMsr/main.tiles";
	}
	
	/**
	 * 속도 측정기 화면
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/speedTest")
	public String speedTest(@RequestParam Map<String, Object> param, Model model, 
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {
		session.setAttribute("NetType", param.get("NETWORK_TYPE"));
		session.setAttribute("lang", String.valueOf(param.get("lang")));
		Locale locale = new Locale(String.valueOf(param.get("lang")));
		localeResolver.setLocale(request, response, locale);
		
		model.addAttribute("agent", "speed");
		model.addAttribute("first", "Y");
		return "spdMsr/speedTest.tiles";
	}
	
	/**
	 * 속도측정 메인 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/internetSpeed.do")
	@UrlCheck(AuthCheck = false, SessionCheck = true)
	public String InternetSpeed(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("agent", "speed");
		return "spdMsr/speedTest.tiles";
	}
	
	/**
	 * 웹측정 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/webSpeed.do")
	public String webSpeed(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		model.addAttribute("agent", "time");
		return "spdMsr/webSpd.tiles";
	}
	
	/**
	 * 측정 목록 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/speedList.do")
	public String speedList(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("agent", "history");
		return "spdMsr/speedList.tiles";
	}
	
	/**
	 * 평균 데이터
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/avgData.do")
	public @ResponseBody Model avgList(Model model,HttpServletRequest request, HttpServletResponse response)throws Exception{
		model.addAttribute("AvgData", 	spdMsrService.avgData());
		return model;
	}
	
	/**
	 * 통계
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/statistics.do")
	public String statistics(@RequestParam Map<String, Object> data, Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("topMenu", 	"1");
		model.addAttribute("PERIOD", 	"D");
		model.addAttribute("NETWORK", 	"LTE");
		model.addAttribute("standard", Utility.getFormatDateString("yyyy-MM-dd", -1));
		model.addAttribute("agent", "statistics");
		return "spdMsr/statistics.tiles";
	}
	
	/**
	 * 설정 화면
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/system.do")
	public String system(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		model.addAttribute("agent", "system");
		return "spdMsr/system.tiles";
	}
	
	/**
	 * 내 통계
	 * @param params
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/myStatistics.do")
	public @ResponseBody Model myStatistics(@RequestParam Map<String, Object> params, Model model, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{	
		params.put("DEVICE_ID", Utility.NVL(params.get("DEVICE_ID")));
		Map<String,Object> rsMap = new HashMap<String, Object>();
		try{
			rsMap = spdMsrService.myStatistics(params);
		}catch(Exception e){
			e.printStackTrace();
		}
		
		model.addAttribute("myData", rsMap);
		
		return model;
	}
	
	/**
	 * 인터넷 속도 통계
	 * @param params
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/localStatistics.do")
	public @ResponseBody Model localStatistics(@RequestParam Map<String, Object> params, Model model, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{	
		params.put("DEVICE_ID", Utility.NVL(params.get("DEVICE_ID")));
			
		model.addAttribute("interNetData", 	spdMsrService.STATICS_LOCALITY(params));
		model.addAttribute("avgData", 		spdMsrService.avgPeriodStatistics(params));
		return model;
	}
	
	/**
	 * 통신사별, 지역별 속도 통계
	 * @param params
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/networkLocalStatistics.do")
	public @ResponseBody Model networkLocalStatistics(@RequestParam Map<String, Object> params, Model model, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{	
			
		model.addAttribute("avgPeriodData", 	spdMsrService.avgPeriodStatistics(params));
		model.addAttribute("networkLocalData", 	spdMsrService.networkStatistics(params));
		return model;
	}
	
	/**
	 * 웹 속도 통계
	 * @param params
	 * @param model
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/SpdMsr/webStatistics.do")
	public @ResponseBody Model webStatistics(@RequestParam Map<String, Object> params, Model model, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{	
			
		model.addAttribute("webData", 	spdMsrService.webStatistics(params));
		return model;
	}
	
	/**
	 * db INTERNET 등록 데이터
	 * @param params
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/myInternetInsert.do")
	public void myInsert(@RequestParam Map<String, Object> params, Model model, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		Decoder decoder = Base64.getDecoder(); 
		byte[] decodedBytes = decoder.decode((String)params.get("nia"));
		
		spdMsrService.myInternetInsert(URLDecoder.decode(new String(decodedBytes), "UTF-8"));
	}
	
	/**
	 * db WEB 등록 데이터
	 * @param params
	 * @param model
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/myWebInsert.do")
	public void myWebInsert(@RequestParam Map<String, Object> params, Model model, 
			HttpServletRequest request, HttpServletResponse response) throws Exception{
		Decoder decoder = Base64.getDecoder(); 
		byte[] decodedBytes = decoder.decode((String)params.get("nia"));
		
		spdMsrService.myWebInsert(URLDecoder.decode(new String(decodedBytes), "UTF-8"));
	}
}