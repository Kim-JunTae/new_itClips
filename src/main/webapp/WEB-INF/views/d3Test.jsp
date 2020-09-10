<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <meta http-equiv="X-UA-Compatible" content="ie=edge" />
  <title>D3-Test : Chart example</title>
  <script src="https://code.jquery.com/jquery-3.5.1.js"></script>
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
	<h2>각 평점(0~10)에 따른 리뷰 수 _ 막대 그래프</h2>
	<hr>
	<h4>영화명 : 반도</h4>
	<h4>주연 : 강동원</h4>
	<h4>필터링 전 평점 평균 : <input id="AvgBefore" type="text" readonly="readonly" size="2"></h4>
	<h4>필터링 후 평점 평균 : <input id="AvgAfter" type="text" readonly="readonly" size="2"></h4>	
	<p>
		필터링 기준<br>
		1.리뷰 길이가 5글자 이상일 것<br>
		2.리뷰 작성일이 개봉일 후인 리뷰만(적용 중 ㅠㅠ)<br>
		현재 문제점<br>
		review의 날짜 형식은 웹 크롤링이라 [2019.08.19, 09:33]으로 저장<br>
		동시에 개봉일은 KOFIC(영화관OPEN API)에서 저장하게 되어있는데<br> 
		두 테이블에서 BoxOffice 테이블의 기본키 movieId로 관계가 정해져 있으나 없는 영화도 많다. 
	</p>
	<div id="svg-area">
      <div id="tooltip"></div>
    </div>
</body>
</html>