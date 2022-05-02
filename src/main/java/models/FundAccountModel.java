package models;

public class FundAccountModel {

	private String fundAccountId;
	private long accountNumber;
	private double accountBalance;
	public String getFundAccountId() {
		return fundAccountId;
	}
	public void setFundAccountId(String fundAccountId) {
		this.fundAccountId = fundAccountId;
	}
	public long getAccountNumber() {
		return accountNumber;
	}
	public void setAccountNumber(long accountNumber) {
		this.accountNumber = accountNumber;
	}
	public double getAccountBalance() {
		return accountBalance;
	}
	public void setAccountBalance(double accountBalance) {
		this.accountBalance = accountBalance;
	}
	
}
