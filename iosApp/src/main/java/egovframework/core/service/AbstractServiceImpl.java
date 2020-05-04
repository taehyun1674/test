package egovframework.core.service;

import javax.annotation.Resource;

import org.slf4j.Logger;

import egovframework.core.mapper.SqlMapper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 서비스 임플 공통
 * 상속받아 임플 구현
 * @author kgy
 *
 */
public abstract class AbstractServiceImpl extends EgovAbstractServiceImpl {
	@Resource(name = "default.sqlMapper")
    protected SqlMapper dao;
	
	protected Logger logger = super.egovLogger;
}
