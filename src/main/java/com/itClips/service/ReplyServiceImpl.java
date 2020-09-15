package com.itClips.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itClips.domain.Criteria;
import com.itClips.domain.ReplyPageDTO;
import com.itClips.domain.ReplyVO;
import com.itClips.mapper.ReplyMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class ReplyServiceImpl implements ReplyService{
	
	@Setter(onMethod_ = @Autowired)
	private ReplyMapper mapper;
	
	@Override
	public int register(ReplyVO vo) {
		log.info("register..." + vo);
		return mapper.insert(vo);
	}

	@Override
	public ReplyVO get(Long replyId) {
		log.info("get..."+replyId);
		return mapper.read(replyId);
	}

	@Override
	public int modify(ReplyVO vo) {
		log.info("modify..." + vo);
		return mapper.update(vo);
	}

	@Override
	public int remove(Long replyId) {
		log.info("remove..." + replyId);
		return mapper.delete(replyId);
	}

	@Override
	public List<ReplyVO> getList(Criteria cri, Long boardId) {
		log.info("get Reply List of a Board"+boardId);
		return mapper.getListWithPaging(cri, boardId);
	}
	
	@Override
	public ReplyPageDTO getListPage(Criteria cri, Long boardId) {
		return new ReplyPageDTO(
				mapper.getCountByBno(boardId),
				mapper.getListWithPaging(cri, boardId));
	}

}
