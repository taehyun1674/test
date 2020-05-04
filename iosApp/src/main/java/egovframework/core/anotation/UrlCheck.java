package egovframework.core.anotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 
 * @작성일     : 2019. 10. 21.
 * @작성자     : kgy
 * @프로그램설명 : 로그인, 세션 체크가 필요할 경우 
 * 			       컨트롤러 메서드에 어노테이션 기재해주시면 됩니다.
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface UrlCheck {
	
	/**
	 * 권한은 기본값 체크안함
	 * @return false
	 */
    public boolean AuthCheck() default false;
    
    /**
     * 세션은 기본값 체크함
     * @return
     */
    public boolean SessionCheck() default true;
}


