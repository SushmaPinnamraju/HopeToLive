package models;

public class VerifierModel {

	private String verifierId;
	private String locationId;
	private LocationModel locationModel;
	private String name;
	private String email;
	private String phone;
	private String password;
	private String address;
	public String getVerifierId() {
		return verifierId;
	}
	public void setVerifierId(String verifierId) {
		this.verifierId = verifierId;
	}
	public String getLocationId() {
		return locationId;
	}
	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}
	public LocationModel getLocationModel() {
		return locationModel;
	}
	public void setLocationModel(LocationModel locationModel) {
		this.locationModel = locationModel;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
}
