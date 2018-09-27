package content;

public class ContentDTO {
	private int contentNum;
	private String picture;
	private String writeId;
	private String fileName;
	private String fileRealName;
	private String title;
	private String content;
	private int coinAmount;
	private int likeAmount;
	private int commentAmount;
	private int reportAmount;
	private String writeDate;

	public ContentDTO() { }

	public ContentDTO(String picture, String writeId, String fileName, String fileRealName, String title,
	                  String content, int coinAmount, int likeAmount, int commentAmount, int reportAmount,
	                  String writeDate) {
		this.picture = picture;
		this.writeId = writeId;
		this.fileName = fileName;
		this.fileRealName = fileRealName;
		this.title = title;
		this.content = content;
		this.coinAmount = coinAmount;
		this.likeAmount = likeAmount;
		this.commentAmount = commentAmount;
		this.reportAmount = reportAmount;
		this.writeDate = writeDate;
	}

	public int getContentNum() {
		return contentNum;
	}

	public void setContentNum(int contentNum) {
		this.contentNum = contentNum;
	}

	public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	public String getWriteId() {
		return writeId;
	}

	public void setWriteId(String writeId) {
		this.writeId = writeId;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getFileRealName() {
		return fileRealName;
	}

	public void setFileRealName(String fileRealName) {
		this.fileRealName = fileRealName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getCoinAmount() {
		return coinAmount;
	}

	public void setCoinAmount(int coinAmount) {
		this.coinAmount = coinAmount;
	}

	public int getLikeAmount() {
		return likeAmount;
	}

	public void setLikeAmount(int likeAmount) {
		this.likeAmount = likeAmount;
	}

	public int getCommentAmount() {
		return commentAmount;
	}

	public void setCommentAmount(int commentAmount) {
		this.commentAmount = commentAmount;
	}

	public int getReportAmount() {
		return reportAmount;
	}

	public void setReportAmount(int reportAmount) {
		this.reportAmount = reportAmount;
	}

	public String getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}

	@Override
	public String toString() {
		return "ContentDTO{" +
				"\npicture='" + picture + '\'' +
				", \nwriteId='" + writeId + '\'' +
				", \nfileName='" + fileName + '\'' +
				", \nfileRealName='" + fileRealName + '\'' +
				", \ntitle='" + title + '\'' +
				", \ncontent='" + content + '\'' +
				", \ncoinAmount=" + coinAmount +
				", \nlikeAmount=" + likeAmount +
				", \ncommentAmount=" + commentAmount +
				", \nreportAmount=" + reportAmount +
				", \nwriteDate='" + writeDate + '\'' +
				"\n}";
	}
}
