package admin.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import user.model.InterUserDAO;
import user.model.UserDAO;

public class UserListPageBarJSONAction extends AbstractController {

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
		
		String sizePerPage = req.getParameter("sizePerPage");
		
		if( sizePerPage == null || "".equals(sizePerPage.trim())) {
			sizePerPage = "5";
		}
		
		
		InterUserDAO udao = new UserDAO();
		
		int totalCount = udao.getUserTotalCount();
		
		int totalPage = (int)Math.ceil((double)totalCount/Integer.parseInt(sizePerPage)); 
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalPage", totalPage);
		jsonObj.put("totalCount", totalCount);
		
		String str_totalPage = jsonObj.toString();
		
		
		req.setAttribute("str_totalPage", str_totalPage);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/admin/PageBarJSON.jsp");
		
	}// end of execute()-----------------------------

}
