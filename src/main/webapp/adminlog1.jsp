<%
	String email=request.getParameter("email");
	String password=request.getParameter("password");
	
	if(email.equalsIgnoreCase("admin@gmail.com") && password.equalsIgnoreCase("admin") ){
		
			session.setAttribute("email", email);
			session.setAttribute("role", "admin");
			
			response.sendRedirect("adminHome.jsp");
		
	}else{
			response.sendRedirect("mMessageFailed.jsp?Msg=Invalid Login Details");
	}
%>>