package user.model;

public class UserVO {
	
	private String userid;		/* 아이디 */
	private String grade_code;	/* 등급코드 */
	private int idx;			/* 회원번호_uq */
	private String pwd;			/* 비밀번호(단방향암호화) */
	private String name;		/* 이름 */
	private String email; 		/* 이메일 */
	private String hp;			/* 폰 */
	private String addr;		/* 주소 */
	private String addrDetail;	/* 상세주소 */
	private String post;		/* 우편번호(신주소) */
	private int totalpoint;	/* 누적적립금 */
	private String birthyyyy;
	private String birthmm;
	private String birthdd;
	private String gender;
	private int sumPurchasePrice;
	private String last_LoginDate;
	private String last_PwdChangeDate;
	private String registDate;
	private int status;
	

	private String grade_name;	/* 등급 */
	private int grade_percent;
	private int grade_point;
	
	private boolean requirePwdChange = false;	// 비밀번호 변경 6개월 지나면 true
	private boolean idlestatus = false;			// 로그인 날짜가 12개월 지나면 true
	
	public UserVO() { }
	
	public UserVO(String userid, String grade_code, int idx, String pwd, String name, String email, String hp,
			String addr, String addrDetail, String post, int totalpoint, String birthyyyy, String birthmm, String birthdd, String gender,
			int sumPurchasePrice, String last_LoginDate, String last_PwdChangeDate, String registDate, int status) {
		
		this.userid = userid;
		this.grade_code = grade_code;
		this.idx = idx;
		this.pwd = pwd;
		this.name = name;
		this.email = email;
		this.hp = hp;
		this.addr = addr;
		this.addrDetail = addrDetail;
		this.post = post;
		this.totalpoint = totalpoint;
		this.birthyyyy = birthyyyy;
		this.birthmm = birthmm;
		this.birthdd = birthdd;
		this.gender = gender;
		this.sumPurchasePrice = sumPurchasePrice;
		this.last_LoginDate = last_LoginDate;
		this.last_PwdChangeDate = last_PwdChangeDate;
		this.registDate = registDate;
		this.status = status;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getGrade_code() {
		return grade_code;
	}

	public void setGrade_code(String grade_code) {
		this.grade_code = grade_code;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getHp() {
		return hp;
	}

	public void setHp(String hp) {
		this.hp = hp;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getAddrDetail() {
		return addrDetail;
	}

	public void setAddrDetail(String addrDetail) {
		this.addrDetail = addrDetail;
	}

	public String getPost() {
		return post;
	}

	public void setPost(String post) {
		this.post = post;
	}

	public int getTotalpoint() {
		return totalpoint;
	}

	public void setTotalpoint(int totalpoint) {
		this.totalpoint = totalpoint;
	}

	public String getBirthyyyy() {
		return birthyyyy;
	}

	public void setBirthyyyy(String birthyyyy) {
		this.birthyyyy = birthyyyy;
	}
	
	public String getBirthmm() {
		return birthmm;
	}

	public void setBirthmm(String birthmm) {
		this.birthmm = birthmm;
	}

	public String getBirthdd() {
		return birthdd;
	}

	public void setBirthdd(String birthdd) {
		this.birthdd = birthdd;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getSumPurchasePrice() {
		return sumPurchasePrice;
	}

	public void setSumPurchasePrice(int sumPurchasePrice) {
		this.sumPurchasePrice = sumPurchasePrice;
	}

	public String getLast_LoginDate() {
		return last_LoginDate;
	}

	public void setLast_LoginDate(String last_LoginDate) {
		this.last_LoginDate = last_LoginDate;
	}

	public String getLast_PwdChangeDate() {
		return last_PwdChangeDate;
	}

	public void setLast_PwdChangeDate(String last_PwdChangeDate) {
		this.last_PwdChangeDate = last_PwdChangeDate;
	}

	public String getRegistDate() {
		return registDate;
	}

	public void setRegistDate(String registDate) {
		this.registDate = registDate;
	}
	
	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getGrade_name() {
		return grade_name;
	}

	public void setGrade_name(String grade_name) {
		this.grade_name = grade_name;
	}

	public int getGrade_percent() {
		return grade_percent;
	}

	public void setGrade_percent(int grade_percent) {
		this.grade_percent = grade_percent;
	}

	public int getGrade_point() {
		return grade_point;
	}

	public void setGrade_point(int grade_point) {
		this.grade_point = grade_point;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}

	public boolean isIdlestatus() {
		return idlestatus;
	}

	public void setIdlestatus(boolean idlestatus) {
		this.idlestatus = idlestatus;
	}
	
	public String getBirth() {
		
		String birth = "";
		
		birth = birthyyyy + "/" + birthmm + "/" + birthdd;
		
		return birth;
	}
	
	
	

}
