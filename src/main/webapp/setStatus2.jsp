<%@page import="dao.FundRequestDao"%>
<% 
	String fundRequestId = request.getParameter("fundRequestId");
	String status = request.getParameter("status");
	String verifierId = request.getParameter("verifierId");
	
	FundRequestDao fundRequestDao = new FundRequestDao();
	String Status = fundRequestDao.setStatus2(fundRequestId, status, verifierId);
	if(Status.equalsIgnoreCase("Assigned SuccessFully")){
		response.sendRedirect("mMessageSuccess.jsp?Msg="+Status);		
	}else{
			response.sendRedirect("mMessageFailed.jsp?Msg="+Status);
    }	
%>