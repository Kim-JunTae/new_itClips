package com.itClips.domain;

import java.util.Date;
import lombok.Data;

@Data
public class ReplyVO {

	private Long replyId;
	private Long boardId;
	
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
}
