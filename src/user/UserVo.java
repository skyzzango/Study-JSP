package user;

/* 자바빈즈를 사용하기 위해 데이터베이스용 객체를 생성한다. */
public class UserVo {
	private String userId;
	private String userPw;
	private String userName;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPw() {
		return userPw;
	}

	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	@Override
	public String toString() {
		return "UserVo{" +
				"userId='" + userId + '\'' +
				", userPw='" + userPw + '\'' +
				", userName='" + userName + '\'' +
				'}';
	}
}
