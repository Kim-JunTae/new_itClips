package com.itClips.controller;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itClips.domain.BoxOfficeVO;
import com.itClips.domain.ReviewVO;
import com.itClips.service.BoxOfficeService;
import com.itClips.service.ReviewService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/movie/*")
@AllArgsConstructor
public class MovieController {
	
	private BoxOfficeService boxOfficeService;
	
	private ReviewService reviewService;
	
	@GetMapping(value="/moviePoster")
	public void moviePoster() {
		log.info("moviePoster");	
	}
	
	@ResponseBody
	@GetMapping(value="/getBoxOfficeJSON", 
	            produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<BoxOfficeVO[]> getBoxOfficeList() throws Exception{
		log.info("getBoxOfficeList");
		
		BoxOfficeVO[] response = boxOfficeService.getBoxOfficeList();
		
		log.info(response);
		return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value="/getChartData",
				produces=MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Map<String, String>>> getChartData(String movieId){
		log.info("MovieController_getChartData");
		
		//test : 영화 반도, 주연 강동원
		movieId = "125372";
		
		List<Map<String, String>> response = new ArrayList<Map<String,String>>();
		
		for(int i=0; i<=10; i++) {
			ReviewVO vo = new ReviewVO();
			vo.setMovieId(movieId);
			vo.setGrade(Integer.toString(i));
			
			Map<String, String> map = new Hashtable<String, String>();
			String reviewCount = reviewService.getChartData(vo);
			map.put("grade", Integer.toString(i));
			map.put("value", reviewCount);
			
			log.info("map 등록 : " + map);
			
			response.add(map);
		}
		
		return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value="/getAvg", 
	            produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String, String>> getAvg(String movieId) throws Exception{
		log.info("MovieController_getAvg");
		
		//test : 영화 반도, 주연 강동원
		movieId = "125372";
		
		Map<String, String> response = new Hashtable<String, String>();
		
		String AvgBeforeFiltering = reviewService.getAvgBeforeFiltering(movieId);
		String AvgAfterFiltering = reviewService.getAvgAfterFiltering(movieId);
		
		response.put("AvgBeforeFilter", AvgBeforeFiltering);
		response.put("AvgAfterFilter", AvgAfterFiltering);
		
		log.info(response);
		
		return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
}
