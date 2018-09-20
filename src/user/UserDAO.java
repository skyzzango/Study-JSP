package user;

import util.ConnUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

	private UserDAO() {
	}

	private static class LazyHolder {
		static final UserDAO INSTANCE = new UserDAO();
	}

	public static UserDAO getInstance() {
		return LazyHolder.INSTANCE;
	}

	private PreparedStatement setPreparedStatement(Connection conn, String sql, String state) throws SQLException {
		PreparedStatement pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, state);
		return pstmt;
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
					return 0; // 비밀번호 불 일치
				}
			}
			return -1; // 아이디 없음
		} catch (Exception e) {
			System.out.println("Error: user.UserDAO.login Failed (" + e.getMessage() + ")");
		}
		return -2; // DB 작동 오류
	}

	public int register(UserVo userVo) {
		System.out.println("Run: user.UserDAO.register");
		String sql = "INSERT INTO user VALUES(?, ?, ?)";

		try (
				Connection conn = ConnUtil.getConnection();
				PreparedStatement pstmt = conn.prepareStatement(sql)
		) {
			pstmt.setString(1, userVo.getUserId());
			pstmt.setString(2, userVo.getUserPw());
			pstmt.setString(3, userVo.getUserName());
			pstmt.executeUpdate();
			return 1; // 정상 실행
		} catch (Exception e) {
			System.out.println("Error: user.UserDAO.register Failed (" + e.getMessage() + ")");
		}
		return -1; // DB 작동 오류
	}

}
