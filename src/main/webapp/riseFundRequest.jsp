<%@page import="java.util.Iterator"%>
<%@page import="models.HospitalModel"%>
<%@page import="java.util.List"%>
<%@page import="dao.HospitalDao"%>
<%@ include file="seekerHead.jsp" %>
<% 
	HospitalDao hospitalDao = new HospitalDao();
	List<HospitalModel> hospitalList=hospitalDao.getHospitals();
	Iterator<HospitalModel> hospitalIterator= hospitalList.iterator();
%>
<div class="row">
	<div class="col-md-2"></div>
	<div class="col-md-8"><br><br><br>
		<div class="card mt-2 p-3">
			<form action="riseFundRequest1.jsp" method="post" enctype="multipart/form-data">
			<div class="text-center h3">Raise Fund Request</div>
				<div class="mb-3 mt-3">
						<label for="hospitalId">Choose Hospital</label> 
						<select  name="hospitalId" id="hospitalId" required class="form-control">
						<%while(hospitalIterator.hasNext()){
							HospitalModel hospitalModel= hospitalIterator.next();%>
								<option value="<%=hospitalModel.getHospitalId()%>"><%=hospitalModel.getHospitalName()%></option>
						<%}%>						
						</select>
				</div>
				<div class="mb-3 mt-3">
					<label for="cause">Cause</label>
					<input type="text" id="cause" name="cause" placeholder="Enter Cause" required class="form-control">
				</div>
				<div class="mb-3 mt-3">
					<label for="amountRequired">Required Amount</label>
					<input type="text" id="amountRequired" name="amountRequired" placeholder="Enter Required Amount" required class="form-control">
				</div>
				<div class="mb-3 mt-3">
					<label for="reports">Upload Reports</label>
					<input type="file" id="reports" name="reports" placeholder="Choose File" required class="form-control">
				</div>
				<div class="mb-3 mt-3">
					<label for="photo">Upload Photo</label>
					<input type="file" id="photo" name="photo" placeholder="Choose File" required class="form-control">
				</div>
				<div class="mb-3 mt-3">
					<label for="description">Description</label>
					<textarea rows="4" name="description" class="form-control"  placeholder="Enter Description"required ></textarea>
				</div>
					<input type="submit" value="Raise Request" class="btn btn-primary btn-block mt-3 " style="width:100%;">
			</form>
		</div>
	</div>
	<div class="col-md-2"></div>
</div>