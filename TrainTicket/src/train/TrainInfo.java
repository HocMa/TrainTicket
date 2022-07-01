package train;

import java.io.Serializable;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;

import java.io.BufferedReader;
import java.io.FileOutputStream;
import java.io.IOException;

public class TrainInfo implements java.io.Serializable{
	public TrainInfo(){
	}
	
	/* 최종 도출 */
	public ArrayList<ArrayList<String>> getTrainInfo(String depStCode, String arrvStCode, String trainKnd, String depTime, String cnt) throws IOException {
		ArrayList<ArrayList<String>> finalInfo = new ArrayList<ArrayList<String>>();
		if(trainKnd.equals("KTX")){
			finalInfo = TrainlInfo(depStCode, arrvStCode, "00", cnt, depTime);
		} else if(trainKnd.equals("ITX")){
			finalInfo = TrainlInfo(depStCode, arrvStCode, "08", cnt, depTime);
		} else {
			ArrayList<ArrayList<String>> temInfo = new ArrayList<ArrayList<String>>();
			ArrayList<ArrayList<String>> finalInfo_1 = TrainlInfo(depStCode, arrvStCode, "00", cnt, depTime);
			ArrayList<ArrayList<String>> finalInfo_2 = TrainlInfo(depStCode, arrvStCode, "08", cnt, depTime);
			temInfo.addAll(finalInfo_1);
			temInfo.addAll(finalInfo_2);
  
	        // 정렬할 key를 지정한다.
	        ArrayList<String> arrSortKey = new ArrayList<String>();
	        
	        // Key에 해당하는 Data를 추출하고, 정렬한다.
	        for( int i=0; i<temInfo.size(); i++) arrSortKey.add(temInfo.get(i).get(2));
	        Collections.sort(arrSortKey);
	        
	        // 정렬된 Key정보를 이용하여 데이터를 추출, 적재한다.
	        for(int i=0; i<arrSortKey.size(); i++){
	            
	            for(int k=0; k<temInfo.size(); k++){
	                
	                if(arrSortKey.get(i).equals(temInfo.get(k).get(2))){
	                    
	                	finalInfo.add(temInfo.get(k));
	                    temInfo.remove(k);
	                    break;
	                }
	            }
	        }
		}
		return finalInfo;
	}
	
