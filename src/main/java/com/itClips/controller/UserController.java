package com.itClips.controller;

import java.util.Hashtable;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.itClips.domain.UserVO;
import com.itClips.service.UserService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/user/*")
@AllArgsConstructor
public class UserController {

	private UserService service;
	
	@RequestMapping(value="/checkLogin")
	@ResponseBody
	public void login(UserVO vo, Model model) {
		//Map<String, String> check = new Hashtable<String, String>();
		
		UserVO userVO = null;
		userVO = service.login(vo.getId(), vo.getPw());
		
		if(userVO != null) {//로그인 성공
			model.addAttribute("id", userVO.getId());
			model.addAttribute("nickname", userVO.getNickname());
			
			//session.setAttribute("id", userVO.getId());
			//session.setAttribute("nickname", userVO.getNickname());
			//check.put("chk", "0");
			//check.put("res","로그인 성공");
			model.addAttribute("chk", "0");
			model.addAttribute("res", "로그인 성공");
			log.info("로그인 성공");
			//System.out.println("로그인 성공!");
		}else{//로그인 실패
			//check.put("chk", "1");
			//check.put("res","로그인 실패");
			model.addAttribute("chk", "0");
			model.addAttribute("res", "로그인 성공");
			log.info("로그인 실패");
			//System.out.println("로그인 실패");
		}
		//return check;
	}
	
//	@RequestMapping(value="/logout") 
//	public String logout(HttpSession session) { 
//		session.invalidate();
//		System.out.println("로그아웃 성공!"); 
//		return "userHome"; 
//	}
	
	@GetMapping("/join")
	public void join(Model model) {
		log.info("join");
		
		//카테고리 리스트 보내주기
		
	}
	
	@PostMapping("/join")
	public String join(UserVO vo, Model model) {
		
		int joinCheck = service.join(vo);
		
		if(joinCheck == 1) {
			log.info("회원가입 성공");
			model.addAttribute("message", "회원가입을 축하합니다! 로그인을 해주세요");
		}else {
			log.info("회원가입 실패");
		}
		
		return "redirect:/userHome";
	}
	
	//아이디 중복 검사
	@RequestMapping(value="/checkId", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> checkId(String id){
		Map<String, String> map = new Hashtable<String, String>();
		
		//인자로 넘어온 id값이 이미 있다면
		//check true
		boolean check = service.get_user(id);
		if(check) {
			map.put("chk","0");
			map.put("res", "<span class='red_txt'>아이디 사용불가(중복)</span>");
		}else{
			map.put("chk","1");
			map.put("res", "<span class='blue_txt'>아이디 사용가능</span>");
		}
		return map;
	}
	
	//닉네임 중복 검사
	@RequestMapping(value="/checkNickname", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> checkNickname(String nickname){
		Map<String, String> map = new Hashtable<String, String>();
	
		boolean check = service.get_nickname(nickname);
		if(check) {
			map.put("chk","0");
			map.put("res", "<span class='red_txt'>이미 사용하고 있는 닉네임입니다.</span>");
		}else{
			map.put("chk","1");
			map.put("res", "<span class='blue_txt'>사용 가능한 닉네임입니다.</span>");
		}
		return map;
	}
	
	//이메일 중복 검사
	@RequestMapping(value="/checkEmail", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, String> checkEmail(String email){
		Map<String, String> map = new Hashtable<String, String>();
		
		//인자로 넘어온 id값이 이미 있다면 UserVO가 null이 아니고,
		//사용할 수 없는 아이디가 된다. 하지만 UserVO가 null이면
		//사용가능한 아이디가 된다.
		boolean check = service.get_email(email);
		if(check) {
			map.put("chk","0");
			map.put("res", "<span class='red_txt'>이미 사용하고 있는 이메일입니다.</span>");
		}else{
			map.put("chk","1");
			map.put("res", "<span class='blue_txt'>사용 가능한 이메일입니다.</span>");
		}
		return map;
	}
	
	
}
