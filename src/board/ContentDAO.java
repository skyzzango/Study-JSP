package board;

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

	public String getDate() {
		String sql = "SELECT NOW()";
		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			System.out.println("Error: board.ContentDAO.getDate Failed (" + e.getMessage() + ")");
		}
		return "";
	}

	public int getNext() {
		String sql = "SELECT contentNum FROM content ORDER BY contentNum DESC";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		} catch (Exception e) {
			System.out.println("Error: board.ContentDAO.getNext Failed (" + e.getMessage() + ")");
		}
		return 1;
	}

	public int write(String contentTitle, String userName, String contentDetail) {
		String sql = "INSERT INTO content VALUES(?, ?, ?, ?, ?)";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
		) {
			pstmt.setInt(1, getNext());
			pstmt.setString(2, contentTitle);
			pstmt.setString(3, userName);
			pstmt.setString(4, getDate());
			pstmt.setString(5, contentDetail);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			System.out.println("Error: board.ContentDAO.write Failed (" + e.getMessage() + ")");
		}
		return -1;
	}

	public List<Content> getList(int pageNumber) {
		List<Content> list = new ArrayList<>();
		String sql = "SELECT * FROM content " +
				"WHERE contentNum < ? " +
				"ORDER BY contentNum DESC " +
				"LIMIT 10";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, (getNext() - (pageNumber - 1) * 10));
				ResultSet rs = pstmt.executeQuery()
		) {
			while (rs.next()) {
				Content content = new Content();
				content.setContentNum(rs.getInt(1));
				content.setContentTitle(rs.getString(2));
				content.setContentUser(rs.getString(3));
				content.setContentDate(rs.getString(4));
				content.setContentDetail(rs.getString(5));
				list.add(content);
			}
		} catch (Exception e) {
			System.out.println("Error: board.ContentDAO.getList Failed (" + e.getMessage() + ")");
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {
		String sql = "SELECT * FROM content WHERE contentNum < ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, (getNext() - (pageNumber - 1) * 10));
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			System.out.println("Error: board.ContentDAO.nextPage Failed (" + e.getMessage() + ")");
		}
		return false;
	}

	public Content getContent(int contentNum) {
		String sql = "SELECT * FROM content WHERE contentNum = ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, contentNum);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				Content content = new Content();
				content.setContentNum(rs.getInt(1));
				content.setContentTitle(rs.getString(2));
				content.setContentUser(rs.getString(3));
				content.setContentDate(rs.getString(4));
				content.setContentDetail(rs.getString(5));
				return content;
			}
		} catch (Exception e) {
			System.out.println("Error: board.ContentDAO.getContent Failed (" + e.getMessage() + ")");
		}
		return null;
	}

	private PreparedStatement setPreparedStatement(Connection conn, String sql, Object status) throws SQLException {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		if (status instanceof String) {
			pstmt.setString(1, (String) status);
		} else {
			pstmt.setInt(1, (int) status);
		}
		return pstmt;
	}

}
