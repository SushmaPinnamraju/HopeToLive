<%@page import="dao.VerifierDao"%>
<% 
	String email = request.getParameter("email");
	String password = request.getParameter("password");

	VerifierDao verifierDao = new VerifierDao();
	verifierDao.verifierLogin(email, password, response, session);
%>