<%@page import="dao.HospitalDao"%>
<% 
	String hospitalId = request.getParameter("hospitalId");
	String status = request.getParameter("status");
	
	HospitalDao hospitalDao = new HospitalDao();
	hospitalDao.activateHospital(hospitalId, status, response);
%>