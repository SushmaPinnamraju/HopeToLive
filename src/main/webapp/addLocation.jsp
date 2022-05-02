<%@ include file="adminHead.jsp" %>
<div class="crwd-add-location">
<div class="row">
	<div class="col-md-4"></div>
	<div class="col-md-4"><br><br><br>
		<div class="card mt-5 p-3">
			<form action="addLocation1.jsp" method="post">
			<div class="text-center h3">Add Location</div>
				<div class="mb-3 mt-3">
					<label for="locationName">Location name</label>
					<input type="text" id="locationName" name="locationName" placeholder="Enter Location Name" required class="form-control">
				</div>
				<input type="submit" value="submit" class="btn btn-primary btn-block mt-3 " style="width:100%;">
			</form>
		</div>
	</div>
	<div class="col-md-4"></div>
</div>
</div>