package user;

import util.ConnUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

	private UserDAO() {	}

	private static class LazyHolder {
		static final UserDAO INSTANCE = new UserDAO();
	}

	public static UserDAO getInstance() {
		return LazyHolder.INSTANCE;
	}

	private PreparedStatement setPreparedStatement(Connection conn, String sql, String state) throws SQLException {
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, state);
		return stmt;
	}

	public int login(String userId, String userPw) {
		String sql = "SELECT userPw FROM user WHERE userId = ?";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = setPreparedStatement(conn, sql, userId);
				ResultSet rs = pstmt.executeQuery()
		) {
			if (rs.next()) { // next() 하여 데이터가 있다면
				if (rs.getString(1).equals(userPw)) {
					return 1; // 로그인 성공
				} else {
					return 0; // 비밀번호 불일치
				}
			}
			return -1; // 아이디 없음
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -2; // 데이터 오류
	}

}
