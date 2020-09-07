package com.itClips.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class YouTube_API {
	public List<Map<String, String>> search(String search) throws IOException {
		List<Map<String, String>> response = new ArrayList<Map<String,String>>();
		
		String searchWord = "영화 " + search + " 리뷰";
		
		String apiurl = "https://www.googleapis.com/youtube/v3/search";
		//apiurl += "?key=AIzaSyCNY8isLFGtuy_mRV23YNPdJRY0-TrwVZk";	//내꺼
		//apiurl += "?key=AIzaSyCeJAeERHKe0jkfUaL1czciAEtdHyXGD0A";	//현진씨꺼
		apiurl += "?key=AIzaSyCNY8isLFGtuy_mRV23YNPdJRY0-TrwVZk";
		apiurl += "&part=snippet&eventType=completed&type=video&maxResults=5&videoEmbeddable=true";
		apiurl += "&order=viewCount";
		apiurl += "&q="+URLEncoder.encode(searchWord,"UTF-8");
		
		URL url = new URL(apiurl);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");

		BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
		String inputLine;
		StringBuffer result = new StringBuffer();
		while((inputLine = br.readLine()) != null) {
			result.append(inputLine);
		}
		br.close();
		
		JsonParser jsonParser = new JsonParser();
		JsonObject object = (JsonObject) jsonParser.parse(result.toString());
		JsonArray itemsArray = (JsonArray)object.get("items");
		
		for(int i=0; i<itemsArray.size(); i++) {
			JsonObject itemObject = (JsonObject)itemsArray.get(i);
			
			Map<String, String> map = new Hashtable<String, String>();
			
			//JSON name으로 추출
			//1. id
			JsonObject id = (JsonObject)itemObject.get("id");
			map.put("videoId", id.get("videoId").getAsString());
			
			//2. snippet
			JsonObject snippet = (JsonObject)itemObject.get("snippet");
			map.put("title", snippet.get("title").getAsString());
			map.put("description", snippet.get("description").getAsString());
			map.put("publishedAt", snippet.get("publishedAt").getAsString());
			map.put("channelId", snippet.get("channelId").getAsString());
			
			//3. thumbnail
			JsonObject thumbnail = (JsonObject)snippet.get("thumbnails");
			JsonObject thumbnail_default = (JsonObject)thumbnail.get("default");
			
			map.put("thumbnail", thumbnail_default.get("url").getAsString());
			
			response.add(map);
		}
		return response;
	}
	
	public Map<String, String> getVideoInfo(String videoId) throws IOException {
		//System.out.println("youTubeAPI : " + videoId);
		//apiurl += "?key=AIzaSyCNY8isLFGtuy_mRV23YNPdJRY0-TrwVZk";	//내꺼
		//apiurl += "?key=AIzaSyCeJAeERHKe0jkfUaL1czciAEtdHyXGD0A";	//현진씨꺼
		String apiurl = "https://www.googleapis.com/youtube/v3/videos";
		apiurl += "?key=AIzaSyCNY8isLFGtuy_mRV23YNPdJRY0-TrwVZk";
		apiurl += "&part=statistics";
		apiurl += "&id="+URLEncoder.encode(videoId,"UTF-8");
		
		URL url = new URL(apiurl);
		HttpURLConnection con = (HttpURLConnection) url.openConnection();
		con.setRequestMethod("GET");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
		String inputLine;
		StringBuffer result = new StringBuffer();
		while((inputLine = br.readLine()) != null) {
			result.append(inputLine);
		}
		br.close();
		
		Map<String, String> videoInfo = new Hashtable<String, String>();
		
		JsonParser jsonParser = new JsonParser();
		JsonObject object = (JsonObject) jsonParser.parse(result.toString());
		//추가
		JsonArray items = (JsonArray)object.get("items");
		
		for(int i=0; i<items.size(); i++) {
			JsonObject itemObject = (JsonObject)items.get(i);
			
			JsonObject statistics = (JsonObject)itemObject.get("statistics");
			
			//1. viewCount 추출		: 동영상 조회 수
			if(statistics.get("viewCount") != null) {
				JsonElement viewCount = (JsonElement)statistics.get("viewCount");
				videoInfo.put("viewCount", viewCount.getAsString());
			}
			//2. likeCount 추출		: 추천 버튼 누른 수
			if(statistics.get("likeCount") != null) {
				JsonElement likeCount = (JsonElement)statistics.get("likeCount");
				videoInfo.put("likeCount", likeCount.getAsString());
			}
			//3. dislikeCount 추출	: 추천 안함 버튼 누른 수
			if(statistics.get("dislikeCount") != null) {
				JsonElement dislikeCount = (JsonElement)statistics.get("dislikeCount");
				videoInfo.put("dislikeCount", dislikeCount.getAsString());
			}
			//4. favoriteCount 추출 	: 즐겨찾기에 등록한 수
			if(statistics.get("favoriteCount") != null) {
				JsonElement favoriteCount = (JsonElement)statistics.get("favoriteCount");
				videoInfo.put("favoriteCount", favoriteCount.getAsString());
			}
			//5. commentCount 추출	: 댓글 등록 수
			if(statistics.get("commentCount") != null) {
				JsonElement commentCount = (JsonElement)statistics.get("commentCount");
				videoInfo.put("commentCount", commentCount.getAsString());
			}
		}
		return videoInfo;
	}
}
