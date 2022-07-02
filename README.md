# TrainTicket
  - 목적
    + HTML5, CSS3, JavaScript를 학습하여 프론트 엔드에서의 기본적인 디자인과 Java를 학습한 것을 바탕으로 JSP의 활용, JDBC를 이용한 MySQL과의 연동으로 동적 웹페이지를 구현하여 이들에 익숙해 지고자 이 사이트를 만들게 되었다.
  - 기차표 예매 사이트 : http://trainticket.tk/TrainTicket/Main.jsp
# 개발 환경
  - OS : Windows 10 pro
  - IDE : eclipse Enterprise Java Developers 2020-03(4.15.0)
  - Language : JDK 1.8.0_171
  - Server : Apache Tomcat 9.0.63
  - DataBase : MySQL 8.0.20 


# 자동으로 넘어가는 슬라이드 구현
  <img src="https://user-images.githubusercontent.com/90808284/176828812-75c3f574-a77c-4b6e-ae29-91e847d89964.JPG" widht="400px" height="200px" alt="Slide Composition"><img><br>
  기본적인 구성은 위와 같다.
  
  <img src="https://user-images.githubusercontent.com/90808284/176825137-a2961e58-08fe-457b-a135-96f76795cbab.JPG" widht="500px" height="350px" alt="Slide Composition"><img><br>
  .inner_list에 display:flex 속성을 주어 .inner_list안에 #slideShow 크기의 이미지를 가로로 4개 배치하고 슬라이드를 보여주는 #slideShow에 overflow:hidden을 적용시킴으로써 .inner_list의 잘린 부분을 숨긴다. 
  
  <img src="https://user-images.githubusercontent.com/90808284/176825181-5ddd030f-f792-48af-958d-7c465bf89fe7.JPG" widht="700px" height="350px" alt="Slide Composition"><img><br>
  위의 자바스크립트 코드는 이전/다음 버튼도 포함되어 있는 코드다. 쉽게 설명하자면 .inner_list를 #slideShow의 width만큼 좌우로 이동시킴으로써 우리가 보기에는 슬라이드가 다른 슬라이드를 밀어내면서 나타나는 것으로 보이게 된다.


# JDBC로 MySQL과 JSP연동하기
<img src="https://user-images.githubusercontent.com/90808284/176825204-61e6d5a5-8f27-4362-ba7a-4d65528b07cb.JPG" widht="500px" height="300px" alt="Slide Composition"><img><br>
Class.forName()을 사용하여 JDBC의 mysql드라이버를 로들하는 코드이다. 쓰이는 곳이 많으니 다른 파일에서 디렉티브 태그의 include를 사용하여 사용할 수 있도록 dbconn.jsp를 만들었다.


# 공공API에서 기차 데이터 가져오기(src파일)

## 공공API 활용하기
공공데이터 포털: https://www.data.go.kr/tcs/dss/selectApiDataDetailView.do?publicDataPk=15098552
<br>
공공API를 활용하는 부분에서 이번 프로젝트의 상당 시간을 들인것 같다;;;

```
StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/.....);
urlBuilder.append("&" + URLEncoder.encode("cityCode","UTF-8")
URL url = new URL(urlBuilder.toString());
HttpURLConnection conn = (HttpURLConnection) url.openConnection();
conn.setRequestMethod("GET");
```
먼저 url을 urlBuilder에 작성 후 append로 전달요소를 추가하고, urlBuilder로 URL객체를 만들어 HttpURLConnection을 사용하여 GET방식으로 연결한다.

```
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
```
InputStreamReader를 통해 가져온 xml 텍스트를 rd에 저장 후 1줄 단위로 sb에 저장하고 다 사용한 rd와 conn은 닫아준다.

```
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
```
DocumentBuilder객체를 생성해주고 전의 sb를 파일로 만들어 준다
<br>
이 파일에 저장된 도출하고자 하는 데이터를 Element로 접근하고 nodeValue()로 읽어낸다.

## 기차역 데이터 가져오기
<img src="https://user-images.githubusercontent.com/90808284/176826867-b3647d36-c5fd-47fc-b72e-fb65a0913e62.JPG" widht="700px" height="350px" alt="Slide Composition"><img><br>

위의 공공API에서 전국의 모든 역의 이름과 코드를 가져올 수가 없어 각 광역시/도의 코드를 구한 후 그 코드를 통해 모든 역의 이름과 코드를 구하였다.<br>
<br>
각 광역시/도의 역 개수를 구하는 이유는 개수를 넣어주지 않을 경우 구할 수 있는 역의 개수가 10개로 제한되기 때문이다.
<br>
역 이름과 코드는 잘 변하지 않는 데이터이기에 매번 공공API를 통해 불러오기 보다 DB에 저장하여 사용하는 것이 효율적이어서 stations 테이블을 만들고 MakeDB.java를 통해 모든 역의 이름과 코드를 저장하였다.<br>
src/station의 파일들을 한번만 쓰이고 train.sql에 저장되어 있기에 안 써도 되는 파일이다.

## 기차 정보 및 시간 데이터 가져오기
<img src="https://user-images.githubusercontent.com/90808284/176836225-ba87711e-c751-4271-a7c9-5c3fc10ad33d.JPG" widht="400px" height="200px" alt="Slide Composition"><img><br>

TrainCnt()함수로 기차 수를 구해서 BuyTicket.jsp에서 전달받은 정보에 해당하는 기차의 유무를 판단한다.<br>
구한 기차 수와 BuyTicket.jsp에서 받은 정보를 통해 TrainInfo()에서 열차 정보를 반환하고 getTrainInfo()를 통해 정보를 가져올 수 있다.<br>
TrainInfo()에서 현재시간과 기차시간을 비교하는 반복문을 넣어 현재시간 이전의 기차 정보는 반환되지 않게 하였다.

````
<%
  request.setAttribute("minDate", LocalDate.now());
        request.setAttribute("maxDate", LocalDate.now().plusMonths(3));
%>
<label id="for_date" for="date">출발 날짜</label>
<input type="date" id="date" name="date" min="${minDate}" max="${maxDate}" required>
````
위의 코드를 BuyTicket.jsp에 작성함으로써 사용자가 현재 날짜 이전의 날짜를 입력하지 못하게 조정하였다.<br>
<br>
p.s. 공공API에서 기차의 가격이 0으로 된것이 많아 TicketGn.jsp파일에서 가격을 임의로 지정해 주었다.


# MVC패턴을 기반으로 모델2 게시판 구현
<img src="https://user-images.githubusercontent.com/90808284/177004873-72251bd6-506f-44b0-8450-c294311017fb.PNG" widht="400px" height="200px" alt="Slide Composition"><img><br>
위는 게시판을 구현할 때 사용한 MVC패턴을 모식화한 것이다.<br>
<br>
list.jsp파일에서 현재 로그인 중인 id를 session으로 판별하여 관리자 계정인 'admin'이면 글쓰기 링크가 보이도록 하였고, view.jsp에서 또한 관리자 계정을 판별하여 게시글을 수정할 수 있도록 하였다.
