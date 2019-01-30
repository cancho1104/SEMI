package store.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import common.controller.AbstractController;
import store.model.InterStoreDAO;
import store.model.StoreDAO;
import store.model.StoreVO;

public class GetProdListAction extends AbstractController {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String sort = req.getParameter("sort");
		String category = req.getParameter("category");
		String color = req.getParameter("color");
		String company = req.getParameter("company");
		String minprice = req.getParameter("minprice");
		String maxprice = req.getParameter("maxprice");
		String pageNo = req.getParameter("pageNo");
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
		
		if( pageNo == null || "".equals(pageNo.trim())) {
			pageNo = "1";
		}
		
		if( sizePerPage == null || "".equals(sizePerPage.trim())) {
			sizePerPage = "5";
		}
		
		int isizePerPage = Integer.parseInt(sizePerPage);
		int ipageNo = Integer.parseInt(pageNo);
		
		InterStoreDAO sdao = new StoreDAO();
		
		List<StoreVO> productList = sdao.getproductList(sort, category, color, company, minprice, maxprice, ipageNo, isizePerPage, searchWord);
		
		JSONArray jsonArr = new JSONArray();
		
		if(productList != null && productList.size() > 0) {
			for(StoreVO svo : productList) {
				JSONObject jsonObj = new JSONObject();
				
				
				jsonObj.put("pnum",svo.getPnum());
				jsonObj.put("fk_bcode",svo.getFk_bcode());
				jsonObj.put("pname",svo.getPname());
				jsonObj.put("company",svo.getCompany());
				jsonObj.put("price",svo.getPrice());
				jsonObj.put("saleprice",svo.getSaleprice());
				jsonObj.put("pimage",svo.getPimage());
				jsonObj.put("oqty",svo.getOqty());
				jsonObj.put("pcontent",svo.getPcontent());
				jsonObj.put("point",svo.getPoint());
				jsonObj.put("pqty",svo.getPqty());
				jsonObj.put("pspec",svo.getPdate());
				jsonObj.put("pinputdate",svo.getAsdate());
				jsonObj.put("percent",svo.getPercent());
				
				jsonArr.add(jsonObj);
			}
		}
		 
		String str_jsonArray = jsonArr.toString();
		
		req.setAttribute("str_jsonArray", str_jsonArray);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/shopping/prodListJSON.jsp");
		
	}// end of execute()----------------------

}
