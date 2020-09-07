package com.itClips.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itClips.domain.UserVO;
import com.itClips.mapper.UserMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class UserServiceImpl implements UserService{

	@Setter(onMethod_ = @Autowired)
	private UserMapper mapper;
	
	@Override
	public UserVO login(String id, String pw) {
		log.info("login..." + id + "/" + pw);
		return mapper.login(id, pw);
	}

	@Override
	public boolean get_user(String id) {
		log.info("get_user..." + id);
		return mapper.get_user(id) != null;
	}

	@Override
	public boolean get_nickname(String nickname) {
		log.info("get_nickname..." + nickname);
		return mapper.get_nickname(nickname) != null;
	}

	@Override
	public boolean get_email(String email) {
		log.info("get_email..." + email);
		return mapper.get_email(email) != null;
	}

	@Override
	public int join(UserVO vo) {
		log.info("join..." + vo);
		return mapper.join(vo);
	}

}
