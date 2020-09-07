package com.itClips.mapper;

import com.itClips.domain.UserVO;

public interface UserMapper {

	public UserVO login(String id, String pw);
	
	public UserVO get_user(String id);
	
	public UserVO get_nickname(String nickname);
	
	public UserVO get_email(String email);
	
	public int join(UserVO vo);
	
}
