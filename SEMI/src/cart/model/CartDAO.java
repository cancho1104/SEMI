package cart.model;

import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import jdbc.util.AES256;
import my.util.MyKey;

public class CartDAO implements InterCartDAO {
	
	private DataSource ds = null;
	// 객체변수 ds는 아파치톰캣이 제공하는 DBCP(DB Connection Pool) 이다.
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	AES256 aes = null;
	/*
	 	=== MemberDAO 생성자에서 해야할 일은 ===
	 	아파치 톰캣이 제공하는 DBCP(DB Connection Pool) 객체인 ds를 얻어오는 것이다
	 	
	 */
	public CartDAO() {
		try {
			Context initContext = new InitialContext();
			Context envContext  = (Context)initContext.lookup("java:/comp/env");
			ds = (DataSource)envContext.lookup("jdbc/myoracle");
			
			String key = MyKey.key; //암호화 복호화 키
			aes = new AES256(key);
			
		} catch (NamingException e) {
			
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			System.out.println("key 값은 17글자 이상이어야 한다.");
			e.printStackTrace();
		} 
		
	}//생성자 끝
	
	// == 사용한 자원을 반납하는 close() 메소드 생성하기 ==//
	public void close() {
		try {
			if(rs !=null) {
			rs.close();
			rs = null;
			}
			if(pstmt !=null) {
				pstmt.close();
				pstmt = null;
			}
			if(conn !=null) {
				conn.close();
				conn = null;
			}
			
		}catch(SQLException e) {
			
		}
	}//Eo close

	@Override
	public int insertCartList(int pnum, String userid, String color, String oqty, String ram, String disk, int totalprice) throws SQLException {
		
		int result = 0;
		
		String[] ramArr = null;
		String[] diskArr = null;
		
		if(ram != null && disk != null) {

			ramArr = ram.split("/");
			diskArr = disk.split("/");
			
		}
		
		System.out.println(userid + " " + pnum + " " + color + " " + oqty + " " + ram + " " + disk + " " + totalprice);
		
		try {
			conn = ds.getConnection();
			
			String sql = "";
			
			if(ramArr != null && diskArr != null) {
				sql = " insert into semi_cartList(cnum, fk_userid, fk_pnum, oqty, color, totalprice, ramtype, strgtype, strgsize)\n"
					+ " values(seq_semi_cartList_cnum.nextval,?,?,?,?,?,?,?,?)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, userid);
				pstmt.setInt(2, pnum);
				pstmt.setInt(3, Integer.parseInt(oqty));
				pstmt.setString(4, color);
				pstmt.setInt(5, totalprice);
				pstmt.setString(6, ramArr[0]);
				pstmt.setInt(7, diskArr[0].equals("HDD")?1:2);
				pstmt.setString(8, diskArr[1]);
				
				
			}
			else {
				sql = " insert into semi_cartList(cnum, fk_userid, fk_pnum, oqty, color, totalprice)\n"
					+ " values(seq_semi_cartList_cnum.nextval,?,?,?,?,?)";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, userid);
				pstmt.setInt(2, pnum);
				pstmt.setInt(3, Integer.parseInt(oqty));
				pstmt.setString(4, color);
				pstmt.setInt(5, totalprice);
			}
			
			
			result = pstmt.executeUpdate();
		}finally {
			
			close();
		}
		
		return result;
	}// end of insertCartList()------------------------------------

	@Override
	public List<CartVO> getCartListByUser(String userid) throws SQLException {
		
		List<CartVO> cartList = null;
		try {
			conn = ds.getConnection();
			String sql = " select fk_bcode,pname, pimage, pcontent,cnum, fk_userid, fk_pnum, B.oqty, color, B.totalPrice\n"
					+ "		from semi_product A join semi_cartList B \n"
					+ "		on A.pnum = B.fk_pnum\n"
					+ " where fk_userid = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userid);
			rs = pstmt.executeQuery();
			int cnt=0;
			while(rs.next()) {
				cnt++;
				if(cnt == 1) cartList = new ArrayList<CartVO>();
				
				String bcode = rs.getString("fk_bcode");
				String userid_v = rs.getString("fk_userid");
				String pname = rs.getString("pname");
				String pimage = rs.getString("pimage");
				String pcontent = rs.getString("pcontent");
				int cnum = rs.getInt("cnum");
				int pnum = rs.getInt("fk_pnum");
				int oqty = rs.getInt("oqty");
				String color = rs.getString("color");
				int saleprice = rs.getInt("totalPrice");
				
				CartVO cvo = new CartVO();
				
				cvo = new CartVO();
				cvo.setCnum(cnum);
				cvo.setBcode(bcode);
				cvo.setUserid(userid_v);
				cvo.setPname(pname);
				cvo.setPimage(pimage);
				cvo.setPcontent(pcontent);
				cvo.setColor(color);
				cvo.setPnum(pnum);
				cvo.setOqty(oqty);
				cvo.setColor(color);
				cvo.setSaleprice(saleprice);
				
				cartList.add(cvo);
			}
			
		}finally {
			close();
		}
		
		return cartList;
	}

	@Override
	public int cartDelete(int cnum) throws SQLException {
		int result = 0;
		try {
			conn = ds.getConnection();
			String sql = " delete semi_cartList where cnum = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cnum);
			result = pstmt.executeUpdate();
			
		}finally {
			close();
		}
		return result;
	}// end of cartDelete()-------------------------------------
}
