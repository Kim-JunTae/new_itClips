package com.itClips.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itClips.domain.BoxOfficeVO;
import com.itClips.mapper.BoxOfficeMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoxOfficeServiceImpl implements BoxOfficeService{
	
	@Setter(onMethod_ = @Autowired)
	private BoxOfficeMapper mapper;

	@Override
	public BoxOfficeVO check(String movieId) {
		log.info("check..." + movieId);
		return mapper.check(movieId);
	}

	@Override
	public int insert(BoxOfficeVO vo) {
		log.info("insert..." + vo);
		return mapper.insert(vo);
	}

	@Override
	public String getMovieId(String title) {
		log.info("getMovieId..." + title);
		String result = mapper.getMovieId(title);
		if(result != null) {
			return result;
		}else{
			return "none";
		}
	}

	@Override
	public BoxOfficeVO[] getBoxOfficeList() {
		log.info("getBoxOfficeList...");
		return mapper.select();
	}

	@Override
	public BoxOfficeVO[] getMovieIdList() {
		log.info("getMovieIdList...");
		return mapper.getMovieIdList();
	}
	
	@Override
	public BoxOfficeVO[] getMovieList(String keyword) {
		log.info("getMovieList...");
		return mapper.getMovieList(keyword);
	}
}
