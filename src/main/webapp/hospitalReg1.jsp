<%@page import="dao.HospitalDao"%>
<%@page import="md5.MD5"%>
<%@page import="models.HospitalModel"%>
<% 
	String locationId = request.getParameter("locationId");
	String hospitalName = request.getParameter("hospitalName");
	String hospitalType = request.getParameter("hospitalType");
	String hospitalCode = request.getParameter("hospitalCode");
	String password = request.getParameter("password");
	String email = request.getParameter("email");
	String phone = request.getParameter("phone");
	String address = request.getParameter("address");
	String accountNumber = request.getParameter("accountNumber");
	
	HospitalModel hospitalModel = new HospitalModel();
	hospitalModel.setLocationId(locationId);
	hospitalModel.setHospitalName(hospitalName);
	hospitalModel.setHospitalType(hospitalType);
	hospitalModel.setHospitalCode(hospitalCode);
	hospitalModel.setPassword(MD5.getMd5(password));
	hospitalModel.setEmail(email);
	hospitalModel.setPhone(phone);
	hospitalModel.setAddress(address);
	hospitalModel.setAccountNumber(Long.parseLong(accountNumber));
	
	HospitalDao hospitalDao = new HospitalDao();
	String Status = hospitalDao.addHospital(hospitalModel);
	if(Status.equalsIgnoreCase("Hospital Registered Successfully")){
		response.sendRedirect("mMessageSuccess.jsp?Msg="+Status);		
	}else{
			response.sendRedirect("mMessageFailed.jsp?Msg="+Status);
    }
	
%>