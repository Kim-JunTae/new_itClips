package com.itClips.service;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;


public class Jsoup {
	
	public List<Map<String, String>> searchMovieReview(String movieId) throws Exception{
		
		List<Map<String, String>> response = new ArrayList<Map<String,String>>();
		
		//페이지 수에 따른 네티즌 리뷰 평점 가져오기
		for(int i=1; i<=10; i++) {
			String apiurl = "https://movie.daum.net/moviedb/grade?movieId="+URLEncoder.encode(movieId,"UTF-8");
			apiurl += "&type=netizen&page="+i;
			
			//페이지가 존재하면 가져오기
			if(org.jsoup.Jsoup.connect(apiurl).get() != null) {
				Document doc = org.jsoup.Jsoup.connect(apiurl).get();
				
				Elements lis = doc.select(".list_review li");
				
				for(Element li : lis) {
					Map<String, String> map = new Hashtable<String, String>();
					//1.네티즌 닉네임
					String netizenName = li.select(".review_info .link_review .link_profile").get(0).text();
					map.put("netizenName", netizenName);
					//System.out.println(netizenName);
					//2.평점(10점 만점에)
					String grade = li.select(".review_info .raking_grade .emph_grade").get(0).text();
					map.put("grade", grade);
					//System.out.println(grade);
					//3.리뷰 내용
					String review = li.select(".review_info .desc_review").get(0).text();
					map.put("review", review);
					//System.out.println(review);
					//4.리뷰쓴 날짜
					String reviewDate = li.select(".review_info .append_review .info_append").get(0).text();
					map.put("reviewDate", reviewDate);
					//System.out.println(reviewDate);
					//5.해당 영화 Id값(FK)
					map.put("movideId", movieId);
					
					response.add(map);
				}
			}
		}
		
		return response;
	}
	
	
	public List<Map<String, String>> searchWeeklyBoxOffice() throws Exception{
		
		//StringBuffer response = new StringBuffer();
		List<Map<String, String>> response = new ArrayList<Map<String,String>>();
		
		String apiurl = "https://movie.daum.net/boxoffice/weekly";
			   apiurl += "?startDate=20200817";
			   
		Document doc = org.jsoup.Jsoup.connect(apiurl).get();
		
		//System.out.println(doc);
		
		Elements lis = doc.select(".list_movie li");
		
		for (Element li : lis) {
			Map<String, String> map = new Hashtable<String, String>();
			
			String title = li.select(".wrap_movie .name_movie").get(0).text();
			map.put("title", title);
			//System.out.println(title);
			
			String src = li.select(".thumb_movie img").attr("src");
			map.put("src", src);
			//System.out.println(src);
			
			String movieId = li.select(".wrap_desc a").get(0).attr("data-tiara-id");
			map.put("movieId", movieId);
			//System.out.println(movieId);
			response.add(map);
		}
		
		return response;
	}//end searchWeeklyBoxOffice()
	
	public List<Map<String, String>> searchMonthlyBoxOffice() throws Exception{
		
		//StringBuffer response = new StringBuffer();
		List<Map<String, String>> response = new ArrayList<Map<String,String>>();
	
		String apiurl = "https://movie.daum.net/boxoffice/monthly";
			   apiurl += "?yyyymm=202008";
		
		Document doc = org.jsoup.Jsoup.connect(apiurl).get();
		
		//System.out.println(doc);
		
		Elements lis = doc.select(".list_movie li");
		
		for (Element li : lis) {
			Map<String, String> map = new Hashtable<String, String>();
			
			String title = li.select(".wrap_movie .name_movie").get(0).text();
			map.put("title", title);
			//System.out.println(title);
			
			String src = li.select(".thumb_movie img").attr("src");
			map.put("src", src);
			//System.out.println(src);
			
			String movieId = li.select(".wrap_desc a").get(0).attr("data-tiara-id");
			map.put("movieId", movieId);
			//System.out.println(movieId);
			response.add(map);
		}
		
		return response;
	}//end searchMonthlyBoxOffice()
	
	//미친 수동 year조절은 쫌;;;
	public List<Map<String, String>> searchYearlyBoxOffice() throws Exception{
		
		//StringBuffer response = new StringBuffer();
		List<Map<String, String>> response = new ArrayList<Map<String,String>>();
	
		String apiurl = "https://movie.daum.net/boxoffice/yearly";
			   apiurl += "?year=2010";
		
		Document doc = org.jsoup.Jsoup.connect(apiurl).get();
		
		//System.out.println(doc);
		
		Elements lis = doc.select(".list_movie li");
		
		for (Element li : lis) {
			Map<String, String> map = new Hashtable<String, String>();
			
			String title = li.select(".wrap_movie .name_movie").get(0).text();
			map.put("title", title);
			//System.out.println(title);
			
			String src = li.select(".thumb_movie img").attr("src");
			map.put("src", src);
			//System.out.println(src);
			
			String movieId = li.select(".wrap_desc a").get(0).attr("data-tiara-id");
			map.put("movieId", movieId);
			//System.out.println(movieId);
			response.add(map);
		}
		
		return response;
	}//end searchYearlyBoxOffice()
}
