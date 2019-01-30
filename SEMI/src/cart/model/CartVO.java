package cart.model;

public class CartVO {
	
	private int cnum;
	private int pnum;
	private String bcode;
	private String userid;
	private String pname;
	private int oqty;
	private String pimage;
	private String pcontent;
	private String color;
	private int price;
	private int saleprice;
	private int point;
	private int totalPrice;
	private int totalPoint;
	
	public CartVO() {}

	
	
	public CartVO(int cnum, int pnum, String bcode, String userid, String pname, int oqty, String pimage,
			String pcontent, String color, int price, int saleprice, int point, int totalPrice, int totalPoint) {
		super();
		this.cnum = cnum;
		this.pnum = pnum;
		this.bcode = bcode;
		this.userid = userid;
		this.pname = pname;
		this.oqty = oqty;
		this.pimage = pimage;
		this.pcontent = pcontent;
		this.color = color;
		this.price = price;
		this.saleprice = saleprice;
		this.point = point;
		this.totalPrice = totalPrice;
		this.totalPoint = totalPoint;
	}



	public String getBcode() {
		return bcode;
	}



	public void setBcode(String bcode) {
		this.bcode = bcode;
	}



	public String getUserid() {
		return userid;
	}



	public void setUserid(String userid) {
		this.userid = userid;
	}



	public int getCnum() {
		return cnum;
	}
	public void setCnum(int cnum) {
		this.cnum = cnum;
	}
	public int getPnum() {
		return pnum;
	}
	public void setPnum(int pnum) {
		this.pnum = pnum;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getOqty() {
		return oqty;
	}
	public void setOqty(int oqty) {
		this.oqty = oqty;
	}
	public String getPimage() {
		return pimage;
	}
	public void setPimage(String pimage) {
		this.pimage = pimage;
	}
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	public String getColor() {
		return color;
	}
	public void setColor(String color) {
		this.color = color;
	}
	
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public int getSaleprice() {
		return saleprice;
	}
	public void setSaleprice(int saleprice) {
		this.saleprice = saleprice;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	
	public int getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(int totalPrice) {
		this.totalPrice = totalPrice;
	}

	public int getTotalPoint() {
		return totalPoint;
	}

	public void setTotalPoint(int totalPoint) {
		this.totalPoint = totalPoint;
	}

	public void setTotalPriceTotalPoint(int oqty) {//oqty 는 주문량임
		 // 총판매가(실제판매가 * 주문량) 입력하기
		 totalPrice = saleprice * oqty;
		 
		 // 총포인트(제품1개당 포인트 * 주문량) 입력하기
		 totalPoint = point * oqty;
	}
	
	public int getPercent() {
		// 정가 : 실제판매가 = 100 : x
		// x = (실제판매가*100)/정가
		// 할인률 = 100 - (실제판매가*100)/정가
		// 예: 100 - (2800*100)/3000 = 6.66
		
		double per = 100 - (saleprice * 100.0)/price;
		long percent = Math.round(per);
		
		return (int)percent;
		
	}
	
	
}
