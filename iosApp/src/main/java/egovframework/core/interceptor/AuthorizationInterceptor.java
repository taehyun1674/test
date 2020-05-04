package egovframework.core.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.core.anotation.UrlCheck;
import egovframework.core.utils.PropetiesUtils;

public class AuthorizationInterceptor extends HandlerInterceptorAdapter {
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//LoginCheck 어노테이션이 컨트롤러에 사용되었는지 체크함
		UrlCheck urlCheck = ((HandlerMethod) handler).getMethodAnnotation(UrlCheck.class);

        //로그인 체크함
        if (urlCheck != null) {
        	Boolean authCheck 	 = urlCheck.AuthCheck();
        	Boolean sessionCheck = urlCheck.SessionCheck();
        	
        	
        	System.out.println("요청 URI : " + request.getRequestURI() + "\n권한 체크 여부 : " + 
        						authCheck.toString() + "\n세션 체크 여부 : " + sessionCheck);
        	
        	// 세션체크 할 경우
        	if (sessionCheck) {
        		
        	}
        	
        	// 권한체크 할 경우
        	if (authCheck) {
        		
        	}
        }

		return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		
		String uri = request.getRequestURI();
		
		/**
		 * URI 메뉴명 맵핑
		 * ex) /SpdMsr/main.do 요청올 경우 .do 아래 SpdMsr 으로 글로벌 프로퍼티 에서 조회하여 타이틀 셋팅
		 */
		if (uri != null && !"".equals(uri)) {
			String[] uriArr = uri.split("/");
			
			for (int i = 0; i < uriArr.length; i++) {
				String tmp = uriArr[i];
				
				if (tmp.indexOf(".do") > 0) {
					if (i != 0) {
						String menuNm = uriArr[(i-1)];
						
						String title = PropetiesUtils.getProperty("menu.title."+menuNm);
						String topTitle = PropetiesUtils.getProperty("menu.topTitle."+menuNm);
						
						modelAndView.addObject("MENU_TITLE", title);
						modelAndView.addObject("MENU_TOP_TITLE", topTitle);
					}
					
					break;
				}
			}
		}
		
		super.postHandle(request, response, handler, modelAndView);
	}

}
