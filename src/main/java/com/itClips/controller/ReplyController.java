package com.itClips.controller;

import java.util.List;
import org.apache.ibatis.annotations.Delete;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.itClips.domain.Criteria;
import com.itClips.domain.ReplyPageDTO;
import com.itClips.domain.ReplyVO;
import com.itClips.service.ReplyService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@RequestMapping("/replies/")
@RestController
@Log4j
@AllArgsConstructor
public class ReplyController {
	
	private ReplyService service;

	@PostMapping(value="/new",
				 consumes = "application/json",
				 produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> create(@RequestBody ReplyVO vo){
		log.info("ReplyVO: " + vo);
		
		int insertCount = service.register(vo);
		
		log.info("Reply INSERT COUNT : " + insertCount);
		
		return insertCount == 1
			   ? new ResponseEntity<String>("success", HttpStatus.OK)
			   : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@GetMapping(value="/pages/{boardId}/{page}",
		    produces = {MediaType.APPLICATION_ATOM_XML_VALUE,
		    			MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyPageDTO> getList(
		@PathVariable("page") int page,
		@PathVariable("bno") Long boardId){
	Criteria cri = new Criteria(page, 10);
	
	log.info("get Reply List boardId : " + boardId);
	log.info("cri : " + cri);
	
	return new ResponseEntity<ReplyPageDTO>(service.getListPage(cri, boardId), HttpStatus.OK);
}
	
	
	@GetMapping(value = "/{rno}",
				produces= {MediaType.APPLICATION_XML_VALUE,
						   MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<ReplyVO> get(@PathVariable("replyId") Long replyId){
		log.info("get : " + replyId);
	
		return new ResponseEntity<ReplyVO>(service.get(replyId), HttpStatus.OK);
	}	
	
	@DeleteMapping(value = "/{rno}",
			       produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove(@PathVariable("replyId") Long replyId){
		log.info("remove : " + replyId);
		
		return service.remove(replyId) == 1
			   ? new ResponseEntity<String>("success", HttpStatus.OK)
			   : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	@RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
					value = "/{rno}",
					consumes = "application/json",
					produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> modify(
			@RequestBody ReplyVO vo,
			@PathVariable("rno") Long replyId){
		vo.setReplyId(replyId);
		log.info("rno : " + replyId);
		log.info("modify : " + vo);
		
		return service.modify(vo) == 1
			   ? new ResponseEntity<String>("success", HttpStatus.OK)
			   : new ResponseEntity<String>(HttpStatus.INTERNAL_SERVER_ERROR);
	}

}
