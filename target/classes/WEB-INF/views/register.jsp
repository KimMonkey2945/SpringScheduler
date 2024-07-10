<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<title></title>
</head>

<script>

	$(function(){
		
		var data = {};
		
		$('#userName').on('keyup', function(){
			this.value = this.value.replace(/[^ㄱ-ㅎ가-힣]/g, '').substring(0,84);
		});
		
		$('#userPhone').on('keyup', function(){
			var value = this.value.replace(/[^0-9]/g, '').substring(0,11);
			if (value.substring(0, 3) !== "010") {
		            value = "010" + value.substring(3);
		    }
		    if (value.length > 7) {
		        value = value.slice(0, 3) + '-' + value.slice(3, 7) + '-' + value.slice(7);
		    }
			this.value = value;
		});
		
		$('#period').on('keyup', function(){
			this.value = this.value.replace(/[^0-9]/g, '').substring(0,84);
		});
		
		$('#expend').on('keyup', function(){
			 var value = this.value.replace(/[^\d]/g, '');
		     var formattedValue = numberWithCommas(value); // 세 자리마다 쉼표 추가
		     this.value = formattedValue;
		});
		
		function numberWithCommas(x) {
		      return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		}
		
		
		function validation(){
			var userName = $('#userName').val();
			var userPhone = $('#userPhone').val();
			var period = $('#period').val();
			var expend = $('#expend').val();		
			
			if(userName == ''){
				alert('이름을 입력해주세요.')
				$('#userName').focus();
				return;
			}else if(userPhone == ''){
				alert('전화번호를 입력해주세요.')
				$('#userPhone').focus();
				return;
			}else if(userPhone.length < 13 ){
				alert('전화번호를 확인해주세요.')
				$('#userPhone').focus();
				return;
			}else if(period == ''){
				alert('여행기간을 입력해주세요.')
				$('#period').focus();
				return;
			}else if(period == 0 || period > 30){
				alert('여행기간은 최소 1일 부터 최대 30일까지 가능합니다.');
				$('#period').focus();
				return;
			}else if(expend == ''){
				alert('예상경비를 입력해주세요.')
				$('#expend').focus();
				return;
			}
					
		};
		
		$('#register').on('click', function(){
			
			validation();

			$('table input, table select').each(function(){
				 var input = $(this);
				 if (input.attr('name')) { // name 속성이 있는 경우에만 처리
				     data[input.attr('name')] = input.val();
				 }
	        });
			
			console.log('JSON.stringify(data) : ', JSON.stringify(data));
		
			 $.ajax({
					url : "/registerForm.do",
				    type: "POST",
	 			    contentType: "application/json",
				    data : JSON.stringify(data),
				    success: function(response, textStatus, jqXHR)
				    {
				    	alert(response.result);
				    	window.location.href="/home.do";
						
				    },
				    error: function (xhr, textStatus, error)
				    {
				    	alert("실패");
				    	console.log("textStatus : ", textStatus);
				    	console.log("error : ", error);
				    }	
				
				});
			
			 
		});
		
	});

</script>

<body>

	<table align="center" border="1">
		<input type="hidden" id="seq" name="seq" value=""/>
		<tr>
			<td>이름</td>
			<td><input id="userName" name="userName" value="${userName}"/></td>
		</tr>
		<tr>
			<td>휴대폰번호</td>
			<td><input id="userPhone" name="userPhone" value="${userPhone}"/></td>
		</tr>
		<tr>
			<td>여행기간</td>
			<td><input id="period" name="period" value=""/></td>
		</tr>
		<tr>
			<td>이동수단</td>
			<td>
				<select id="transport" name="transport">
					<option vlaue="R">렌트</option>
					<option vlaue="B">대중교통</option>
					<option vlaue="C">자차</option>
				</select>
			</td>
		</tr>
		<tr>
			<td>예상경비</td>
			<td><input id="expend" name="expend" value=""/></td>
		</tr>
		<tr>
			<td>여행지</td>
			<td>
				<select id="traveCity" name="traveCity">
					<option vlaue="서울특별시">서울특별시</option>
					<option vlaue="인천광역시">인천광역시</option>
					<option vlaue="대전광역시">대전광역시</option>
					<option vlaue="광주광역시">광주광역시</option>
					<option vlaue="대구광역시">대구광역시</option>
					<option vlaue="울산광역시">울산광역시</option>
					<option vlaue="부산광역시">부산광역시</option>
					<option vlaue="경기도">경기도</option>
					<option vlaue="강원도">강원도</option>
					<option vlaue="충청북도">충청북도</option>
					<option vlaue="충청남도">충청남도</option>
					<option vlaue="전라북도">전라북도</option>
					<option vlaue="전라남도">전라남도</option>
					<option vlaue="경상북도">경상북도</option>
					<option vlaue="경상남도">경상남도</option>
					<option vlaue="제주도">제주도</option>
				</select>
			</td>
		</tr>
		<tr>
			<td align="center" colspan="2"><input id="register" type="button" value="신청" /></td>
		</tr>
	</table>

</body>
</html>