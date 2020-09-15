package com.itClips.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.itClips.domain.Criteria;
import com.itClips.domain.ReplyVO;

public interface ReplyMapper {
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long boardId);
	
	public int delete(Long replyId);
	
	public int update(ReplyVO reply);
	
	public List<ReplyVO> getListWithPaging(
			@Param("cri") Criteria cri,
			@Param("boardId") Long boardId);
	
	public int getCountByBno(Long boardId);
}
