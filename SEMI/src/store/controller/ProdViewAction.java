package store.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;
import store.model.InterStoreDAO;
import store.model.StoreDAO;
import store.model.StoreVO;

public class ProdViewAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String pnum = req.getParameter("pnum");
		
		try {
			Integer.parseInt(pnum);
		} catch (NumberFormatException e) {
			String msg = "잘못된 경로입니다.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			
			return;
		}
		
		InterStoreDAO sdao = new StoreDAO();
		
		StoreVO svo = sdao.getOneProduct(pnum);
		List<HashMap<String, String>> imageList = sdao.getProdImage(pnum);
		List<HashMap<String, String>> colorList = sdao.getProdColor(pnum);
		HashMap<String, String> prodSpec = sdao.getProdSpec(pnum);
		
		String fk_bcode = "";
		
		if(svo != null)
			fk_bcode = svo.getFk_bcode();
		
		if("데스크탑".equals(fk_bcode) || "노트북".equals(fk_bcode)) {
			List<HashMap<String, String>> ramList = sdao.getProdRam(pnum);
			List<HashMap<String, String>> hddList = sdao.getProdStorage(pnum, "0");
			List<HashMap<String, String>> ssdList = sdao.getProdStorage(pnum, "1");
			
			req.setAttribute("ramList", ramList);
			req.setAttribute("hddList", hddList);
			req.setAttribute("ssdList", ssdList);
		}
		
		req.setAttribute("svo", svo);
		req.setAttribute("imageList", imageList);
		req.setAttribute("colorList", colorList);
		req.setAttribute("prodSpec", prodSpec);
		
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/shopping/prodview.jsp");
		
	}// end of execute()-----------------------------------

}
