package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;



public class UserDAO { // DAO= 데이터베이스  접근 객체: 데이터베이스에서 정보를 불러오거나 입력할때 사용.
	private Connection conn; 		//Connection : DB에 접근하게 해주는 객체
	private PreparedStatement pstmt;
	private ResultSet rs; 			//정보를 담을 수 있는 객체 생성
	
	
	//mysql에 접속하게 해주는 부분.
	public UserDAO() {		//UserDAO를 생성자를 통해 하나의 객체로 만듦. DB 자동 connection이 이루어지게 하기 위함.
		try {
			String dbURL="jdbc:mysql://localhost:3306/BBS";  //본인 컴퓨터 주소 3306포트(mysql서버)에 BBS 접속 가능.
			String dbID ="root";
			String dbPassword = "root";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);  //conn 객체안에 접속된 정보가 담기게 됨.
		}catch(Exception e) {
			e.printStackTrace();
		}
	}

	//login을 시도하는 함수
	public int login(String userID, String userPassword) {
		String SQL="SELECT userPassword FROM user WHERE userID = ?";
		
		try {	// 하나의 준비된 문장 물음표에 값을 입력.
			pstmt =conn.prepareStatement(SQL);	// prepareStatement에 정해진 SQL 문장을 데이터베이스에 삽입하는  pstmt 인스턴스를 가져 옴
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); 			// 결과를 담을 수 있는 객체(rs)에 실행 결과를 넣어준다.
			if (rs.next()) { // 	아이디가 있는 경우.
					if(rs.getString(1).equals(userPassword)) 	// 결과로 나온(rs) 값(password)과 password와 동일하다면 아래의 값 반환	 
						return 1; //	로그인 성공
					else 						
						return 0; //	비밀번호 불일치
			}
			return -1; // 아이디가 없음.
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -2;	//	데이터베이스 오류
	}
	
}
