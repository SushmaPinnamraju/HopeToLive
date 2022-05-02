<% 
	String role = (String)session.getAttribute("role");
	if(role!=null&& role.equalsIgnoreCase("admin")){%>
		<%@ include file="adminHead.jsp"%>
	<% } else if(role!=null&& role.equalsIgnoreCase("hospital")){%>
		<%@ include file="hospitalHead.jsp" %>
	<% } else if(role!=null&& role.equalsIgnoreCase("seeker")){%>
		<%@ include file="seekerHead.jsp" %>
	<%}else if(role!=null&& role.equalsIgnoreCase("donor")){%>
		<%@ include file="donorHead.jsp" %>
	<%}else if(role!=null&& role.equalsIgnoreCase("verifier")){%>
		<%@ include file="verifierHead.jsp" %>
	<%}else{%>
		<%@ include file="mainHead.jsp" %>
	<%}%>
 <% 
  String Msg=request.getParameter("Msg");
 %>
<div class="text-center text-success h4 mt-5">
	<%=Msg %>
</div>