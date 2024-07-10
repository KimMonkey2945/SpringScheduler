<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	
$(function() {
	
	jQuery.fn.serializeObject = function() {
	    var obj = null;
	    try {
	        if ( this[0].tagName && this[0].tagName.toUpperCase() == "FORM" ) {
	            var arr = this.serializeArray();
	            if ( arr ) {
	                obj = {};
	                jQuery.each(arr, function() {
	                    obj[this.name] = this.value;
	                });            
	            }//if ( arr ) {
	        }
	    }
	    catch(e) {alert(e.message);}
	    finally  {}
	     
	    return obj;
	};
	  // 시,도 및 구,군 데이터
	  var areas = [
	    ["서울특별시", "인천광역시", "대전광역시", "광주광역시", "대구광역시", "울산광역시", "부산광역시", "경기도", "강원도", "충청북도", "충청남도", "전라북도", "전라남도", "경상북도", "경상남도", "제주도"],
	    ["강남구", "강동구", "강북구", "강서구", "관악구", "광진구", "구로구", "금천구", "노원구", "도봉구", "동대문구", "동작구", "마포구", "서대문구", "서초구", "성동구", "성북구", "송파구", "양천구", "영등포구", "용산구", "은평구", "종로구", "중구", "중랑구"],
	    ["계양구", "남구", "남동구", "동구", "부평구", "서구", "연수구", "중구", "강화군", "옹진군"],
	    ["대덕구", "동구", "서구", "유성구", "중구"],
	    ["광산구", "남구", "동구", "북구", "서구"],
	    ["남구", "달서구", "동구", "북구", "서구", "수성구", "중구", "달성군"],
	    ["남구", "동구", "북구", "중구", "울주군"],
	    ["강서구", "금정구", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구", "기장군"],
	    ["고양시", "과천시", "광명시", "광주시", "구리시", "군포시", "김포시", "남양주시", "동두천시", "부천시", "성남시", "수원시", "시흥시", "안산시", "안성시", "안양시", "양주시", "오산시", "용인시", "의왕시", "의정부시", "이천시", "파주시", "평택시", "포천시", "하남시", "화성시", "가평군", "양평군", "여주군", "연천군"],
	    ["강릉시", "동해시", "삼척시", "속초시", "원주시", "춘천시", "태백시", "고성군", "양구군", "양양군", "영월군", "인제군", "정선군", "철원군", "평창군", "홍천군", "화천군", "횡성군"],
	    ["제천시", "청주시", "충주시", "괴산군", "단양군", "보은군", "영동군", "옥천군", "음성군", "증평군", "진천군", "청원군"],
	    ["계룡시", "공주시", "논산시", "보령시", "서산시", "아산시", "천안시", "금산군", "당진군", "부여군", "서천군", "연기군", "예산군", "청양군", "태안군", "홍성군"],
	    ["군산시", "김제시", "남원시", "익산시", "전주시", "정읍시", "고창군", "무주군", "부안군", "순창군", "완주군", "임실군", "장수군", "진안군"],
	    ["광양시", "나주시", "목포시", "순천시", "여수시", "강진군", "고흥군", "곡성군", "구례군", "담양군", "무안군", "보성군", "신안군", "영광군", "영암군", "완도군", "장성군", "장흥군", "진도군", "함평군", "해남군", "화순군"],
	    ["경산시", "경주시", "구미시", "김천시", "문경시", "상주시", "안동시", "영주시", "영천시", "포항시", "고령군", "군위군", "봉화군", "성주군", "영덕군", "영양군", "예천군", "울릉군", "울진군", "의성군", "청도군", "청송군", "칠곡군"],
	    ["거제시", "김해시", "마산시", "밀양시", "사천시", "양산시", "진주시", "진해시", "창원시", "통영시", "거창군", "고성군", "남해군", "산청군", "의령군", "창녕군", "하동군", "함안군", "함양군", "합천군"],
	    ["서귀포시", "제주시", "남제주군", "북제주군"]
	  ];

	  // 시/도 선택 박스 초기화
	  function initCitySelect($select) {
	    $select.empty();
	    $select.append("<option value=''>시/도 선택</option>");
	    $.each(areas[0], function(index, value) {
	      $select.append("<option value='" + value + "'>" + value + "</option>");
	    });
	  }

	  // 구/군 선택 박스 초기화
	  function initCountySelect($citySelect, $countySelect) {
	    var areaIndex = $citySelect.prop('selectedIndex');
	    $countySelect.empty();
	    if (areaIndex > 0) {
	      $countySelect.append("<option value=''>구/군 선택</option>");
	      $.each(areas[areaIndex], function(index, value) {
	        $countySelect.append("<option value='" + value + "'>" + value + "</option>");
	      });
	    }
	  }

	  // 시/도 및 구/군 선택 박스 초기화
	  initCitySelect($('#taveCity'));

	  $(document).on('change', '.taveCity', function() {
	    var $countySelect = $(this).closest('tr').find('.taveCounty');
	    initCountySelect($(this), $countySelect);
	  });

	  $(document).on('click', '#addSchedule', function() {
		    var str = "";
		    str += "<tr class='enterSchedule'>";
		    str += 	"<td><input type='checkbox' class='scheduleCheck'/></td>";
		    str += 	"<td><input id='traveTime' class='traveTime' type='time'/></td>";
		    str += 	"<td>";
		    str += 	"<select id='taveCity' class='taveCity' name='taveCity'>";
		    str += 	"</select>";
		    str += 	"<select id='taveCounty' class='taveCounty' name='taveCounty'>";
		    str += 	"</select>";
		    str +=	 "</td>";
		    str += 	"<td><input id='traveLoc' class='traveLoc'/></td>";
		    str += 	"<td>";
		    str += 	"<select id='traveTrans' class='traveTrans' name='traveTrans'>";
		    str += 	"<option value='W'>도보</option>";
		    str += 	"<option value='B'>버스</option>";
		    str += 	"<option value='S'>지하철</option>";
		    str += 	"<option value='T'>택시</option>";
		    str += 	"<option value='R'>렌트</option>";
		    str += 	"<option value='C'>자차</option>";
		    str += 	"</select>";
		    str += 	"</td>";
		    str += 	"<td><input id='transTime' class='transTime'/></td>";
		    str += 	"<td><input id='useExpend' class='useExpend'/></td>";
		    str += 	"<td><input id='traveDetail' class='traveDetail'/></td>";
		    str += 	"<td><input id='request' class='request'/></td>";
		    str += 	"</tr>";

	    $('#traveInfo').append(str);

	    // 새로 추가된 요소에 대해 시/도 및 구/군 선택 박스 초기화
	    var $addedRow = $('#traveInfo').find('tr:last');
	    initCitySelect($addedRow.find('.taveCity'));
	  });

	  $(document).on('click', '#deleteSchedule', function() {
	    $('#traveInfo .scheduleCheck:checked').each(function() {
	      $(this).closest('tr').remove();
	    });
	  });
	  
	  var period = '';
	  var schedules = {}; // 일별데이터 저장
	  var currentDay = null;
	  var userResultName = '';
	  
	  var submitData ={
		  clientInfoVo: {},
		  traveInfoVo: []	  
	  };
	  
	  
	  
	  // 이름에 따라 여행기간 버튼 
	  $(document).on('click', '#userName', function(){
		  
		  var userName = $(this).val();

		  $.ajax({
				url : "/registerList.do",
			    type: "POST",
			    data : {userName: userName},
			    success: function(response, textStatus, jqXHR)
			    {
// 			    	console.log('resultPeriod : ', response.resultPeriod);
			    	period = response.resultPeriod;
			    	userResultName = response.resultUserName;
			    	console.log('period : ', period);
			    	console.log('userName : ', userName);
			    	 var str = "";
					 for(var i = 1; i <= period; i++){
						 console.log('i : ', i);
						 if(i == period){
							 str += "<input id='" + 'traveDay' + i + "' class='date' type='button' value='" + i +"'/>"
						 }else{
							 str += "<input id='" + 'traveDay' + i + "' class='date' type='button' value='" + i +"'/>&nbsp;&nbsp;|&nbsp;&nbsp;"
						 }
						 				
					 }
					 $('#page').empty();
			         $('#page').append(str);
			    },
			    error: function (xhr, textStatus, error)
			    {
			    	alert("실패");
			    	console.log("textStatus : ", textStatus);
			    	console.log("error : ", error);
			    }	
			
			});
	  });
	  
	  $(document).on('click','#page .date' ,function(){
		  var day = $(this).val();
		  
		  // 시/도 및 구/군 선택 박스 초기화
		  initCitySelect($('#taveCity'));
		  
		  $('#page .date').each(function() {
		        $(this).css("background", "");
		  });
		  $(this).css("background", "#74D19D");
		 
		 // 현재 데이터 저장
// 		 saveCurrentData();
	 	 // 선택한 날짜를 업데이트
	     currentDay = day;
		 
		 console.log('selectDay : ', day);
		 
		 var str = '';
		 str +=  "<input type='hidden' class='traveDay' value=' "+ day +"'/> "
		 str +=	 "<table style='margin-top:20px;' id='traveInfo' align='center' border='1'>"
		 str +=				"<tr>"
		 str +=				"<td></td>"
		 str +=				"<td>시간</td>"
		 str +=				"<td>지역</td>"
		 str +=				"<td>장소명</td>"
		 str +=				"<td>교통편</td>"
		 str +=				"<td>예상이동시간</td>"
		 str +=				"<td>이용요금(예상지출비용)</td>"
		 str +=				"<td>계획상세</td>"
		 str +=				"<td>교통비</td>"
		 str +=			"</tr>"
		 str +=			"<tr class='enterSchedule'>"
		 str +=				"<td><input type='checkbox' class='scheduleCheck' /></td>"
		 str +=				"<td><input id='traveTime' class='traveTime' type='time'/></td>"
		 str +=				"<td>"
		 str +=					"<select id='taveCity' class='taveCity' name='taveCity' value=''>"
		 str +=					"</select>"
		 str +=					"<select id='taveCounty' class='taveCounty' name='taveCounty' value=''>"
		 str +=					"</select>"
		 str +=				"</td>"
		 str +=				"<td><input id='traveLoc' class='traveLoc'/></td>"
		 str +=				"<td>"
		 str +=					"<select id='traveTrans' class='traveTrans' name='traveTrans'>"
		 str +=						"<option value='W'>도보</option>"
		 str +=						"<option value='B'>버스</option>"
		 str +=						"<option value='S'>지하철</option>"
		 str +=						"<option value='T'>택시</option>"
		 str +=						"<option value='R'>렌트</option>"
		 str +=						"<option value='C'>자차</option>"
		 str +=					"</select>"
		 str +=				"</td>"
		 str +=				"<td><input id='transTime' class='transTime'/></td>"
		 str +=				"<td><input id='useExpend' class='useExpend'/></td>"
		 str +=				"<td><input id='traveDetail' class='traveDetail'/></td>"
		 str +=				"<td><input id='request' class='request'/></td>"
		 str +=			"</tr>"
		 str +=		"</table>"
		 
		// 선택한 일자의 스케줄 테이블을 업데이트
	    $('#traveInfoContainer').empty();
	    $('#traveInfoContainer').append(str);
	    
	    // 새로 추가된 요소에 대해 시/도 및 구/군 선택 박스 초기화
	    var $addedRow = $('#traveInfo').find('tr:last');
	    initCitySelect($addedRow.find('.taveCity'));
	    
// 	 	// 이전에 저장된 데이터 로드
// 	    if (schedules[day]) {
// 	        loadScheduleData(schedules[day]);
// 	    }
		  
	  });
	  
/* 	  function saveCurrentData(){
		  var day = currentDay;
		 
		  if(day != null){
			
			  var scheduleData = {
				time: $(this).find('.traveTime').val(),
		        city: $(this).find('.taveCity').val(),
		        county: $(this).find('.taveCounty').val(),
		        location: $(this).find('.traveLoc').val(),
		        transport: $(this).find('.traveTrans').val(),
		        transportTime: $(this).find('.transTime').val(),
		        expense: $(this).find('.useExpend').val(),
		        detail: $(this).find('.traveDetail').val()	  
			  };
			  
			  schedules[day] = scheduleData;
			  console.log('Saved schedule day ' + day, scheduleData); 
			  
		  }

	  }
	  
	  function loadScheduleData(data) {
	      $('#traveTime').val(data.time);
	      $('#taveCity').val(data.city);
	      $('#taveCounty').val(data.county);
	      $('#traveLoc').val(data.location);
	      $('#traveTrans').val(data.transport);
	      $('#transTime').val(data.transportTime);
	      $('#useExpend').val(data.expense);
	      $('#traveDetail').val(data.detail);
	  } */
	  
	  
	 $('#submit').on('click', function(){
			  
		  clientInfo = {userName: userResultName};
		  submitData.clientInfoVo = (clientInfo);
		  
		  $('#traveInfo .enterSchedule').each(function(){
			  var obj = {};
		  	  var allFieldsValid = true;
			  $(this).find('input:not(.scheduleCheck), select').each(function(){
			  		var element = $(this);
			  		var id = element.attr('id');
			  		var value = element.val();
// 			  		if(value == '' || value == null){
// 			  			allFieldsValid = false;
// 			  		}
			  		obj[id] = value;
			  });
			  submitData.traveInfoVo.push(obj);
			  
// 			  if(allFieldsValid){
				  
// 			  }
			  
		  });
		  
		  console.log('data : ', submitData);
		  
	  });
	  
	});
	
</script>
<body>


	<table id="clientInfo" align="center" border="1">
		<tr>
			<td>고객명</td>
			<td>휴대폰번호</td>
			<td>여행지</td>
			<td>여행기간</td>
			<td>이동수단</td>
			<td>예상경비</td>
			<td>견적경비</td>
		</tr>
		<c:forEach var="client" items="${clientList}">
			<tr>
				<td><input id="userName" value="${client.userName}" readonly/></td>
				<td><input id="userPhone" value="${client.userPhone}" readonly/></td>
				<td><input id="traveCity" value="${client.traveCity}" readonly/></td>
				<td><input id="period" value="${client.period}" readonly/></td>
				<td><input id="transport" value="${client.transport}" readonly/></td>
				<td><input id="expend" value="${client.expend}" readonly/></td>
				<td><input id="" value=""/></td>
			</tr>
		</c:forEach>

	</table>
	
	<div id="page" style="margin-top:300px;">	
	</div>
	<div style="margin-top:15px;">
		<input type="button" id="addSchedule" value="추가"/>&nbsp;&nbsp;|&nbsp;
		<input type="button" id="deleteSchedule" value="삭제"/>
	</div>
	<div id="traveInfoContainer">
		<table style="margin-top:20px;" id="traveInfo" align="center" border="1">
			<tr>
				<td></td>
				<td>시간</td>
				<td>지역</td>
				<td>장소명</td>
				<td>교통편</td>
				<td>예상이동시간</td>
				<td>이용요금(예상지출비용)</td>
				<td>계획상세</td>
				<td>교통비</td>
			</tr>
			<tr class="enterSchedule">
				<td><input type="checkbox" class="scheduleCheck" /></td>
				<td><input id="traveTime" class="traveTime" type="time"/></td>
				<td>
					<select id="taveCity" class="taveCity" name="taveCity" value="">
					</select>
					
					<select id="taveCounty" class="taveCounty" name="taveCounty" value="">
					</select>
				</td>
				<td><input id="traveLoc" class="traveLoc"/></td>
				<td>
					<select id="traveTrans" class="traveTrans" name="traveTrans">
						<option value="W">도보</option>
						<option value="B">버스</option>
						<option value="S">지하철</option>
						<option value="T">택시</option>
						<option value="R">렌트</option>
						<option value="C">자차</option>
					</select>
				</td>
				<td><input id="transTime" class="transTime"/></td>
				<td><input id="useExpend" class="useExpend"/></td>
				<td><input id="traveDetail" class="traveDetail"/></td>
				<td><input id="request" class="request"/></td>
			</tr>
		</table>
		
	</div>
	
	<input style="margin-top:20px;" id="submit" type="button" value="저장">
	


</body>
</html>