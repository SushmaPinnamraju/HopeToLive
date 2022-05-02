<%@page import="models.FundRequestModel"%>
<%@page import="dao.FundRequestDao"%>
<%@page import="models.FundAccountModel"%>
<%@page import="dao.FundAccountDao"%>
<%@page import="models.DonationReceivedModel"%>
<%@page import="dao.DonationReceivedDao"%>
<% 
	String donorId=(String) session.getAttribute("donorId");
	double amount = Double.parseDouble(request.getParameter("amount"));
	String fundRequestId = request.getParameter("fundRequestId");
	String role= (String) session.getAttribute("role");
	FundAccountDao fundAccountDao = new FundAccountDao();
	FundAccountModel fundAccountModel = fundAccountDao.getFundAccount();
	String Status = null;
	DonationReceivedDao donationReceivedDao = new DonationReceivedDao();
	if(role.equalsIgnoreCase("donor")){
		DonationReceivedModel donationReceivedModel = new DonationReceivedModel();
		donationReceivedModel.setAmount(amount);
		donationReceivedModel.setFundRequestId(fundRequestId);
		donationReceivedModel.setSenderId((String) session.getAttribute("donorId"));
		donationReceivedModel.setSender((String) session.getAttribute("role"));
		donationReceivedModel.setReceiverId(fundAccountModel.getFundAccountId());
		donationReceivedModel.setReceiver("Admin");
		donationReceivedModel.setDonationType("For Cause");
		
		
		 Status = donationReceivedDao.donationReceived(donationReceivedModel);
	}
	FundRequestDao fundRequestDao = new FundRequestDao();
	FundRequestModel fundRequestModel = fundRequestDao.getFundRequstedById(fundRequestId); 
	
	DonationReceivedModel donationReceivedModel2 = new DonationReceivedModel();
	donationReceivedModel2.setAmount(amount);
	donationReceivedModel2.setFundRequestId(fundRequestId);
	donationReceivedModel2.setSenderId(fundAccountModel.getFundAccountId());
	donationReceivedModel2.setSender("Admin");
	donationReceivedModel2.setReceiverId(fundRequestModel.getHospitalId());
	donationReceivedModel2.setReceiver("Hospital");
	donationReceivedModel2.setDonationType("For Cause");

	Status = donationReceivedDao.donationReceived(donationReceivedModel2);
	
	if(Status.equalsIgnoreCase("Amount Donated Successfully")){
		response.sendRedirect("mMessageSuccess.jsp?Msg="+Status);		
	}else{
			response.sendRedirect("mMessageFailed.jsp?Msg="+Status);
    }
%>