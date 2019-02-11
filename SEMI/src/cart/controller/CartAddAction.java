package cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import cart.model.CartDAO;
import cart.model.InterCartDAO;
import common.controller.AbstractController;
import user.model.UserVO;

public class CartAddAction extends AbstractController {

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
		
		int pnum = Integer.parseInt(req.getParameter("pnum"));
		String color = req.getParameter("color");
		String ram = req.getParameter("ram");
		String disk = req.getParameter("disk");
		String oqty = req.getParameter("oqty");
		int totalprice = Integer.parseInt(req.getParameter("totalprice"));
		
		InterCartDAO dao = new CartDAO();
		
		int n = dao.insertCartList(pnum, loginuser.getUserid(), color, oqty, ram, disk, totalprice);
		
		String msg = "";
		String loc = "";
		
		if(n == 1) {
			msg = "장바구니에 등록되었습니다.";
			loc = "cartList.do";
		}
		else {
			msg = "오류가 발생되었습니다.";
			loc = "history.back()";
		}
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		super.setViewPage("/WEB-INF/msg.jsp");
		
	}// end of execute()------------------------------------------------

}
