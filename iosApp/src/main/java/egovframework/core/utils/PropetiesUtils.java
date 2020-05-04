package egovframework.core.utils;

import java.util.Locale;
import java.util.ResourceBundle;

/**
 * 프로퍼티 유틸
 * resources/Global.properties 에 존재하는 프로퍼티 가져옴
 * @author kgy
 *
 */
public class PropetiesUtils {
	
	/**
	 * 프로퍼티 가져오기
	 * 해당 프로퍼티 미존재시 공백 리턴
	 * @param name 프로퍼티명
	 * @return
	 */
    public static String getProperty(String name) {
    	try {
    		ResourceBundle bundle = ResourceBundle.getBundle("Global", Locale.KOREA);
    		
    		return bundle.getString(name);
    	} catch(Exception e) {
    		
    		return "";
    	}
    }
}
