<%@page import="md5.MD5"%>
<%@page import="dao.DonorDao"%>
<%@page import="models.DonorModel"%>
<% 
	String locationId=request.getParameter("locationId");
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String phone=request.getParameter("phone");
	String password=request.getParameter("password");

	DonorModel donorModel = new DonorModel();
	donorModel.setLocationId(locationId);
	donorModel.setName(name);
	donorModel.setEmail(email);
	donorModel.setPhone(phone);
	donorModel.setPassword(MD5.getMd5(password));

	DonorDao donorDao = new DonorDao();
	String Status = donorDao.donorRegistration(donorModel);
		if(Status.equalsIgnoreCase("Donor Registered Successfully")){
			response.sendRedirect("mMessageSuccess.jsp?Msg="+Status);		
		}else{
			response.sendRedirect("mMessageFailed.jsp?Msg="+Status);
		}
%>