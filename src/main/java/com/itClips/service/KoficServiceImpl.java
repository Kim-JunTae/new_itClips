package com.itClips.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itClips.domain.KoficVO;
import com.itClips.mapper.KoficMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
@AllArgsConstructor
public class KoficServiceImpl implements KoficService{
	
	@Setter(onMethod_ = @Autowired)
	private KoficMapper mapper;
	
	@Override
	public KoficVO[] getKoficMovieList() {
		log.info("getKoficMovieList...");
		return mapper.getKoficMovieList();
	}

	@Override
	public boolean checkKoficMovie(String title) {
		log.info("checkKoficMovie..." + title);
		KoficVO result = mapper.checkKoficMovie(title);
		log.info(result);
		if(result != null)
			return false;
		
		return true;
	}
	
	@Override
	public int insert(KoficVO vo) {
		log.info("insert..." + vo);
		return mapper.insert(vo);
	}
	
	@Override
	public KoficVO getKoficMovie(String movieId) {
		log.info("getKoficMovie..." + movieId);
		KoficVO result = mapper.getKoficMovie(movieId);
		
		log.info(result);
		if(result != null){
			return result;
		}else {
			result = new KoficVO();
			result.setOpenDt("DB에 데이터가 존재하지 않습니다.");
			result.setAudiAcc("DB에 데이터가 존재하지 않습니다.");
			return result;
		}
	}
}
