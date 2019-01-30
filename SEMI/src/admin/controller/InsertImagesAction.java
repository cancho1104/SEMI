package admin.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class InsertImagesAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		HttpSession session = req.getSession();
		
		@SuppressWarnings("unchecked")
		HashMap<String, String> loginadmin = (HashMap<String, String>)session.getAttribute("loginadmin");
		
		if(loginadmin == null) {
			String msg = "관리자로 로그인해주세요.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/admin/product/insertImages.jsp");
		
	}// end of execute()-----------------------------------------

}
