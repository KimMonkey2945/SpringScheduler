package com.travel.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.travel.dto.TravelDTO;
import com.travel.service.TravelService;
import com.travel.vo.ClientInfoVo;
import com.travel.vo.TraveInfoVo;

import org.apache.logging.log4j.Level;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@Controller
public class TravelController {
	
	private static final Logger logger = LogManager.getLogger(TravelController.class);
	
	@Autowired
	TravelService travelService; 
	 
	@GetMapping("/home.do")
	public String home() {
		return "login";
	}
	
	@PostMapping("/checkUser.do")
	@ResponseBody
	public Map<String, String> register(@RequestBody Map<String, String> data){
		Map<String, String> response = new HashMap<String, String>();
		Map<String, String> requestData = new HashMap<String, String>();
		requestData.put("userName", data.get("userName"));
		requestData.put("userPhone", data.get("userPhone"));
		
		ClientInfoVo client = travelService.checkUser(requestData);
		if(client == null) {
			response.put("register","0");
			response.put("site", "/registerForm.do");
		}else {
			response.put("register", "1");
			response.put("site", "/registerForm.do");
		}
		
		logger.info(response);
		
		
		
		return response;
	}
	
	@GetMapping("/registerForm.do")
	public String registerForm(@RequestParam("userName") String userName
							  ,@RequestParam("userPhone") String userPhone
							  ,Model model) {
		model.addAttribute("userName", userName);
		model.addAttribute("userPhone", userPhone);
		return "register";
	}
	
	@PostMapping("/registerForm.do")
	@ResponseBody
	public Map<String, String> registerList(@RequestBody ClientInfoVo data) {
		Map<String, String> response = new HashMap<String, String>();
		int result = travelService.register(data);
		
		logger.info(data.toString());
		
		if(result == 1) {
			response.put("result", "신청성공");
			
		}else {
			response.put("result", "신청실패");
		}
		
		return response;
	}
	
	@GetMapping("/registerList.do")
	public String registerList(Model model) {
		List<ClientInfoVo> clientList = travelService.registerClient();
//		logger.info(clientList.toString());
		
		model.addAttribute("clientList", clientList);	
		return "registerList";
	}
	
	@PostMapping("/registerList.do")
	@ResponseBody
	public Map<Object, Object> getPeriod(@RequestParam("userName") String userName,  Model model) {
		Map<Object, Object> response = new HashMap<Object, Object>();
		
		ClientInfoVo result = travelService.getName(userName);
		String resultPeriod = result.getPeriod();
		String resultUserName = result.getUserName();
		String resultClientSeq = result.getSeq();
		
		List<TraveInfoVo> taravelInfo = travelService.getSchedule(resultClientSeq);
		
		
		response.put("resultPeriod", resultPeriod);
		response.put("resultUserName", resultUserName);
		response.put("resultClientSeq", resultClientSeq);
		response.put("taravelInfo", taravelInfo);
		
		return response;
	}
	
	@PostMapping("/registerSchedule.do")
	@ResponseBody
	public Map<String, String> registerSchedule(@RequestBody TravelDTO travelDTO) {
		Map<String, String> response = new HashMap<String, String>();
		
		logger.info("getClientInfoVo" + travelDTO.getClientInfoVo().toString());
		logger.info("getTraveInfoVo" + travelDTO.getTraveInfoVo().toString());
		
		
		travelService.registerSchedule(travelDTO);
		
		return response;
	}
	

}
