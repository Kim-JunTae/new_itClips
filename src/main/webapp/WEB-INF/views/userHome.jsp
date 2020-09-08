<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE HTML>
<html>
	<head>
		<title>UserHome</title>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="resources/user/assets/css/main.css"/>
		<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		<!-- owlCarousel 추가 -->
		<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
		<link rel="stylesheet" href="resources/user/owlcarousel/assets/owl.carousel.min.css">
		<link rel="stylesheet" href="resources/user/owlcarousel/assets/owl.theme.default.min.css">	
		<script src="resources/user/owlcarousel/owl.carousel.min.js"></script>

		<style>
			button {
				box-shadow: none;
			}
			
			#owl-demo .item{
	  			margin: 3px;
			}
			
			#owl-demo .item img{
			  display: block;
			  width: 20%;
			  height: auto;
			}
			
			.owl-carousel .owl-video-wrapper {
				height: 200px;
			}
			
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
									<a href="/" class="logo"><strong><span>itClips</span></strong></a>
									<!-- NAV : 영화 목록 보기(three.js), 영화 분석 페이지 -->
									<input type="button" style="flex: 0.1;" value="무비 포스터로!" onclick="location.href='movie/moviePoster'">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									<!-- 로그인 닉네임 체크 -->
									<c:if test="${sessionScope.nickname ne null}">
										<span>${sessionScope.nickname}님 안녕하세요</span>
									</c:if>
									
									<form id="searchForm" method="post" action="/movie/list">
										  <input type="text" name="keyword" class="form-control" placeholder="영화 분석 페이지로">
									</form>
									<input type="button" style="flex: 0.1;" id="analysis" value="search">
								</header>
							
							<!-- Banner : Ajax -->
								<section>
									<!-- <header class="major">
										<h2>BoxOffice</h2>
									</header> -->
									<ul class="actions">
										<li><header class="major" style="height: 4em;"><h2>BoxOffice</h2></header></li>
										<li>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</li>
										<li><span id="weeklyBtn" class="button primary" onclick="getWeekly()">주간</span></li>
										<li><span id="monthlyBtn" class="button" onclick="getMonthly()">월간</span></li>
										<li><span id="yearlyBtn" class="button" onclick="getYearly()">연간</span></li>
									</ul>
									<!-- <div id="boxOffice" class="carousel slide" data-ride="carousel" style="background-image:url('resources/images/pic01.jpg')"></div> -->
									
									<div id="boxOffice" class="owl-carousel owl-theme">
										<div class="item" style="width:100%"><h4 class="badge badge-primary">1</h4><img id="item0" src="#" onclick="searchYouTube(0); searchReview(0);"><input id="title0" type="hidden" value=""></div>
										<div class="item" style="width:100%"><h4 class="badge badge-primary">2</h4><img id="item1" src="#" onclick="searchYouTube(1); searchReview(1);"><input id="title1" type="hidden" value=""></div>
										<div class="item" style="width:100%"><h4 class="badge badge-primary">3</h4><img id="item2" src="#" onclick="searchYouTube(2); searchReview(2);"><input id="title2" type="hidden" value=""></div>
										<div class="item" style="width:100%"><h4 class="badge badge-light">4</h4><img id="item3" src="#" onclick="searchYouTube(3); searchReview(3);"><input id="title3" type="hidden" value=""></div>
										<div class="item" style="width:100%"><h4 class="badge badge-light">5</h4><img id="item4" src="#" onclick="searchYouTube(4); searchReview(4);"><input id="title4" type="hidden" value=""></div>
										<div class="item" style="width:100%"><h4 class="badge badge-light">6</h4><img id="item5" src="#" onclick="searchYouTube(5); searchReview(5);"><input id="title5" type="hidden" value=""></div>
										<div class="item" style="width:100%"><h4 class="badge badge-light">7</h4><img id="item6" src="#" onclick="searchYouTube(6); searchReview(6);"><input id="title6" type="hidden" value=""></div>
										<div class="item" style="width:100%"><h4 class="badge badge-light">8</h4><img id="item7" src="#" onclick="searchYouTube(7); searchReview(7);"><input id="title7" type="hidden" value=""></div>
										<div class="item" style="width:100%"><h4 class="badge badge-light">9</h4><img id="item8" src="#" onclick="searchYouTube(8); searchReview(8);"><input id="title8" type="hidden" value=""></div>
										<div class="item" style="width:100%"><h4 class="badge badge-light">10</h4><img id="item9" src="#" onclick="searchYouTube(9); searchReview(9);"><input id="title9" type="hidden" value=""></div>
									</div>
								</section>
								
							<!-- Section -->
								<section>
									<header class="major" style="height: 4em;">
										<h2>관련 YouTube</h2>
									</header>
									<div id="youTube"><!-- 420, 314 -->
									    <iframe id="video0" src="" width="420" height="314"></iframe>
									    <iframe id="video1" src="" width="420" height="314"></iframe>
									    <iframe id="video2" src="" width="420" height="314"></iframe>
									    <!--<iframe id="video3" src="" width="420" height="314"></iframe>
									    <iframe id="video4" src="" width="420" height="314"></iframe>
									    <iframe id="video5" src="" width="420" height="314"></iframe>
									    <iframe id="video6" src="" width="420" height="314"></iframe>
									    <iframe id="video7" src="" width="420" height="314"></iframe>
									    <iframe id="video8" src="" width="420" height="314"></iframe>
									    <iframe id="video9" src="" width="420" height="314"></iframe> -->
									</div>
								</section>
							<!-- Section -->
								<section>
									<header class="major" style="height: 4em;">
										<h2>최근 리뷰</h2>
									</header>
									<div class="posts">
										<article>
											<div class="box">
												<p id="review0"> 리뷰1 </p>
											</div>
										</article>
										<article>
											<div class="box">
												<p id="review1"> 리뷰2 </p>
											</div>
										</article>
										<article>
											<div class="box">
												<p id="review2"> 리뷰3 </p>
											</div>
										</article>
										<article>
											<div class="box">
												<p id="review3"> 리뷰4 </p>
											</div>
										</article>
										<article>
											<div class="box">
												<p id="review4"> 리뷰5 </p>
											</div>
										</article>
										<article>
											<div class="box">
												<p id="review5"> 리뷰6 </p>
											</div>
										</article>
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

			<script>
				$(document).ready(function(){ 
					    // 로딩되기 시작할때
						$.ajax({
							url: "boxOfficeJSON1",
							type: "GET",
							dataType: "JSON",
							async: false
							
						}).done(function(data){
							//console.log(data);
							
							for(var i=0; i<data.length; i++){
								var item = "item" + i;
								var title = "title" + i;
								//console.log(item);
								//console.log(title);
								
								var image = document.getElementById(item);
								var input = document.getElementById(title);
								
								image.src = data[i].src;
								input.value = data[i].title;
								
								//console.log(image);
								//console.log(input);
							} 
	
							//console.log(data);
						}).fail(function(err){
							console.log(err);
						});
					    
					    //로딩될 때 가장 첫번째 박스오피스 영화 유튜브영상 밑에 뿌려주기
					    searchYouTube(0);
					    searchReview(0);
				});
				
				function searchReview(number){
					var title = "title" + number;
					//영화 제목 가져오기
					var search = document.getElementById(title).value;
					//1. 영화 제목으로 ITCLIPS_BOXOFFICE 테이블에서 movieId 가져오기
					$.ajax({
					  	url: "reviewJSON",
						type: "GET",
						data: "searchTitle="+encodeURIComponent(search),
						dataType: "JSON",
						asynce: false
						
					  }).done(function(data){
						console.log(data);
						//2. movideId로 ITCLIPS_REVIEW의 최신(REVIEW_DATE가 최근이고, 내용이 null이 아닌 것)내용 가져오기
						  for(var i=0; i<6; i++){
							  var review = "review" + i;
							  var content = data[i].netizenName+"&nbsp;&nbsp;&nbsp;";
							  	  content += data[i].grade + "/10 <br>"
							  	  content += data[i].review + "<br>"
							  	  content += data[i].reviewDate;
							  console.log(content);
							  
							  document.getElementById(review).innerHTML = content;
						  }
						
					  }).fail(function(err){
						 console.log(err); 
					  });
					//2. movideId로 ITCLIPS_REVIEW의 최신(REVIEW_DATE가 최근이고, 내용이 null이 아닌 것)내용 가져오기
					//3. review0~3 내용 바꿔주기
					
				}
				
				function searchYouTube(number) {
					  var title = "title" + number;
					  //console.log(title);
					  //title[number]에 해당하는 값을 넘겨주기
					  
					  var search = document.getElementById(title).value;
					  //console.log(search);
					  
					  $.ajax({
					  	url: "getYouTubeList",
						type: "GET",
						data: "searchTitle="+encodeURIComponent(search),
						dataType: "JSON",
						asynce: false
						
					  }).done(function(data){
						  //console.log(data);
						  for(var i=0; i<data.length; i++){
							  var video = "video"+i;
							  //console.log(video);
							  //console.log(youTube);
							  
							  var address = "https://www.youtube.com/embed/" + data[i].videoId;
							  //console.log(data[i].videoId);
							  //console.log(address);
							  
							  document.getElementById(video).setAttribute('src', address);
						  }
						  
					  }).fail(function(err){
						 console.log(err); 
					  });
				}
				
				function getWeekly(){
					document.getElementById("weeklyBtn").className="button large primary";
					document.getElementById("monthlyBtn").className="button large";
					document.getElementById("yearlyBtn").className="button large";
					
					$.ajax({
						url: "boxOfficeJSON1",
						type: "GET",
						dataType: "JSON",
						async: false
						
					}).done(function(data){
						//console.log(data);
						
						for(var i=0; i<data.length; i++){
							var item = "item" + i;
							var title = "title" + i;
							//console.log(item);
							//console.log(title);
							
							var image = document.getElementById(item);
							var input = document.getElementById(title);
							
							image.src = data[i].src;
							input.value = data[i].title;
							
							//console.log(image);
							//console.log(input);
						} 

						//console.log(data);
					}).fail(function(err){
						console.log(err);
					});
				}
				
				function getMonthly(){
					document.getElementById("weeklyBtn").className="button large";
					document.getElementById("monthlyBtn").className="button large primary";
					document.getElementById("yearlyBtn").className="button large";
					
					$.ajax({
						url: "boxOfficeJSON2",
						type: "GET",
						dataType: "JSON",
						async: false
						
					}).done(function(data){
						//console.log(data);
						
						for(var i=0; i<data.length; i++){
							var item = "item" + i;
							var title = "title" + i;
							//console.log(item);
							//console.log(title);
							
							var image = document.getElementById(item);
							var input = document.getElementById(title);
							
							image.src = data[i].src;
							input.value = data[i].title;
							
							//console.log(image);
							//console.log(input);
						} 

						//console.log(data);
					}).fail(function(err){
						console.log(err);
					});
				}
				
				function getYearly(){
					document.getElementById("weeklyBtn").className="button large";
					document.getElementById("monthlyBtn").className="button large";
					document.getElementById("yearlyBtn").className="button large primary";
					
					$.ajax({
						url: "boxOfficeJSON3",
						type: "GET",
						dataType: "JSON",
						async: false
						
					}).done(function(data){
						//console.log(data);
						
						for(var i=0; i<data.length; i++){
							var item = "item" + i;
							var title = "title" + i;
							//console.log(item);
							//console.log(title);
							
							var image = document.getElementById(item);
							var input = document.getElementById(title);
							
							image.src = data[i].src;
							input.value = data[i].title;
							
							//console.log(image);
							//console.log(input);
						} 

						//console.log(data);
					}).fail(function(err){
						console.log(err);
					});
				}
			</script>
			
			
			
			<script>
				(function($) {$(document).ready(function(){
					var owl = $('.owl-carousel');
					
					owl.owlCarousel({
					    loop:true,
					    margin:10,
					    nav:true,
					    responsive:{
					        0:{
					            items:1
					        },
					        600:{
					            items:3
					        },
					        960:{
					            items:5
					        },
					        1200:{
					        	items:6
					        }
					    }
					});
					
					owl.on('mousewheel', '.owl-stage', function (e){
						if (e.deltaY>0) {
					        owl.trigger('next.owl');
					    } else {
					        owl.trigger('prev.owl');
					    }
					    e.preventDefault();
					});
					});
				})(jQuery);
			</script>
			<!-- Scripts -->
			<script src="resources/user/assets/js/browser.min.js"></script>
			<script src="resources/user/assets/js/breakpoints.min.js"></script>
			<script src="resources/user/assets/js/util.js"></script>
			<script src="resources/user/assets/js/main.js"></script>
		
			<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
			<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>			 
			<script src="resources/user/js/sidebar.js"></script>
	</body>
</html>