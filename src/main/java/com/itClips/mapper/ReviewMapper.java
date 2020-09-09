package com.itClips.mapper;

import com.itClips.domain.ReviewVO;

public interface ReviewMapper {
	public int insert(ReviewVO vo);
	
	public ReviewVO[] getReviewList(String movieId);
	
	public ReviewVO[] reviewJSON(String movieId);
	
	public ReviewVO check(String movieId, String netizenName);

}
