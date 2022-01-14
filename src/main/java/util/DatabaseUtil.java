package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil { // 데이터베이스와 연동 
   public static Connection getConnection() { //static을 사용하여 userDAO.java에서 함수 바로사용
      try {
         String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation";// 우리 컴퓨터 안에 깔린 3306 포트를 사용하는 TUTORIAL이라는 mysql DB에
         String dbID = "root"; // 접속할 ID
         String dbPassword = "nexon0918,"; // 접속할 비밀번호 
         Class.forName("com.mysql.jdbc.Driver"); //DriverManager에 등록

         return DriverManager.getConnection(dbURL, dbID, dbPassword);
      } catch (Exception e) {
         e.printStackTrace();
      }
      return null;
   }
}

