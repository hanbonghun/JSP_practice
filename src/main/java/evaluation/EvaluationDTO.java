package evaluation;

public class EvaluationDTO {
	private int evaluationID;
	private String userID;
	private String lectureName;
	private String professorName;
	private int lectureYear;
	private String semesterDivide;
	private String lectureDivide;
	private String evaluationTitle;
	private String evaluationContent;
	private String totalScore;
	private String assignment;
	private String groupMeeting;
	private String attendance;
	private int likeCount;

	public String getLectureDivide() {
		return lectureDivide;
	}

	public void setLectureDivide(String lectureDivide) {
		this.lectureDivide = lectureDivide;
	}
	
	public EvaluationDTO() {}
	
	public EvaluationDTO(int evaluationID, String userID, String lectureName, String professorName, int lectureYear,
			String semesterDivide, String lectureDivide, String evaluationTitle, String evaluationContent, String totalScore,
			String assignment, String groupMeeting, String attendance, int likeCount) {
		super();
		this.evaluationID = evaluationID;
		this.userID = userID;
		this.lectureName = lectureName;
		this.professorName = professorName;
		this.lectureYear = lectureYear;
		this.semesterDivide = semesterDivide;
		this.lectureDivide = lectureDivide;
		this.evaluationTitle = evaluationTitle;
		this.evaluationContent = evaluationContent;
		this.totalScore = totalScore;
		this.assignment = assignment;
		this.groupMeeting = groupMeeting;
		this.attendance = attendance;
		this.likeCount = likeCount;
	}
	public int getEvaluationID() {
		return evaluationID;
	}
	public void setEvaluationID(int evaluationID) {
		this.evaluationID = evaluationID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getLectureName() {
		return lectureName;
	}
	public void setLectureName(String lectureName) {
		this.lectureName = lectureName;
	}
	public String getProfessorName() {
		return professorName;
	}
	public void setProfessorName(String professorName) {
		this.professorName = professorName;
	}
	public int getLectureYear() {
		return lectureYear;
	}
	public void setLectureYear(int lectureYear) {
		this.lectureYear = lectureYear;
	}
	public String getSemesterDivide() {
		return semesterDivide;
	}
	public void setSemesterDivide(String semesterDivide) {
		this.semesterDivide = semesterDivide;
	}
	public String getEvaluationTitle() {
		return evaluationTitle;
	}
	public void setEvaluationTitle(String evaluationTitle) {
		this.evaluationTitle = evaluationTitle;
	}
	public String getEvaluationContent() {
		return evaluationContent;
	}
	public void setEvaluationContent(String evaluationContent) {
		this.evaluationContent = evaluationContent;
	}
	public String getTotalScore() {
		return totalScore;
	}
	public void setTotalScore(String totalScore) {
		this.totalScore = totalScore;
	}
	public String getAssignment() {
		return assignment;
	}
	public void setAssignment(String assignment) {
		this.assignment = assignment;
	}
	public String getGroupMeeting() {
		return groupMeeting;
	}
	public void setGroupMeeting(String groupMeeting) {
		this.groupMeeting = groupMeeting;
	}
	public String getAttendance() {
		return attendance;
	}
	public void setAttendance(String attendance) {
		this.attendance = attendance;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	

}
