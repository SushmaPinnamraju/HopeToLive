<%@page import="dao.HospitalDao"%>
<% 
	String email = request.getParameter("email");
	String password = request.getParameter("password");
	
	HospitalDao hospitalDao = new HospitalDao();
	hospitalDao.hospitalLogin(email, password, response, session);
%>