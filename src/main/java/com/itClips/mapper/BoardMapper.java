package com.itClips.mapper;

import java.util.List;

import com.itClips.domain.BoardVO;
import com.itClips.domain.Criteria;


public interface BoardMapper {
	
	//@Select("select * from tbl_board where bno > 0")
	public List<BoardVO> getList();
	
	public List<BoardVO> getListWithPaging(Criteria cri);
	
	public void insert(BoardVO board);
	
	public void insertSelectKey(BoardVO board);
	
	public BoardVO read(Long boardId);
	
	public int delete(Long boardId);
	
	public int update(BoardVO board);
	
	public int getTotalCount(Criteria cri);
}
