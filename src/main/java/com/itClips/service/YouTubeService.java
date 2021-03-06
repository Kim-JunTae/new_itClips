package com.itClips.service;

import com.itClips.domain.YouTubeVO;

public interface YouTubeService {
	
	public YouTubeVO[] getYouTubeList(String movieId);

	public boolean check(String videoId);
	
	public int insert(YouTubeVO vo);
}
