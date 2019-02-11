package cart.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.model.CartDAO;
import cart.model.CartVO;
import cart.model.InterCartDAO;
import common.controller.AbstractController;
import user.model.UserVO;

public class CartListAction extends AbstractController {

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
		
		InterCartDAO cdao = new CartDAO();
		List<CartVO> cartList = cdao.getCartListByUser(loginuser.getUserid());
		
		req.setAttribute("cartList", cartList);
		super.setViewPage("/WEB-INF/shopping/cart/cartList.jsp");
	}

}
