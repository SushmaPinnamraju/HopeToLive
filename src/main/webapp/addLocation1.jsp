<%@page import="java.io.ObjectInputFilter.Status"%>
<%@page import="dao.LocationDao"%>
<%@page import="models.LocationModel"%>
<% 
	String locationName=request.getParameter("locationName");

	LocationModel locationModel = new LocationModel();
	locationModel.setLocationName(locationName);
	
	LocationDao locationDao = new LocationDao();
	String Status = locationDao.addLocation(locationModel);
	if(Status.equalsIgnoreCase("Location added Successfully")){
		response.sendRedirect("mMessageSuccess.jsp?Msg="+Status);		
	}else{
			response.sendRedirect("mMessageFailed.jsp?Msg="+Status);
    }
%>