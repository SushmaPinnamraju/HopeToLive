<%@page import="dao.SeekerDao"%>
<% 
	String email = request.getParameter("email");
	String password = request.getParameter("password");

	SeekerDao seekerDao = new SeekerDao();
	seekerDao.seekerLogin(email, password, response, session);
%>