package store.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.controller.AbstractController;

public class ProdListAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String search = req.getParameter("serch");
		String searchCategoryCode = req.getParameter("searchCategoryCode");
		
		if("0".equals(searchCategoryCode))
			searchCategoryCode = "";
		
		req.setAttribute("search", search);
		req.setAttribute("searchCategoryCode", searchCategoryCode);
		
		super.setRedirect(false);
		super.setViewPage("/WEB-INF/shopping/prodList.jsp");
		
	}// end of execute()--------------------------------

}
