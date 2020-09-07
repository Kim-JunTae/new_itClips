package com.itClips.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.itClips.domain.YouTubeVO;
import com.itClips.service.BoxOfficeService;
import com.itClips.service.YouTubeService;
import com.itClips.util.YouTube_API;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
public class YoutubeController {

	private BoxOfficeService boxOfficeService;
	
	private YouTubeService service;
	
	@ResponseBody
	@GetMapping(value="/searchYouTube", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Map<String, String>>> searchYoutube(String searchTitleName) throws Exception{
		
		YouTube_API youtube = new YouTube_API();
		
		List<Map<String, String>> result = youtube.search(searchTitleName);
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	//작업해야할것
	//유튜브에서 검색한 내용을 DB에 spring.util의 Scheduler에서 DB에 저장하였고
	//userHome.jsp에서 boxoffice의 영화 포스터를 클릭하거나 검색하였을 때
	//DB의 YouTube 테이블에 접근하여 가져오는 함수이다.
	
	@ResponseBody
	@GetMapping(value="/getYouTubeList", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<YouTubeVO[]> getYouTubeList(String searchTitle) throws Exception{
		
		//title을 받아서 boxOffice 테이블에서 검색하여 movieId 값을 받아서 YouTube 테이블로 가야된다.
		String movieId = boxOfficeService.getMovieId(searchTitle);
		
		YouTubeVO[] result = service.getYouTubeList(movieId);
		//문제점 : vo배열로 주어도 JSON으로 표현이 될까? : 확인하려면? => 표현됨
		
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
}
