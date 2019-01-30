package user.model;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;

public interface InterUserDAO {
	
	// 아이디 중복검사 추상메소드 //
	boolean idDuplicateCheck(String userid) throws SQLException;
	
	// 회원가입 유저 insert 추상메소드  //
	int insertUser(UserVO uvo) throws SQLException;
	
	// 로그인 추상 메소드 //
	UserVO loginUser(String userid, String pwd) throws SQLException;
	
	// 관리자 로그인 추상 메소드 //
	HashMap<String, String> loginAdmin(String adminid, String pwd) throws SQLException;
	
	// 아이디찾기 추상 메소드 //
	String findUserid(String name, String email) throws SQLException;
	
	// 비밀번호 찾기 회원조회 추상 메소드 //
	boolean CheckUser(String userid, String email) throws SQLException;
	
	// 현재 사용중이던 비밀번호인지 체크하는 추상 메소드 //
	int pwdDuplicate(String userid, String pwd) throws SQLException;
	
	// 비밀번호 변경 추상 메소드 //
	int ChangePwd(String userid, String pwd) throws SQLException;
	
	// 유저 전체목록을 가져오는 추상 메소드 //
	List<UserVO> getUserList(String sort, int pageNo, int sizePerPage) throws SQLException;
	
	// 유저 전체 수를 가져오는 추상 메소드 //
	int getUserTotalCount() throws SQLException;
	
	// 휴면계정을 활성화 시키는 추상 메소드 //
	int ableUser(String idx) throws SQLException;

	// 회원을 탈퇴하는 추상 메소드 //
	int deleteUser(String idx) throws SQLException;
	
	// 회원을 복원 시키는 추상 메소드 //
	int recoveryUser(String idx) throws SQLException;

}
