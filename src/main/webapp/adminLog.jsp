<%@ include file="mainHead.jsp" %>
<div class="crwd-admn-log">
<div class="row">
	<div class="col-md-4"></div>
	<div class="col-md-4"><br><br><br>
		<div class="card mt-5 p-3">
			<form action="adminlog1.jsp" method="post">
			<div class="text-center h3">Administrator Login</div>
				<div class="mb-3 mt-3">
					<label for="email">Email</label>
					<input type="email" id="email" name="email" placeholder="Enter Email Address" required class="form-control">
				</div>
				<div class="form-group">
					<label for="password">Password</label>
					<input type="password" id="password" name="password" placeholder="Enter Password" required class="form-control">
				</div>
				<input type="submit" value="Login" class="btn btn-primary btn-block mt-3 " style="width:100%;">
			</form>
		</div>
	</div>
	<div class="col-md-4"></div>
</div>
</div>