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

public class GetNewProdListJSONAction extends AbstractController {

	@SuppressWarnings("unchecked")
	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		InterStoreDAO sdao = new StoreDAO();
		
		List<StoreVO> newList =  sdao.getNewList();
		
		JSONArray jsonArr = new JSONArray();
		
		if(newList != null) {
		
			for(StoreVO svo : newList) {
				
				JSONObject jsonObj = new JSONObject();
				
				int pnum = svo.getPnum();
				String fk_bcode = svo.getFk_bcode();
				String pname = svo.getPname();
				String company = svo.getCompany();
				int price = svo.getPrice();
				int saleprice = svo.getSaleprice();
				String pimage = svo.getPimage();
				int oqty = svo.getOqty();
				String pcontent = svo.getPcontent();
				int point = svo.getPoint();
				int pqty = svo.getPqty();
				String pdate = svo.getPdate();
				String asdate = svo.getAsdate();
				int percent = svo.getPercent();
				
				jsonObj.put("pnum", pnum);
				jsonObj.put("fk_bcode", fk_bcode);
				jsonObj.put("pname", pname);
				jsonObj.put("company", company);
				jsonObj.put("price", price);
				jsonObj.put("saleprice", saleprice);
				jsonObj.put("pimage", pimage);
				jsonObj.put("oqty", oqty);
				jsonObj.put("pcontent", pcontent);
				jsonObj.put("point", point);
				jsonObj.put("pqty", pqty);
				jsonObj.put("pdate", pdate);
				jsonObj.put("asdate", asdate);
				jsonObj.put("percent", percent);
				
				jsonArr.add(jsonObj);
				
			}// end of for----------------
		}// end of if-------------------------
		
		String str_JsonArr = jsonArr.toString();
		
		req.setAttribute("str_JsonArr", str_JsonArr);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/shopping/newProdListJSON.jsp");
		
	}// end of execute()--------------------------------

}
