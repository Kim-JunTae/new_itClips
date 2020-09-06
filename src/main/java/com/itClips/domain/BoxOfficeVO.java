package com.itClips.domain;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class BoxOfficeVO {
	private String 	movieId,
					title,
					src;

	@Override
	public String toString() {
		return "BoxOfficeVO [movieId=" + movieId + ", title=" + title + ", src=" + src + "]";
	}
}
