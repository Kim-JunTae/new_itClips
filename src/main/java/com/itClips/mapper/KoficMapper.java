package com.itClips.mapper;

import com.itClips.domain.KoficVO;

public interface KoficMapper {

	public KoficVO[] getKoficMovieList();
	
	public KoficVO checkKoficMovie(String title);
	
	public int insert(KoficVO vo);
	
	public KoficVO getKoficMovie(String movieId);
}
