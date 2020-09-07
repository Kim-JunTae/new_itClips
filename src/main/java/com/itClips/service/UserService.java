package com.itClips.service;

import com.itClips.domain.UserVO;

public interface UserService {
	
	public UserVO login(String id, String pw);
	
	public boolean get_user(String id);
	
	public boolean get_nickname(String nickname);
	
	public boolean get_email(String email);
	
	public int join(UserVO vo); 
}
