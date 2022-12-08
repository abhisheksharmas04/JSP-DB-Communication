<%@page isErrorPage="true"%>

<b><i>Internal Problem try-again</i></b>
<a href="student_db.jsp">Home</a>

<hr/>

<%=exception.getMessage()%>