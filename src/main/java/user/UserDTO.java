package user;

public class UserDTO { //DTO(Data Transfer Object) 
	//JSP ���� �ϳ��� ������ ������ ��� ���� ��ü 
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
