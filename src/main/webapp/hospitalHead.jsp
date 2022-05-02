<%@page import="dao.FundRequestDao"%>
<%@page import="dao.FundAccountDao"%>
<%@ include file="links.jsp" %>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="hospitalHead.jsp">Hospital Head</a>
  
  <ul class="navbar-nav">
      <li class="nav-item"><a class="nav-link" href="viewRequestStatus.jsp?status=Requested">View FundRequest</a></li>
      <li class="nav-item"><a class="nav-link" href="viewRequestStatus.jsp?status=Rejected">Rejected Requests</a></li>
      <li class="nav-item"><a class="nav-link" href="viewRequestStatus.jsp?status=Processing">Donations</a></li>
      <li class="nav-item"><a class="nav-link" href="donationSent.jsp">View Account Transactions</a></li>
      <li class="nav-item"><a class="nav-link" href="index.jsp">Logout</a></li>
  </ul>
</nav>