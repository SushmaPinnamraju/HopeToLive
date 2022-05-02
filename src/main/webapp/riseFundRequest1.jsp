<%@page import="dao.FundRequestDao"%>
<%@page import="models.FundRequestModel"%>
<%@page import="models.HospitalModel"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<% 
	String seekerId=(String) session.getAttribute("seekerId");

	String path = application.getRealPath("reports");
	MultipartRequest multi=new MultipartRequest(request,path);
	
	String hospitalId = multi.getParameter("hospitalId");
	String cause = multi.getParameter("cause");
	String description = multi.getParameter("description");
	String reports = multi.getFilesystemName("reports");
	String photo = multi.getFilesystemName("photo");
	String amountRequired = multi.getParameter("amountRequired");
	
	FundRequestModel fundRequestModel = new FundRequestModel();
	fundRequestModel.setHospitalId(hospitalId);
	fundRequestModel.setCause(cause);
	fundRequestModel.setDescription(description);
	fundRequestModel.setReports(reports);
	fundRequestModel.setPhoto(photo);
	fundRequestModel.setSeekerId(seekerId);
	fundRequestModel.setAmountRequired(Double.parseDouble(amountRequired));
	
	
	FundRequestDao fundRequestDao = new FundRequestDao();
	String Status = fundRequestDao.fundRequest(fundRequestModel);
	if(Status.equalsIgnoreCase("Fund Requested Successfully")){
		response.sendRedirect("mMessageSuccess.jsp?Msg="+Status);		
	}else{
			response.sendRedirect("mMessageFailed.jsp?Msg="+Status);
    }

%>