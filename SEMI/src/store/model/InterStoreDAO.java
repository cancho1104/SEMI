package store.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterStoreDAO {

	// Top3 상품 가져오는 추상 메소드 //
	List<StoreVO> getTop3() throws SQLException;
	
	// New3 상품 가져오는 추상 메소드 //
	List<StoreVO> getNew3() throws SQLException;
	
	// best(판매량) 8개씩을 가져오는 추상 메소드 //
	HashMap<String, List<StoreVO>> getBest() throws SQLException;
	
	// hit(판매량 best 다음) 10개씩을 가져오는 추상 메소드 //
	HashMap<String, List<StoreVO>> getHit() throws SQLException;
	
	// new(최신 등록순) 12개씩을 가져오는 추상 메소드 //
	HashMap<String, List<StoreVO>> getNew() throws SQLException;
	
	// 상품 리스트를 가져오는 추상 메소드 //
	List<StoreVO> getproductList(String sort, String category, String color, String company, String minprice, String maxprice, int PageNo, int sizePerPage, String searchWord) throws SQLException;
	
	// 상품 리스트 갯수를 알아오는 추상 메소드 //
	int getListTotalCount(String category, String color, String company, String minprice, String maxprice, String searchWord) throws SQLException;
	
	// 제품상세보기 가져오는 추상 메소드 //
	StoreVO getOneProduct(String pnum) throws SQLException;
	
	// 제품상세 추가 이미지를 가져오는 추상 메소드 //
	List<HashMap<String, String>> getProdImage(String pnum) throws SQLException;
	
	// 제품상세 색상을 가져오는 추상 메소드 //
	List<HashMap<String, String>> getProdColor(String pnum) throws SQLException;
	
	// 제품상세 램을 가져오는 추상 메소드 //
	List<HashMap<String, String>> getProdRam(String pnum) throws SQLException;
	
	// 제품상세 저장장치를 가져오는 추상 메소드 //
	List<HashMap<String, String>> getProdStorage(String pnum, String strgtype) throws SQLException;
	
	// 제품상세 상세스펙을 가져오는 추상 메소드 //
	HashMap<String, String> getProdSpec(String pnum) throws SQLException;
	
	// 신상품 12개를 가져오는 추상 메소드 //
	List<StoreVO> getNewList() throws SQLException;
	
	// 제품등록 하는 추상 메소드 //
	boolean registerProduct(String bcategory, String[] colorsArr, String[] storagesArr, String[] ramsArr, String cpu, String mainboard, String power, 
							String pc_case, String screenSize, String os, String company, String pname, int price, int saleprice, String[] pimagesArr, String pcontent, int point, int pqty) throws SQLException;
	
}
