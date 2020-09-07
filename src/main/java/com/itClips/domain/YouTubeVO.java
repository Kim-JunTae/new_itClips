package com.itClips.domain;

import lombok.Getter;
import lombok.Setter;

@Getter @Setter
public class YouTubeVO {
	private String 	videoId,
					title,
					description,
					thumbnail,
					publishedAt, 
					channelId,
					viewCount,
					likeCount,
					dislikeCount,
					favoriteCount,
					commentCount,
					movieId;

	@Override
	public String toString() {
		return "YouTubeVO [videoId=" + videoId + ", title=" + title + ", description=" + description + ", thumbnail="
				+ thumbnail + ", publishedAt=" + publishedAt + ", channelId=" + channelId + ", viewCount=" + viewCount
				+ ", likeCount=" + likeCount + ", dislikeCount=" + dislikeCount + ", favoriteCount=" + favoriteCount
				+ ", commentCount=" + commentCount + ", movieId=" + movieId + "]";
	}
}
