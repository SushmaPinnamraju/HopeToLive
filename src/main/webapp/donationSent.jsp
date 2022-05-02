<%@page import="java.util.Iterator"%>
<%@page import="models.DonationReceivedModel"%>
<%@page import="java.util.List"%>
<%@page import="dao.DonationReceivedDao"%>
<%@page import="models.FundAccountModel"%>
<% 
	String role = (String)session.getAttribute("role");
	String id=null;
	if(role!=null&& role.equalsIgnoreCase("admin")){
		FundAccountDao fundAccountDao = new FundAccountDao();
		FundAccountModel fundAccountModel = fundAccountDao.getFundAccount();
		id = fundAccountModel.getFundAccountId();
		
	%>
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
	<%}%>
 <%
 System.out.println(role);
 System.out.println(id);
 DonationReceivedDao donationReceivedDao=new DonationReceivedDao();
 List<DonationReceivedModel> donationReceivedModelList = donationReceivedDao.getTransactions(role, id);
 Iterator<DonationReceivedModel> iterator= donationReceivedModelList.iterator();%>
 <div class="container-fluid">
 <div class="text-center h5 m-3">Transactions</div>
 <table class="table table-bordered">
 	<tr>
 		<th>Sender Name</th>
 		<th>Sender Role</th>
 		<th>Receiver Name</th>
 		<th>Receiver Role</th>
 		<th>Donation Type</th>
 		<th>Fund Request</th>
 		<th>Date</th>
 		<th>Amount</th>
 	</tr>
 
 <%while(iterator.hasNext()){
	 DonationReceivedModel donationReceivedModel=iterator.next()	;
	 	String sender = donationReceivedDao.getPersonDetais(donationReceivedModel.getSenderId(), donationReceivedModel.getSender());
	 	String receiver = donationReceivedDao.getPersonDetais(donationReceivedModel.getReceiverId(), donationReceivedModel.getReceiver());
	 %>
	 
	  	<tr>
 		<td><%=sender%></td>
 		<td><%=donationReceivedModel.getSender()%></td>
 		<td><%=receiver%></td>
 		<td><%=donationReceivedModel.getReceiver()%></td>
 		<td><%=donationReceivedModel.getDonationType()%></td>
 		<td>
 		<% if(donationReceivedModel.getFundRequestId()!=null) {%>
 			<a href="displayFunRequest.jsp?fundRequestId=<%=donationReceivedModel.getFundRequestId()%>"><%=donationReceivedModel.getFundRequestId()%></a>
 		<%}%>
 		</td>
 		<td><%=donationReceivedModel.getDate()%></td>
 		<td><%=donationReceivedModel.getAmount()%></td>
 	</tr>
	 
 <% }
 %>
</table>
</div>