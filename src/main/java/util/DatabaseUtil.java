package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil { // �����ͺ��̽��� ���� 
   public static Connection getConnection() { //static�� ����Ͽ� userDAO.java���� �Լ� �ٷλ��
      try {
         String dbURL = "jdbc:mysql://localhost:3306/LectureEvaluation";// �츮 ��ǻ�� �ȿ� �� 3306 ��Ʈ�� ����ϴ� TUTORIAL�̶�� mysql DB��
         String dbID = "root"; // ������ ID
         String dbPassword = "nexon0918,"; // ������ ��й�ȣ 
         Class.forName("com.mysql.jdbc.Driver"); //DriverManager�� ���

         return DriverManager.getConnection(dbURL, dbID, dbPassword);
      } catch (Exception e) {
         e.printStackTrace();
      }
      return null;
   }
}