	/* 종합 기차 정보(기차종류, 기차번호, 출발시간, 도착시간, 기차비용) */
    public ArrayList<ArrayList<String>> TrainlInfo(String depStCode, String arrvStCode, String trainKnd, String cnt, String depTime) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/TrainInfoService/getStrtpntAlocFndTrainInfo"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=lYFVQEas4F0kVChDgZXnJay1nIu%2FjFYD9nhyMYuirKv8zCM2rHqX1zeRw%2BiONDhntmcBxNayfjq9XRg%2F92Hlew%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(cnt, "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("depPlaceId","UTF-8") + "=" + URLEncoder.encode(depStCode, "UTF-8")); /*출발기차역ID [상세기능3. 시/도별 기차역 목록조회]에서 조회 가능*/
        urlBuilder.append("&" + URLEncoder.encode("arrPlaceId","UTF-8") + "=" + URLEncoder.encode(arrvStCode, "UTF-8")); /*도착기차역ID [상세기능3. 시/도별 기차역 목록조회]에서 조회 가능*/
        urlBuilder.append("&" + URLEncoder.encode("depPlandTime","UTF-8") + "=" + URLEncoder.encode(depTime, "UTF-8")); /*출발일(YYYYMMDD)*/
        urlBuilder.append("&" + URLEncoder.encode("trainGradeCode","UTF-8") + "=" + URLEncoder.encode(trainKnd, "UTF-8")); /*차량종류코드*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        
        ArrayList<ArrayList<String>> TrainlInfo = new ArrayList<ArrayList<String>>();
        
        Node adultcharge = null;
        Node arrplandtime = null;
        Node depplandtime = null;
        Node traingradename = null;
        Node trainno = null;
    	try {
        	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        	DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        	
        	FileOutputStream output = new FileOutputStream("./PM13");
        	output.write(sb.toString().getBytes());
        	output.close();
        	
        	Document doc = dBuilder.parse("./PM13");
        	doc.getDocumentElement().normalize();
        	
        	Element body = (Element) doc.getElementsByTagName("body").item(0);
	    	Element items = (Element) body.getElementsByTagName("items").item(0);
	    	for(int i=0; i<Integer.parseInt(cnt); i++) {
	    		ArrayList<String> eachTrain = new ArrayList<String>();
        		Element item = (Element) items.getElementsByTagName("item").item(i);
        		depplandtime = item.getElementsByTagName("depplandtime").item(0);
        		
        		LocalDateTime now = LocalDateTime.now();
				String formatedNow = now.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
        		
				long lvTime = Long.parseLong(depplandtime.getChildNodes().item(0).getNodeValue());
				long nTime = Long.parseLong(formatedNow);
				
				if(lvTime >= nTime) {
	    			trainno = item.getElementsByTagName("trainno").item(0);
	    			arrplandtime = item.getElementsByTagName("arrplandtime").item(0);
	    			adultcharge = item.getElementsByTagName("adultcharge").item(0);
	    			traingradename = item.getElementsByTagName("traingradename").item(0);
	    			
	    			eachTrain.add(traingradename.getChildNodes().item(0).getNodeValue());
	    			eachTrain.add(trainno.getChildNodes().item(0).getNodeValue());
	    			eachTrain.add(depplandtime.getChildNodes().item(0).getNodeValue());
	    			eachTrain.add(arrplandtime.getChildNodes().item(0).getNodeValue());
	    			eachTrain.add(adultcharge.getChildNodes().item(0).getNodeValue());
	    			
	    			TrainlInfo.add(eachTrain);
				}
        	}
        	
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return TrainlInfo;
    }
    
    /*기차 유무 & 기차 수*/
    public String TrainCnt(String depSt, String arrvSt, String depTime, String trainNum) throws IOException {
        StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/TrainInfoService/getStrtpntAlocFndTrainInfo"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=lYFVQEas4F0kVChDgZXnJay1nIu%2FjFYD9nhyMYuirKv8zCM2rHqX1zeRw%2BiONDhntmcBxNayfjq9XRg%2F92Hlew%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("depPlaceId","UTF-8") + "=" + URLEncoder.encode(depSt, "UTF-8")); /*출발기차역ID [상세기능3. 시/도별 기차역 목록조회]에서 조회 가능*/
        urlBuilder.append("&" + URLEncoder.encode("arrPlaceId","UTF-8") + "=" + URLEncoder.encode(arrvSt, "UTF-8")); /*도착기차역ID [상세기능3. 시/도별 기차역 목록조회]에서 조회 가능*/
        urlBuilder.append("&" + URLEncoder.encode("depPlandTime","UTF-8") + "=" + URLEncoder.encode(depTime, "UTF-8")); /*출발일(YYYYMMDD)*/
        urlBuilder.append("&" + URLEncoder.encode("trainGradeCode","UTF-8") + "=" + URLEncoder.encode(trainNum, "UTF-8")); /*차량종류코드*/
        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        
        String trainCnt= null;
    	try {
        	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        	DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        	
        	FileOutputStream output = new FileOutputStream("./PM14");
        	output.write(sb.toString().getBytes());
        	output.close();
        	
        	Document doc = dBuilder.parse("./PM14");
        	doc.getDocumentElement().normalize();
        	
        	Element body = (Element) doc.getElementsByTagName("body").item(0);
        	Node totalCount = body.getElementsByTagName("totalCount").item(0);
        	trainCnt = totalCount.getChildNodes().item(0).getNodeValue();
        	
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return trainCnt;
    }
}