package com.travel.service;

import java.util.List;
import java.util.Map;

import com.travel.dto.TravelDTO;
import com.travel.vo.ClientInfoVo;

public interface TravelService {
	
	public ClientInfoVo checkUser(Map<String, String> data);

	public int register(ClientInfoVo data);

	public List<ClientInfoVo> registerClient();

	public ClientInfoVo getName(String userName);

	public int registerSchedule(TravelDTO travelDTO);

}
