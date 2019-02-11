package cart.model;

import java.sql.SQLException;
import java.util.List;

public interface InterCartDAO {
	
	//** semi_cartList테이블에 해당유저와 물품번호를 insert하는 메소드
	int insertCartList(int pnum, String userid, String color, String oqty, String ram, String disk, int totalprice) throws SQLException;
	
	//** semi_cartList 테이블에서 정보를 가져오는 메소드
	List<CartVO> getCartListByUser(String userid) throws SQLException;
	
	//** semi_cartList테이블에서 해당 pnum에 적합한 정보를 삭제하는 메소드
	int cartDelete(int cnum) throws SQLException;
}
