<%-- <%@page info="JSP to Db Communication" 
		language="java" 
		contentType="text/html"
		pageEncoding="UTF-8"
		session="false"
		%> <!-- page directive tag -->
		
<%@page isThreadSafe="false" %>
		
<%@page session="false" %> done not create implicit object session
<%@page session="true" %> create implicit object session
<%@page extends="com.ab.servlet.MyTestBase" %> this will extends MyTestBase class
<%@page isELIgnored="false" %> --%>

<%@page import="java.sql.ResultSetMetaData"%>
<%@page import="java.sql.ResultSet", import="java.sql.SQLException"%>
<%@page import="java.util.Random"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@page errorPage="error.jsp" %>

<%!
	Connection con;
	PreparedStatement ps1, ps2;
	
	public void jspInit(){
		try{
			//get access to servlet config object, To read init parameter value
			//ServletConfig cg = getServl
			
			// read JSP init parameters values
			//String url = cg.getInitParameter("url");
			//String dbuser = cg.getInitParameter("dbuser");
			//String password = cg.getInitParameter("password"); 
			
			String driver = "com.mysql.jdbc.Driver";
			String url = "jdbc:mysql://localhost:3306/for_advance_java";
			String dbuser = "root";
			String password = "manager";
			
			// load the driver class
			Class.forName(driver);
			
			//established the connection
			Connection con = DriverManager.getConnection(url,dbuser,password);
			
			// create preapred statement objects taking sql queries as the precompiled sql queries
			ps1 = con.prepareStatement("SELECT  SNO,SNAME,SADD,COURSE FROM jsp_students");
			ps1 = con.prepareStatement("INSERT INTO jsp_students VALUES(?,?,?,?)");
			
		}catch(SQLException se){
			se.printStackTrace();
		}catch(Exception e){
			e.printStackTrace();
		}
	
	}
%>

<%
	//read additional request param values:
	String pVal = request.getParameter("s1");
	
	if (pVal.equalsIgnoreCase("register")) {
		
		// read from data
		String name = request.getParameter("stname");
		String address = request.getParameter("stadders");
		String course = request.getParameter("stcourse");
		
		// set values to precompiled sql query parameters
		ps2.setInt(1, new Random().nextInt());
		ps2.setString(2, name);
		ps2.setString(3, address);
		ps2.setString(4, course);
		
		// execute query
		int count = ps2.executeUpdate();
		
		// process result
		if(count == 0){ %>
			<h2 style="color:red;text-align: center;">Student Registration Failed</h2>
		<% } 
		else{ 
		%> <h2 style="color:red;text-align: center;">Student Registration Sucess</h2><%} 
		
	}// end of fist if
	else{
		// execute the precomiled sql select query
		ResultSet rs = ps1.executeQuery();
		
		// process result Set:
		// create ResultSetMetaData:
			ResultSetMetaData rsmd = rs.getMetaData();
		// get Coloum Count and coloum names:
			int colCount = rsmd.getColumnCount(); %>
			
			<table>
				<tr>
					<% for(int i=1;i<colCount;++i) {%>
						<td><%= rsmd.getColumnLabel(i) %></td>
						<%}%>
				</tr>
				<% // print coloum values by processing result set
					while(rs.next()){%>
					<tr>
						<% for(int i=1;i<=colCount;++i){ %>
							<td><%= rs.getString(i) %></td>
							<%}%>
					</tr>
					<%} rs.close();%>
			</table>
	<%}%>

<br> <a href="sutdent_details.html"></a>

<%!public void jspDestroy() {
		// close jdbc objects
		try {
			if (ps1 != null) {
				ps1.close();
			}
		} catch (SQLException se) {
			se.printStackTrace();
		}
		try {
			if (ps2 != null) {
				ps2.close();
			}
		} catch (SQLException se) {
			se.printStackTrace();
		}
		try {
			if (con != null) {
				con.close();
			}
		} catch (SQLException se) {
			se.printStackTrace();
		}
	}%>