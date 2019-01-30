package user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import user.model.UserDAO;

public class IdDuplicateCheckAction extends AbstractController {

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
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/user/idDuplicateCheck.jsp");
		
	}// end of execute()-----------------------------

}
