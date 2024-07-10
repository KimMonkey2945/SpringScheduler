<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
</head>
<script type="text/javascript">

	
	$(function(){
		
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
		
		var phoneInput = $('#userPhone');
	    phoneInput.val('010');

		$('#login').on('click', function(){
			
			var userName = $('#userName').val();
			var userPhone = $('#userPhone').val();
			
			if(userName == ""){
				alert('이름을 입력해주세요.');
				$('#userName').focus();
				return false;
			}
			
			if (userPhone == "" && userName != "") {
		        alert('전화번호를 입력해주세요.');
		        $('#userPhone').focus();
	            return false;
	        }
			else if(userPhone.length < 13){
			alert('전화번호를 확인해주세요.');
			$('#userPhone').focus();
			return false;	
		    }
			
			var data = {};
			data['userName'] = userName;
			data['userPhone'] = userPhone;
			
 			console.log("미리찍어보는 콘솔 : ", JSON.stringify(data));
 			
 			$.ajax({
				url : "/checkUser.do",
			    type: "POST",
 			    contentType: "application/json",
			    data : JSON.stringify(data),
			    success: function(response, textStatus, jqXHR)
			    {
//  	 			    console.log('response : ', response);
//  	 			    console.log('response.register : ', response.register);
//  	 			    console.log('response.site : ', response.site);
 	 			    if(response.register == '0'){
 	 			    	window.location.href=response.site +'?userName=' + userName + '&userPhone=' + userPhone;
 	 			    }else{
 	 			         	
 	 			    }
 	 			 
					
			    },
			    error: function (xhr, textStatus, error)
			    {
			    	alert("실패");
// 			    	console.log("xhr : ", xhr.responseText);
			    	console.log("textStatus : ", textStatus);
			    	console.log("error : ", error);
			    }	
			
			});	
			
			
		});
		
		
		
		
	});
	

</script>
<body>
	
	<table align="center" border="1">
		<tr>
			<td>이름</td>
			<td><input id="userName"/></td>
		</tr>
		<tr>
			<td>휴대폰번호</td>
			<td><input id="userPhone"/></td>
		</tr>
		<tr>
			<td align="center" colspan="2"><input id="login" type="button" value="로그인" /></td>
		</tr>
	</table>
	
</body>
</html>