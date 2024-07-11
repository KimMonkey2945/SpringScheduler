package com.travel.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.travel.dao.TravelDao;
import com.travel.dto.TravelDTO;
import com.travel.vo.ClientInfoVo;
import com.travel.vo.TraveInfoVo;

@Repository
public class TravelDaoImpl implements TravelDao{

	@Autowired
	private SqlSession sqlSession;

	@Override
	public ClientInfoVo checkUser(Map<String, String> data) {
		return sqlSession.selectOne("travel.chechUser", data);
	}

	@Override
	public int register(ClientInfoVo data) {
		return sqlSession.insert("travel.register", data);
	}

	@Override
	public List<ClientInfoVo> registerClient() {
		return sqlSession.selectList("travel.registerClient");
	}

	@Override
	public ClientInfoVo getName(String userName) {
		return sqlSession.selectOne("travel.getName", userName);
	}

	@Override
	public int registerSchedule(TravelDTO travelDTO) {
		int result = 0;
		
		// 견적경비용
//		sqlSession.insert("travel.insertClient", travelDTO);
		
		sqlSession.insert("travel.insertSchedule", travelDTO);
		
		
		return result;
	}

	@Override
	public List<TraveInfoVo> getSchedule(String clientSeq) {
		return sqlSession.selectList("travel.selectSchedule",clientSeq);
	}
	
}
