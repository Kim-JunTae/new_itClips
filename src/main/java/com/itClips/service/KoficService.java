package com.itClips.service;

import com.itClips.domain.KoficVO;

public interface KoficService {

	public KoficVO[] getKoficMovieList();
	
	public boolean checkKoficMovie(String title);
	
	public int insert(KoficVO vo);
	
	public KoficVO getKoficMovie(String movieId);
}
