package com.itClips.service;

import java.util.List;

import com.itClips.domain.Criteria;
import com.itClips.domain.ReplyPageDTO;
import com.itClips.domain.ReplyVO;

public interface ReplyService {

	public int register(ReplyVO vo);
	
	public ReplyVO get(Long replyId);
	
	public int modify(ReplyVO vo);
	
	public int remove(Long replyId);
	
	public List<ReplyVO> getList(Criteria cri, Long boardId);
	
	public ReplyPageDTO getListPage(Criteria cri, Long boardId);
}
