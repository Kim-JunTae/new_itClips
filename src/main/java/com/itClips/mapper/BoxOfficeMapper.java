package com.itClips.mapper;

import com.itClips.domain.BoxOfficeVO;

public interface BoxOfficeMapper {
	public BoxOfficeVO check(String movieId);
	
	public int insert(BoxOfficeVO vo);
	
	public String getMovieId(String title);
	
	public BoxOfficeVO[] select();
	
	public BoxOfficeVO[] getMovieIdList();
	
	public BoxOfficeVO[] getMovieList(String keyword);
}
