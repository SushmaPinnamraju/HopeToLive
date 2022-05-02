<%@page import="java.util.Iterator"%>
<%@page import="models.LocationModel"%>
<%@page import="java.util.List"%>
<%@page import="dao.LocationDao"%>
<%@ include file="mainHead.jsp" %>
<% 
	LocationDao locationDao = new LocationDao();
	List<LocationModel> locationList = locationDao.getLocations();
	Iterator<LocationModel> locationIterator=locationList.iterator();
%>
<div class="container mt-5">
	<div class="card p-4">
		<form action="hospitalReg1.jsp" method="post">
			<div class="text-center h2">New Hospital Registration</div>
			<div class="row">
				<div class="col-md-2"></div>
				<div class="col-md-4">
					<div class="mb-3 mt-3">
						<label for="locationId">Choose Location </label> 
						<select  name="locationId" id="locationId" required class="form-control">
						<%while(locationIterator.hasNext()){
								LocationModel locationModel= locationIterator.next();%>
								<option value="<%=locationModel.getLocationId()%>"><%=locationModel.getLocationName()%></option>
						<%}%>						
						</select>
					</div>
					<div class="mb-3 mt-3">
						<label for="hospitalName">Hospital Name</label>
						 <input type="text" id="hospitalName"name="hospitalName" placeholder="Enter Hospital Name" required class="form-control">
					</div>
					<div class="mb-3 mt-3">
						<label for="hospitalType">Hospital Type</label>
						<input type="text" id="hospitalType"name="hospitalType" placeholder="Enter Hospital Type" required class="form-control">
					</div>
					<div class="mb-3 mt-3">
						<label for="hospitalCode">Hospital Code </label> 
						<input type="text"id="hospitalCode" name="hospitalCode" placeholder="Enter Hospital Code"required class="form-control">
					</div>
					<div class="mb-3 mt-3">
						<label for="address">Add Address</label>
						<textarea name="address" class="form-control" placeholder="Enter Address" ></textarea>
					</div>
				</div>
	
				<div class="col-md-4">					
					<div class="mb-3 mt-3">
						<label for="email">Email</label>
						<input type="email" id="email" name="email" placeholder="Enter Email Address" required class="form-control">
					</div>
					<div class="mb-3 mt-3">
						<label for="phone">Phone Number </label> 
						<input type="number"id="phone" name="phone" placeholder="Enter Phone Number"required class="form-control">
					</div>
					<div class="mb-3 mt-3">
						<label for="password">Password</label>
						<input type="password" id="password" name="password"placeholder="Enter password" required class="form-control">
					</div >
					<div class="mb-3 mt-3">
						<label for="accountNumber">Account Number</label>
						<input type="Number" id="accountNumber" name="accountNumber"placeholder="Enter Account Number" required class="form-control">
					</div>
					<div class="mb-3 mt-3">
						<input type="Submit" value="Submit" class="btn btn-primary btn-block mt-3 mb-4" style="width:100%">
					</div>
				</div>		
				</div>		
		</form>
	</div>
</div>