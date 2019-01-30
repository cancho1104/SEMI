package login.controller;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.controller.AbstractController;
import user.model.InterUserDAO;
import user.model.UserDAO;
import user.model.UserVO;

public class LoginEndAction extends AbstractController {

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
		
		
		
		String userid = req.getParameter("userid");
		String pwd = req.getParameter("pwd");
		
		InterUserDAO udao = new UserDAO();
		
		UserVO loginuser = udao.loginUser(userid, pwd);
		
		if(loginuser == null) {
			String msg = "아이디 또는 비밀번호가 잘못되었습니다.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		if(loginuser.isIdlestatus()) {
			String msg = "휴면계정입니다 관리자에게 문의하세요";
			String loc = "index.do";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		String remember = req.getParameter("remember");
		
		HttpSession session = req.getSession();
		
		session.setAttribute("loginuser", loginuser);
		
		Cookie cookie = new Cookie("remember", loginuser.getUserid());
		
		if(remember != null) {
			cookie.setMaxAge(7*24*60*60); 
		}
		else {
			
			cookie.setMaxAge(0);
		}
		
		cookie.setPath("/");
		
		res.addCookie(cookie);
		
		if(loginuser.isRequirePwdChange() ) {
			String msg = "비밀번호를 변경하신지 6개월이 지났습니다. 암호를 변경하세요";
			String loc = "index.do";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			session.removeAttribute("returnPage");
			return;
		}
		
		super.setRedirect(true);
		super.setViewPage("index.do");
		
	}// end of execute()---------------------

}
