package store.model;

public class StoreVO {
	
	private int pnum;
	private String fk_bcode;
	private String pname;
	private String company;
	private int price;
	private int saleprice;
	private String pimage;
	private int oqty;
	private String pcontent;
	private int point;
	private int pqty;
	private String pdate;
	private String asdate;
	
	
	
	public StoreVO() { }
	
	public StoreVO(int pnum, String fk_bcode, String pname, String company, int price, int saleprice, String pimage,
			int oqty, String pcontent, int point, int pqty, String pdate, String asdate) {
		super();
		this.pnum = pnum;
		this.fk_bcode = fk_bcode;
		this.pname = pname;
		this.company = company;
		this.price = price;
		this.saleprice = saleprice;
		this.pimage = pimage;
		this.oqty = oqty;
		this.pcontent = pcontent;
		this.point = point;
		this.pqty = pqty;
		this.pdate = pdate;
		this.asdate = asdate;
	}

	public int getPnum() {
		return pnum;
	}

	public void setPnum(int pnum) {
		this.pnum = pnum;
	}

	public String getFk_bcode() {
		
		if("100000".equals(fk_bcode))
			return "데스크탑";
		
		if("200000".equals(fk_bcode))
			return "노트북";
		
		if("300000".equals(fk_bcode))
			return "모니터";
		
		if("400000".equals(fk_bcode))
			return "주변기기";
		
		return fk_bcode;
	}

	public void setFk_bcode(String fk_bcode) {
		this.fk_bcode = fk_bcode;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
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

	public String getPimage() {
		return pimage;
	}

	public void setPimage(String pimage) {
		this.pimage = pimage;
	}

	public int getOqty() {
		return oqty;
	}

	public void setOqty(int oqty) {
		this.oqty = oqty;
	}

	public String getPcontent() {
		return pcontent;
	}

	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public int getPqty() {
		return pqty;
	}

	public void setPqty(int pqty) {
		this.pqty = pqty;
	}

	public String getPdate() {
		return pdate;
	}

	public void setPdate(String pdate) {
		this.pdate = pdate;
	}

	public String getAsdate() {
		return asdate;
	}

	public void setAsdate(String asdate) {
		this.asdate = asdate;
	}
	
	// 할인율 계산 메소드
	public int getPercent() {
		
		double per = 100 - (saleprice * 100.0)/price;
		long percent = Math.round(per);
		
		return (int)percent;
		
	}// end of getPercent()---------------
	
}
