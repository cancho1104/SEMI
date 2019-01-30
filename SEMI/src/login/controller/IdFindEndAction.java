package login.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import user.model.InterUserDAO;
import user.model.UserDAO;

public class IdFindEndAction extends AbstractController {

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
		
		InterUserDAO udao = new UserDAO();
		
		String name = req.getParameter("name");
		String email = req.getParameter("email");
		
		String userid = udao.findUserid(name, email);
		
		if(userid != "") {
			userid = userid.substring(0, 2) + "***" + userid.substring(userid.length()-2);
		}
		

		JSONObject jsonObj = new JSONObject();
		jsonObj.put("userid", userid);
		
		String str_json = jsonObj.toString();
		
		req.setAttribute("userid", str_json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/idFindJSON.jsp");
		
	}// end of execute()-------------------------

}
