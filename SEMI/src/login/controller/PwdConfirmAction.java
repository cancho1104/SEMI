package login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import user.model.InterUserDAO;
import user.model.UserDAO;

public class PwdConfirmAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String method = req.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			String msg = "비정상적인 경로입니다.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		String pwd = req.getParameter("pwd");
		String userid = req.getParameter("userid");
		
		InterUserDAO udao = new UserDAO();
		
		int n = udao.ChangePwd(userid, pwd);
		
		if(n == 0) {
			String msg = "비밀번호 변경이 실패했습니다.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		String msg = "비밀번호가 변경되었습니다.";
		String loc = "login.do";
		
		req.setAttribute("msg", msg);
		req.setAttribute("loc", loc);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/msg.jsp");
		
		
	}// end of execute()--------------------------

}
