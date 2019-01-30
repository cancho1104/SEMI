package common.controller;

public abstract class AbstractController implements Command {
	
	private boolean isRedirect = false;
	/*
		* 이것은 우리끼리의 약속이다. *
		
		VIEW단 페이지(.jsp 페이지)로 이동시
		sendRedirect 방법으로 이동시키고자 한다라면
		isRedirect 변수의 값을 true 로 한다.
		
		VIEW단 페이지(.jsp 페이지)로 이동시
		forward 방법으로 이동시키고자 한다라면
		isRedirect 변수의 값을 false 로 한다.
	*/
	
	private String viewPage;
	// VIEW단 페이지(.jsp 페이지)의 경로명으로 사용되어지는 변수이다.

	public boolean isRedirect() {
		return isRedirect;
	}// 리턴타입이 불린이라면 get 이 아니라 is 로 나타난다.

	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

	public String getViewPage() {
		return viewPage;
	}

	public void setViewPage(String viewPage) {
		this.viewPage = viewPage;
	}
	
	
	/*// **** 로그인 유무를 검사해서
	// 로그인 했으면 사용자의 정보(MemberVO)를 return 해주고
	// 로그인 안했으면 null을 return 해주는 메소드 생성하기 **** //
	public MemberVO getLoginUser(HttpServletRequest req, HttpServletResponse res) {
		
		MemberVO loginuser = new MemberVO();
		
		HttpSession session = req.getSession();
		
		loginuser = (MemberVO)session.getAttribute("loginuser");
		
		if(loginuser == null) {
			
			String msg = "로그인을 해주세요";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			isRedirect = false;
			viewPage = "/WEB-INF/msg.jsp";	
		}
		
		return loginuser;
		
	}// end of checkLoginUser()-----------------------------

	
	public void getCategoryList(HttpServletRequest req) throws SQLException{
		
		// jsp_category 테이블에서
		// 카테고리코드(code)와 카테고리명(cname)을 가져와서
		// request 영역에 저장시킨다.
		ProductDAO pdao = new ProductDAO();
		List<CategoryVO> categoryList = pdao.getCategoryList();
		
		req.setAttribute("categoryList", categoryList);
		
	}// end of getCategoryList() -----------------------------------
*/	
	
}
