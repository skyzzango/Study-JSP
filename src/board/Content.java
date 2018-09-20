package board;

public class Content {
	private int contentNum;
	private String contentTitle;
	private String contentUser;
	private String contentDate;
	private String contentDetail;

	public int getContentNum() {
		return contentNum;
	}

	public void setContentNum(int contentNum) {
		this.contentNum = contentNum;
	}

	public String getContentTitle() {
		return contentTitle;
	}

	public void setContentTitle(String contentTitle) {
		this.contentTitle = contentTitle;
	}

	public String getContentUser() {
		return contentUser;
	}

	public void setContentUser(String contentUser) {
		this.contentUser = contentUser;
	}

	public String getContentDate() {
		return contentDate;
	}

	public void setContentDate(String contentDate) {
		this.contentDate = contentDate;
	}

	public String getContentDetail() {
		return contentDetail;
	}

	public void setContentDetail(String contentDetail) {
		this.contentDetail = contentDetail;
	}

	@Override
	public String toString() {
		return "Content{" +
				"contentNum=" + contentNum +
				", contentTitle='" + contentTitle + '\'' +
				", contentUser='" + contentUser + '\'' +
				", contentDate='" + contentDate + '\'' +
				", contentDetail='" + contentDetail + '\'' +
				'}';
	}
}
