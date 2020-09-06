package com.itClips.service;

import com.itClips.domain.BoxOfficeVO;

public interface BoxOfficeService {
	
	public BoxOfficeVO check(String movieId);
	
	public int insert(BoxOfficeVO vo);
	
	public String getMovieId(String title);
	
	public BoxOfficeVO[] getBoxOfficeList();
	
	public BoxOfficeVO[] getMovieIdList();
	
}
