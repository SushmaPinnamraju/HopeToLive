<%@ include file="links.jsp" %>
<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
  <a class="navbar-brand" href="index.jsp">Crowd Funding</a>
  <%session.invalidate(); %>
  <ul class="navbar-nav">
      <li class="nav-item"><a class="nav-link" href="adminLog.jsp">Admin</a></li>
      <li class="nav-item"><a class="nav-link" href="hospitalLog.jsp">Hospital</a></li>
      <li class="nav-item"><a class="nav-link" href="verifierLog.jsp">Verifier</a></li>
      <li class="nav-item"><a class="nav-link" href="seekerLog.jsp">Seeker</a></li>
      <li class="nav-item"><a class="nav-link" href="donorLog.jsp">Donor</a></li>
  </ul>
</nav>