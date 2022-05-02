<head>
  <title>Crowd Funding</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

</head>
<%@ include file="links.jsp" %>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="adminHead.jsp">Admin Head</a>
  
  <ul class="navbar-nav">
      <li class="nav-item"><a class="nav-link" href="addLocation.jsp">Add Location</a></li>
      <li class="nav-item"><a class="nav-link" href="viewLocations.jsp">View Locations</a></li>
      <li class="nav-item"><a class="nav-link" href="viewHospitals.jsp">View Hospitals</a></li>
      <li class="nav-item"><a class="nav-link" href="addVerifier.jsp">Add Verifier</a></li>
      <li class="nav-item"><a class="nav-link" href="viewVerifier.jsp">View Verifiers</a></li>
      <li class="nav-item"><a class="nav-link" href="fundAccount.jsp">Fund Account</a></li>
      <li class="nav-item"><a class="nav-link" href="viewRequestStatus.jsp?status=Requested">View Fund Request</a></li>
      <li class="nav-item"><a class="nav-link" href="viewRequestStatus.jsp?status=Rejected">Rejected Requests</a></li>
      <li class="nav-item"><a class="nav-link" href="viewRequestStatus.jsp?status=Processing">Donations</a></li>
      <li class="nav-item"><a class="nav-link" href="index.jsp">Logout</a></li>
  </ul>
</nav>
