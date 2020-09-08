package com.itClips.controller;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.itClips.domain.BoxOfficeVO;
import com.itClips.service.BoxOfficeService;
import com.itClips.util.Jsoup;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@AllArgsConstructor
public class BoxOfficeController {

	private BoxOfficeService service;
	
	@GetMapping(value="/boxOfficeJSON1",
				produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Map<String, String>>> searchWeeklyBoxOffice() throws Exception{
		log.info("searchWeeklyBoxOffice...");
		Jsoup jsoup = new Jsoup();
		List<Map<String, String>> result = jsoup.searchWeeklyBoxOffice();
		
		//System.out.println(result);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value="/boxOfficeJSON2", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Map<String, String>>> searchMonthlyBoxOffice() throws Exception{
		log.info("searchMonthlyBoxOffice");
		Jsoup jsoup = new Jsoup();
		List<Map<String, String>> result = jsoup.searchMonthlyBoxOffice();
		
		//System.out.println(result);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}

	@ResponseBody
	@GetMapping(value="/boxOfficeJSON3", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<Map<String, String>>> searchYearlyBoxOffice() throws Exception{
		log.info("searchYearlyBoxOffice");
		Jsoup jsoup = new Jsoup();
		List<Map<String, String>> result = jsoup.searchYearlyBoxOffice();
		
		//System.out.println(result);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
	
	@ResponseBody
	@GetMapping(value="/getBoxOfficeJSON", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<BoxOfficeVO[]> getBoxOfficeList() throws Exception{
		log.info("getBoxOfficeList");
		BoxOfficeVO[] result = service.getBoxOfficeList();
		
		//System.out.println(result);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
}
