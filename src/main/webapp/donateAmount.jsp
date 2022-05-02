<%@ include file="donorHead.jsp" %>
<% 
	String donorId=(String)session.getAttribute("donorId");
	double amountRequired = Double.parseDouble(request.getParameter("amountRequired"));
	double amount = Double.parseDouble(request.getParameter("amount"));
	String fundRequestId = request.getParameter("fundRequestId");
	
	if(amount > amountRequired){
		amount = amountRequired;
	}
%>
<div class="row">
	<form action="donateAmount1.jsp">
	<input type="hidden" name="fundRequestId" value="<%=fundRequestId%>">
	<input type="hidden" name="amount" value="<%=amount%>">
	<div class="col-md-4"></div>
		<div class="col-md-6">
			<div class="card p-3 m-5">
					<div class="text-center h4">Donate Amount</div>
					<div class="text-center h4">Total Amount :$ <%=amount %></div>
					<div class="mb-3 mt-3">
						<label for="cardNumber" class="form-label">Card Number</label>
						<input type="number" name="cardNumber" class="form-control" id="cardNumber" placeholder="Enter Card Number" required>
					</div>
					<div class="mb-3 mt-3">
						<label for="cardName" class="form-label">Name on Card</label>
						<input type="text" name="cardName" class="form-control" id="cardName" placeholder="Name On Card" required>
					</div>
					<div class="mb-3 mt-3">
						<label for="cvv" class="form-label">CVV</label>
						<input type="text" name="cvv" class="form-control" id="cvv" placeholder="Enter CVV" required>
					</div>
					<div class="mb-3 mt-3">
						<label for="expiryDate" class="form-label">Expiry Date</label>
						<input type="text" name="expiryDate" class="form-control" id="expiryDate" placeholder="Enter Expiry Date (MM/YY)" required>
					</div>
					<div>
						<input type="Submit" value="Pay Now" class="btn btn-primary" id="pay"  style="width: 100%;">
					</div>		
			</div>
		</div>
	</form>
</div>