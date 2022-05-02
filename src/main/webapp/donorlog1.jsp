<%@page import="dao.DonorDao"%>
<% 
	String email = request.getParameter("email");
	String password = request.getParameter("password");

	DonorDao donorDao = new DonorDao();
	donorDao.donorLogin(email, password, response, session);
%>