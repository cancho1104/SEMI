package cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.model.CartDAO;
import common.controller.AbstractController;
import user.model.UserVO;

public class CartDelAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		HttpSession session = req.getSession();
		UserVO loginuser = (UserVO)session.getAttribute("loginuser");
		if(loginuser == null) {
			String msg = "로그인해주세요.";
			String loc = "javascript:history.back()";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("WEB-INF/msg.jsp");
			return;
		}
		String str_pnum = req.getParameter("pnum");
		int pnum = 0;
		try {
			pnum = Integer.parseInt(str_pnum);
		}catch(NumberFormatException e) {
			String msg = "숫자를 입력해주세요..";
			String loc = "javascript:history.back()";
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		CartDAO cdao = new CartDAO();
		int result = cdao.cartDelete(pnum);
	
		if(result == 1) {
			String msg = "삭제되었습니다.";
			String loc = "cartList.do";
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}else {
			String msg = "삭제 실패.";
			String loc = "javascript:history.back()";
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
		
	}

}
