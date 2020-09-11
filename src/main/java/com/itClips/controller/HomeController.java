package com.itClips.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import lombok.extern.log4j.Log4j;


@Controller
@Log4j
public class HomeController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String intro() {
		log.info("intro");
		return "intro";
	}
	
	@RequestMapping(value = "userHome", method = RequestMethod.GET)
	public String userHome() {
		log.info("userHome");
		return "userHome";
	}
	
	@RequestMapping(value = "adminHome", method = RequestMethod.GET)
	public String adminHome() {
		log.info("adminHome");
		return "adminHome";
	}
	
	@RequestMapping(value = "/test", method = RequestMethod.GET)
	public String test() {
		log.info("D3.js Test page");
		return "d3Test";
	}
	
	@RequestMapping(value = "/test1", method = RequestMethod.GET)
	public String test1() {
		log.info("D3.js Test page");
		return "d3Test_line_chart";
	}
	
	@RequestMapping(value = "/test2", method = RequestMethod.GET)
	public String test2() {
		log.info("D3.js Test page");
		return "d3Test_bar_chart";
	}
	
	@RequestMapping(value = "/test3", method = RequestMethod.GET)
	public String test3() {
		log.info("D3.js Test page");
		return "d3Test_pie_chart";
	}
	
	@RequestMapping(value = "/test4", method = RequestMethod.GET)
	public String test4() {
		log.info("D3.js Test page");
		return "d3Test_scatterplot_chart";
	}
}
