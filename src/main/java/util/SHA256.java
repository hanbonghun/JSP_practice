package util;
import java.security.MessageDigest; //JAVA에서 SHA 암호화를 사용하기 위해 
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
	        MessageDigest md = MessageDigest.getInstance("SHA-256"); //digest : 해시함수가 출력하는 압축된 문장 
	        md.update(text.getBytes()); //객체 내 저장된 digest값 갱신 
	        return bytesToHex(md.digest());  //md.digest() : 해시 결과 
	    }
	  
	
}

