$(function(){
	/*메인 슬라이드*/
    const slideWidth = $("#slideShow").width();
	const innerList = $('.inner_list');
	const inners = $('.inner');
	let cnt = 0; // 현재 슬라이드 화면 인덱스
	
	inners.each(function(){
		$(this).css({"width":slideWidth});
	});
	
	// innerList의 width를 inner의 width * inner의 개수로 만들기
	innerList.css({"width":slideWidth*inners.length}); 
	
	$(".slideState").children().on("click", function(){
        if($(this).hasClass("beforeBtn")){
            if(cnt==0){
				innerList.animate({marginLeft:"-="+slideWidth*(inners.length-1)});
                cnt=3;
            } else{
				innerList.animate({marginLeft:"+="+slideWidth});
                cnt--;
            }
        } else if($(this).hasClass("nextBtn")){
            if(cnt==3){
				innerList.animate({marginLeft:"+="+slideWidth*(inners.length-1)});
                cnt=0;
            } else{
				innerList.animate({marginLeft:"-="+slideWidth});
                cnt++;
            }
        } else{
            cnt = $("li").index(this);
        }
        
		clearInterval(interval);
        interval = getInterval();
        $(".slideState .on").removeClass("on");
        $(".slideState li").eq(cnt).addClass("on");
    });
    
    const getInterval = () => {
	  return setInterval(() => {
	    cnt++;
	    cnt = cnt >= inners.length ? 0 : cnt;
	    $(".slideState .on").removeClass("on");
        $(".slideState li").eq(cnt).addClass("on");
	    innerList.animate({marginLeft:-slideWidth * cnt});
	  }, 2000);
	}
	
	let interval = getInterval();
    
    /* 정기 선택시 인원정보 사라짐*/
    $("#regular").on("click", function(){
    	if($("#regular").is(":checked")){
            $("#pp_num").addClass("visible");
            $("#for_date").text("시작 날짜");
        }
    });
    
    /* 일반 선택시 인원정보 나타남*/
    $("#general").on("click", function(){
    	if($("#general").is(":checked")){
            $("#pp_num").removeClass("visible");
            $("#for_date").text("출발 날짜");
		}
    });
    
    $(".cncBtn").on("click", function(){
    	var result = confirm("정말 예매를 취소 하시겠습니까?");
    	if(!result){
    		event.returnValue=false;
    	}
    });
});

/*주민등록번호 입력 시*/
function CheckNum(){
	if(!(event.keyCode >= 48 && event.keyCode <= 57)){
		alert("숫자만 입력 가능합니다.");
		event.returnValue=false;
	}
}
/*이름 입력 시*/
function CheckChar(){
	if(!((event.keyCode >= 12592 && event.keyCode <= 12687) || 
	(event.keyCode >= 65 && event.keyCode <= 90) || (event.keyCode >= 97 && event.keyCode <= 122))){
		alert("문자만 입력 가능합니다.");
		event.returnValue=false;
	}
}
/*아이디 입력 시*/
function CheckSpecial(){
	if((event.keyCode >= 33 && event.keyCode <= 47) || (event.keyCode >= 58 && event.keyCode <= 64)
			|| (event.keyCode >= 91 && event.keyCode <= 96) || (event.keyCode >= 123 && event.keyCode <= 126)){
		alert("특수문자는 입력이 불가능합니다.");
		event.returnValue=false;
	}
}

/*회원가입시 비밀번호 체크*/
function PwChk(){
	var pw = document.getElementById("user_pw");
	var pwchk = document.getElementById("user_pwchk");
	
	if(pw.value != pwchk.value){
		alert("비밀번호가 다릅니다.");
		event.returnValue=false;
	}
}

function Sure(){
	var result = confirm("정말 회원 탈퇴를 하시겠습니까?");
	if(!result){
		event.returnValue=false;
	}
}

function CncChk(){
	var result = confirm("정말 예매를 취소 하시겠습니까?");
	if(!result){
		event.returnValue=false;
	}
}