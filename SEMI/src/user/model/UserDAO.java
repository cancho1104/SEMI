package user.model;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
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
import jdbc.util.SHA256;
import my.util.MyKey;

public class UserDAO implements InterUserDAO{
	
	private DataSource ds = null;
	
	private Connection conn = null;
	private PreparedStatement pstmt = null;
	private ResultSet rs = null;
	
	AES256 aes = null;
	
	public UserDAO() {
		
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

	// 아이디 중복검사 메소드 //
	@Override
	public boolean idDuplicateCheck(String userid) throws SQLException {
		// true면 사용가능 false면 사용불가
		boolean bool = true;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select userid\n"+
						 "from semi_user\n"+
						 "where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bool = false;
			}
			
		} finally {
			close();
		}
		
		return bool;
	}

	// 회원가입 유저 insert 메소드  //
	@Override
	public int insertUser(UserVO uvo) throws SQLException {
		
		int result = 0; 
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select count(*) as cnt "
					+ 	 " from semi_user "
					+ 	 " where userid = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, uvo.getUserid());
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			if(rs.getInt("cnt") > 0) {
				return result;
			}
			
			sql = "insert into semi_user(userid, fk_grade_code, idx, pwd, name, email, hp, addr, addrDetail\n"+
				  "      ,post , totalPoint, birth, gender, sumPurchasePrice, last_LoginDate, last_PwdChangeDate, registDate, status)\n"+
				  "values(?, default, seq_semi_user_idx.nextval, ?, ?, ?\n"+
				  ", ?, ?, ?, ?, default, ?, ?, default\n"+
				  ", default, default, default, 0)";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, uvo.getUserid());
			pstmt.setString(2, SHA256.encrypt(uvo.getPwd()));
			pstmt.setString(3, uvo.getName());
			pstmt.setString(4, aes.encrypt(uvo.getEmail()));
			pstmt.setString(5, aes.encrypt(uvo.getHp()));
			pstmt.setString(6, uvo.getAddr());
			pstmt.setString(7, uvo.getAddrDetail());
			pstmt.setString(8, uvo.getPost());
			pstmt.setString(9, uvo.getBirthyyyy() + uvo.getBirthmm() + uvo.getBirthdd());
			pstmt.setString(10, uvo.getGender());
			
			result = pstmt.executeUpdate();
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return result;
	}// end of insertUser()----------------

	
	// 로그인 메소드 //
	@Override
	public UserVO loginUser(String userid, String pwd) throws SQLException {
		
		UserVO loginuser = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select userid, G.grade_name as fk_grade_code, idx, name, totalPoint,\n"+
						 "       sumPurchasePrice,\n" +
						 " trunc(months_between(sysdate, last_LoginDate)) AS last_LoginDate,\n" +
					 	 " trunc(months_between(sysdate, last_PwdChangeDate)) AS last_PwdChangeDate " +
						 "from semi_user U, semi_grade G\n"+
						 "where U.fk_grade_code = G.grade_code\n" + 
						 "and U.userid = ?\n" + 
						 "and U.pwd = ?\n" + 
						 "and U.status = 0";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			pstmt.setString(2, SHA256.encrypt(pwd));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				String v_userid = rs.getString("userid");
				String grade_code = rs.getString("fk_grade_code");
				int idx = rs.getInt("idx");
				String name = rs.getString("name");
				int totalPoint = rs.getInt("totalPoint");
				int sumPurchasePrice = rs.getInt("sumPurchasePrice");
				int last_LoginDate = rs.getInt("last_LoginDate");
				int last_PwdChangeDate = rs.getInt("last_PwdChangeDate");
				
				loginuser = new UserVO();
				
				loginuser.setUserid(v_userid);
				loginuser.setGrade_code(grade_code);
				loginuser.setIdx(idx);
				loginuser.setName(name);
				loginuser.setTotalpoint(totalPoint);
				loginuser.setSumPurchasePrice(sumPurchasePrice);
				
				if(last_LoginDate > 12) {
					loginuser.setIdlestatus(true);
				}
				else {
					if(last_PwdChangeDate >= 6)
						loginuser.setRequirePwdChange(true);
					
					// 마지막으로 로그인 한 날짜시각 기록하기
					sql = " update semi_user set last_LoginDate = sysdate "
						+ " where userid = ? ";
					
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, userid);
					pstmt.executeUpdate();
				}
			}
			
		} finally {
			close();
		}
		
		return loginuser;
	}

	
	// 관리자 로그인 메소드 //
	@Override
	public HashMap<String, String> loginAdmin(String adminid, String pwd) throws SQLException{
		
		HashMap<String, String> adminMap = null;
			
			try {
				
				conn = ds.getConnection();
				
				String sql = " select admin_num, admin_id "
						+ 	 " from semi_admin "
						+ 	 " where admin_id = ? "
						+ 	 " and admin_pwd = ? ";
				
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, adminid);
				pstmt.setString(2, SHA256.encrypt(pwd));
				
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					
					adminMap = new HashMap<String, String>();
					
					String admin_num = rs.getString("admin_num");
					String admin_id = rs.getString("admin_id");
					
					adminMap.put("admin_num", admin_num);
					adminMap.put("admin_id", admin_id);
				}
				
			} finally {
				close();
			}
		
		return adminMap;
	}

	
	// 아이디찾기 메소드 //
	@Override
	public String findUserid(String name, String email) throws SQLException {
		
		String userid = "";
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select userid "
					+ 	 " from semi_user "
					+ 	 " where name = ? and "
					+ 	 " email = ? "
					+ 	 " and status = 0";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, name);
			pstmt.setString(2, aes.encrypt(email));
			
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				userid = rs.getString("userid");
			}
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return userid;
	}

	// 비밀번호 찾기 회원조회 추상 메소드 //
	@Override
	public boolean CheckUser(String userid, String email) throws SQLException{
		
		boolean bool = false;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select userid "
					+ 	 " from semi_user "
					+ 	 " where userid = ? "
					+ 	 " and email = ? "
					+ 	 " and status = 0";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			pstmt.setString(2, aes.encrypt(email));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				bool = true;
			}
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return bool;
	}

	
	// 현재 사용중이던 비밀번호인지 체크하는 메소드 //
	@Override
	public int pwdDuplicate(String userid, String pwd) throws SQLException {
		
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select count(*) as cnt "
					+ 	 " from semi_user "
					+ 	 " where userid = ? "
					+ 	 " and pwd = ? "
					+ 	 " and status = 0";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userid);
			pstmt.setString(2, SHA256.encrypt(pwd));
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				result = rs.getInt("cnt");
			}
			
		} finally {
			close();
		}
		
		return result;
	}
	
	
	// 비밀번호 변경 메소드 //
	@Override
	public int ChangePwd(String userid, String pwd) throws SQLException {
		
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update semi_user set pwd = ?, last_PwdChangeDate = sysdate "
					+ 	 " where userid = ? "
					+ 	 " and status = 0";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, SHA256.encrypt(pwd));
			pstmt.setString(2, userid);
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}

	
	// 유저 전체목록을 가져오는 메소드 //
	@Override
	public List<UserVO> getUserList(String sort, int pageNo, int sizePerPage) throws SQLException {
		
		if("이름순".equals(sort))
			sort = "userid";
		else if("가입순".equals(sort))
			sort = "registDate";
		else
			sort = "sumPurchasePrice";
		
		List<UserVO> userList = null;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = "select rno, userid, grade_name, idx, name, email, hp, addr, addrDetail\n"+
						 "      ,post , totalPoint, birth, gender, sumPurchasePrice, last_LoginDate, last_PwdChangeDate, registDate, status\n"+
						 "from\n"+
						 "(\n"+
						 "    select rownum as rno, userid, grade_name, idx, pwd, name, email, hp, addr, addrDetail\n"+
						 "          ,post , totalPoint, birth, gender, sumPurchasePrice, last_LoginDate, last_PwdChangeDate, registDate, status\n"+
						 "    from\n"+
						 "    (\n"+
						 "        select userid, grade_name, idx, pwd, name, email, hp, addr, addrDetail\n"+
						 "              ,post , totalPoint, birth, gender, sumPurchasePrice, last_LoginDate, last_PwdChangeDate, registDate, \n"+ 
						 "				case when (trunc(months_between(sysdate, last_LoginDate)) > 12) and (status in (0,1)) then 1 \n" + 
						 "              else status end AS status\n"+
						 "        from semi_user U join semi_grade G\n"+
						 "        on U.sumPurchasePrice between min_purPrice and max_purPrice\n";
			
			sql += " order by "+ sort + ("sumPurchasePrice".equals(sort)?" desc\n":" \n");
						 
			sql += "    ) V \n"+
				   ") T\n"+
				   "where rno between ? and ?";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, (pageNo*sizePerPage) - (sizePerPage - 1) );
			pstmt.setInt(2, (pageNo*sizePerPage) );
			
			rs = pstmt.executeQuery();
			
			int cnt = 0;
			while(rs.next()) {
				cnt++;
				
				if(cnt == 1) {
					userList = new ArrayList<UserVO>();
				}
				
				String userid = rs.getString("userid");
				String grade_name = rs.getString("grade_name");
				int idx = rs.getInt("idx");
				String name = rs.getString("name");
				String email = aes.decrypt(rs.getString("email"));
				String hp =aes.decrypt(rs.getString("hp"));
				String addr = rs.getString("addr");
				String addrDetail = rs.getString("addrDetail");
				String post = rs.getString("post");
				int totalpoint = rs.getInt("totalpoint");
				String birth = rs.getString("birth");
				String gender = rs.getString("gender");
				int sumPurchasePrice = rs.getInt("sumPurchasePrice");
				String last_LoginDate = rs.getString("last_LoginDate");
				String last_PwdChangeDate = rs.getString("last_PwdChangeDate");
				String registDate = rs.getString("registDate");
				int status = rs.getInt("status");
				
				UserVO uvo = new UserVO(userid, "", idx, "", name, email, hp, addr, addrDetail, post, totalpoint,
										birth.substring(0, 4), birth.substring(4, 6), birth.substring(6, 8), gender, 
										sumPurchasePrice, last_LoginDate, last_PwdChangeDate, registDate, status);
				
				uvo.setGrade_name(grade_name);
				
				userList.add(uvo);
				
			}// end of while
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		} finally {
			close();
		}
		
		return userList;
	}// end of getUserList()----------------------

	
	// 유저 전체 수를 가져오는 메소드 //
	@Override
	public int getUserTotalCount() throws SQLException {
		int totalCount = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " select count(*) as cnt "
					+ 	 " from semi_user ";
			
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			rs.next();
			
			totalCount = rs.getInt("cnt");
			
		} finally {
			close(); 
		}
		
		return totalCount;
		
	}// end of getUserTotalCount()--------------------------

	
	// 휴면계정을 활성화 시키는 메소드 //
	@Override
	public int ableUser(String idx) throws SQLException {
		
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update semi_user set last_logindate = sysdate "
					+ 	 " where idx = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, idx);
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}// end of ableUser()--------------------

	
	// 회원을 탈퇴하는 메소드 //
	@Override
	public int deleteUser(String idx) throws SQLException {
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update semi_user set status = 2 "
					+ 	 " where idx = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, idx);
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}// end of deleteUser()---------------------
	
	
	// 회원을 복원하는 메소드 //
	@Override
	public int recoveryUser(String idx) throws SQLException {
		int result = 0;
		
		try {
			
			conn = ds.getConnection();
			
			String sql = " update semi_user set status = 0, last_logindate = sysdate "
					+ 	 " where idx = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, idx);
			
			result = pstmt.executeUpdate();
			
		} finally {
			close();
		}
		
		return result;
	}// end of deleteUser()---------------------

	

}
