package admin.controller;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import common.controller.AbstractController;
import store.model.InterStoreDAO;
import store.model.StoreDAO;

public class RegisterProductEndAction extends AbstractController {

	@Override
	public void execute(HttpServletRequest req, HttpServletResponse res) throws Exception {
		
		String method = req.getMethod();
		
		if(!"POST".equalsIgnoreCase(method)) {
			
			String msg = "잘못된 경로입니다.";
			String loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		HttpSession session = req.getSession();
		ServletContext svlCtx = session.getServletContext(); // 프로그램 전체를 의미한다.
		String imagesDir = svlCtx.getRealPath("/images");
		
		
		MultipartRequest mtreq = null;
		
		int size = ((10 * 1024) * 1024); 
		
		
		try {
			mtreq = new MultipartRequest(req, imagesDir,  size, "UTF-8", new DefaultFileRenamePolicy() );
		} catch (IOException e) {
			req.setAttribute("msg", "파일업로드 실패 ==> 용량 10MB 초과");
			req.setAttribute("loc", "javascript:history.back();");
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
			return;
		}
		
		String bcategory = mtreq.getParameter("bcategory");
		String colors = mtreq.getParameter("colors");
		
		String storages = mtreq.getParameter("storages");
		String rams = mtreq.getParameter("rams");
		String cpu = mtreq.getParameter("cpu");
		String mainboard = mtreq.getParameter("mainboard");
		String power = mtreq.getParameter("power");
		String pc_case = mtreq.getParameter("case");
		String screenSize = mtreq.getParameter("screenSize");
		String os = mtreq.getParameter("os");
		
		String company = mtreq.getParameter("company");
		String pname = mtreq.getParameter("pname");
		String str_price = mtreq.getParameter("price");
		String str_saleprice = mtreq.getParameter("saleprice");
		String pimages = mtreq.getParameter("pimages");
		String pcontent = mtreq.getParameter("pcontent");
		String str_point = mtreq.getParameter("point");
		String str_pqty = mtreq.getParameter("pqty");
		
		System.out.println(rams);
		
		int price = 0, saleprice = 0, point = 0, pqty = 0;
		
		if(str_price != null && !"".equals(str_price.trim()))
			price = Integer.parseInt(str_price);
		
		if(str_saleprice != null && !"".equals(str_saleprice.trim()))
			saleprice = Integer.parseInt(str_saleprice);
		
		if(str_point != null && !"".equals(str_point.trim()))
			point = Integer.parseInt(str_point);
		
		if(str_pqty != null && !"".equals(str_pqty.trim()))
			pqty = Integer.parseInt(str_pqty);
		
		if("1".equals(company))
			company = "삼성";
		if("2".equals(company))
			company = "ASUS";
		if("3".equals(company))
			company = "MSI";
		if("4".equals(company))
			company = "HP";
		if("5".equals(company))
			company = "APPLE";
		
		String[] colorsArr = (colors != null && !"".equals(colors.trim()))?colors.split(","):null;
		String[] storagesArr = (storages != null && !"".equals(storages.trim()))?storages.split(","):null;
		String[] ramsArr = (rams != null && !"".equals(rams.trim()))?rams.split(","):null;
		String[] pimagesArr = (pimages != null && !"".equals(pimages.trim()))?pimages.split(","):null;
		
		
		
		InterStoreDAO sdao = new StoreDAO();
		
		boolean bool = sdao.registerProduct(bcategory, colorsArr, storagesArr, ramsArr, cpu, mainboard, power, pc_case, 
											screenSize, os, company, pname, price, saleprice, pimagesArr, pcontent, point, pqty);
		
		String msg = "";
		String loc = "";
		
		if(bool) {
			msg = "제품이 등록되었습니다.";
			loc = "managementProduct.do";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		else {
			msg = "제품이 등록되었습니다.";
			loc = "javascript:history.back();";
			
			req.setAttribute("msg", msg);
			req.setAttribute("loc", loc);
			
			super.setRedirect(false);
			super.setViewPage("/WEB-INF/msg.jsp");
		}
		
	}// end of execute()--------------------------

}
