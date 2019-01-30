package my.util;


import javax.servlet.http.HttpServletRequest;


public class MyUtil {
	
	// *** ?다음의 데이터까지 포함 현재 URL주소를 알려주는 메소드 *** //
	public static String getCurrentURL(HttpServletRequest request) { 
		
		String currentURL = request.getRequestURL().toString();
		// http://localhost:9090/MyWeb/member/memberList.jsp
		
		String queryString = request.getQueryString();
		// searchType=name&searchWord=유미&sizePerPage=5&period=60
		
		currentURL += "?" + queryString;
		// http://localhost:9090/MyWeb/member/memberList.jsp?searchType=name&searchWord=%EC%9C%A0%EB%AF%B8&sizePerPage=5&period=60
		
		String ctxPath = request.getContextPath();
		// /MyWeb
		
		int beginIndex = currentURL.indexOf(ctxPath) + ctxPath.length();
		// 21 + 6 ==> 27
		
		currentURL = currentURL.substring(beginIndex+1);
		
		return currentURL;
	}// end of getCurrentURL()------------------------

	
	// ===== **** 검색어  및 날짜구간(period)이 포함된 페이지바 만들기 **** ===== //
	
	public static String getSearchPageBar(String url, int currentShowPageNo, int sizePerPage, int totalPage,
			int blockSize, String searchType, String searchWord, int period) {
		
		String pageBar = "";
		
		// blockSize는 1개 블럭(토막)당 보여지는 페이지번호의 갯수이다.
		/*
			1 2 3 4 5 6 7 8 9 10			-- 1개블럭
			11 12 13 14 15 16 17 18 19 20	-- 1개블럭
		*/

		int loop = 1;
		/*
			loop 는 1부터 증가하여 1개 블럭을 이루는 페이지번호의 갯수(지금은 10개)까지만
			증가하는 용도이다.
		*/
		
			
		int pageNo = ( (currentShowPageNo - 1)/blockSize) * blockSize + 1; 
		// **** !!! 공식이다 !!! **** //
		/* 한 블럭당 10개씩 목록 표시해주는 공식
			1 2 3 4 5 6 7 8 9 10			-- 첫번째 블럭의 페이지번호 시작값(pageNo)은 1 이다.
			11 12 13 14 15 16 17 18 19 20	-- 두번째 블럭의 페이지번호 시작값(pageNo)은 11 이다.
			
			currentShowPageNo	pageNo
			---------------------------
					1			 1 == ((1 - 1)/10) * 10 + 1
					2			 1 == ((2 - 1)/10) * 10 + 1
					3			 1 == ((3 - 1)/10) * 10 + 1
					4			 1 == ((4 - 1)/10) * 10 + 1
					5			 1 == ((5 - 1)/10) * 10 + 1
					6			 1 == ((6 - 1)/10) * 10 + 1
					7			 1 == ((7 - 1)/10) * 10 + 1
					8			 1 == ((8 - 1)/10) * 10 + 1
					9			 1 == ((9 - 1)/10) * 10 + 1
					10			 1 == ((10 - 1)/10) * 10 + 1
					11			 11 == ((11 - 1)/10) * 10 + 1
					12			 11 == ((12 - 1)/10) * 10 + 1
					13			 11 == ((13 - 1)/10) * 10 + 1
					14			 11
					15			 11
					16			 11
					17			 11
					18			 11
					19			 11
					20			 11 == ((20 - 1)/10) * 10 + 1
					21			 21 == ((21 - 1)/10) * 10 + 1
					22			 21 == ((22 - 1)/10) * 10 + 1
					23			 21 == ((23 - 1)/10) * 10 + 1
					...
					29			 21 == ((29 - 1)/10) * 10 + 1
					30			 21 == ((30 - 1)/10) * 10 + 1
		*/
		
		if(pageNo != 1) {
			pageBar += "&nbsp;<a href=\""+ url +"?currentShowPageNo=" + (pageNo-1) + "&sizePerPage=" + sizePerPage + "&searchType=" + searchType + "&searchWord=" + searchWord + "&period=" + period + "\">[이전]</a>&nbsp;";
		}
		
		while( !(loop > blockSize || pageNo > totalPage)) {
			
			if(pageNo != currentShowPageNo)
				pageBar += "&nbsp;<a href=\""+ url +"?currentShowPageNo=" + pageNo + "&sizePerPage=" + sizePerPage + "&searchType=" + searchType + "&searchWord=" + searchWord + "&period=" + period + "\">" + pageNo + "</a>&nbsp;";
			else
				pageBar += "&nbsp;<span style=\"color: red; font-size: 13pt; font-weight: bold; text-decoration: underline; \">" + pageNo + "</span>&nbsp;";
			
			loop++;
			pageNo++;
		}// end of while -----------------------
		
		if( !(pageNo > totalPage) ) {
			pageBar += "&nbsp;<a href=\""+ url +"?currentShowPageNo=" + pageNo + "&sizePerPage=" + sizePerPage + "&searchType=" + searchType + "&searchWord=" + searchWord + "&period=" + period + "\">[다음]</a>&nbsp;";
		}
		
		return pageBar;
		
	}// end of getSearchPageBar()----------------------------------------

}
