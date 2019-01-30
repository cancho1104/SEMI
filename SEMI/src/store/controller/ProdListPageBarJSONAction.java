package store.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import common.controller.AbstractController;
import store.model.InterStoreDAO;
import store.model.StoreDAO;

public class ProdListPageBarJSONAction extends AbstractController {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String category = req.getParameter("category");
		String color = req.getParameter("color");
		String company = req.getParameter("company");
		String minprice = req.getParameter("minprice");
		String maxprice = req.getParameter("maxprice");
		String sizePerPage = req.getParameter("sizePerPage");
		String searchWord = req.getParameter("searchWord");
		
		if( category == null || "".equals(category.trim())) {
			category = "";
		}
		
		if( color == null || "".equals(color.trim())) {
			color = "";
		}
		
		if( company == null || "".equals(company.trim())) {
			company = "";
		}
		
		if( minprice == null || "".equals(minprice.trim())) {
			minprice = "0";
		}
		
		if( maxprice == null || "".equals(maxprice.trim())) {
			maxprice = "200";
		}
		
		if( sizePerPage == null || "".equals(sizePerPage.trim())) {
			sizePerPage = "5";
		}
		
		InterStoreDAO sdao = new StoreDAO();
		
		int totalCount = sdao.getListTotalCount(category, color, company, minprice, maxprice, searchWord);
		
		int totalPage = (int)Math.ceil((double)totalCount/Integer.parseInt(sizePerPage)); 
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("totalPage", totalPage);
		jsonObj.put("totalCount", totalCount);
		
		String str_totalPage = jsonObj.toString();
		
		
		req.setAttribute("str_totalPage", str_totalPage);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/shopping/PageBarJSON.jsp");
		
	}// end of execute()----------------------

}
