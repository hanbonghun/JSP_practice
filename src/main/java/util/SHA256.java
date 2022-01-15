package util;
import java.security.MessageDigest; //JAVA���� SHA ��ȣȭ�� ����ϱ� ���� 
import java.security.NoSuchAlgorithmException;



public class SHA256 {
	  private static String bytesToHex(byte[] bytes) {
	        StringBuilder builder = new StringBuilder();
	        for (byte b : bytes) {   
	            builder.append(String.format("%02x", b));
	        }
	        return builder.toString();
	    }
	  
	  public static String encrypt(String text) throws NoSuchAlgorithmException {
	        MessageDigest md = MessageDigest.getInstance("SHA-256"); //digest : �ؽ��Լ��� ����ϴ� ����� ���� 
	        md.update(text.getBytes()); //��ü �� ����� digest�� ���� 
	        return bytesToHex(md.digest());  //md.digest() : �ؽ� ��� 
	    }
	  
	
}

