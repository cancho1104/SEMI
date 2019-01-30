package login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import user.model.InterUserDAO;
import user.model.UserDAO;

public class PwdDuplicateAction extends AbstractController {

	@SuppressWarnings("unchecked")
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
		
		int n = udao.pwdDuplicate(userid, pwd);
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("n", n);
		
		String str_json = jsonObj.toString();
		
		req.setAttribute("str_json", str_json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/pwdDuplicateJSON.jsp");
		
	}// end of execute()--------------------------

}
