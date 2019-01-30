package user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import user.model.UserDAO;

public class IdDuplicateCheckEndAction extends AbstractController {

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
		
		UserDAO udao = new UserDAO();
		
		String userid = req.getParameter("userid");
		
		boolean idBool = udao.idDuplicateCheck(userid);
		
		JSONObject jsonObj = new JSONObject();
		
		jsonObj.put("idBool", idBool);
		jsonObj.put("userid", userid);
		
		String str_json = jsonObj.toString();
		
		req.setAttribute("userid", userid);
		req.setAttribute("str_json", str_json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/user/idDuplicateCheckJSON.jsp");
		
	}// end of execute()-------------------------

}
