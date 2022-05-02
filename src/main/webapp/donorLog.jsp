<%@ include file="mainHead.jsp" %>
<div class="crwd-donor-log">
<div class="row">
	<div class="col-md-4"></div>
	<div class="col-md-4"><br><br><br>
		<div class="card mt-5 p-3">
			<form action="donorlog1.jsp" method="post">
			<div class="text-center h3">Donor Login</div>
				<div class="mb-3 mt-3">
					<label for="email">Email</label>
					<input type="email" id="email" name="email" placeholder="Enter Email Address" required class="form-control">
				</div>
				<div class="form-group">
					<label for="password">Password</label>
					<input type="password" id="password" name="password" placeholder="Enter Password" required class="form-control">
				</div>
				<input type="submit" value="Login" class="btn btn-primary btn-block mt-3 " style="width:100%;">
				<br>
				<div class="text-center"><a href="donorReg.jsp">New Donor? Sign up!</a></div>
			</form>
		</div>
	</div>
	<div class="col-md-4"></div>
</div>
</div>
