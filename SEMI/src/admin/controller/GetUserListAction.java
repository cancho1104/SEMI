package admin.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import common.controller.AbstractController;
import user.model.InterUserDAO;
import user.model.UserDAO;
import user.model.UserVO;

public class GetUserListAction extends AbstractController {

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
		
		String sort = req.getParameter("sort");
		String pageNo = req.getParameter("pageNo");
		String sizePerPage = req.getParameter("sizePerPage");
		
		if( pageNo == null || "".equals(pageNo.trim())) {
			pageNo = "1";
		}
		
		if( sizePerPage == null || "".equals(sizePerPage.trim())) {
			sizePerPage = "5";
		}
		
		int isizePerPage = Integer.parseInt(sizePerPage);
		int ipageNo = Integer.parseInt(pageNo);
		
		InterUserDAO udao = new UserDAO();
		
		List<UserVO> uvoList = udao.getUserList(sort, ipageNo, isizePerPage);
		
		JSONArray jsonArr = new JSONArray();
		
		if(uvoList != null && uvoList.size() > 0) {
			for(UserVO uvo : uvoList) {
				JSONObject jsonObj = new JSONObject();
				
				
				jsonObj.put("userid", uvo.getUserid());
				jsonObj.put("idx", uvo.getIdx());
				jsonObj.put("name", uvo.getName());
				jsonObj.put("email", uvo.getEmail());
				jsonObj.put("hp", uvo.getHp());
				jsonObj.put("addr", uvo.getAddr());
				jsonObj.put("addrDetail", uvo.getAddrDetail());
				jsonObj.put("post", uvo.getPost());
				jsonObj.put("totalpoint", uvo.getTotalpoint());
				jsonObj.put("birth", uvo.getBirth());
				jsonObj.put("gender", uvo.getGender());
				jsonObj.put("sumPurchasePrice", uvo.getSumPurchasePrice());
				jsonObj.put("gender", uvo.getGender());
				jsonObj.put("last_LoginDate", uvo.getLast_LoginDate());
				jsonObj.put("last_PwdChangeDate", uvo.getLast_PwdChangeDate());
				jsonObj.put("registDate", uvo.getRegistDate());
				jsonObj.put("status", uvo.getStatus());
				jsonObj.put("grade_name", uvo.getGrade_name());
				
				jsonArr.add(jsonObj);
				
			}
		}
		 
		String str_jsonArray = jsonArr.toString();
		
		req.setAttribute("str_jsonArray", str_jsonArray);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/admin/userListJSON.jsp");
		
	}// end of execute()----------------------------

}
