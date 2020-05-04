package egovframework.core.mapper;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.session.ResultHandler;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractMapper;

/**
 * 공통 맵퍼
 * @author kgy
 *
 */
@Repository("default.sqlMapper")
public class SqlMapperImpl extends EgovAbstractMapper implements SqlMapper {
	
	/**
     * 추가
     *
     * @param queryId
     * @param param
     * @return
     */
	@Override
    public int insert(String queryId, Object param) {
        return super.insert(queryId, param);
    }

	/**
     * 수정
     *
     * @param queryId
     * @param param
     * @return
     */
	@Override
    public int update(String queryId, Object param) {
        return super.update(queryId, param);
    }

	/**
     * 삭제
     *
     * @param queryId
     * @param param
     * @return
     */
	@Override
    public int delete(String queryId, Object param) {
        return super.delete(queryId, param);
    }

	/**
     * 단건 조회
     *
     * @param queryId
     * @return
     */
	@Override
    public <T> T selectOne(String queryId) {
        return super.selectOne(queryId);
    }
    
	/**
     * 단건 조회
     *
     * @param queryId
     * @param param
     * @return
     */
	@Override
    public <T> T selectOne(String queryId, Object param) {
        return super.selectOne(queryId, param);
    }

	/**
     * 다건 조회
     *
     * @param queryId
     * @return 리스트 반환
     */
	@Override
    public <E> List<E> selectList(String queryId) {
        return super.selectList(queryId);
    }
    
	/**
     * 다건 조회
     *
     * @param queryId
     * @param param
     * @return 리스트 반환
     */
	@Override
    public <E> List<E> selectList(String queryId, Object param) {
        return super.selectList(queryId, param);
    }
}
