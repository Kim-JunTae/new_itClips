package com.itClips.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itClips.domain.YouTubeVO;
import com.itClips.mapper.YouTubeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class YouTubeServiceImpl implements YouTubeService{
	
	@Setter(onMethod_ = @Autowired)
	private YouTubeMapper mapper;
	
	@Override
	public YouTubeVO[] getYouTubeList(String movieId) {
		log.info("getYouTubeList..." + movieId);
		return mapper.getYouTubeList(movieId);
	}

	@Override
	public YouTubeVO check(String videoId) {
		log.info("check..." + videoId);
		return mapper.check(videoId);
	}

	@Override
	public int insert(YouTubeVO vo) {
		log.info("insert..." + vo);
		return mapper.insert(vo);
	}
	
}
