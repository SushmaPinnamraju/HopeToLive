<%@page import="java.util.Iterator"%>
<%@page import="models.LocationModel"%>
<%@page import="java.util.List"%>
<%@page import="dao.LocationDao"%>
<%@ include file="adminHead.jsp" %>
<% 
	LocationDao locationDao = new LocationDao();
	List<LocationModel> locationList =locationDao.viewLocations();
	Iterator<LocationModel> locationIterator= locationList.iterator();
%>
<div class="container">
<div class="row">
<div class="col-md-4"></div>
<div class="col-md-4">
	<div class="text-center h4 m-5">View Locations</div>
	<table class="table table-primary table-bordered">
		<thead>
			<tr>
				<th>Location Name</th>		
			</tr>
		</thead>
		<tbody>
		<% while (locationIterator.hasNext()) {
			LocationModel locationModel =locationIterator.next();%>
			<tr>
				<td><%=locationModel.getLocationName()%></td>
			</tr>
			<%} %>
		</tbody>
	</table>
</div>
</div>
</div>