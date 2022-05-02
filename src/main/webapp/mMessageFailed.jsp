<% 
	String role = (String)session.getAttribute("role");
	if(role!=null&& role.equalsIgnoreCase("admin")){%>
		<%@ include file="adminHead.jsp"%>
	<% } else if(role!=null&& role.equalsIgnoreCase("hospital")){%>
		<%@ include file="hospitalHead.jsp"%>
	<% }else{%>
		<%@ include file="mainHead.jsp"%>
	<%}%>
 <% 
  String Msg=request.getParameter("Msg");
 %>
<div class="text-center text-danger h4 mt-5">
	<%=Msg %>
</div>