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
	
}
