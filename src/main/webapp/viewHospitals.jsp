<%@page import="models.LocationModel"%>
<%@page import="dao.LocationDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="models.HospitalModel"%>
<%@page import="java.util.List"%>
<%@page import="dao.HospitalDao"%>
<%@ include file="adminHead.jsp" %>
<% 
	HospitalDao hospitalDao = new HospitalDao();
	LocationDao locationDao = new LocationDao();
	List<HospitalModel> hospitalList = hospitalDao.viewHospitals();
	Iterator<HospitalModel> hospitalIterator =  hospitalList.iterator();
%>

<div class="row">
<div class="col-md-2"></div>
<div class="col-md-8">
	<div class="text-center h4 m-5">View Hospitals</div>
	<table class="table table-primary table-bordered">
		<thead>
			<tr>
				<th>Hospital Name</th>
				<th>Hospital Type</th>
				<th>Hospital Code</th>
				<th>Email</th>
				<th>Phone</th>	
				<th>Account Number</th>
				<th>Address</th>	
				<th>Location</th>
				<th>Status</th>
				<th>Action</th>
			</tr>
		</thead>
		<tbody>
		<% while (hospitalIterator.hasNext()) {
			HospitalModel hospitalModel =hospitalIterator.next();%>
			<tr>
				<td><%=hospitalModel.getHospitalName()%></td>
				<td><%=hospitalModel.getHospitalType()%></td>
				<td><%=hospitalModel.getHospitalCode()%></td>
				<td><%=hospitalModel.getEmail()%></td>
				<td><%=hospitalModel.getPhone()%></td>
				<td><%=hospitalModel.getAccountNumber()%></td>
				<td><%=hospitalModel.getAddress()%></td>
				<td>
					<% 
					LocationModel locationModel = locationDao.getLocationsById(hospitalModel.getLocationId());
					out.println(locationModel.getLocationName());
					%>
				</td>
				<td><%=hospitalModel.getStatus() %></td>
				<td>
					<% 
					 if(hospitalModel.getStatus().equalsIgnoreCase("unauthorized")){%>
					 		
					 	<a href="activate.jsp?hospitalId=<%=hospitalModel.getHospitalId()%>&status=<%=hospitalModel.getStatus()%>" class="btn btn-primary">authorized</a>	
					 		
					 <%	}else{%>
					 	<a href="activate.jsp?hospitalId=<%=hospitalModel.getHospitalId()%>&status=<%=hospitalModel.getStatus()%>" class="btn btn-Danger">unauthorized</a>
					 		
					 <%}%>
				</td>
			</tr>
			<%} %>
		</tbody>
	</table>
</div>
</div>
