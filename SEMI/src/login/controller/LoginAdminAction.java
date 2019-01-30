package login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;

public class LoginAdminAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		HttpSession session = req.getSession();
		
		if(session.getAttribute("loginuser") != null || session.getAttribute("loginadmin") != null) {
			String msg = "로그인 상태에서는 접근이 불가합니다";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/loginAdmin.jsp");
		
	}// end of execute()---------------------------------

}
