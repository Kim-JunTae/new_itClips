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
import org.springframework.ui.Model;
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
	
	//검색어(영화 명으로 검색) 있을 때 없을 때 구분해서 나타낼것
	@GetMapping(value="/movieList")
	public void movieList(String keyword, Model model) {
		log.info("movieGet : " + keyword);
		BoxOfficeVO[] movieList = boxOfficeService.getMovieList(keyword);
		//검색된 영화 키워드를 통해서 영화명을 찾아서 movieId를 가져온다.
		
		model.addAttribute("movieList", movieList);
	}
	
	@GetMapping(value="/movieGet")
	public void movieGet(BoxOfficeVO vo, Model model) {
		log.info("movieGet : " + vo.getMovieId());
		//log.info("movieGet : " + src);
		//log.info("movieGet : " + title);
		
		BoxOfficeVO newVo = boxOfficeService.check(vo.getMovieId());
		
		//검색된 영화 키워드를 통해서 영화명을 찾아서 movieId를 가져온다.
		// Test 용 : String movieId = "125372";
		
		model.addAttribute("movieId", vo.getMovieId());
		model.addAttribute("src", newVo.getSrc());
		model.addAttribute("title", newVo.getTitle());
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
		log.info("MovieController_getChartData : " + movieId);
		
		String colorList[] = {"#FFA7A7","#FFC19E","#FFE08C","#FAED7D","#CEF279",
							  "#B7F0B1","#B2EBF4","#B2CCFF","#B5B2FF","#D1B2FF","#FFD9EC"};
		
		//test : 영화 반도, 주연 강동원
		//movieId = "125372";
		
		//test : movieId 없을 때 어떻게 나오는지 : 다 0 그래프 안그려짐
		//movieId = "00000";
		
		List<Map<String, String>> response = new ArrayList<Map<String,String>>();
		
		for(int i=0; i<=10; i++) {
			ReviewVO vo = new ReviewVO();
			vo.setMovieId(movieId);
			vo.setGrade(Integer.toString(i));
			
			Map<String, String> map = new Hashtable<String, String>();
			String reviewCount = reviewService.getChartData(vo);
			map.put("grade", Integer.toString(i));
			map.put("value", reviewCount);
			map.put("color", colorList[i]);
			log.info("map 등록 : " + map);
			
			response.add(map);
		}
		
		return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value="/getAvg", 
	            produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<Map<String, String>> getAvg(String movieId) throws Exception{
		log.info("MovieController_getAvg : " + movieId);
		//test : 영화 반도, 주연 강동원
		//movieId = "125372";
		
		//test : movieId 없을 때 어떻게 나오는지
		//movieId = "00000";
		
		Map<String, String> response = new Hashtable<String, String>();
		
		String AvgBeforeFiltering = reviewService.getAvgBeforeFiltering(movieId);
		String AvgAfterFiltering = reviewService.getAvgAfterFiltering(movieId);
		
		response.put("AvgBeforeFilter", AvgBeforeFiltering);
		response.put("AvgAfterFilter", AvgAfterFiltering);
		
		log.info(response);
		
		return new ResponseEntity<>(response, HttpStatus.OK);
	}
	
}
