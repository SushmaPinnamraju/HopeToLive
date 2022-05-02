package models;

public class FundRequestModel {

	private String fundRequestId;
	private String seekerId;
	private String verifierId;
	private String hospitalId;
	private String cause;
	private String date;
	private String description;
	private String photo;
	private String reports;
	private String status;
	private double amountRequired;
	public String getFundRequestId() {
		return fundRequestId;
	}
	public void setFundRequestId(String fundRequestId) {
		this.fundRequestId = fundRequestId;
	}
	public String getSeekerId() {
		return seekerId;
	}
	public void setSeekerId(String seekerId) {
		this.seekerId = seekerId;
	}
	public String getVerifierId() {
		return verifierId;
	}
	public void setVerifierId(String verifierId) {
		this.verifierId = verifierId;
	}

	public String getHospitalId() {
		return hospitalId;
	}
	public void setHospitalId(String hospitalId) {
		this.hospitalId = hospitalId;
	}
	
	public String getCause() {
		return cause;
	}
	public void setCause(String cause) {
		this.cause = cause;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getReports() {
		return reports;
	}
	public void setReports(String reports) {
		this.reports = reports;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	public double getAmountRequired() {
		return amountRequired;
	}
	public void setAmountRequired(double amountRequired) {
		this.amountRequired = amountRequired;
	}
	
	
}
