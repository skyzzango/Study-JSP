package util;

import javax.naming.InitialContext;
import javax.sql.DataSource;
import java.sql.Connection;

public class ConnUtil {

	private static class LazyHolder {
		static final ConnUtil INSTANCE = new ConnUtil();
	}

	public static ConnUtil getInstance() {
		return LazyHolder.INSTANCE;
	}

	public static Connection getConnection() throws Exception {
		DataSource dataSource = (DataSource) new InitialContext()
				.lookup("java:comp/env/jdbc/mySql");
		return dataSource.getConnection();
	}

}
