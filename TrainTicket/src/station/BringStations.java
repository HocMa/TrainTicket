package station;

import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.io.BufferedReader;
import java.io.IOException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.FileOutputStream;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.Element;
import java.util.HashMap;
import java.util.ArrayList;

public class BringStations{
	public BringStations() {
	}
	
	/* 모든 광역시, 도의 코드를 추출한 뒤 각 광역시, 도의 도시들의 코드를 얻는다 */
	public static HashMap<String, String> getStations() throws IOException {
		ArrayList<String> citycode = new ArrayList<>();
		citycode = CityCode();
		
		HashMap<String, String> stations = new HashMap<>();
		for(String code : citycode) {
			String total = TotalCount(code);
			HashMap<String, String> eachCity = StationInfo(code, total);
			stations.putAll(eachCity);
		}
		
		return stations;
	}

	/* 도시 코드(광역시, 도) */
	public static ArrayList<String> CityCode() throws IOException {
	    StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/TrainInfoService/getCtyCodeList"); /*URL*/
	    urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=lYFVQEas4F0kVChDgZXnJay1nIu%2FjFYD9nhyMYuirKv8zCM2rHqX1zeRw%2BiONDhntmcBxNayfjq9XRg%2F92Hlew%3D%3D"); /*Service Key*/
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
	    
	    ArrayList<String> citycode = new ArrayList<>();
	    try {
	    	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	    	DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
	    	
	    	FileOutputStream output = new FileOutputStream("./PM10");
	    	output.write(sb.toString().getBytes());
	    	output.close();
	    	
	    	Document doc = dBuilder.parse("./PM10");
	    	doc.getDocumentElement().normalize();
	    	
	    	Element body = (Element) doc.getElementsByTagName("body").item(0);
	    	Element items = (Element) body.getElementsByTagName("items").item(0);
	    	Node cityNum = null;
	    	int num = 0;
	    	
	    	while(true) {
	    		if(items.getElementsByTagName("item").item(num) == null) {
	    			break;
	    		}
	    		Element item = (Element) items.getElementsByTagName("item").item(num);
	        	cityNum = item.getElementsByTagName("citycode").item(0);
	        	
	        	citycode.add(cityNum.getChildNodes().item(0).getNodeValue());
	        	num +=1;
	    	}
	    	
	    } catch (Exception e) {
	    	e.printStackTrace();
	    } 
	    return citycode; 
	}
    
	
	/* 각 광역시, 도의 역개수 */
    public static String TotalCount(String code) throws IOException {
    	StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/TrainInfoService/getCtyAcctoTrainSttnList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=lYFVQEas4F0kVChDgZXnJay1nIu%2FjFYD9nhyMYuirKv8zCM2rHqX1zeRw%2BiONDhntmcBxNayfjq9XRg%2F92Hlew%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode(code, "UTF-8")); /*시/도 ID*/
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
        
        String total= null;
    	try {
        	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        	DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        	
        	FileOutputStream output = new FileOutputStream("./PM11");
        	output.write(sb.toString().getBytes());
        	output.close();
        	
        	Document doc = dBuilder.parse("./PM11");
        	doc.getDocumentElement().normalize();
        	
        	Element body = (Element) doc.getElementsByTagName("body").item(0);
        	Node totalCount = body.getElementsByTagName("totalCount").item(0);
        	total = totalCount.getChildNodes().item(0).getNodeValue();
        	
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return total;
    }
    
    
    
    /* 각 광역시, 도의 역이름 : 역코드 */
    public static HashMap<String, String> StationInfo(String code, String total) throws IOException {
    	StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1613000/TrainInfoService/getCtyAcctoTrainSttnList"); /*URL*/
        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=lYFVQEas4F0kVChDgZXnJay1nIu%2FjFYD9nhyMYuirKv8zCM2rHqX1zeRw%2BiONDhntmcBxNayfjq9XRg%2F92Hlew%3D%3D"); /*Service Key*/
        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode(total, "UTF-8")); /*한 페이지 결과 수*/
        urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8") + "=" + URLEncoder.encode(code, "UTF-8")); /*시/도 ID*/
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
        
        HashMap<String, String> eachCity = new HashMap<String, String>();
    	try {
        	DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
        	DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
        	
        	FileOutputStream output = new FileOutputStream("./PM12");
        	output.write(sb.toString().getBytes());
        	output.close();
        	
        	Document doc = dBuilder.parse("./PM12");
        	doc.getDocumentElement().normalize();
        	
        	Element body = (Element) doc.getElementsByTagName("body").item(0);
        	Element items = (Element) body.getElementsByTagName("items").item(0);
        	Node nodeid = null;
            Node nodename = null;
            
        	for(int i=0; i<Integer.parseInt(total); i++){
	    		Element item = (Element) items.getElementsByTagName("item").item(i);
        		nodeid = item.getElementsByTagName("nodeid").item(0);
        		nodename = item.getElementsByTagName("nodename").item(0);
            	
        		eachCity.put(nodename.getChildNodes().item(0).getNodeValue(), nodeid.getChildNodes().item(0).getNodeValue());
	    	}
        	
        } catch (Exception e) {
        	e.printStackTrace();
        }
    	return eachCity;
    }
}
