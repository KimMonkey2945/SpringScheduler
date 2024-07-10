package com.travel.dao;

import java.util.List;
import java.util.Map;

import com.travel.dto.TravelDTO;
import com.travel.vo.ClientInfoVo;

public interface TravelDao {

	public ClientInfoVo checkUser(Map<String, String> data);

	public int register(ClientInfoVo data);

	public List<ClientInfoVo> registerClient();

	public ClientInfoVo getName(String userName);

	public int registerSchedule(TravelDTO travelDTO);

}