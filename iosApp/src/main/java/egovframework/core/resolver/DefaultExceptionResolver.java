package egovframework.core.resolver;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;

/**
 * 공통 예외처리
 * @author kgy
 *
 */
public class DefaultExceptionResolver implements HandlerExceptionResolver {
	
	private Logger logger = LogManager.getLogger(DefaultExceptionResolver.class);
	
	@Override
	public ModelAndView resolveException(HttpServletRequest request, HttpServletResponse response, Object handler,
			Exception ex) {
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("error/error");
		modelAndView.addObject("title", "error");
		
		System.out.println(ex);
		
		return modelAndView;
	}

}
