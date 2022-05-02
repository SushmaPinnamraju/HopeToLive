<%@page import="md5.MD5"%>
<%@page import="dao.VerifierDao"%>
<%@page import="models.VerifierModel"%>
<% 
	String locationId=request.getParameter("locationId");
	String name=request.getParameter("name");
	String email=request.getParameter("email");
	String phone=request.getParameter("phone");
	String password=request.getParameter("password");
	String address=request.getParameter("address");
	 
	VerifierModel verifierModel = new VerifierModel();
	verifierModel.setLocationId(locationId);
	verifierModel.setName(name);
	verifierModel.setEmail(email);
	verifierModel.setPhone(phone);
	//verifierModel.setPassword(MD5.getMd5(password));
	verifierModel.setPassword(password);
	verifierModel.setAddress(address);
	
	VerifierDao verifierDao = new VerifierDao();
	String Status = verifierDao.addVerifier(verifierModel);
	if(Status.equalsIgnoreCase("Verifier added Successfully")){
		response.sendRedirect("mMessageSuccess.jsp?Msg="+Status);		
	}else{
			response.sendRedirect("mMessageFailed.jsp?Msg="+Status);
    }
%>