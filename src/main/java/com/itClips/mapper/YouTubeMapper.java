package com.itClips.mapper;

import com.itClips.domain.YouTubeVO;

public interface YouTubeMapper {

	public YouTubeVO[] getYouTubeList(String movieId);

	public YouTubeVO check(String videoId);
	
	public int insert(YouTubeVO vo);
}
