package models;

public class DonationSentModel {

	private String donationSentId;
	private String fundAccountId;
	private FundAccountModel fundAccountModel;
	private String fundRequestId;
	private FundRequestModel fundRequestModel;
	private String amount;
	private String date;
	private String status;
	public String getDonationSentId() {
		return donationSentId;
	}
	public void setDonationSentId(String donationSentId) {
		this.donationSentId = donationSentId;
	}
	public String getFundAccountId() {
		return fundAccountId;
	}
	public void setFundAccountId(String fundAccountId) {
		this.fundAccountId = fundAccountId;
	}
	public FundAccountModel getFundAccountModel() {
		return fundAccountModel;
	}
	public void setFundAccountModel(FundAccountModel fundAccountModel) {
		this.fundAccountModel = fundAccountModel;
	}
	public String getFundRequestId() {
		return fundRequestId;
	}
	public void setFundRequestId(String fundRequestId) {
		this.fundRequestId = fundRequestId;
	}
	public FundRequestModel getFundRequestModel() {
		return fundRequestModel;
	}
	public void setFundRequestModel(FundRequestModel fundRequestModel) {
		this.fundRequestModel = fundRequestModel;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
