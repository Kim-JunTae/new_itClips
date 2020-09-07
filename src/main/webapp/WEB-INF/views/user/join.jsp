<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE HTML>
<html>
<head>
	<title>회원가입</title>
	<meta charset="utf-8" />
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
	<link rel="stylesheet" href="/resources/user/assets/css/main.css" />
	<style>
		.blue_txt{color:#00f; font-weight: bold;}
		.red_txt{color:#f00; font-weight: bold;}
	</style>
</head>
<body class="is-preload">

	<!-- Wrapper -->
	<div id="wrapper">

		<!-- Main -->
		<div id="main">
			<div class="inner">

				<!-- Header -->
				<header id="header">
					<h2><a href="userHome" class="logo">itClips</a>&nbsp;&nbsp;회원가입</h2>
				</header>

				<!-- Content -->
				<section>
					<form id="join_form" method="post" action="join">
						<div class="row gtr-uniform">
						<!-- 아이디 -->
							<div class="col-2 col-12-small">
								<label for="id">아이디</label>
							</div>
							<div class="col-5 col-12-small">
								<input type="text" name="id" id="id" placeholder="id" />
							</div>
							<div class="col-5 col-12-small">
								<p>아이디는 영문, 숫자 조합하여 4~20자 입력가능<br>
								(대소문자 구별, 한글/특수문자 사용불가)</p>
							</div>
							<!-- 아이디 중복 Ajax -->
							<div class="col-2"></div>
							<div class="col-10">
								<span id="idCheckMsg"></span>
							</div>
						<!-- 비밀번호 -->
							<div class="col-2 col-12-small">
								<label for="pw">비밀번호</label>
							</div>
							<div class="col-5 col-12-small">
								<input type="password" name="pw" id="pw" placeholder="pw" />
							</div>
							<div class="col-5 col-12-small">
								비밀번호는 영문,숫자,특수문자를 하나 이상 조합하여<br>
								8~20자 이내로 입력해 주세요.(대소문자 구별)
							</div>
							<!-- 비밀번호 체크 javascript -->
							<div class="col-2"></div>
							<div class="col-10">
								<span id="pwCheckMsg1"></span>
							</div>
							
							<div class="col-2 col-12-small">
								<label for="pw_check">비밀번호 확인</label>
							</div>
							<div class="col-5 col-12-small">
								<input type="password" name="pw_check" id="pw_check" placeholder="pw_check" />
							</div>
							<div class="col-5 col-12-small"></div>
							<!-- 비밀번호 확인 체크 javascript -->
							<div class="col-2"></div>
							<div class="col-10">
								<span id="pwCheckMsg2"></span>
							</div>
						<!-- 닉네임 -->
							<div class="col-2 col-12-small">
								<label for="nickname">닉네임</label>
							</div>
							<div class="col-5 col-12-small">
								<input type="text" name="nickname" id="nickname" placeholder="nickname" />
							</div>
							<div class="col-5 col-12-small">
								닉네임은 최대 10자 이내로 입력해주세요.(한글, 영문, 숫자 가능)
							</div>
							<!-- 닉네임 중복 Ajax -->
							<div class="col-2"></div>
							<div class="col-10">
								<span id="nicknameCheckMsg"></span>
							</div>
						<!-- 이메일 -->
							<div class="col-2 col-12-small">
								<label for="email">이메일</label>
							</div>
							<div class="col-5 col-12-small">
								<input type="text" name="email" id="email" placeholder="예)id@domain.com"/>
							</div>
							<div class="col-5"></div>
							<!-- 이메일 체크 javascript, 정규표현식 -->
							<div class="col-2"></div>
							<div class="col-10">
								<span id="emailCheckMsg"></span>
							</div>
						<!-- 생년월일 -->
							<div class="col-2 col-12-small">
								<label for="birthday">생년월일</label>
							</div>
							<div class="col-5 col-12-small">
								<input type="text" name="birthday" id="birthday" placeholder="예)19920212"/>
							</div>
							<div class="col-5"></div>
							<!-- 생년월일 체크 javascript, 정규표현식 -->
							<div class="col-2"></div>
							<div class="col-10">
								<span id="birthdayCheckMsg"></span>
							</div>
						<!-- 성별 -->
							<div class="col-2 col-12-small">
								<label for="gender">성별</label>
							</div>
							<div class="col-2 col-12-small">
								<input type="radio" id="male" name="gender" value="남성" checked>
								<label for="male">남성</label>
							</div>
							<div class="col-2 col-12-small">
								<input type="radio" id="female" value="여성" name="gender">
								<label for="female">여성</label>
							</div>
							
							<div class="col-12"></div>
							
						<!-- 취향 선택 -->
							<!-- 취향 테이블에서 가져와서 뿌려주기 : 
							CategoryTable, CategoryVO, CategoryDAO, category.xml -->
							<div class="col-2 col-12-small">
								<label for="category">취향선택</label>
							</div>
							<div class="col-10">
								<c:if test="${!empty clist}">
									<c:forEach items="${clist}" var="c">
										<span class="col-2">
											<input type="checkbox" id="${c.getCategory_high()}" class="category" value="${c.getCategory_high()}">
											<label for="${c.getCategory_high()}">${c.getCategory_high()}</label>
										</span>
									</c:forEach>
								</c:if>
							</div>
							
							
						<!-- 이용약관 체크 -->
							<div class="col-12">
								<input type="checkbox" id="user_agreements" class="user_agreements" value="itClips 이용약관 동의">
								<label for="user_agreements">itClips 이용약관 동의 (필수)</label><br>
							</div>
							<div class="box col-12" style="overflow-x:hidden; height:200px;">
								<p>여러분을 환영합니다.</p>
								<P>itClips 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 itClips 서비스의 이용과 관련하여 itClips 서비스를 제공하는 itClips 주식회사(이하 ‘itClips’)와 이를 이용하는 itClips 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 itClips 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.
								   itClips 서비스를 이용하시거나 itClips 서비스 회원으로 가입하실 경우 여러분은 본 약관 및 관련 운영 정책을 확인하거나 동의하게 되므로, 잠시 시간을 내시어 주의 깊게 살펴봐 주시기 바랍니다.
								      다양한 itClips 서비스를 즐겨보세요.</p>
								<p>itClips는 itClips 도메인의 웹사이트를 통해 동영상 콘텐츠 제공, 상품 쇼핑 등 여러분의 생활에 즐거움을 더할 수 있는 다양한 서비스를 제공하고 있습니다.
								      여러분은 PC, 휴대폰 등 인터넷 이용이 가능한 각종 단말기를 통해 각양각색의 itClips 서비스를 자유롭게 이용하실 수 있으며, 개별 서비스들의 구체적인 내용은 각 서비스 상의 안내, 공지사항, itClips 웹고객센터(이하 ‘고객센터’) 도움말 등에서 쉽게 확인하실 수 있습니다.
								   itClips는 기본적으로 여러분 모두에게 동일한 내용의 서비스를 제공합니다. 다만, '청소년보호법' 등 관련 법령이나 기타 개별 서비스 제공에서의 특별한 필요에 의해서 연령 또는 일정한 등급을 기준으로 이용자를 구분하여 제공하는 서비스의 내용, 이용 시간, 이용 횟수 등을 다르게 하는 등 일부 이용을 제한하는 경우가 있습니다. 자세한 내용은 역시 각 서비스 상의 안내, 공지사항, 고객센터 도움말 등에서 확인하실 수 있습니다.
								      회원으로 가입하시면 itClips 서비스를 보다 편리하게 이용할 수 있습니다.</p>
								<p>여러분은 본 약관을 읽고 동의하신 후 회원 가입을 신청하실 수 있으며, itClips는 이에 대한 승낙을 통해 회원 가입 절차를 완료하고 여러분께 itClips 서비스 이용 계정(이하 ‘계정’)을 부여합니다. 계정이란 회원이 itClips 서비스에 로그인한 이후 이용하는 각종 서비스 이용 이력을 회원 별로 관리하기 위해 설정한 회원 식별 단위를 말합니다. 회원은 자신의 계정을 통해 좀더 다양한 itClips 서비스를 보다 편리하게 이용할 수 있습니다. 이와 관련한 상세한 내용은 계정 운영정책 및 고객센터 내 itClips 회원가입 방법 등에서 확인해 주세요.
									....
								</p>
							</div>
						<!-- 설명 -->
							<div class="box col-12">
								<p>
									- 비회원도 itClips 영상들을 보실 수 있습니다.<br>
									- 자신의 동영상을 올리고 싶다면 크리에이터로 가입하세요.
								</p>
							</div>
							
							<!-- 확인된 체크 값-->
							<input type="hidden" id="chk_id">
							<input type="hidden" id="chk_pw">
							<input type="hidden" id="chk_nickname">
							<input type="hidden" id="chk_email">
							
							<!-- 추가해서 보낼 값들 -->
							<input type="hidden" id="checkedCategoryList" name="category" value="">
							<input type="hidden" id="grade" name="grade" value="">
							
							<!-- 회원가입 완료 전 유효성 검사! -->
							<div class="col-12">
								<ul class="actions">
									<li><input type="button" value="크리에이터로 가입" class="primary" onclick="validityCheck(2);"/></li>
									<li><input type="button" value="사용자로 가입" class="primary" onclick="validityCheck(1);"/></li>
									<li><input type="button" value="취소" onclick="history.back(-1);"/></li>
								</ul>
							</div>
							
						</div>
					</form>
				</section>
			</div>
		</div>
	</div>
	

	<!-- Scripts -->
	<script src="/resources/user/assets/js/jquery.min.js"></script>
	<script src="/resources/user/assets/js/browser.min.js"></script>
	<script src="/resources/user/assets/js/breakpoints.min.js"></script>
	<script src="/resources/user/assets/js/util.js"></script>
	<script src="/resources/user/assets/js/main.js"></script>
	<script src="/resources/user/js/join.js"></script>
	</body>
</html>