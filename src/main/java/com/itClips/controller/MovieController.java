package com.itClips.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itClips.domain.BoxOfficeVO;
import com.itClips.service.BoxOfficeService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/movie/*")
@AllArgsConstructor
public class MovieController {
	
	private BoxOfficeService service;
	
	@GetMapping(value="/moviePoster")
	public void moviePoster() {
		log.info("moviePoster");	
	}
	
	@ResponseBody
	@GetMapping(value="/getBoxOfficeJSON", 
	            produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<BoxOfficeVO[]> getBoxOfficeList() throws Exception{
		log.info("getBoxOfficeList");
		
		BoxOfficeVO[] result = service.getBoxOfficeList();
		
		log.info(result);
		return new ResponseEntity<>(result, HttpStatus.OK);
	}
}
