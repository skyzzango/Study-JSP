package boardone;

import util.ConnUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BoardDao {
	private static BoardDao instance = null;

	private BoardDao() { }

	public static BoardDao getInstance() {
		if (instance == null) {
			synchronized (BoardDao.class) {
				if (instance == null) {
					instance = new BoardDao();
				}
			}
		}
		return instance;
	}

	private PreparedStatement setPreparedStatement(Connection conn, String sql, int start, int end) throws SQLException {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, start);
		pstmt.setInt(2, end);
		return pstmt;
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

	public void insertArticle(BoardDto article) {
		int num = article.getNum();
		int ref = article.getRef();
		int step = article.getStep();
		int depth = article.getDepth();
		int number;

		String sql = "select max(num) from board";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				number = rs.getInt(1) + 1;
			} else {
				number = 1;
			}

			if (num != 0) { // 답 글일 경우
				sql = "update board set step = step + 1 where ref = ? and step > ?";
				try (PreparedStatement pstmt1 = conn.prepareStatement(sql)) {
					pstmt1.setInt(1, ref);
					pstmt1.setInt(2, step);
					pstmt1.executeUpdate();
					step++;
					depth++;
				}
			} else { // 새 글일 경우
				ref = number;
				step = 0;
				depth = 0;
			}

			sql = "insert into board " +
					"(num, writer, email, subject, password, regdate, ref, step, depth, content, ip) " +
					"values (null, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			try (PreparedStatement pstmt2 = conn.prepareStatement(sql)) {
				pstmt2.setString(1, article.getWriter());
				pstmt2.setString(2, article.getEmail());
				pstmt2.setString(3, article.getSubject());
				pstmt2.setString(4, article.getPassword());
				pstmt2.setTimestamp(5, article.getRegdate());
				pstmt2.setInt(6, ref);
				pstmt2.setInt(7, step);
				pstmt2.setInt(8, depth);
				pstmt2.setString(9, article.getContent());
				pstmt2.setString(10, article.getIp());
				pstmt2.executeUpdate();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int getArticleCount() {
		int x = 0;
		String sql = "select count(*) as totalCount from board";
		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return x;
	}

	public List<BoardDto> getArticlesPage(int start, int end) {
		List<BoardDto> articleList = null;
		String sql = "select num, writer, email, subject, password, regdate, readcount, ref, step, depth, content, ip " +
				"from board " +
				"order by ref desc, step asc " +
				"limit ?, ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, start, end);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				articleList = new ArrayList<>(10);
				do {
					BoardDto article = createArticle(rs);
					articleList.add(article);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articleList;
	}

	public List<BoardDto> getArticles() {
		List<BoardDto> articleList = null;
		String sql = "select * from board order by num desc";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				articleList = new ArrayList<>();
				do {
					BoardDto article = createArticle(rs);
					articleList.add(article);
				} while (rs.next());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return articleList;
	}

	public BoardDto getArticle(int num) {
		BoardDto article = null;
		String sql = "update board set readcount = readcount + 1 where num = ?";
		String sql1 = "select * from board where num = ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, num);
				PreparedStatement pstmt1 = setPreparedStatement(conn, sql1, num);
				ResultSet rs = pstmt1.executeQuery()
		) {
			pstmt.executeUpdate();

			if (rs.next()) {
				article = createArticle(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return article;
	}

	public BoardDto updateGetArticle(int num) {
		BoardDto article = null;
		String sql = "select * from board where num = ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, num);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				article = createArticle(rs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return article;
	}

	public int updateArticle(BoardDto article) {
		int result = -1;
		String sql = "select password from board where num = ?";
		String sql1 = "update board set writer = ?, email = ?, subject = ?, content = ? where num = ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, article.getNum());
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				String dbPass = rs.getString("password");
				if (dbPass.equals(article.getPassword())) {
					try (PreparedStatement pstmt1 = conn.prepareStatement(sql1)) {
						pstmt1.setString(1, article.getWriter());
						pstmt1.setString(2, article.getEmail());
						pstmt1.setString(3, article.getSubject());
						pstmt1.setString(4, article.getContent());
						pstmt1.setInt(5, article.getNum());
						pstmt1.executeUpdate();
						result = 1;
					}
				} else {
					result = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int deleteArticle(int num, String pass) {
		int result = -1;
		String sql = "select password from board where num = ?";
		String sql1 = "delete from board where num = ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, num);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) {
				String dbPass = rs.getString("password");
				if (dbPass.equals(pass)) {
					try (PreparedStatement pstmt1 = conn.prepareStatement(sql1)) {
						pstmt1.setInt(1, num);
						pstmt1.executeUpdate();
						result = 1;
					}
				} else {
					result = 0;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	private BoardDto createArticle(ResultSet rs) throws SQLException {
		BoardDto article = new BoardDto();

		article.setNum(rs.getInt("num"));
		article.setWriter(rs.getString("writer"));
		article.setEmail(rs.getString("email"));
		article.setSubject(rs.getString("subject"));
		article.setPassword(rs.getString("password"));
		article.setRegdate(rs.getTimestamp("regdate"));
		article.setReadcount(rs.getInt("readcount"));
		article.setRef(rs.getInt("ref"));
		article.setStep(rs.getInt("step"));
		article.setDepth(rs.getInt("depth"));
		article.setContent(rs.getString("content"));
		article.setIp(rs.getString("ip"));

		return article;
	}
}
