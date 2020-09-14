package com.itClips.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.itClips.domain.BoxOfficeVO;
import com.itClips.domain.KoficVO;
import com.itClips.domain.ReviewVO;
import com.itClips.domain.YouTubeVO;
import com.itClips.service.BoxOfficeService;
import com.itClips.service.KoficService;
import com.itClips.service.ReviewService;
import com.itClips.service.YouTubeService;
import lombok.extern.log4j.Log4j;

@Component
@Log4j
public class Scheduler {
	
	@Autowired
	private BoxOfficeService boxOfficeService;
	
	@Autowired
	private YouTubeService youTubeService;
	
	@Autowired
	private ReviewService reviewService;
	
	@Autowired
	private KoficService koficService;
	
	//매일 새벽 2시 스케줄러 가동하여 정보들 저장 : http://blog.naver.com/PostView.nhn?blogId=lovemema&logNo=140200056062
	//매 1분마다 실행 : * 1 * * * *
	//매일 새벽 2시 실행 : 0 0 02 * * ?
	
	@Scheduled(cron="0 30 02 * * ?")
	public void insertDB_KoficData() throws Exception{
		log.info("schedule start... : insertDB_KoficData");
		log.info("======================================");
		
		KOFIC_API koficApi = new KOFIC_API();
		int date = 20100101;
		
		List<Map<String, String>> koficMoiveList = new ArrayList<Map<String,String>>(); 
		//이거 다시 생각해보자. 현재날짜부터 예전 날짜까지로 꺼꾸로 가야될듯
		//for문으로 현재 날짜까지
		for(int i = date; i < 20200914; i++) {
			koficMoiveList = koficApi.searchWeeklyBoxOffice(i);
			log.info(koficMoiveList);
			
			for(int j=0; j<koficMoiveList.size(); j++) {
				//title로 먼저 ITCLIPS_KOFIC Table에 있는지 검사하여 있으면 return;
				String movieTitle = koficMoiveList.get(j).get("title").toString();
				//log.info("영화제목 : " + movieTitle);
				
				//새로운 영화
				if(koficService.checkKoficMovie(movieTitle)) {
					KoficVO vo = new KoficVO();
					vo.setKoficId(koficMoiveList.get(j).get("koficId"));
					vo.setTitle(koficMoiveList.get(j).get("title"));
					vo.setOpenDt(koficMoiveList.get(j).get("openDt"));
					vo.setSalesAcc(koficMoiveList.get(j).get("salesAcc"));
					vo.setAudiAcc(koficMoiveList.get(j).get("audiAcc"));
					
					//제목이 같은 영화가 ITCLIPS_BoxOffice Table에 있는지 검사
					String movieId = boxOfficeService.getMovieId(movieTitle);
					//log.info(movieTitle + "의 movieId 등록 : " + boxOfficeService.getMovieId(movieTitle));
					vo.setMovieId(movieId);
					
					if(koficService.insert(vo) == 1) {
						log.info("DB 등록 완료 : " + vo.toString());
					}else{
						log.info("DB 등록 실패");
					}
					
				}else{//존재하는 영화
					log.info(movieTitle + "은 이미 DB에 있는 영화입니다.");
				}
			}
		}
	}
	
	
	@Scheduled(cron="0 0 02 * * ?")
	public void insertDB_BoxOffice() throws Exception{
		log.info("schedule start... : insertDB_BoxOffice");
		log.info("======================================");
		
		//Jsoup을 이용하여 Daum 영화 주간/월간/연간 박스오피스 정보를 저장하자.
		Jsoup jsoup = new Jsoup();
		
		//맨 처음 저장할 때(데이터가 없을때는):주간,월간,연간을 바꿔서 저장해줘야한다.
		List<Map<String, String>> boxOfficeList = jsoup.searchYearlyBoxOffice();
		
		for(int i=0; i<boxOfficeList.size(); i++) {
			BoxOfficeVO vo = new BoxOfficeVO();
			vo.setMovieId(boxOfficeList.get(i).get("movieId"));
			vo.setTitle(boxOfficeList.get(i).get("title"));
			vo.setSrc(boxOfficeList.get(i).get("src"));
			
			//해당 영화 중복 체크
			//System.out.println(boxOfficeService.check(vo.getMovieId()));
			if(boxOfficeService.check(vo.getMovieId()) != null) {
				boxOfficeService.insert(vo);
				log.info("박스오피스 정보 저장 성공");
				//System.out.println("박스오피스 정보 저장 성공");
				
				//해당 영화의 리뷰 저장 시작
				log.info("박스오피스 정보 저장 성공");
				log.info("schedule start... : insertDB_Review");
				log.info("======================================");
				
				List<Map<String, String>> reviewList = jsoup.searchMovieReview(vo.getMovieId());
				
				for(int j=0; j<reviewList.size(); j++) {
					ReviewVO review = new ReviewVO();
					
					review.setMovieId(vo.getMovieId());
					review.setNetizenName(reviewList.get(j).get("netizenName"));
					review.setGrade(reviewList.get(j).get("grade"));
					review.setReview(reviewList.get(j).get("review"));
					review.setReviewDate(reviewList.get(j).get("reviewDate"));
					
					
					if(reviewService.check(review.getMovieId(), review.getNetizenName()) != null) {
						reviewService.insert(review);
						System.out.println(vo.getTitle()+" 의 리뷰 정보 저장 성공");
					}
				}//해당 영화의 리뷰 저장 끝
			}
		}
	}//end insertdB_BoxOffice();
	

