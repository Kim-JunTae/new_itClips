<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>         
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
<script type="text/javascript">
	<!--검색-->
	function getMovieList(){
		
		if(!$("#keyword").val()){
			alert("영화명을 입력하세요");
			return false;
		}
		
		searchForm.submit();
	}
</script>
  <!-- API문서 : https://github.com/zziuni/d3/wiki/API-Reference -->
  <script src="/resources/d3/js/review_bar_chart.js?v=<%=System.currentTimeMillis() %>"></script>
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
								<input type="button" style="flex: 0.1;" value="전체 영화 관련 YouTube 분석" onclick="location.href='movie/movieChart'">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<form id="searchForm" method="post" action="/movie/list">
									  <input type="text" name="keyword" class="form-control" placeholder="영화 분석 페이지로">
								</form>
								<input type="button" style="flex: 0.1;" id="analysis" value="search" onclick="getMovieList()">
							</header>
						
						<!-- 영화 분석란 : Ajax -->
						<!-- 영화명, 포스터, 개봉일, 누적관객수, 그래프 등  -->
						<section id="banner">
							<div class="content">
								<header>
									<table>
									<tr>
										<td>
											<h2>영화명 : ${title}</h2>
											
											<h5>개봉일 : ${openDt}</h5>
											<h5>누적관객수 : ${audiAcc}명</h5>
											<h5>필터링 전 평점 평균 : <span id="AvgBefore"></span></h5>
											<h5>필터링 후 평점 평균 : <span id="AvgAfter"></span></h5>
											<h5>필터링 후 평점 변화율 : <span id="ChangeRate"></span></h5>
											<!-- <h5>필터링 전 평점 평균 : <input id="AvgBefore" type="text" readonly="readonly" size="2"></h5>
											<h5>필터링 후 평점 평균 : <input id="AvgAfter" type="text" readonly="readonly" size="2"></h5> -->
										</td>
										<td>
											<img src="${src}"/>
										</td>
										<td>
											<!-- 막대 그래프 -->
											<div id="chart" class="content">
												<span id="svg-area">
													<span id="tooltip"></span>
												</span>
											</div>
										</td>
									</tr>
									</table>
								</header>
							</div>
						</section>
					</div>
				</div>
		</div>
		<input type="hidden" id="movieId" value="${movieId}">
		<!-- Scripts -->
		<script src="/resources/user/assets/js/browser.min.js"></script>
		<script src="/resources/user/assets/js/breakpoints.min.js"></script>
		<script src="/resources/user/assets/js/util.js"></script>
		<script src="/resources/user/assets/js/main.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>			 
		<!-- <script src="/resources/user/js/sidebar.js"></script> -->
</body>
</html>