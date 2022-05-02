<%@page import="java.util.Iterator"%>
<%@page import="models.LocationModel"%>
<%@page import="java.util.List"%>
<%@page import="dao.LocationDao"%>
<%@ include file="adminHead.jsp" %>
<% 
	LocationDao locationDao = new LocationDao();
	List<LocationModel> locationList = locationDao.getLocations();
	Iterator<LocationModel> locationIterator=locationList.iterator();
%>
<div class="crwd-add-verifier">
<div class="row">
	<div class="col-md-4"></div>
	<div class="col-md-4"><br><br><br>
		<div class="card mt-2 p-3">
			<form action="addVerifier1.jsp" method="post">
			<div class="text-center h3">Add Verifier</div>
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
					<label for="name">Name</label>
					<input type="text" id="name" name="name" placeholder="Enter Name" required class="form-control">
				</div>
				<div class="mb-3 mt-3">
					<label for="email">Email</label>
					 <input type="email" id="email"name="email" placeholder="Enter Email" required class="form-control">
				</div>
				<div class="mb-3 mt-3">
					<label for="phone">Phone</label>
					<input type="Number" id="phone"name="phone" placeholder="Enter Phone Number" required class="form-control">
				</div>
				<div class="mb-3 mt-3">
					<label for="password">Password </label> 
					<input type="password"id="password" name="password" placeholder="Enter Password"required class="form-control">
				</div>
				<div class="mb-3 mt-3">
					<label for="address">Add Address</label>
					<textarea name="address" class="form-control"  placeholder="Enter Address"required ></textarea>
				</div>
					<input type="submit" value="submit" class="btn btn-primary btn-block mt-3 " style="width:100%;">
			</form>
		</div>
	</div>
	<div class="col-md-4"></div>
</div>
</div>