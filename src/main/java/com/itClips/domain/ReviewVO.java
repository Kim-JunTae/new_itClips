package com.itClips.domain;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class ReviewVO {
	String 	netizenName,
			grade,
			review,
			reviewDate,
			movieId;

	@Override
	public String toString() {
		return "ReviewVO [netizenName=" + netizenName + ", grade=" + grade + ", review=" + review + ", reviewDate="
				+ reviewDate + ", movieId=" + movieId + "]";
	}

}
