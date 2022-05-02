<%@page import="models.LocationModel"%>
<%@page import="dao.LocationDao"%>
<%@page import="java.util.Iterator"%>
<%@page import="models.VerifierModel"%>
<%@page import="java.util.List"%>
<%@page import="dao.VerifierDao"%>
<%@ include file="adminHead.jsp" %>
<% 
	VerifierDao verifierDao = new VerifierDao();
	LocationDao locationDao = new LocationDao();
	List<VerifierModel> verifierList = verifierDao.viewVerifiers();
	Iterator<VerifierModel> verifierIterator = verifierList.iterator();
%>
<div class="container">
<div class="row">
<div class="col-md-2"></div>
<div class="col-md-8">
	<div class="text-center h4 m-5">View Verifiers</div>
	<table class="table table-primary table-bordered">
		<thead>
			<tr>
				<th>Name</th>
				<th>Email</th>
				<th>Phone</th>
				<th>Address</th>
				<th>LocationName</th>		
			</tr>
		</thead>
		<tbody>
		<% while (verifierIterator.hasNext()) {
			VerifierModel verifierModel =verifierIterator.next();%>
			<tr>
				<td><%=verifierModel.getName()%></td>
				<td><%=verifierModel.getEmail()%></td>
				<td><%=verifierModel.getPhone()%></td>
				<td><%=verifierModel.getAddress()%></td>
				<td>
					<% 
					LocationModel locationModel = locationDao.getLocationsById(verifierModel.getLocationId());
					out.println(locationModel.getLocationName());
					%>
				</td>
			</tr>
			<%} %>
		</tbody>
	</table>
</div>
</div>
</div>