	// Chart 분석을 위해서 Youtube Data 가져오기
	@Scheduled(cron = "0 0 02 * * ?")
	public void insertDB_YouTubeData() throws Exception{
		System.out.println("scheduler : insertDB_YouTube");
		
		//Jsoup을 이용하여 Daum 영화 주간 박스오피스 정보를 가져오고
		//BoxOfficeVO[] boxOfficeList = boxOfficeService.getBoxOfficeList();
		
		//YoutubeAPI를 이용하여 Youtube 영상들을 검색(1)하고 : search()
		//영상의 정보들을 저장(2)한다 : getVideoInfo()
		YouTube_API youtube = new YouTube_API();
		
//		for(int i=0; i<10; i++) {
//			//DB에서 영화 제목들 가져오고
//			String search = boxOfficeList[i].getTitle();
//			log.info(search);
			
			//한 영화로만 TEST
			String search = "프리즌";
			
			//youtube에서 검색
			List<Map<String, String>> youTubeList = new ArrayList<Map<String,String>>();
			youTubeList = youtube.search(search);
			
			for(int j=0; j<youTubeList.size(); j++) {
				YouTubeVO vo = new YouTubeVO();
				vo.setVideoId(youTubeList.get(j).get("videoId"));
				vo.setTitle(youTubeList.get(j).get("title"));
				vo.setDescription(youTubeList.get(j).get("description"));
				vo.setThumbnail(youTubeList.get(j).get("thumbnail"));
				vo.setPublishedAt(youTubeList.get(j).get("publishedAt"));
				vo.setChannelId(youTubeList.get(j).get("channelId"));
				
				//외래키 지정
				//vo.setMovieId(boxOfficeList[i].getMovieId());
				//System.out.println(vo.getVideoId());
				//String videoId = vo.getVideoId();
				//영화 프리즌
				String videoId = "100648";
				
				//동영상 상세정보(조회, 추천/비추천, 즐겨찾기, 댓글 수) 추가
				Map<String, String> videoInfo = youtube.getVideoInfo(videoId);
				if(videoInfo.get("viewCount") != null) {
					vo.setViewCount(videoInfo.get("viewCount"));
				}else{
					vo.setViewCount("0");
				}
				
				if(videoInfo.get("likeCount") != null) {
					vo.setLikeCount(videoInfo.get("likeCount"));
				}else {
					vo.setLikeCount("0");
				}
				
				if(videoInfo.get("dislikeCount") != null) {
					vo.setDislikeCount(videoInfo.get("dislikeCount"));
				}else {
					vo.setDislikeCount("0");
				}
				
				if(videoInfo.get("favoriteCount") != null) {
					vo.setFavoriteCount(videoInfo.get("favoriteCount"));
				}else {
					vo.setFavoriteCount("0");
				}
				
				if(videoInfo.get("commentCount") != null) {
					vo.setCommentCount(videoInfo.get("commentCount"));
				}else {
					vo.setCommentCount("0");
				}
				
				if(youTubeService.check(vo.getVideoId())) {
					youTubeService.insert(vo);
					System.out.println("유튜브 정보 저장 성공");
				}
			}
		//}//end for문
	}//end insertdB_YouTube();	
	
//	@Scheduled(cron="0 0 02 * * ?")
//	public void insertDB_reviewList() throws Exception{
//		//해당 영화의 리뷰 저장 시작
//		System.out.println("scheduler : insertDB_Review");
//		
//		//해당 영화 movieId 지정
//		BoxOfficeVO[] movieIdList = boxOfficeService.getMovieIdList();
//		
//		Jsoup jsoup = new Jsoup();
//		
//		for(int i=0; i<movieIdList.length; i++){
//			String movieId = movieIdList[i].getMovieId();
//			List<Map<String, String>> reviewList = jsoup.searchMovieReview(movieId);
//
//			for(int j=0; j<reviewList.size(); j++) {
//				ReviewVO review = new ReviewVO();
//				
//				review.setMovieId(movieId);
//				review.setNetizenName(reviewList.get(j).get("netizenName"));
//				review.setGrade(reviewList.get(j).get("grade"));
//				review.setReview(reviewList.get(j).get("review"));
//				review.setReviewDate(reviewList.get(j).get("reviewDate"));
//				
//				if(reviewService.check(movieId, review.getNetizenName()) == null){
//					reviewService.insert(review);
//					System.out.println(movieIdList[i].getMovieId()+" 의 리뷰 정보 저장 성공");
//				}
//			}//해당 영화의 리뷰 저장 끝
//		}
//	}
	
