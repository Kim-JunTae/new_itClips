package com.itClips.util;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;
import java.util.List;
import java.util.Map;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class KOFIC_API {
	
	public List<Map<String, String>> searchWeeklyBoxOffice(int date) throws Exception{
		
		List<Map<String, String>> response = new ArrayList<Map<String,String>>();
		
		String apiurl = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json";
			   apiurl += "?key=3fb8a3781613708291f377177803cf97";
			   apiurl += "&targetDt=" + date;
		
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
		
		//System.out.println(result);
		
		//json으로
		JsonParser jsonParser = new JsonParser();
		JsonObject object = (JsonObject) jsonParser.parse(result.toString());
		JsonObject boxOfficeResult = (JsonObject) object.get("boxOfficeResult");
		
		//System.out.println(boxOfficeResult);
		
		JsonArray list = (JsonArray) boxOfficeResult.get("weeklyBoxOfficeList");
		for(int i=0; i<list.size(); i++) {
			JsonObject movie = (JsonObject)list.get(i);
			
			Map<String, String> map = new Hashtable<String, String>();
			
			//JSON name으로 추출
			//1. movieCd(영화 대표코드) -> koficId
			map.put("koficId", movie.get("movieCd").getAsString());
			
			//2. movieNm(영화명 국문) -> title
			map.put("title", movie.get("movieNm").getAsString());
			
			//3. openDt(개봉일)
			map.put("openDt",movie.get("openDt").getAsString());
			
			//4. salesAcc(누적매출액)
			map.put("salesAcc",movie.get("salesAcc").getAsString());
			
			//5. audiAcc(누적관객수)
			map.put("audiAcc",movie.get("audiAcc").getAsString());
			
			response.add(map);
		}
		
		return response;
	}
	
//	public String getYesterday() {
//	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
//	
//	Calendar cal = Calendar.getInstance();
//	cal.add(Calendar.DATE, -1);
//	
//	String yesterday = dateFormat.format(cal.getTime());
//	
//	return yesterday;
//}//end getYesterday()
//
//public String searchDailyBoxOffice() throws Exception{
//	
//	String apiurl = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json";
//	apiurl += "?key=3fb8a3781613708291f377177803cf97";
//	apiurl += "&targetDt=" + getYesterday();
//	
//	System.out.println(getYesterday());
//	
//	URL url = new URL(apiurl);
//	HttpURLConnection con = (HttpURLConnection) url.openConnection();
//	con.setRequestMethod("GET");
//	
//	BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
//	String inputLine;
//	StringBuffer response = new StringBuffer();
//	while((inputLine = br.readLine()) != null) {
//		response.append(inputLine);
//	}
//	br.close();
//	
//	return response.toString();
//}
}
