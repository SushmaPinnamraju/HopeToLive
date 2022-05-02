<%@page import="models.FundRequestModel"%>
<%@page import="dao.FundRequestDao"%>
<%@page import="models.FundAccountModel"%>
<%@page import="dao.FundAccountDao"%>
<%@page import="models.DonationReceivedModel"%>
<%@page import="dao.DonationReceivedDao"%>
<% 
	String donorId=(String) session.getAttribute("donorId");
	double amount = Double.parseDouble(request.getParameter("amount"));
	
	
	FundAccountDao fundAccountDao = new FundAccountDao();
	FundAccountModel fundAccountModel = fundAccountDao.getFundAccount();
	
	DonationReceivedModel donationReceivedModel = new DonationReceivedModel();
	donationReceivedModel.setAmount(amount);
	donationReceivedModel.setSenderId((String) session.getAttribute("donorId"));
	donationReceivedModel.setSender((String) session.getAttribute("role"));
	donationReceivedModel.setReceiverId(fundAccountModel.getFundAccountId());
	donationReceivedModel.setReceiver("Admin");
	donationReceivedModel.setDonationType("Crowd Fund");
	
	DonationReceivedDao donationReceivedDao = new DonationReceivedDao();
	String Status = donationReceivedDao.donationReceived(donationReceivedModel);
		
	if(Status.equalsIgnoreCase("Amount Donated Successfully")){
		response.sendRedirect("mMessageSuccess.jsp?Msg="+Status);		
	}else{
			response.sendRedirect("mMessageFailed.jsp?Msg="+Status);
    }
%>