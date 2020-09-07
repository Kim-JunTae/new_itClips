/**
 *  sidebar 자바스크립트
 */
// 회원 가입 페이지로
function goJoinPage() {
	location.href="/user/join";
}
	
// 로그인 검사
$(function(){
	$("#loginBtn").click(function(){
		var user_id = $("#id").val();
		var user_pw = $("#pw").val();
		var data = "id=" + user_id + "&pw=" + user_pw;
		//유효성검사
		if(user_id == ""){
			alert("아이디를 입력해주세요");
			$("#id").focus();
            return;
		}
		
		if(user_pw == ""){
			alert("패스워드를 입력해주세요");
			$("#pw").focus();
            return;
		}
		
		//alert(data);
		
		$.ajax({
			url: "checkLogin",
			type: "POST",
			data: data,
			dataType: "JSON"
		}).done(function(data){
			var chk = data.chk;
			if(chk != 0){
				$("#result").html(data.res);
				return;
			}else{
				location.href="userHome";
			}
		}).fail(function(err){
			console.log(err);
		});
	});
});