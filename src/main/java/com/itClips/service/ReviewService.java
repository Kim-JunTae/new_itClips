package com.itClips.service;

import com.itClips.domain.ReviewVO;

public interface ReviewService {

	public int insert(ReviewVO vo);
	
	public ReviewVO[] getReviewList(String movieId);
	
	public ReviewVO[] reviewJSON(String movieId);
	
	public ReviewVO check(String movieId, String netizenName);
}
