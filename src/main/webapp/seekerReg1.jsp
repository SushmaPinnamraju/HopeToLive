<%@page import="dao.SeekerDao"%>
<%@page import="md5.MD5"%>
<%@page import="models.SeekerModel"%>
<% 
	String locationId=request.getParameter("locationId");
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String phone=request.getParameter("phone");
	String password=request.getParameter("password");
 
	SeekerModel seekerModel = new SeekerModel();
	seekerModel.setLocationId(locationId);
	seekerModel.setName(name);
	seekerModel.setEmail(email);
	seekerModel.setPhone(phone);
	seekerModel.setPassword(MD5.getMd5(password));
	
	SeekerDao seekerDao = new SeekerDao();
	String Status = seekerDao.seekeRegistration(seekerModel);
	if(Status.equalsIgnoreCase("Seeker Registered Successfully")){
		response.sendRedirect("mMessageSuccess.jsp?Msg="+Status);		
	}else{
			response.sendRedirect("mMessageFailed.jsp?Msg="+Status);
    }
	
%>