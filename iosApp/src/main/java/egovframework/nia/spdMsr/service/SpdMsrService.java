package egovframework.nia.spdMsr.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public interface SpdMsrService {
	
	/**
	 *  평균 데이터
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> avgData()throws Exception;
	
	/**
	 * 내 통계
	 * @param param
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> myStatistics(Map<String, Object> params)throws Exception;

	/**
	 * 인터넷 속도
	 * @param param
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> STATICS_LOCALITY(Map<String, Object> param)throws Exception;
	
	/**
	 * 인터넷 평균 속도
	 * @param params
	 * @return
	 * @throws Exception
	 */
	Map<String, Object> avgStatistics(Map<String, Object> params)throws Exception;
	
	/**
	 * 기간별 평균 속도
	 */
	Map<String, Object> avgPeriodStatistics(Map<String, Object> params)throws Exception;
	
	/**
	 * 인터넷 지역별, 통신사별 통계
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> networkStatistics(Map<String, Object> params)throws Exception;
	
	/**
	 * 웹속도 통계
	 * @param params
	 * @return
	 * @throws Exception
	 */
	List<Map<String, Object>> webStatistics(Map<String, Object> params)throws Exception;
	
	/**
	 * 인터넷 속도 등록
	 * @param params
	 */
	void myInternetInsert(String params);
	
	/**
	 * 웹 속도 등록
	 * @param params
	 * @throws Exception
	 */
	void myWebInsert(String params)throws Exception;
}
