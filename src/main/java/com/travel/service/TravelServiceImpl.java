package com.travel.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.travel.dao.TravelDao;
import com.travel.dto.TravelDTO;
import com.travel.vo.ClientInfoVo;
import com.travel.vo.TraveInfoVo;

@Service
public class TravelServiceImpl implements TravelService{
	
	@Autowired
	TravelDao travelDao;
	
	@Override
	public ClientInfoVo checkUser(Map<String, String> data) {
		return travelDao.checkUser(data);
	}

	@Override
	public int register(ClientInfoVo data) {
		return travelDao.register(data);
	}

	@Override
	public List<ClientInfoVo> registerClient() {
		return travelDao.registerClient();
	}

	@Override
	public ClientInfoVo getName(String userName) {
		return travelDao.getName(userName);
	}

	@Override
	public int registerSchedule(TravelDTO travelDTO) {
		return travelDao.registerSchedule(travelDTO);
		
	}

	@Override
	public List<TraveInfoVo> getSchedule(String clientSeq) {
		return travelDao.getSchedule(clientSeq);
	}

}
