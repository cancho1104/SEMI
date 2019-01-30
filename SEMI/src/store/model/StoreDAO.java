package store.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jdbc.util.AES256;
import my.util.MyKey;

public class StoreDAO implements InterStoreDAO {

	private DataSource ds = null;
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	AES256 aes = null;
	
	public StoreDAO() {
		
		// DBCP 얻어오는 부분
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
			
			String key = MyKey.key;	// 암호화, 복호화 키
			aes = new AES256(key);
			
		} catch (NamingException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			System.out.println("key 값은 17글자 이상이여야합니다.");
			e.printStackTrace();
		}
		
	}// end of UserDAO() 생성자------------------------------------
	
	// === 사용자 자원을 반납하는 close() 메소드 === //
	public void close() {
		try {
			if(rs != null) {
				rs.close();
				rs = null;
			}
			
			if(pstmt != null) {
				pstmt.close();
				pstmt = null;
			}
			
			if(conn != null) {
				conn.close();
				conn = null;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}// end of close()---------------------------------

	
	// Top3 상품 가져오는 추상 메소드 //
	@Override
	public List<StoreVO> getTop3() throws SQLException {
		
		List<StoreVO> svoList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select row_number() over(order by oqty desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
						 "from semi_product";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt > 3)
					break;
				
				if(cnt == 1) {
					svoList = new ArrayList<StoreVO>();
				}
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				svoList.add(svo);
				
			}// end of while----------------
			
		} finally {
			close();
		}
		
		return svoList;
	}// end of getTop3()------------------
	
	
	@Override
	public List<StoreVO> getNew3() throws SQLException {
		
		List<StoreVO> newList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
						 "from\n"+
						 "(\n"+
						 "    select row_number() over(order by pdate desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
						 "    from semi_product\n"+
						 ") V\n"+
						 "where rno between 1 and 3";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					newList = new ArrayList<StoreVO>();
				}
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				newList.add(svo);
			}
			
		} finally {
			close();
		}
		
		return newList;
	}// end of getNew3()

	
	// best(판매량) 노트북 8개를 가져오는 추상 메소드 //
	@Override
	public HashMap<String, List<StoreVO>> getBest() throws SQLException {
		
		HashMap<String, List<StoreVO>> bestMap = new HashMap<String, List<StoreVO>>();
		
		try {
			
			conn = ds.getConnection();
			
			// 데스크탑 
			String sql = "select row_number() over(order by oqty desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
						 "from semi_product\n"+
						 "where fk_bcode = 100000";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> desktopList = null;
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					desktopList = new ArrayList<StoreVO>();
				}
				
				if(cnt > 8)
					break;
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				desktopList.add(svo);
				
			}// end of while----------------
			
			bestMap.put("desktopList", desktopList);
			
			
			// 노트북 
			sql = "select row_number() over(order by oqty desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "from semi_product\n"+
				  "where fk_bcode = 200000";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> laptopList = null;
			cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					laptopList = new ArrayList<StoreVO>();
				}
				
				if(cnt > 8)
					break;
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				laptopList.add(svo);
				
			}// end of while----------------
			
			bestMap.put("laptopList", laptopList);
			
			// 모니터
			sql = "select row_number() over(order by oqty desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "from semi_product\n"+
				  "where fk_bcode = 300000";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> monitorList = null;
			cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					monitorList = new ArrayList<StoreVO>();
				}
				
				if(cnt > 8)
					break;
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				monitorList.add(svo);
				
			}// end of while----------------
			
			bestMap.put("monitorList", monitorList);
			
			
			// 주변기기
			sql = "select row_number() over(order by oqty desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "from semi_product\n"+
				  "where fk_bcode = 400000";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> otherList = null;
			cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					otherList = new ArrayList<StoreVO>();
				}
				
				if(cnt > 8)
					break;
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				otherList.add(svo);
				
			}// end of while----------------
			
			bestMap.put("otherList", otherList);
			
		} finally {
			close();
		}
		
		return bestMap;
	}// end of getBestLaptop()----------------------

	
	// hit(판매량 best 다음) 10개씩을 가져오는 메소드 //
	@Override
	public HashMap<String, List<StoreVO>> getHit() throws SQLException {
		
		HashMap<String, List<StoreVO>> hitMap = new HashMap<String, List<StoreVO>>();
		
		try {
			
			conn = ds.getConnection();
			
			// 데스크탑 
			String sql = "select rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
						 "from\n"+
						 "(\n"+
						 "    select row_number() over(order by oqty desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
						 "    from semi_product\n"+
						 "    where fk_bcode = 100000\n"+
						 ") V\n"+
						 "where rno between 9 and 18";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> desktopList = null;
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					desktopList = new ArrayList<StoreVO>();
				}
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				desktopList.add(svo);
				
			}// end of while----------------
			
			hitMap.put("desktopList", desktopList);
			
			
			// 노트북 
			sql = "select rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "from\n"+
				  "(\n"+
				  "    select row_number() over(order by oqty desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "    from semi_product\n"+
				  "    where fk_bcode = 200000\n"+
				  ") V\n"+
				  "where rno between 9 and 18";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> laptopList = null;
			cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					laptopList = new ArrayList<StoreVO>();
				}
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				laptopList.add(svo);
				
			}// end of while----------------
			
			hitMap.put("laptopList", laptopList);
			
			// 모니터
			sql = "select rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "from\n"+
				  "(\n"+
				  "    select row_number() over(order by oqty desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "    from semi_product\n"+
				  "    where fk_bcode = 300000\n"+
				  ") V\n"+
				  "where rno between 9 and 18";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> monitorList = null;
			cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					monitorList = new ArrayList<StoreVO>();
				}
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				monitorList.add(svo);
				
			}// end of while----------------
			
			hitMap.put("monitorList", monitorList);
			
			
			// 주변기기
			sql = "select rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "from\n"+
				  "(\n"+
				  "    select row_number() over(order by oqty desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "    from semi_product\n"+
				  "    where fk_bcode = 400000\n"+
				  ") V\n"+
				  "where rno between 9 and 18";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> otherList = null;
			cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					otherList = new ArrayList<StoreVO>();
				}
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				otherList.add(svo);
				
			}// end of while----------------
			
			hitMap.put("otherList", otherList);
			
		} finally {
			close();
		}
		
		return hitMap;
	}// end of getHit()--------------------------

	
	// new(최신 등록순) 12개씩을 가져오는 메소드 //
	@Override
	public HashMap<String, List<StoreVO>> getNew() throws SQLException {
		
		HashMap<String, List<StoreVO>> newMap = new HashMap<String, List<StoreVO>>();
		
		try {
			
			conn = ds.getConnection();
			
			// 데스크탑 
			String sql = "select row_number() over(order by pdate desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
						 "from semi_product\n"+
						 "where fk_bcode = 100000";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> desktopList = null;
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					desktopList = new ArrayList<StoreVO>();
				}
				
				if(cnt > 12)
					break;
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				desktopList.add(svo);
				
			}// end of while----------------
			
			newMap.put("desktopList", desktopList);
			
			
			// 노트북 
			sql = "select row_number() over(order by pdate desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "from semi_product\n"+
				  "where fk_bcode = 200000";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> laptopList = null;
			cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					laptopList = new ArrayList<StoreVO>();
				}
				
				if(cnt > 12)
					break;
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				laptopList.add(svo);
				
			}// end of while----------------
			
			newMap.put("laptopList", laptopList);
			
			// 모니터
			sql = "select row_number() over(order by pdate desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "from semi_product\n"+
				  "where fk_bcode = 300000";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> monitorList = null;
			cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					monitorList = new ArrayList<StoreVO>();
				}
				
				if(cnt > 12)
					break;
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				monitorList.add(svo);
				
			}// end of while----------------
			
			newMap.put("monitorList", monitorList);
			
			
			// 주변기기
			sql = "select row_number() over(order by pdate desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
				  "from semi_product\n"+
				  "where fk_bcode = 400000";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			List<StoreVO> otherList = null;
			cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					otherList = new ArrayList<StoreVO>();
				}
				
				if(cnt > 12)
					break;
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				otherList.add(svo);
				
			}// end of while----------------
			
			newMap.put("otherList", otherList);
			
		} finally {
			close();
		}
		
		return newMap;
	}// end of getNew()---------------------

	
	// 상품 리스트를 가져오는 메소드 //
	@Override
	public List<StoreVO> getproductList(String sort, String category, String color, String company, String minprice,
			String maxprice, int pageNo, int sizePerPage, String searchWord)  throws SQLException{
		
		if("판매순".equals(sort))
			sort = "oqty";
		else if("이름순".equals(sort))
			sort = "pname";
		else
			sort = "saleprice";
		
		int iminprice = Integer.parseInt(minprice) * (Integer.parseInt(minprice) == 0 ?0:10000);
		int imaxprice = Integer.parseInt(maxprice) * 10000;
		
		List<StoreVO> svoList = null;
		
		try {
			
			conn = ds.getConnection();
			
			
			String sql = "select rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n" + 
						 "from\n" + 
						 "(\n" + 
						 "    select rownum as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n" + 
						 "    from\n" + 
						 "    (" +
						 			"select DISTINCT pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
						 			("".equals(color)?"from semi_product\n":"from semi_product P join semi_color C\n"+ 
								 								"on fk_pnum = pnum\n" )+
						 			"where saleprice between ? and ?\n"+
						 			"and (pname like '%' || ? || '%' or company like '%' || ? || '%' or pcontent like '%' || ? || '%')\n";
			
			if(!"".equals(category))
				sql += " and fk_bcode in(" + category + ") ";
			
			if(!"".equals(color))
				sql += " and color in(" + color + ") ";
			
			if(!"".equals(company))
				sql += " and company in(" + company + ") ";
			
			sql += " order by "+ sort + ("pname".equals(sort)?"":" desc ");
			
			sql += "    ) V\n" + 
					") T\n" + 
					"where rno between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, iminprice);
			pstmt.setInt(2, imaxprice);
			pstmt.setString(3, searchWord);
			pstmt.setString(4, searchWord);
			pstmt.setString(5, searchWord);
			pstmt.setInt(6, (pageNo*sizePerPage) - (sizePerPage - 1) );
			pstmt.setInt(7, (pageNo*sizePerPage) );
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					svoList = new ArrayList<StoreVO>();
				}
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String v_company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, v_company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				svoList.add(svo);
				
			}// end of while----------------
			
		} finally {
			close();
		}
		
		return svoList;
	}// end of getproductList()---------------------------------

	
	// 상품 리스트 갯수를 알아오는 메소드 //
	@Override
	public int getListTotalCount(String category, String color, String company, String minprice, String maxprice, String searchWord)  throws SQLException{

		int totalCount = 0;
		
		int iminprice = Integer.parseInt(minprice) * (Integer.parseInt(minprice) == 0 ?0:10000);
		int imaxprice = Integer.parseInt(maxprice) * 10000;
		
		try {
			
			conn = ds.getConnection();
			
			
			String sql = "select count(DISTINCT pnum) as cnt\n"+
						 ("".equals(color)?"from semi_product\n":"from semi_product P join semi_color C\n"+ 
								 								"on fk_pnum = pnum\n" )+
						 "where saleprice between ? and ?\n"+
				 		 "and (pname like '%' || ? || '%' or company like '%' || ? || '%' or pcontent like '%' || ? || '%')\n";
			
			if(!"".equals(category))
				sql += " and fk_bcode in(" + category + ") ";
			
			if(!"".equals(color))
				sql += " and color in(" + color + ") ";
			
			if(!"".equals(company))
				sql += " and company in(" + company + ") ";
			
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, iminprice);
			pstmt.setInt(2, imaxprice);
			pstmt.setString(3, searchWord);
			pstmt.setString(4, searchWord);
			pstmt.setString(5, searchWord);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt("cnt");
			
		} finally {
			close();
		}
		
		
		return totalCount;
	}// end of getListTotalCount()--------------

	
	// 제품상세보기 가져오는 메소드 //
	@Override
	public StoreVO getOneProduct(String pnum)  throws SQLException{
		
		StoreVO svo = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
						 "from semi_product\n"+ 
						 "where pnum = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				int v_pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				svo = new StoreVO(v_pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
			}
			
		} finally {
			close();
		}
		
		return svo;
	}// end of getOneProduct()--------------------------------

	
	// 제품상세 추가 이미지를 가져오는 메소드 //
	@Override
	public List<HashMap<String, String>> getProdImage(String pnum) throws SQLException {
		List<HashMap<String, String>> imgList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select more_imagenum, fk_pnum, dimage\n"+
						 "from semi_moreimage\n"+
						 "where fk_pnum = ?\n"+ 
						 "order by fk_pnum";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				
				cnt ++;
				if(cnt == 1) {
					imgList = new ArrayList<HashMap<String, String>>();
				}
				
				String more_imagenum = rs.getString("more_imagenum");
				String fk_pnum = rs.getString("fk_pnum");
				String dimage = rs.getString("dimage");
				
				HashMap<String, String> imgMap = new HashMap<String, String>();
				
				imgMap.put("more_imagenum", more_imagenum);
				imgMap.put("fk_pnum", fk_pnum);
				imgMap.put("dimage", dimage);
				
				imgList.add(imgMap);
				
			}// end of while---------------------------------
			
		} finally {
			close();
		}
		
		return imgList;
	}// end of getProdImage()-----------------------------

	
	// 제품상세 색상을 가져오는 메소드 //
	@Override
	public List<HashMap<String, String>> getProdColor(String pnum) throws SQLException {
		List<HashMap<String, String>> colorList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select colornum, fk_pnum, color\n"+
						 "from semi_color\n"+
						 "where fk_pnum = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1)
					colorList = new ArrayList<HashMap<String, String>>();
				
				String colornum = rs.getString("colornum");
				String fk_pnum = rs.getString("fk_pnum");
				String color = rs.getString("color");
				
				HashMap<String, String> colorMap = new HashMap<String, String>();
				
				colorMap.put("colornum", colornum);
				colorMap.put("fk_pnum", fk_pnum);
				colorMap.put("color", color);
				
				colorList.add(colorMap);
				
			}// end of while-----------------------------
			
		} finally {
			close();
		}
		
		return colorList;
	}// end of getProdColor()-----------------------

	
	// 제품상세 램을 가져오는 메소드 //
	@Override
	public List<HashMap<String, String>> getProdRam(String pnum) throws SQLException {
		
		List<HashMap<String, String>> ramList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select ramnum, fk_pnum, ramtype, ramprice\n"+
						 "from semi_ram\n"+
						 "where fk_pnum = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				
				cnt++;
				if(cnt == 1)
					ramList = new ArrayList<HashMap<String, String>>();
				
				String ramnum = rs.getString("ramnum");
				String fk_pnum = rs.getString("fk_pnum");
				String ramtype = rs.getString("ramtype");
				String ramprice = rs.getString("ramprice");
				
				HashMap<String, String> ramMap = new HashMap<String, String>();
				
				ramMap.put("ramnum", ramnum);
				ramMap.put("fk_pnum", fk_pnum);
				ramMap.put("ramtype", ramtype);
				ramMap.put("ramprice", ramprice);
				
				ramList.add(ramMap);
				
			}// end of while----------------------------------------
			
		} finally {
			close();
		}
		
		return ramList;
	}// end of getProdRam()--------------------------------------

	
	// 제품상세 저장장치를 가져오는 메소드 //
	@Override
	public List<HashMap<String, String>> getProdStorage(String pnum, String strgtype) throws SQLException {
		
		List<HashMap<String, String>> storageList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select storage_num, fk_pnum, strgtype, strhprice, strgsize\n"+
						 "from semi_storage\n"+
						 "where fk_pnum = ?\n"+ 
						 "and strgtype = ?\n"+ 
						 "order by strgtype asc";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pnum);
			pstmt.setString(2, strgtype);
			rs = pstmt.executeQuery();
			
			
			int cnt = 0;
			while(rs.next()) {
				
				cnt++;
				if(cnt == 1)
					storageList = new ArrayList<HashMap<String, String>>();
				
				String storage_num = rs.getString("storage_num");
				String fk_pnum = rs.getString("fk_pnum");
				String v_strgtype = rs.getString("strgtype");
				String strhprice = rs.getString("strhprice");
				String strgsize = rs.getString("strgsize");
				
				HashMap<String, String> storageMap = new HashMap<String, String>();
				
				storageMap.put("storage_num", storage_num);
				storageMap.put("fk_pnum", fk_pnum);
				storageMap.put("strgtype", v_strgtype);
				storageMap.put("strhprice", strhprice);
				storageMap.put("strgsize", strgsize);
				
				storageList.add(storageMap);
			}
			
		} finally {
			close();
		}
		
		return storageList;
	}// end of getProdStorage()----------------------

	
	// 제품상세 상세스펙을 가져오는 메소드 //
	@Override
	public HashMap<String, String> getProdSpec(String pnum) throws SQLException {
		
		HashMap<String, String> specMap = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select fk_pnum, cpu, mainboard, case, power, os, screen_size\n"+
						 "from semi_pcSpec\n"+
						 "where fk_pnum = ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, pnum);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				
				String fk_pnum = rs.getString("fk_pnum");
				String cpu = rs.getString("cpu");
				String mainboard = rs.getString("mainboard");
				String pcCase = rs.getString("case");
				String power = rs.getString("power");
				String os = rs.getString("os");
				String screen_size = rs.getString("screen_size");
				
				specMap = new HashMap<String, String>();
				
				specMap.put("fk_pnum", fk_pnum);
				specMap.put("cpu", cpu);
				specMap.put("mainboard", mainboard);
				specMap.put("pcCase", pcCase);
				specMap.put("power", power);
				specMap.put("os", os);
				specMap.put("screen_size", screen_size);
				
			}
			
		} finally {
			close();
		}
		
		return specMap;
	}// end of getProdSpec()-------------------------------

	
	// 신상품 12개를 가져오는 메소드 //
	@Override
	public List<StoreVO> getNewList() throws SQLException {
		
		List<StoreVO> newList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
						 "from\n"+
						 "(\n"+
						 "    select row_number() over(order by pdate desc) as rno, pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate\n"+
						 "    from semi_product\n"+
						 ") V\n"+
						 "where rno between 1 and 12";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				
				cnt++;
				
				if(cnt == 1) {
					newList = new ArrayList<StoreVO>();
				}
				
				int pnum = rs.getInt("pnum");
				String fk_bcode = rs.getString("fk_bcode");
				String pname = rs.getString("pname");
				String v_company = rs.getString("company");
				int price = rs.getInt("price");
				int saleprice = rs.getInt("saleprice");
				String pimage = rs.getString("pimage");
				int oqty = rs.getInt("oqty");
				String pcontent = rs.getString("pcontent");
				int point = rs.getInt("point");
				int pqty = rs.getInt("pqty");
				String pdate = rs.getString("pdate");
				String asdate = rs.getString("asdate");
				
				
				StoreVO svo = new StoreVO(pnum, fk_bcode, pname, v_company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate);
				
				newList.add(svo);
				
			}// end of while-------------------
			
		} finally {
			close();
		}
		
		return newList;
		
	}// end of getNewList()---------------------------

	
	// 제품등록 하는 메소드 //
	@Override
	public boolean registerProduct(String bcategory, String[] colorsArr, String[] storagesArr, String[] ramsArr,
			String cpu, String mainboard, String power, String pc_case, String screenSize, String os, String company, String pname, int price,
			int saleprice, String[] pimagesArr, String pcontent, int point, int pqty) throws SQLException {
		
		boolean bool = false;
		
		try {
			
			conn = ds.getConnection();
			
			conn.setAutoCommit(false);
			
			String sql = " select seq_semi_product_pnum.nextval as pnum "
					+ 	 " from dual ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			int pnum = rs.getInt("pnum");
			
			sql = "insert into semi_product(pnum, fk_bcode, pname, company, price, saleprice, pimage, oqty, pcontent, point, pqty, pdate, asdate)\n"+
				  "values(?, ?, ?, ?, ?, ?, ?, DEFAULT, ?, ?, ?, default, default)";
			
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, pnum);
			pstmt.setString(2, bcategory);
			pstmt.setString(3, pname);
			pstmt.setString(4, company);
			pstmt.setInt(5, price);
			pstmt.setInt(6, saleprice);
			pstmt.setString(7, pimagesArr[0]);
			pstmt.setString(8, pcontent);
			pstmt.setInt(9, point);
			pstmt.setInt(10, pqty);
			
			int n1 = pstmt.executeUpdate();
			
			if(n1 != 1) {
				conn.rollback();
				return false;
			}
			
			int n2 = 0 ;
			
			for(String color : colorsArr) {
				sql = "insert into semi_color(colornum, fk_pnum, color)\n"+
					  "values(seq_semi_colornum.nextval, ?, ?)";
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, pnum);
				pstmt.setString(2, color);
				
				n2 = pstmt.executeUpdate();
				
				if(n2 != 1) {
					conn.rollback();
					return false;
				}
			}
			
			if("100000".equals(bcategory) || "200000".equals(bcategory)) {
				
				for(String storage : storagesArr) {
					
					String[] storageInfo = storage.split("/");
					
					sql = "insert into semi_storage(storage_num, fk_pnum, strgtype, strhprice, strgsize)\n"+
						  "values(seq_semi_storage_num.nextval, ?, ?, ?, ?)";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, pnum);
					pstmt.setInt(2, ("s".equals(storageInfo[0].substring(0, 1))?0:1));
					pstmt.setString(3, storageInfo[1]);
					pstmt.setString(4, storageInfo[0].substring(1));
					
					int n3 = pstmt.executeUpdate();
					
					if(n3 != 1) {
						conn.rollback();
						return false;
					}
				}
				
				System.out.println(ramsArr.length);
				
				for(String ram : ramsArr) {
					String[] ramInfo = ram.split("/");
					
					sql = "insert into semi_ram(ramnum, fk_pnum, ramtype, ramprice)\n"+
						  "values(seq_semi_ramnum.nextval, ?, ?, ?)";
					
					pstmt = conn.prepareStatement(sql);
					
					pstmt.setInt(1, pnum);
					pstmt.setString(2, ramInfo[0]);
					pstmt.setString(3, ramInfo[1]);
					
					int n4 = pstmt.executeUpdate();
					
					if(n4 != 1) {
						conn.rollback();
						return false;
					}
					
				}
				
				
			}// end of if--------------------
			
			sql = "insert into semi_pcSpec(fk_pnum, CPU, mainboard, power, os, screen_size)\n"+
				  "values(?, ?, ?, ?, ?, ?)";
				
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, pnum);
			pstmt.setString(2, cpu);
			pstmt.setString(3, mainboard);
			pstmt.setString(4, power);
			pstmt.setString(5, os);
			pstmt.setString(6, screenSize);
			
			int n5 = pstmt.executeUpdate();
			
			if(n5 != 1) {
				conn.rollback();
				return false;
			}
			
			for(int i=0; i<pimagesArr.length-1; i++) {
				sql = "insert into semi_moreimage(more_imagenum, fk_pnum, dimage)\n"+
					  "values(seq_semi_moreimage_num.nextval, ?, ?)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, pnum);
				pstmt.setString(2, pimagesArr[i+1]);
				
				int n6 = pstmt.executeUpdate();
				
				if(n6 != 1) {
					conn.rollback();
					return false;
				}
				
			}
			
			conn.commit();
			bool = true;
			
		} finally {
			close();
		}
		
		return bool;
	}// end of registerProduct()--------------------------------------

	
	
}
