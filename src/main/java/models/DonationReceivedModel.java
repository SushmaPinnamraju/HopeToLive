package models;


public class DonationReceivedModel {

	private String donationReceivedId;
	private String senderId;
	private String sender;
	private String receiverId;
	private String receiver;
	private double amount;
	private String donationType;
	private String fundRequestId;
	private String date;
	public String getDonationReceivedId() {
		return donationReceivedId;
	}
	public void setDonationReceivedId(String donationReceivedId) {
		this.donationReceivedId = donationReceivedId;
	}
	public String getSenderId() {
		return senderId;
	}
	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public String getReceiverId() {
		return receiverId;
	}
	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}
	
	public double getAmount() {
		return amount;
	}
	public void setAmount(double amount) {
		this.amount = amount;
	}
	public String getDonationType() {
		return donationType;
	}
	public void setDonationType(String donationType) {
		this.donationType = donationType;
	}
	public String getFundRequestId() {
		return fundRequestId;
	}
	public void setFundRequestId(String fundRequestId) {
		this.fundRequestId = fundRequestId;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getReceiver() {
		return receiver;
	}
	public void setReceiver(String receiver) {
		this.receiver = receiver;
	}
	
}
