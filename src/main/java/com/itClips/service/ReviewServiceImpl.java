package com.itClips.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itClips.domain.ReviewVO;
import com.itClips.mapper.ReviewMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class ReviewServiceImpl implements ReviewService{

	@Setter(onMethod_ = @Autowired)
	private ReviewMapper mapper;
	
	@Override
	public int insert(ReviewVO vo) {
		log.info("insert..." + vo);
		return mapper.insert(vo);
	}

	@Override
	public ReviewVO[] getReviewList(String movieId) {
		log.info("getReviewList..." + movieId);
		return mapper.getReviewList(movieId);
	}

	@Override
	public ReviewVO[] reviewJSON(String movieId) {
		log.info("reviewJSON..." + movieId);
		return mapper.reviewJSON(movieId);
	}

	@Override
	public ReviewVO check(String movieId, String netizenName) {
		log.info("check..." + movieId +"/"+ netizenName);
		return mapper.check(movieId, netizenName);
	}

}