	//박스오피스에 올라온 영화들의 MovieId값으로 다음 영화 댓글을 검색하여 DB에 저장하는 함수 : 스캐줄러로 매일매일 가능하게	
	//0828_할당량 문제를 해결하지 않고는 하기 힘들 것 같다._대체방안으로 다음의 검색을 사용하자
	//-> 스케줄러 하나로 통합해야 되는듯 ㅠㅠ 
	//박스오피스에 올라온 영화들의 제목으로 유튜브 검색을 하여 정보를 DB에 저장하는 함수 : 함수 두 개
//	@Scheduled(cron = "30 * * * * *")
//	public void insertDB_YouTube() throws Exception{
//		System.out.println("scheduler : insertDB_YouTube");
//		
//		//Jsoup을 이용하여 Daum 영화 주간 박스오피스 정보를 가져오고
//		BoxOfficeVO[] boxOfficeList = boxOfficeDao.getBoxOfficeList();
//		
//		//YoutubeAPI를 이용하여 Youtube 영상들을 검색(1)하고 : search()
//		//영상의 정보들을 저장(2)한다 : getVideoInfo()
//		Youtube_API youtube = new Youtube_API();
//		
//		for(int i=0; i<boxOfficeList.length; i++) {
//			//DB에서 영화 제목들 가져오고
//			String search = boxOfficeList[i].getTitle();
//			//youtube에서 검색
//			List<Map<String, String>> youTubeList = new ArrayList<Map<String,String>>();
//			youTubeList = youtube.search(search);
//			
//			for(int j=0; j<youTubeList.size(); j++) {
//				YouTubeVO vo = new YouTubeVO();
//				vo.setVideoId(youTubeList.get(j).get("videoId"));
//				vo.setTitle(youTubeList.get(j).get("title"));
//				vo.setDescription(youTubeList.get(j).get("description"));
//				vo.setThumbnail(youTubeList.get(j).get("thumbnail"));
//				vo.setPublishedAt(youTubeList.get(j).get("publishedAt"));
//				vo.setChannelId(youTubeList.get(j).get("channelId"));
//				
//				//외래키 지정
//				vo.setMovieId(boxOfficeList[i].getMovieId());
//				//System.out.println(vo.getVideoId());
//				String videoId = vo.getVideoId();
//				
//				//동영상 상세정보(조회, 추천/비추천, 즐겨찾기, 댓글 수) 추가
//				Map<String, String> videoInfo = youtube.getVideoInfo(videoId);
//				if(videoInfo.get("viewCount") != null) {
//					vo.setViewCount(videoInfo.get("viewCount"));
//				}else{
//					vo.setViewCount("0");
//				}
//				
//				if(videoInfo.get("likeCount") != null) {
//					vo.setLikeCount(videoInfo.get("likeCount"));
//				}else {
//					vo.setLikeCount("0");
//				}
//				
//				if(videoInfo.get("dislikeCount") != null) {
//					vo.setDislikeCount(videoInfo.get("dislikeCount"));
//				}else {
//					vo.setDislikeCount("0");
//				}
//				
//				if(videoInfo.get("favoriteCount") != null) {
//					vo.setFavoriteCount(videoInfo.get("favoriteCount"));
//				}else {
//					vo.setFavoriteCount("0");
//				}
//				
//				if(videoInfo.get("commentCount") != null) {
//					vo.setCommentCount(videoInfo.get("commentCount"));
//				}else {
//					vo.setCommentCount("0");
//				}
//				
//				
//				if(youTubeDao.check(vo.getVideoId())) {
//					youTubeDao.insert(vo);
//					System.out.println("유튜브 정보 저장 성공");
//				}
//			}
//		}
//	}//end insertdB_YouTube();

}
