package board;

import util.ConnUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {

	private BoardDAO() { }

	private static class LazyHolder {
		static final BoardDAO INSTANCE = new BoardDAO();
	}

	public static BoardDAO getInstance() {
		return BoardDAO.LazyHolder.INSTANCE;
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
			System.out.println("Error: board.BoardDAO.getDate Failed (" + e.getMessage() + ")");
		}
		return "";
	}

	public int getNext() {
		String sql = "SELECT contentNum FROM board ORDER BY contentNum DESC";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		} catch (Exception e) {
			System.out.println("Error: board.BoardDAO.getNext Failed (" + e.getMessage() + ")");
		}
		return 1;
	}

	public int write(String contentTitle, String userName, String contentDetail) {
		String sql = "INSERT INTO board VALUES(?, ?, ?, ?, ?)";

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
			System.out.println("Error: board.BoardDAO.write Failed (" + e.getMessage() + ")");
		}
		return -1;
	}

	public List<BoardDTO> getList(int pageNumber) {
		List<BoardDTO> list = new ArrayList<>();
		String sql = "SELECT * FROM board WHERE contentNum < ? ORDER BY contentNum DESC LIMIT 10";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, (getNext() - (pageNumber - 1) * 10));
				ResultSet rs = pstmt.executeQuery()
		) {
			while (rs.next()) {
				BoardDTO boardDTO = new BoardDTO();
				boardDTO.setContentNum(rs.getInt(1));
				boardDTO.setContentTitle(rs.getString(2));
				boardDTO.setContentUser(rs.getString(3));
				boardDTO.setContentDate(rs.getString(4));
				boardDTO.setContentDetail(rs.getString(5));
				list.add(boardDTO);
			}
		} catch (Exception e) {
			System.out.println("Error: board.BoardDAO.getList Failed (" + e.getMessage() + ")");
		}
		return list;
	}

	public boolean nextPage(int pageNumber) {
		String sql = "SELECT * FROM board WHERE contentNum < ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, (getNext() - (pageNumber - 1) * 10));
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			System.out.println("Error: board.BoardDAO.nextPage Failed (" + e.getMessage() + ")");
		}
		return false;
	}

	public BoardDTO getContent(int contentNum) {
		String sql = "SELECT * FROM board WHERE contentNum = ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, contentNum);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				BoardDTO boardDTO = new BoardDTO();
				boardDTO.setContentNum(rs.getInt(1));
				boardDTO.setContentTitle(rs.getString(2));
				boardDTO.setContentUser(rs.getString(3));
				boardDTO.setContentDate(rs.getString(4));
				boardDTO.setContentDetail(rs.getString(5));
				return boardDTO;
			}
		} catch (Exception e) {
			System.out.println("Error: board.BoardDAO.getContent Failed (" + e.getMessage() + ")");
		}
		return null;
	}

	public int contentUpdate(int contentNum, String contentTitle, String contentDetail) {
		String sql = "UPDATE board SET contentTitle = ?, contentDetail = ? WHERE contentNum = ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
		) {
			pstmt.setString(1, contentTitle);
			pstmt.setString(2, contentDetail);
			pstmt.setInt(3, contentNum);
			pstmt.executeUpdate();
			return 1;
		} catch (Exception e) {
			System.out.println("Error: board.BoardDAO.contentUpdate Failed (" + e.getMessage() + ")");
		}
		return -1;
	}

	public int contentDelete(int contentNum) {
		String sql = "DELETE FROM board WHERE contentNum = ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, contentNum)
		) {
			return pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("Error: board.BoardDAO.contentDelete Failed (" + e.getMessage() + ")");
		}
		return -1;
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
