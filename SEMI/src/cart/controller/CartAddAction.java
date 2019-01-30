package cart.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import cart.model.CartDAO;
import cart.model.InterCartDAO;
import common.controller.AbstractController;
import user.model.UserVO;

public class CartAddAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String pnum = req.getParameter("pnum");
		String userid =req.getParameter("userid");
		String color = req.getParameter("color");
		String oqty = req.getParameter("oqty");
		String str_saleprice = req.getParameter("saleprice");
		//System.out.println(pnum);
		InterCartDAO cdao = new CartDAO();
		int saleprice = Integer.parseInt(str_saleprice);
		System.out.println("pnum:"+pnum+",userid:"+userid+",color:"+color+",oqty:"+oqty+",saleprice:"+saleprice);
		int n = cdao.insertCartList(Integer.parseInt(pnum),userid,color,oqty, saleprice);
		String msg = "";
		if(n==1) {
			msg = "장바구니 담기 성공";
		}else {
			msg = "장바구니 담기 실패";
		}
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("msg", msg);
		String str_jsonMsg = jsonObj.toString();
		req.setAttribute("str_jsonMsg", str_jsonMsg);
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/cart/cartAddJSON.jsp");
	}

}
