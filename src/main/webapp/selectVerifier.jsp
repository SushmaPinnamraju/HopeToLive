<%@page import="java.util.Iterator"%>
<%@page import="models.VerifierModel"%>
<%@page import="java.util.List"%>
<%@page import="dao.FundRequestDao"%>
<%@ include file="adminHead.jsp"%>
<% 
	String fundRequestId = request.getParameter("fundRequestId");
	String status = request.getParameter("status");
	
	FundRequestDao fundRequestDao = new FundRequestDao();
	List<VerifierModel> verifiersList = fundRequestDao.getVerifiers(fundRequestId);
	Iterator<VerifierModel> verifiersIterator = verifiersList.iterator();
%>
<div class="row">
	<div class="col-md-4"></div>
	<div class="col-md-4"><br><br><br>
		<div class="card mt-2 p-3">
			<form action="setStatus2.jsp" method="post">
			<input type="hidden" name="fundRequestId" value="<%=fundRequestId%>">
			<input type="hidden" name="status" value="<%=FundRequestDao.REQUESTED_APPORVED_BY_ADMIN%>">
			<input type="hidden" name="status3" value="Processing">
				<div class="mb-3 mt-3">
						<label for="verifierId">Choose Verifier</label> 
						<select  name="verifierId" id="verifierId" required class="form-control">
						<%while(verifiersIterator.hasNext()){
							VerifierModel verifierModel= verifiersIterator.next();%>
								<option value="<%=verifierModel.getVerifierId()%>"><%=verifierModel.getName()%></option>
						<%}%>						
						</select>
				</div>
					<input type="submit" value="submit" class="btn btn-primary btn-block mt-3 " style="width:100%;">
			</form>
		</div>
	</div>
	<div class="col-md-4"></div>
</div>