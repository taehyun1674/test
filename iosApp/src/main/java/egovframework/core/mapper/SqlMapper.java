package egovframework.core.mapper;

import java.util.List;

/**
 * 맵퍼 인터페이스
 * @author kgy
 *
 */
public interface SqlMapper {
	/**
     * 추가
     *
     * @param queryId
     * @param param
     * @return
     */
	public int insert(String queryId, Object param);
	
	/**
     * 수정
     *
     * @param queryId
     * @param param
     * @return
     */
    public int update(String queryId, Object param);
    
    /**
     * 삭제
     *
     * @param queryId
     * @param param
     * @return
     */
    public int delete(String queryId, Object param);
    
    /**
     * 단건 조회
     *
     * @param queryId
     * @return
     */
    public <T> T selectOne(String queryId);
    
    /**
     * 단건 조회
     *
     * @param queryId
     * @param param
     * @return
     */
    public <T> T selectOne(String queryId, Object param);
    
    /**
     * 다건 조회
     *
     * @param queryId
     * @return 리스트 반환
     */
    public <E> List<E> selectList(String queryId);
    
    /**
     * 다건 조회
     *
     * @param queryId
     * @param param
     * @return 리스트 반환
     */
    public <E> List<E> selectList(String queryId, Object param);
    
}
