package admin.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import user.model.InterUserDAO;
import user.model.UserDAO;

public class UserAbleJSONAction extends AbstractController {

	@SuppressWarnings("unchecked")
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
		
		String method = req.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			String msg = "잘못된 경로입니다.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		String idx = req.getParameter("idx");
		
		InterUserDAO udao = new UserDAO();
		
		int n = udao.ableUser(idx);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("result", n);
		
		String str_json = jsonObj.toString();
		
		req.setAttribute("str_json", str_json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/admin/jsonResult.jsp");
		
	}// end of execute()--------------------------

}
