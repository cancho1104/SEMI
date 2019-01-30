package login.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import common.controller.GoogleMail;
import user.model.InterUserDAO;
import user.model.UserDAO;

public class PwdFindCheckAction extends AbstractController {

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
		String email = req.getParameter("email");
		
		InterUserDAO udao = new UserDAO();
		
		boolean bool = udao.CheckUser(userid, email);
		
		JSONObject jsonObj = new JSONObject();
		
		if(bool) {
			// 회원으로 존재하는 경우
			
			GoogleMail mail = new GoogleMail();
			
			Random rnd = new Random();
			
			String certificationCode = "";
			
			char randchar = ' ';
			for(int i=0; i<5; i++) {
				
				randchar = (char)(rnd.nextInt('z'-'a'+1) + 'a');
				
				certificationCode += randchar;
			}
			
			int randnum = 0;
			for(int i=0; i<7; i++) {
				randnum = rnd.nextInt(9-0+1)+0;
				certificationCode += randnum;
			}
			
			try {
				mail.sendmail(email, certificationCode);
				jsonObj.put("certificationCode", certificationCode);
				jsonObj.put("userid", userid);
				jsonObj.put("email", email);
			
			} catch (Exception e) {
				e.printStackTrace();
				bool = false;
			}
			
		}// end of if---------------------------
		else {
			jsonObj.put("certificationCode", "");
			jsonObj.put("userid", userid);
			jsonObj.put("email", email);
		}
		

		String str_json = jsonObj.toString();
		
		req.setAttribute("str_json", str_json);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/login/pwdFindJSON.jsp");
		
	}// end of execute()-----------------------------------

}
