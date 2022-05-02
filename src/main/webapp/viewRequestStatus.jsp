<%@page import="dao.DonationReceivedDao"%>
<%@page import="models.LocationModel"%>
<%@page import="dao.LocationDao"%>
<%@page import="dao.HospitalDao"%>
<%@page import="models.HospitalModel"%>
<%@page import="dao.SeekerDao"%>
<%@page import="models.SeekerModel"%>
<%@page import="java.util.Iterator"%>
<%@page import="models.FundRequestModel"%>
<%@page import="java.util.List"%>
<%@page import="dao.FundRequestDao"%>
<% 
	String role = (String)session.getAttribute("role");
	String status = request.getParameter("status");
	String id=null;
	if(role!=null&& role.equalsIgnoreCase("admin")){%>
		<%@ include file="adminHead.jsp"%>
	<% } else if(role!=null&& role.equalsIgnoreCase("hospital")){
		id=(String) session.getAttribute("hospitalId");
	%>
		<%@ include file="hospitalHead.jsp" %>
	<% } else if(role!=null&& role.equalsIgnoreCase("seeker")){
		id=(String) session.getAttribute("seekerId");
	%>
		<%@ include file="seekerHead.jsp" %>
	<%}else if(role!=null&& role.equalsIgnoreCase("donor")){
		id=(String) session.getAttribute("donorId");
	%>
		<%@ include file="donorHead.jsp" %>
	<%}else if(role!=null&& role.equalsIgnoreCase("verifier")){
		id=(String) session.getAttribute("verifierId");
	%>
		<%@ include file="verifierHead.jsp" %>
	<%}else{%>
		<%@ include file="mainHead.jsp" %>
	<%}%>
<% 
	
	
	SeekerDao seekerDao = new SeekerDao();
	HospitalDao hospitalDao = new HospitalDao();
	DonationReceivedDao donationReceivedDao=new DonationReceivedDao();
	FundRequestDao fundRequestDao = new FundRequestDao();
	List<FundRequestModel> fundRequestList = fundRequestDao.viewFundRequest(id,role,status);
	Iterator<FundRequestModel> fundRequestIterator= fundRequestList.iterator();
