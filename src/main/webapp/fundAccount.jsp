<%@page import="models.FundAccountModel"%>
<%@page import="dao.FundAccountDao"%>
<%@ include file="adminHead.jsp" %>
<% 
	FundAccountDao fundAccountDao = new FundAccountDao();
	FundAccountModel fundAccountModel = fundAccountDao.getFundAccount();
%>
<div class="crwd-add-acc">
<div class="container">
<div class="row">
	<div class="col-md-4"></div>
	<div class="col-md-4 mt-5">	
	<div class="card p-3">
		<div class="text-center h4 m-5">View FundAccount</div>
		<table class="table table-bordered">
		<thead>
			<tr>
				<th>Fund Account Number</th>
				<th>Account Balance</th>		
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><%=fundAccountModel.getAccountNumber()%></td>
				<td><%=fundAccountModel.getAccountBalance() %></td>
			</tr>
		</tbody>
	</table>
	
	<div class="row">
		<div class="col-md-12">
			<a href="donationSent.jsp" class="btn btn-Primary" style="width:100%;">Transactions</a>
		</div>
		
	</div>
	</div>
	</div>
</div>
</div>
</div>