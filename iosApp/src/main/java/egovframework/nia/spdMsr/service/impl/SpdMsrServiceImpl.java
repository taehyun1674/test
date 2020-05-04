package egovframework.nia.spdMsr.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import egovframework.core.service.AbstractServiceImpl;
import egovframework.nia.spdMsr.service.SpdMsrService;
import egovframework.nia.spdMsr.sqlMap.webModel;
import egovframework.nia.spdMsr.util.Utility;

@Service
public class SpdMsrServiceImpl extends AbstractServiceImpl implements SpdMsrService{

	/**
	 *  평균 데이터
	 * @return
	 * @throws Exception
	 */
	@Override
	public Map<String, Object> avgData()throws Exception{
		return dao.selectOne("speedman.getAvgData");
	}
	/**
	 * 내 통계
	 */
	@Override
	public Map<String, Object> myStatistics(Map<String, Object> params)throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();		
		try{
			rsMap = dao.selectOne("speedman.getMyStatistics", params); 
		}catch(Exception e){
			e.printStackTrace();
		}
		return rsMap;
	}
	
	/**
	 * 인터넷 속도
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> STATICS_LOCALITY(Map<String, Object> param)throws Exception{
		return dao.selectList("speedman.STATICS_LOCALITY", param);
	}
	
	/**
	 * 인터넷 평균 속도
	 */
	@Override
	public Map<String, Object> avgStatistics(Map<String, Object> params)throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();		
		
		rsMap = dao.selectOne("speedman.AVG_STATICS", params); 		
		return rsMap;
	}
	
	/**
	 * 기간별 평균 속도
	 */
	@Override
	public Map<String, Object> avgPeriodStatistics(Map<String, Object> params)throws Exception{
		Map<String, Object> rsMap = new HashMap<String, Object>();		
		
		rsMap = dao.selectOne("speedman.AVG_PERIOD_STATICS", params); 		
		return rsMap;
	}
	
	/**
	 * 인터넷 지역별, 통신사별 통계
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> networkStatistics(Map<String, Object> params)throws Exception{
		return dao.selectList("speedman.STATICS_LOCALITY_NETWORK", params);
	}
	
	/**
	 * 웹속도 통계
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@Override
	public List<Map<String, Object>> webStatistics(Map<String, Object> params)throws Exception{
		return dao.selectList("speedman.WEB_STATISTICS", params);
	}
	
	/**
	 * 인터넷 속도 등록
	 * @param params
	 */
	@Override
	public void myInternetInsert(String params){
		try{
			String[] temps = params.split("&");
			Map<String, Object> rsMap = new HashMap<String, Object>();
			for(int i = 0; i < temps.length; i++){
				String[] temp = temps[i].split("=");
				if(temp.length == 2){
					rsMap.put(temp[0], temp[1]);
				}			
			}		
						
			int subsIdx = 0;
			subsIdx = dao.selectOne("speedman.deviceSubsId", rsMap);
			if(subsIdx == 0){
				subsIdx = dao.selectOne("speedman.SUBS_COUNT");
				rsMap.put("SUBS_ID", subsIdx);
				dao.insert("speedman.subscribeInternetInsert", rsMap);
			}
			else{
				rsMap.put("SUBS_ID", subsIdx);
			}
			
			int testIdx = dao.selectOne("speedman.TEST_COUNT");
			int groupIdx =  dao.selectOne("speedman.GROUP_COUNT");
			
			rsMap.put("TEST_ID", testIdx);
			rsMap.put("GROUP_ID", groupIdx);
			
			dao.insert("speedman.speedtest2InternetInsert", rsMap);
			
		}catch(Exception e){
			System.out.println(e.toString());
		}
	}
	
	/**
	 * 웹 속도 등록
	 * @param params
	 * @throws Exception
	 */
	@Override
	public void myWebInsert(String params)throws Exception{
		webModel wm = new webModel();
		try{
			String[] temps = params.split("&");
			Map<String, Object> rsMap = new HashMap<String, Object>();
			for(int i = 0; i < temps.length; i++){
				String[] temp = temps[i].split("=");
				if(temp.length == 2){
					rsMap.put(temp[0], temp[1]);
				}			
			}		
			
			int subsIdx = 0;
			subsIdx = dao.selectOne("speedman.deviceSubsId", rsMap);
			if(subsIdx == 0){
				subsIdx = dao.selectOne("speedman.SUBS_COUNT");
				rsMap.put("SUBS_ID", subsIdx);
				dao.insert("speedman.subscribeInternetInsert", rsMap);
			}
			
			int testIdx = dao.selectOne("speedman.WEB_TEST_COUNT");
			int groupIdx =  dao.selectOne("speedman.WEB_GROUP_COUNT");
			int trnsfer1 = 0;
			int trnsfer2 = 0;
			int trnsfer3 = 0;
			float interval1 = 0;
			float interval2 = 0;
			float interval3 = 0;
			
			if(!Utility.NVL(rsMap.get("transfer_1")).equals("")){
				trnsfer1 = Integer.parseInt(Utility.NVL(rsMap.get("transfer_1")));
			}
			if(!Utility.NVL(rsMap.get("transfer_2")).equals("")){
				trnsfer2 = Integer.parseInt(Utility.NVL(rsMap.get("transfer_2")));
			}
			if(!Utility.NVL(rsMap.get("transfer_3")).equals("")){
				trnsfer3 = Integer.parseInt(Utility.NVL(rsMap.get("transfer_3")));
			}
			if(!Utility.NVL(rsMap.get("interval_1")).equals("")){
				interval1 = Float.parseFloat(Utility.NVL(rsMap.get("interval_1")));
			}
			if(!Utility.NVL(rsMap.get("interval_2")).equals("")){
				interval2 = Float.parseFloat(Utility.NVL(rsMap.get("interval_2")));
			}
			if(!Utility.NVL(rsMap.get("interval_3")).equals("")){
				interval3 = Float.parseFloat(Utility.NVL(rsMap.get("interval_3")));
			}
			wm.setSubs_id(subsIdx);
			wm.setNetwork_id(Integer.parseInt(Utility.NVL(rsMap.get("network_id"))));
			wm.setTest_id(testIdx);
			wm.setGroup_id(groupIdx);
			wm.setCurrent_count(Integer.parseInt(Utility.NVL(rsMap.get("current_count"))));
			wm.setIsp_id(Integer.parseInt(Utility.NVL(rsMap.get("isp_id"))));
			wm.setUrl_1(Utility.NVL(rsMap.get("url_1")));
			wm.setTransfer_1(trnsfer1);
			wm.setInterval_1(interval1);
			wm.setUrl_2(Utility.NVL(rsMap.get("url_2")));
			wm.setTransfer_2(trnsfer2);
			wm.setInterval_2(interval2);
			wm.setUrl_3(Utility.NVL(rsMap.get("url_3")));
			wm.setTransfer_3(trnsfer3);
			wm.setInterval_3(interval3);
			wm.setStart_time(Utility.NVL(rsMap.get("start_time")));
			wm.setEnd_time(Utility.NVL(rsMap.get("end_time")));
			wm.setConnection_success(Utility.NVL(rsMap.get("connection_success")));
			wm.setTimeline(Utility.NVL(rsMap.get("timeline")));
			wm.setCountry(Utility.NVL(rsMap.get("country")));
			wm.setLocality(Utility.NVL(rsMap.get("locality")));
			wm.setSublocality(Utility.NVL(rsMap.get("sublocality")));
			wm.setThoroughfare(Utility.NVL(rsMap.get("thoroughfare")));
			wm.setSubthoroughfare(Utility.NVL(rsMap.get("subthoroughfare")));
			wm.setCell_id(Utility.NVL(rsMap.get("cell_id")));
			
			dao.insert("speedman.insertWebWebTest", wm);
			
		}catch(Exception e){
			System.out.println(e.toString());
		}
	}
}
