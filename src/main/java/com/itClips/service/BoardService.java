package com.itClips.service;

import java.util.List;

import com.itClips.domain.BoardVO;
import com.itClips.domain.Criteria;

public interface BoardService {
	
	public void register(BoardVO board);
	
	public BoardVO get(Long boardId);
	
	public boolean modify(BoardVO board);
	
	public boolean remove(Long boardId);
	
	//public List<BoardVO> getList();
	
	public List<BoardVO> getList(Criteria cri);
	
	public int getTotal(Criteria cri);
}
