package content;

import util.ConnUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ContentDAO {

	private ContentDAO() {
	}

	private static class LazyHolder {
		static final ContentDAO INSTANCE = new ContentDAO();
	}

	public static ContentDAO getInstance() {
		return ContentDAO.LazyHolder.INSTANCE;
	}

	public List<ContentDTO> getContentList() {
		List<ContentDTO> contentList = new ArrayList<>();
		String sql = "SELECT * FROM content ORDER BY writeDate desc";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()
		) {
			while (rs.next()) {
				contentList.add(convertDBtoClass(rs));
			}
		} catch (Exception e) {
			System.out.println("Error: content.ContentDAO.getContentList Failed (" + e.getMessage() + ")");
		}
		return contentList;
	}

	public List<ContentDTO> getSearchList(String search) {
		List<ContentDTO> searchList = new ArrayList<>();
		String sql = "SELECT * FROM content WHERE CONCAT(writeId, title, content) LIKE CONCAT('%', ?, '%') ORDER BY " +
				"writeDate DESC";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn.prepareStatement(sql), search);
				ResultSet rs = pstmt.executeQuery()
		) {
			while (rs.next()) {
				searchList.add(convertDBtoClass(rs));
			}
		} catch (Exception e) {
			System.out.println("Error: content.ContentDAO.getSearchList Failed (" + e.getMessage() + ")");
		}
		return searchList;
	}

	public int writeContent(ContentDTO contentDTO) {
		String sql = "INSERT INTO content VALUE (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)
		) {
			pstmt.setString(1, contentDTO.getPicture());
			pstmt.setString(2, contentDTO.getWriteId());
			pstmt.setString(3, contentDTO.getFileName());
			pstmt.setString(4, contentDTO.getFileRealName());
			pstmt.setString(5, contentDTO.getTitle());
			pstmt.setString(6, contentDTO.getContent());
			pstmt.setInt(7, contentDTO.getCoinAmount());
			pstmt.setInt(8, contentDTO.getLikeAmount());
			pstmt.setInt(9, contentDTO.getCommentAmount());
			pstmt.setInt(10, contentDTO.getReportAmount());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("Error: content.ContentDAO.writeContent Failed (" + e.getMessage() + ")");
		}
		return -1;
	}

	public ContentDTO getContent(String contentNum) {
		String sql = "SELECT * FROM content WHERE contentNum = ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn.prepareStatement(sql), contentNum);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				return convertDBtoClass(rs);
			}
		} catch (Exception e) {
			System.out.println("Error: content.ContentDAO.getContent Failed (" + e.getMessage() + ")");
		}
		return null;
	}

	public int deleteContent(String contentNum) {
		String sql = "DELETE FROM content WHERE contentNum = ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn.prepareStatement(sql), contentNum)
		) {
			System.out.println(pstmt);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("Error: content.ContentDAO.deleteContent Failed (" + e.getMessage() + ")");
		}
		return -1;
	}

	private ContentDTO convertDBtoClass(ResultSet rs) throws SQLException {
		ContentDTO content = new ContentDTO();
		content.setContentNum(rs.getInt("contentNum"));
		content.setPicture(rs.getString("picture"));
		content.setWriteId(rs.getString("writeId"));

		// 시간을 오전 오후로 변환하여 표시
		int date = Integer.parseInt(rs.getString("writeDate").substring(11, 13));
		String dateType = "오전";
		if (Integer.parseInt(rs.getString("writeDate").substring(11, 13)) >= 12) {
			dateType = "오후";
			date -= 12;
		}

		content.setWriteDate(rs.getString("writeDate").substring(0, 11) + " " + dateType + " " + date + "시 " + rs.getString("writeDate").substring(14, 16) + "분");
		content.setFileName(rs.getString("fileName"));
		content.setFileRealName(rs.getString("fileRealName"));
		content.setTitle(checkBadScript(rs.getString("title")));
		content.setContent(checkBadScript(rs.getString("content")));
		content.setCoinAmount(rs.getInt("coinAmount"));
		content.setLikeAmount(rs.getInt("likeAmount"));
		content.setCommentAmount(rs.getInt("commentAmount"));
		content.setReportAmount(rs.getInt("reportAmount"));
		return content;
	}

	private String checkBadScript(String str) {
		return str.replaceAll(" ", "&nbsp;")
				.replaceAll("<", "&lt;")
				.replaceAll(">", "&gt;")
				.replaceAll("\n", "<br>");
	}

	private PreparedStatement setPreparedStatement(PreparedStatement pstmt, Object status) throws SQLException {
		if (status instanceof String) {
			pstmt.setString(1, (String) status);
		} else {
			pstmt.setInt(1, (int) status);
		}
		return pstmt;
	}
}
