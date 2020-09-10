<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 분석 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link rel="stylesheet" href="/resources/user/assets/css/main.css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://d3js.org/d3.v5.min.js"></script>
  <!-- API문서 : https://github.com/zziuni/d3/wiki/API-Reference -->
  <script src="/resources/d3/js/review_bar_chart.js"></script>
  <style type="text/css">
  	#svg-area {
  		position: relative;
	}
	
	#tooltip {
	  position: absolute;
	  opacity: 0;
	  width: 40px;
	  height: 20px;
	  line-height: 20px;
	  transition: all 0.3s;
	  border-radius: 5px;
	  text-align: center;
	  color: #fff;
	  font-size: 14px;
	  font-weight: bold;
	}
  </style>
</head>
<body>
	<!-- Wrapper -->
		<div id="wrapper">

			<!-- Main -->
				<div id="main">
					<div class="inner">

						<!-- Header -->
							<header id="header">
								<a href="/" class="logo"><strong><span>itClips</span></strong></a>
								<!-- NAV : 영화 목록 보기(three.js), 영화 분석 페이지 -->
								<input type="button" style="flex: 0.1;" value="무비 포스터로!" onclick="location.href='/movie/moviePoster'">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								
								<form id="searchForm" method="post" action="/movie/list">
									  <input type="text" name="keyword" class="form-control" placeholder="영화 분석 페이지로">
								</form>
								<input type="button" style="flex: 0.1;" id="analysis" value="search">
							</header>
						
						<!-- 영화 분석란 : Ajax -->
						<!-- 영화명, 포스터, 개봉일, 누적관객수, 그래프 등  -->
						<section id="banner">
							<div class="content">
								<header>
									<h2>영화명</h2>
									<h5>개봉일</h5>
									<h5>누적관객수</h5>
									<h5>필터링 전 평점 평균 : <input id="AvgBefore" type="text" readonly="readonly" size="2"></h5>
									<h5>필터링 후 평점 평균 : <input id="AvgAfter" type="text" readonly="readonly" size="2"></h5>
								</header>
							</div>
							<span class="image object">
								<img src="/resources/user/images/pic10.jpg" alt="포스터" />
							</span>
						</section>	
						<section id="chart">
							<div class="content">
								<div id="svg-area">
							      <div id="tooltip"></div>
							    </div>
							</div>
						</section>	
					</div>
				</div>

			<!-- Sidebar -->
				<div id="sidebar">
					<div class="inner">

						<!-- Menu -->
							<nav id="menu">
								<header class="major">
									<h2>Quick Menu</h2>
								</header>
								<ul>
									<li><a href="" class="icon solid fa-home">&nbsp;&nbsp;Home</a></li>
									<li>
										<c:choose>
											<c:when test="${sessionScope.nickname eq null}">
												<a href="javascript:modal(0)" class="icon solid fa-sign-in-alt" data-toggle="modal" data-target="#loginModal">&nbsp;&nbsp;Login</a>
											</c:when>
											<c:when test="${sessionScope.nickname ne null}">
												<a href="logout" class="icon solid fa-sign-out-alt">&nbsp;&nbsp;Logout</a>
											</c:when>
										</c:choose>
									</li>
									<li><a href="myPage" class="icon solid fa-user-cog">&nbsp;&nbsp;MyPage</a></li>
									<li><a href="javascript:modal(1)" class="icon solid fa-bell" data-toggle="modal" data-target="#alertModal">&nbsp;&nbsp;Alert</a></li>
									<li><a href="javascript:modal(2)" class="icon solid fa-share-alt" data-toggle="modal" data-target="#shareModal">&nbsp;&nbsp;Share</a></li>
									<li><a href="support" class="icon solid fa-question-circle">&nbsp;&nbsp;Support</a></li>
								</ul>
							</nav>

						<!-- Footer -->
							<footer id="footer">
								<p class="copyright">&copy; itClips. All rights reserved.</p>
							</footer>
					</div>
				</div>
		</div>

		<!-- Modal -->
		<!-- loginModal -->
		<div class="modal fade" id="loginModal" tabindex="-1" role="dialog" aria-labelledby="loginModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">Login</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="height: auto; box-shadow: inset 0 0 0 0px;">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      	<form id="login_form">
					<div class="form-group">
					    <label for="userId">ID</label>
					    <input type="text" class="form-control" id="id" name="id" placeholder="아이디를 입력하세요">
				  	</div>
				  	
				  	<div class="form-group">
					    <label for="userPw">PW</label>
					    <input type="password" class="form-control" id="pw" name="pw" placeholder="패스워드를 입력하세요">
				  	</div>
				  	
				  	<div class="form-group form-check">
					    <input type="checkbox" class="form-check-input" id="rememberIdCheck">
					    <label class="form-check-label" for="rememberIdCheck">Remember id</label>
				  	</div>
				  	
				  	<div id="result">로그인 실패 시 출력 영역</div>
				</form>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="button" data-dismiss="modal" onclick="goJoinPage()">Join</button>
		        <button type="button" class="button" data-dismiss="modal">아이디/비밀번호 찾기</button>
		        <button type="button" class="button primary" id="loginBtn">Login</button>
		      </div>
		    </div>
		  </div>
		</div>		

		<!-- alertModal -->
		<div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-labelledby="alertModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">알림메시지</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="height: auto; box-shadow: inset 0 0 0 0px;">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
		      	<!--문의 결과-->
				<article>
					문의결과입니다.
				</article>
				
				<!--신고 결과-->
				<article>
					신고결과입니다.
				</article>
				
				<!--새로운 공지-->
				<article>
					공지사항입니다.
				</article>
		      </div>
		    </div>
		  </div>
		</div>

		<!-- ShareModal2 -->
		<div class="modal fade" id="shareModal" tabindex="-1" role="dialog" aria-labelledby="shareModalLabel" aria-hidden="true">
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title">공유</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close" style="height: auto; box-shadow: inset 0 0 0 0px;">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">
				<div class="input-group mb-3">
				  <input type="text" class="form-control" value="http://localhost:8080/userHome">
				  <div class="input-group-append">
				    <button class="button" type="button" id="button-addon2">복사</button>
				  </div>
				</div>
		      </div>
		    </div>
		  </div>
		</div>
		<!-- Scripts -->
		<script src="/resources/user/assets/js/browser.min.js"></script>
		<script src="/resources/user/assets/js/breakpoints.min.js"></script>
		<script src="/resources/user/assets/js/util.js"></script>
		<script src="/resources/user/assets/js/main.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>			 
		<script src="/resources/user/js/sidebar.js"></script>
</body>
</html>