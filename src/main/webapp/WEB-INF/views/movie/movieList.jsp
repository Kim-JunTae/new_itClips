<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 검색 목록 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link rel="stylesheet" href="/resources/user/assets/css/main.css"/>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script type="text/javascript">
	<!--검색-->
	function getMovieList(){
		
		if(!$("#keyword").val()){
			alert("영화명을 입력하세요");
			return false;
		}
		
		searchForm.submit();
	}
	
	<!--영화 분석 페이지로 이동-->
	function getMovie(movieId){
		var searchId = movieId;
		//var searchSrc = src;
		//var searchTitle = title;
		
		console.log(searchId);
		//console.log(searchSrc);
		//console.log(searchTitle);
		
		$("#getMovieId").val(searchId);
		//$("#getSrc").val(searchSrc);
		//$("#getTitle").val(searchTitle);
		
		var actionForm = $('#goGetMovie');
		actionForm.submit();
	}
</script>
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
								<form id="searchForm" method="get" action="/movie/movieList">
									<input type="text" id="keyword" name="keyword" class="form-control" placeholder="영화 분석 페이지로">
										  
								</form>
									<input type="button" id="analysis" style="flex: 0.1;" value="search" onclick="getMovieList()">
							</header>
							
							<section id="banner">
								<div class="table-wrapper">
									<header class="major"><h2>검색된 영화 목록</h2></header>
									<table>
										<thead>
											<tr>
												<th>영화 포스터</th>
												<th>영화 제목</th>
												<!-- <th>영화 id값</th> -->
											</tr>
										</thead>
										<c:if test="${movieList ne null}">
										
										<c:forEach items="${movieList}" var="movie">
											<tr>
												<td><img src="${movie.src}" style="width: 50%"/></td>
												<td>
													<a class="move" href='javascript:getMovie(${movie.movieId});'>
														<c:out value="${movie.title}"/>
													</a>
												</td>
												<%-- <td>${movie.movieId}</td> --%>
											</tr>
										</c:forEach>
										</c:if>
									</table>
								</div>
								
								<c:if test="${movieList eq null}">
									<h6>해당 키워드에 해당하는 영화가 DB에 존재하지 않습니다.</h6>
									<span>검색가능한 영화 리스트 목록 뿌려주기(키워드로 영화 검색했는데 없을 시)</span>
								</c:if>
							</section>
					</div>
				</div>
			</div>
			<form id="goGetMovie" method="get" action="/movie/movieGet">
				<input type="hidden" id="getMovieId" name="movieId" value="#">
				<!-- <input type="hidden" id="getSrc" name="src" value="#"> -->
				<!-- <input type="hidden" id="getTitle" name="title" value="#"> -->
			</form>
		<!-- Scripts -->
		<script src="/resources/user/assets/js/browser.min.js"></script>
		<script src="/resources/user/assets/js/breakpoints.min.js"></script>
		<script src="/resources/user/assets/js/util.js"></script>
		<script src="/resources/user/assets/js/main.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
		<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>	
</body>
</html>