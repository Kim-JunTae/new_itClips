package com.itClips.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.itClips.domain.ReviewVO;
import com.itClips.service.BoxOfficeService;
import com.itClips.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
public class ReviewController {
	
	private ReviewService service;
	
	private BoxOfficeService boxOfficeService;
	
	@ResponseBody
	@GetMapping(value="/reviewJSON",
			    produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ReviewVO[]> reviewJSON(String searchTitle) throws Exception{
		log.info("searchTitle : " + searchTitle);
		
		String movieId = boxOfficeService.getMovieId(searchTitle);
		log.info("movieId : " + movieId);
		ReviewVO[] result = service.reviewJSON(movieId);
		
//		ReviewVO[] reviewList = service.reviewJSON(movieId);
//		List<ReviewVO> resultList = new ArrayList<ReviewVO>();
//		ReviewVO[] result = null;
//		
//		//6개만 보내기
//		for(int i=0; i < 6; i++) {
//			resultList.add(reviewList[i]);
//		}
//		
//		resultList.toArray(result);
		
		return new ResponseEntity<ReviewVO[]>(result, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value="/getReviewList",
	            produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<ReviewVO[]> getReviewList(String searchTitle) throws Exception{
		log.info("searchTitle : " + searchTitle);
		
		String movieId = boxOfficeService.getMovieId(searchTitle);
		log.info("movieId : " + movieId);
		
		ReviewVO[] result = service.getReviewList(movieId);
		
		return new ResponseEntity<ReviewVO[]>(result, HttpStatus.OK);
	}
	
}
