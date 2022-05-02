<%@page import="dao.FundRequestDao"%>
<% 
	String fundRequestId = request.getParameter("fundRequestId");
	String status = request.getParameter("status");
	String status2 = request.getParameter("status2");
	FundRequestDao fundRequestDao = new FundRequestDao();
	fundRequestDao.setStatus(fundRequestId, status, response, status2);
%>