package store.controller;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import common.controller.AbstractController;
import store.model.InterStoreDAO;
import store.model.StoreDAO;
import store.model.StoreVO;

public class IndexAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		InterStoreDAO sdao = new StoreDAO();
		
		List<StoreVO> top3List = sdao.getTop3();
		List<StoreVO> new3List = sdao.getNew3();
		
		HashMap<String, List<StoreVO>> bestMap = sdao.getBest();
		HashMap<String, List<StoreVO>> hitMap = sdao.getHit();
		HashMap<String, List<StoreVO>> newMap = sdao.getNew();
		
		req.setAttribute("top3List", top3List);
		req.setAttribute("bestMap", bestMap);
		req.setAttribute("hitMap", hitMap);
		req.setAttribute("newMap", newMap);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/index.jsp");
		
	}// end of execute()------------------------------------

}
