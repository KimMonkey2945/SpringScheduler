package com.travel.dto;

import java.util.List;

import com.travel.vo.ClientInfoVo;
import com.travel.vo.TraveInfoVo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;


@Getter
@Setter
@ToString
public class TravelDTO {
	
	private ClientInfoVo clientInfoVo;
	private List<TraveInfoVo> traveInfoVo;
	

}
