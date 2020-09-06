/**
 *  회원가입(join.jsp) 자바스크립트
 */
	// 정규식
	var regId = RegExp(/^[A-Za-z0-9]{4,20}$/);
	var regPw = RegExp(/^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^*()\-_=+\\\|\[\]{};:\,.<>\/?]).{8,20}$/);
	var regNickname = RegExp(/^[가-힣A-Za-z0-9]{1,10}$/);
	//var regEmail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+$/);
	var regEmail = RegExp(/^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i);
	var regBirthday = RegExp(/^(19|20)[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/);

	//유효성 검사
	function validityCheck(grade) {
		//사용자로 가입하는 지 크리에이터로 가입하는지 확인
		var user_Grade = grade;
		$("#grade").val(grade);
		console.log('grade', $("#grade").val());
		
		//아이디 공백확인
		if($("#id").val() == ""){
			//alert("아이디를 입력해주세요");
			$("#idCheckMsg").html("<span class='red_txt'>필수 정보입니다.</span>");
		}
		
		//비밀번호 공백 확인
		if($("#pw").val() == ""){
			//alert("패스워드를 입력해주세요");
			$("#pwCheckMsg1").html("<span class='red_txt'>필수 정보입니다.</span>");
		}
		if($("#pw_check").val() == ""){
			//alert("패스워드 확인을 입력해주세요");
			$("#pwCheckMsg2").html("<span class='red_txt'>필수 정보입니다.</span>");
		}
		
		//닉네임 공백 검사
		if($("#nickname").val() == ""){
			//alert("닉네임을 입력해 주세요");
			///$("#nickname").focus();
			$("#nicknameCheckMsg").html("<span class='red_txt'>필수 정보입니다.</span>");
		}
		
		//이메일 공백 검사
		if($("#email").val() == ""){
			//alert("이메일을 입력해 주세요");
			//$("#email").focus();
			$("#emailCheckMsg").html("<span class='red_txt'>필수 정보입니다.</span>");
		}
		
		//생년월일 공백 검사
		if($("#birthday").val() == ""){
			//alert("생년월일을 입력해 주세요");
			//$("#birthday").focus();
			$("#birthdayCheckMsg").html("<span class='red_txt'>필수 정보입니다.</span>");
		}
		
		//아이디 유효성검사1 : 정규식 검사
		if(!regId.test($("#id").val())){
			alert("아이디는 영문, 숫자 조합하여 4~20자 입력가능합니다.");
			$("#id").val("");
			$("#id").focus("");
			return false;
		}
		//아이디 유효성검사2 : 중복 검사
		if($("#chk_id").val() == "0"){
			alert("중복된 아이디가 존재합니다.");
			return false;
		}
		
		//아이디 비밀번호 같음 확인
		if($("#id").val() == $("#pw").val()){
			alert("아이디와 비밀번호가 같습니다.");
			$("#pw").val("");
			$("#pw").focus("");
			return false;
		}
		
		//비밀번호 유효성 검사
		if(!regPw.test($("#pw").val())){
			alert("비밀번호는 영문,숫자,특수문자를 하나 이상 조합하여 8~20자 이내로 입력해 주세요.");
			$("#pw").val("");
			$("#pw").focus();
			return false;
		}
		
		//비밀번호 서로 확인
		if($("#pw").val() != $("#pw_check").val()){
			alert("비밀번호가 같지 않습니다.");
			$("#pw").val("");
			$("#pw_check").val("");
			$("#pw").focus();
			return false;
		}
		
		//닉네임 유효성 검사1 : 정규식 검사
		if(!regNickname.test($("#nickname").val())){
			alert("닉네임은 한글, 영문, 숫자로 조합하여 최대 10자 이내로 가능합니다.");
			$("#nickname").val("");
			$("#nickname").focus();
			return false;
		}
		//닉네임 유효성 검사2 : 중복 검사
		if($("#chk_nickname").val() == "0"){
			alert("중복된 닉네임이 존재합니다.");
			return false;
		}
		
		//이메일 유효성 검사1: 정규식 검사
		if(!regEmail.test($("#email").val())){
			alert("이메일 양식을 확인해주세요.");
			$("#email").val("");
			$("#email").focus("");
			return false;
		}
		//이메일 유효성 검사2: 중복
		if($("#chk_email").val() == "0"){
			alert("중복된 이메일이 존재합니다.");
			return false;
		}
		
		//생년월일 유효성 검사
		if(!regBirthday.test($("#birthday").val())){
			alert("생년월일 양식을 확인해주세요.");
			$("#birthday").val("");
			$("#birthday").focus("");
			return false;
		}
		
		//취향 체크 유효성 검사(최소 1개이상 체크)
		var checkedArray = Array();
		var checkedCount = 0;
		var checkBox = $(".category");
		
		for(i=0; i<checkBox.length; i++){
			if(checkBox[i].checked == true){
				checkedArray[checkedCount] = checkBox[i].value;
				checkedCount++;
			}
		}
		
		if(checkedCount == 0){
			alert("적어도 한 개 이상의 카테고리를 선택해주세요.");
			return false;
		}
		//console.log('checkedArray', checkedArray);
		
		//[중요] 배열값들을 VO에 넣을 category 값으로 넣는다.
		var categoryList = checkedArray.join();
		console.log('categoryList', categoryList);
		
		$("#checkedCategoryList").val(categoryList);
	
		//이용약관 동의 유효성 검사
		var AgreeCheckBox = $(".user_agreements");
		if(AgreeCheckBox.checked == false){
			alert("itClips 이용약관에 동의해주세요.");
			return false;
		}
		
		//alert("회원가입 완료!");
		$("#join_form").submit();
	}
	
	//중복 검사
	$(function(){
		//아이디 중복 체크
		//아이디가 id인 요소에서 입력된 문자가 4자 이상 입력 시 서버에 비동기식 호출을 수행한다.
		$("#id").bind("keyup", function(){
			//id에 입력된 자원 가져오기
			var id = $(this).val();
			
			//아이디 유효성 체크
			if(id.length >= 4){
				//비동기식 통신을 수행
				$.ajax({
					url: "checkId",
					type: "POST",
					data: "id="+encodeURIComponent(id),
					dataType: "JSON"
					
				}).done(function(data){
					$("#idCheckMsg").html(data.res);
					$("#chk_id").val(data.chk);
				}).fail(function(err){
					console.log(err);
				});
			}else if(id.length > 20){
				$("#idCheckMsg").html("<span class='red_txt'>아이디 사용불가(글자 수 초과)</span>");
			}else{
				//아이디가 msg인 요소의 내용을 지워야한다.(초기화한다)
				$("#idCheckMsg").html("");
			}
		});
		
		//닉네임 중복 체크
		$("#nickname").bind("keyup", function(){
			//닉네임에 입력된 자원 가져오기
			var nickname = $(this).val();
			
			//닉네임 입력여부 확인
			if(nickname.length > 0 && nickname.length <= 10){
				//비동기식 통신을 수행
				$.ajax({
					url: "checkNickname",
					type: "POST",
					data: "nickname="+encodeURIComponent(nickname),
					dataType: "JSON"
					
				}).done(function(data){
					$("#nicknameCheckMsg").html(data.res);
					$("#chk_nickname").val(data.chk);
					
					if($("#chk_nickname").val() == 1){
						$("#nickname").focus();
					}
				}).fail(function(err){
					console.log(err);
				});
			}else if(nickname.length > 10){
				$("#nicknameCheckMsg").html("<span class='red_txt'>닉네임 사용불가(글자 수 초과)</span>");
			}else{
				//닉네임의 msg인 요소의 내용을 지워야한다.(초기화한다)
				$("#nicknameCheckMsg").html("");
			}
		});
		
		//이메일 중복 체크
		$("#email").bind("keyup", function(){
			//이메일에 입력된 자원 가져오기
			var email = $(this).val();
			
			//이메일 입력 여부 확인
			if(email.length > 0){
				//이메일 유효성 검사
				if(!regEmail.test(email)){
					//비동기식 통신을 수행
					$.ajax({
						url: "checkEmail",
						type: "POST",
						data: "email="+encodeURIComponent(email),
						dataType: "JSON"
						
					}).done(function(data){
						$("#emailCheckMsg").html(data.res);
						$("#chk_email").val(data.chk);
						
						if($("#chk_email").val() == 1){
							$("#email").focus();
						}
					}).fail(function(err){
						console.log(err);
					});
				}
			}else{
				//아이디가 msg인 요소의 내용을 지워야한다.(초기화한다)
				$("#emailCheckMsg").html("");
			}
		});
	});