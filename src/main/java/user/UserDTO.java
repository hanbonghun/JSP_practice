package user;

public class UserDTO { //DTO(Data Transfer Object) 
	//JSP 에서 하나의 데이터 단위를 담기 위한 객체 
	String userID;
	String userPassword;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getUserPassword() {
		return userPassword;
	}
	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

}
