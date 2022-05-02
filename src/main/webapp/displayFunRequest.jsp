<%@page import="models.HospitalModel"%>
<%@page import="dao.HospitalDao"%>
<%@page import="dao.SeekerDao"%>
<%@page import="models.SeekerModel"%>
<%@page import="models.FundRequestModel"%>
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
	String fundRequestId = request.getParameter("fundRequestId");
	FundRequestDao fundRequestDao=new FundRequestDao();
	FundRequestModel fundRequestModel = fundRequestDao.getFundRequstedById(fundRequestId);
%>
<div class="row">
	<div class="col-md-4"></div>
	<div class="col-md-4">
		<div class="card mt-3">
			<div class="card-header text-center h4 text-dark">
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
					<div  class="col-md-6 mt-2">Date</div>
			  		<div  class="col-md-6 mt-2 h6"> <%=fundRequestModel.getDate()%></div>
			  		<div  class="col-md-6 mt-2">Status</div>
			  		<div  class="col-md-6 mt-2 h6"> <%=fundRequestModel.getStatus() %></div>
			  		<div class= "row">
			  		<div class="col-md-6 p-2">
			  		<div class="">
			  			<a href="reports/<%=fundRequestModel.getReports()%> " class="btn btn-primary text-center" >View Reports</a>
			  		</div>
			  		</div>
			  		<div class="col-md-6 p-2">
			  		
			  		</div>
			  	</div>	
			  </div>
			  <div class="card-footer">
			  <div>Description</div>
			  <div><%=fundRequestModel.getDescription()%></div>
			</div>
		</div>
	</div>
	<div class="col-md-4"></div>
</div>