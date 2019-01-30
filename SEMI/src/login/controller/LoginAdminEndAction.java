package login.controller;

import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import user.model.InterUserDAO;
import user.model.UserDAO;
import user.model.UserVO;

public class LoginAdminEndAction extends AbstractController {

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
		
		String adminid = req.getParameter("adminid");
		String pwd = req.getParameter("pwd");
		
		InterUserDAO udao = new UserDAO();
		
		HashMap<String, String> loginadmin = udao.loginAdmin(adminid, pwd);
		
		if(loginadmin == null) {
			String msg = "아이디 또는 비밀번호가 잘못되었습니다.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		String remember = req.getParameter("remember");
		
		HttpSession session = req.getSession();
		
		session.setAttribute("loginadmin", loginadmin);
		
		Cookie cookie = new Cookie("Aremember", loginadmin.get("admin_id"));
		
		if(remember != null) {
			cookie.setMaxAge(7*24*60*60);
		}
		else {
			
			cookie.setMaxAge(0);
		}
		
		cookie.setPath("/");
		
		res.addCookie(cookie);
		
		super.setRedirect(true);
		super.setViewPage("index.do");
		
	}// end of execute()-----------------------------

}
