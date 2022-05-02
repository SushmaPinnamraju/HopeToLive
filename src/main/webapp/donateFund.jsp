<%@ include file="donorHead.jsp" %>
<div class="crwd-add-acc1">
<form action="donateAmount11.jsp">
<div class="row">
	
	<div class="col-md-3"></div>
		<div class="col-md-6">
			<div class="card p-3 m-5">
					<div class="text-center h4">Donate Amount</div>
					<div class="mb-3 mt-3">
						<label for="amount" class="form-label">Enter Amount</label>
						<input type="number" name="amount" class="form-control" id="amount" placeholder="Enter amount" required>
					</div>
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

</div>
	</form>
	
</div>	