%>
<div class="container">
	<div class="text-center h4 mt-3 text-primary">View Request Status</div>
	<div class="row">
	<% while(fundRequestIterator.hasNext()){
		FundRequestModel fundRequestModel=fundRequestIterator.next();
		double donationReceivedAmount = donationReceivedDao.getDonationAmount(fundRequestModel.getFundRequestId());
		%>
		<div class="col-md-4">
		<div class="card m-2">
			  <div class="card-header text-center h4 text-dark 
			  <%if(fundRequestModel.getStatus().equalsIgnoreCase(FundRequestDao.REQUESTED_CANCELLED_BY_SEEKER) 
					  || fundRequestModel.getStatus().equalsIgnoreCase(FundRequestDao.REQUESTED_REJECTED_BY_HOSPITAL)
					  || fundRequestModel.getStatus().equalsIgnoreCase(FundRequestDao.REQUESTED_REJECTED_BY_ADMIN)
					  || fundRequestModel.getStatus().equalsIgnoreCase(FundRequestDao.REQUESTED_REJECTED_BY_VERIFIER)
					  || fundRequestModel.getStatus().equalsIgnoreCase(FundRequestDao.REQUESTED_CANCELLED_BY_HOSPITAL)
					  || fundRequestModel.getStatus().equalsIgnoreCase(FundRequestDao.REQUESTED_CANCELLED_BY_ADMIN)){
				  out.println("bg-danger text-white");} 
				  
				 %>">
			  <%
			  	SeekerModel seekerModel = seekerDao.getSeekerById(fundRequestModel.getSeekerId());
			  	out.println(seekerModel.getName());
			  %>
			  </div>
			  <div class="card-body">
				<img src="reports/<%=fundRequestModel.getPhoto()%>" style="height:200px;">
			  	<div class="row">
			  		<div  class="col-md-6 mt-2">Hospital Name</div>
			  		<div  class="col-md-6 mt-2">
			  		<% 
		  			HospitalModel hospitalModel = hospitalDao.getHospitalById(fundRequestModel.getHospitalId()); 
		  			out.println(hospitalModel.getHospitalName()); 
		            %>
		            </div>
			  		<div  class="col-md-6 mt-2">Cause</div>
			  		<div  class="col-md-6 mt-2 h6"> <%=fundRequestModel.getCause() %></div>
			  		<div  class="col-md-6 mt-2">Amount Required</div>
			  		<div  class="col-md-6 mt-2 h6"> <%=fundRequestModel.getAmountRequired()%></div>
			  		<% if(donationReceivedAmount>0){%>
			  			<div  class="col-md-6 mt-2">Donation Received</div>
				  		<div  class="col-md-6 mt-2 h6"> <%=donationReceivedAmount%></div>
			  		<% } %>
					<div  class="col-md-6 mt-2">Date</div>
			  		<div  class="col-md-6 mt-2 h6" style="font-size: 70%"> <%=fundRequestModel.getDate()%></div>
			  		<div  class="col-md-6 mt-2">Status</div>
			  		<div  class="col-md-6 mt-2 h6" style="font-size: 70%"> <%=fundRequestModel.getStatus() %></div>

			  		<div class= "row">
			  		<div class="col-md-6 p-2">
			  		<div class="">
			  			<a href="reports/<%=fundRequestModel.getReports()%> " class="btn btn-primary text-center" >View Reports</a>
			  		</div>
			  		</div>
			  		<div class="col-md-6 p-2">
			  		<div>
			  		
			  		<%
			  		if(role.equalsIgnoreCase("seeker")){
			  			if(fundRequestModel.getStatus().equalsIgnoreCase(FundRequestDao.REQUESTED)){%>
			  				<form action="setStatus.jsp" method="post">
			  				<input type="hidden" name="fundRequestId" value="<%=fundRequestModel.getFundRequestId() %>">
			  				<input type="hidden" name="status" value="<%=FundRequestDao.REQUESTED_CANCELLED_BY_SEEKER %>">
			  				<input type="hidden" name="status2" value="Rejected">
			  				<input type="submit" value="Cancel Request" class="btn btn-danger">
			  				</form>
			  		   <% }
			  		}else if(role.equalsIgnoreCase("hospital")){
			  			if(status.equalsIgnoreCase("Requested")){%>
		  				<div class="row">
		  					<div class="col-md-6">
		  						<form action="setStatus.jsp" method="post">
			  						<input type="hidden" name="fundRequestId" value="<%=fundRequestModel.getFundRequestId() %>">
				  					<input type="hidden" name="status" value="<%=FundRequestDao.REQUESTED_APPORVED_BY_HOSPITAL%>">
				  					<input type="hidden" name="status2" value="Processing">
				  					<input type="submit" value="Accept" class="btn btn-success">
				  				</form>
		  					</div>
		  					<div class="col-md-6">
		  						<form action="setStatus.jsp" method="post">
			  						<input type="hidden" name="fundRequestId" value="<%=fundRequestModel.getFundRequestId() %>">
				  					<input type="hidden" name="status" value="<%=FundRequestDao.REQUESTED_REJECTED_BY_HOSPITAL%>">
				  					<input type="hidden" name="status2" value="Rejected">
				  					<input type="submit" value="Reject" class="btn btn-danger">
				  				</form>
		  					</div>
		  				</div>
		  		   <% }else if(fundRequestModel.getStatus().equalsIgnoreCase(FundRequestDao.REQUESTED_APPORVED_BY_VERIFIER)) {%>
<%-- 						<a href="viewDonations.jsp?fundRequestId=<%=fundRequestModel.getFundRequestId() %>" class="btn btn-primary w-100">View Donations</a> --%>
		  		   	<%}else if(status.equalsIgnoreCase("Processing")) {%>
						<form action="setStatus.jsp" method="post">
	  						<input type="hidden" name="fundRequestId" value="<%=fundRequestModel.getFundRequestId() %>">
		  					<input type="hidden" name="status" value="<%=FundRequestDao.REQUESTED_CANCELLED_BY_HOSPITAL%>">
		  					<input type="hidden" name="status2" value="Rejected">
		  					<input type="submit" value="Cancel Request" class="btn btn-danger w-100">
		  				</form>
		  		   	<%}
			  		}else if(role.equalsIgnoreCase("admin")){
			  			if(status.equalsIgnoreCase("Requested")){%>
		  				<div class="row">
		  					<div class="col-md-6">
		  						<form action="selectVerifier.jsp" method="post">
			  						<input type="hidden" name="fundRequestId" value="<%=fundRequestModel.getFundRequestId() %>">
				  					<input type="hidden" name="status" value="<%=FundRequestDao.REQUESTED_APPORVED_BY_ADMIN%>">
				  					<input type="hidden" name="status2" value="Processing">
				  					<input type="submit" value="Accept" class="btn btn-success">
				  				</form>
		  					</div>
		  					<div class="col-md-6">
		  						<form action="setStatus.jsp" method="post">
			  						<input type="hidden" name="fundRequestId" value="<%=fundRequestModel.getFundRequestId() %>">
				  					<input type="hidden" name="status" value="<%=FundRequestDao.REQUESTED_REJECTED_BY_ADMIN%>">
				  					<input type="hidden" name="status2" value="Rejected">
				  					<input type="submit" value="Reject" class="btn btn-danger">
				  				</form>
		  					</div>
		  				</div>
		  		   <% }else if(fundRequestModel.getStatus().equalsIgnoreCase(FundRequestDao.REQUESTED_APPORVED_BY_VERIFIER) && fundRequestModel.getAmountRequired()>0) {%>
		  		   	
						<form action="donateAmount1.jsp" method="post">
	  						<input type="hidden" name="fundRequestId" value="<%=fundRequestModel.getFundRequestId() %>">
	  						<input type="hidden" name="amountRequired" value="<%=fundRequestModel.getAmountRequired() %>">
	  						<div class="row">
	  							<div class="col-md-6">
	  								<div>
				  						<input type="number" name="amount" id="amount" placeholder="Amt" class="form-control" required> 
				  					</div>
	  							</div>
	  							<div class="col-md-6">
	  								<input type="submit" value="Donate" class="btn btn-success">
	  							</div>
	  						</div>
		  				</form>
		  		   	<%}else if(fundRequestModel.getStatus().equalsIgnoreCase(FundRequestDao.REQUESTED_APPORVED_BY_VERIFIER)) {%>
<%-- 						<a href="viewDonations.jsp?fundRequestId=<%=fundRequestModel.getFundRequestId() %>" class="btn btn-primary w-100">View Donations</a> --%>
		  		   	<%}else if(status.equalsIgnoreCase("Processing")) {%>
						<form action="setStatus.jsp" method="post">
						<input type="hidden" name="fundRequestId" value="<%=fundRequestModel.getFundRequestId() %>">
	  					<input type="hidden" name="status" value="<%=FundRequestDao.REQUESTED_CANCELLED_BY_ADMIN%>">
	  					<input type="hidden" name="status2" value="Rejected">
	  					<input type="submit" value="Cancel Request" class="btn btn-danger w-100">
						</form>
			   		<%}
			  		}else if(role.equalsIgnoreCase("donor")){%>
			  			<form action="donateAmount.jsp" method="post">
	  						<input type="hidden" name="fundRequestId" value="<%=fundRequestModel.getFundRequestId() %>">
	  						<input type="hidden" name="amountRequired" value="<%=fundRequestModel.getAmountRequired() %>">
	  						<div class="row">
	  							<div class="col-md-6">
	  								<div>
				  						<input type="number" name="amount" id="amount" placeholder="Amt" class="form-control" required> 
				  					</div>
	  							</div>
	  							<div class="col-md-6">
	  								<input type="submit" value="Donate" class="btn btn-success">
	  							</div>
	  						</div>
		  				</form>
			  		<% }else if(role.equalsIgnoreCase("verifier")){
						if(status.equalsIgnoreCase("Requested")){%>
		  				<div class="row">
		  					<div class="col-md-6">
		  						<form action="setStatus.jsp" method="post">
			  						<input type="hidden" name="fundRequestId" value="<%=fundRequestModel.getFundRequestId() %>">
				  					<input type="hidden" name="status" value="<%=FundRequestDao.REQUESTED_APPORVED_BY_VERIFIER%>">
				  					<input type="hidden" name="status2" value="Processing">
				  					<input type="submit" value="Accept" class="btn btn-success">
				  				</form>
		  					</div>
		  					<div class="col-md-6">
		  						<form action="setStatus.jsp" method="post">
			  						<input type="hidden" name="fundRequestId" value="<%=fundRequestModel.getFundRequestId() %>">
				  					<input type="hidden" name="status" value="<%=FundRequestDao.REQUESTED_REJECTED_BY_VERIFIER%>">
				  					<input type="hidden" name="status2" value="Rejected">
				  					<input type="submit" value="Reject" class="btn btn-danger">
				  				</form>
		  					</div>
		  				</div>
		  		   <% }}%>

			  		</div>
			  		</div>
			  	</div>	
			  </div>
			  <div class="card-footer">
			  <div>Description</div>
			  <div><%=fundRequestModel.getDescription()%></div>
			</div>
			</div>
		</div>
		</div>
	<% }%>
	</div>	
</div>	