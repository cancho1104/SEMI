package user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import user.model.UserDAO;
import user.model.UserVO;

public class UserRegisterEnd extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String method = req.getMethod();
		
		String msg = "";
		String loc = "";
		
		if(!"POST".equalsIgnoreCase(method)) {
			
			msg = "잘못된 경로입니다.";
			loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		String userid = req.getParameter("userid");
		String pwd = req.getParameter("pwd");
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		String hp = req.getParameter("hp");
		String post = req.getParameter("post");
		String addr = req.getParameter("addr");
		String addrDetail = req.getParameter("addrDetail");
		String birthyyyy = req.getParameter("birthyyyy");
		String birthmm = req.getParameter("birthmm");
		String birthdd = req.getParameter("birthdd");
		String gender = req.getParameter("gender");
		
		UserVO uvo = new UserVO(); 
		
		uvo.setUserid(userid);
		uvo.setPwd(pwd);
		uvo.setName(name);
		uvo.setEmail(email);
		uvo.setHp(hp);
		uvo.setPost(post);
		uvo.setAddr(addr);
		uvo.setAddrDetail(addrDetail);
		uvo.setBirthyyyy(birthyyyy);
		uvo.setBirthmm(birthmm);
		uvo.setBirthdd(birthdd);
		uvo.setGender(gender);
		
		UserDAO udao = new UserDAO();
		
		
		int n = udao.insertUser(uvo);
		
		if(n == 1) {
			msg = "회원가입이 성공했습니다";
			loc = "index.do";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		else {
			msg = "회원가입이 실패했습니다";
			loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}// end of execute()------------------------------

}
