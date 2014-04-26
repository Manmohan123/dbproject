<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<%Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project",
            "manmohan", "manmohan");
    Statement st = con.createStatement();
    ResultSet result= null;
    result= st.executeQuery("select * from imgaes where imageid ='1'");
    
    %>




<!DOCTYPE html>
<html>
<head>
		<link type="text/css" rel="stylesheet" href="stylesheet.css"/>
		<title></title>
		</head>
<body bgcolor ="#E8E8E8">
    
    
	<div id="header">
	<p id="name">Aparrels</p>
<!-- HTML for SEARCH BAR -->
		<form id="tfnewsearch" method="get" action="keysearchpage.jsp">
		        <input type="text" class="tftextinput" name="q" size="21" maxlength="120"><input type="submit" value="search" class="tfbutton">
		</form>
	<div class="tfclear"></div>
	</div>
   
	
<div id="row">
</br>
<%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>
Welcome  <%=session.getAttribute("userid")%> !!
<left><a href='index.jsp'>Log out</a></left>
<%
    }
%>
<marquee> Welcome </marquee>

</div>

		<div class="lefte">
                    </br><h3><a href="about.jsp"> About Us </a></h3> </br>
                    <h3>  </h3> </br>
		</div>
	 <%if(result.next()){};%>
	<a href="women_search.jsp"> <div class="home"> 
                <img src= "<%=result.getString(2)%>" ; height="400px"; width="100%"/>
	</div> </a>
	
	<a href="men_search.jsp"> <div class="home"> 
	<img src= "<%=result.getString(1)%>"; height="400px"; width="100%"/>
	</div> </a>
	
	<div id="footer">
			<p>123 Your Street, Anytown, State 12345-6789 | Tel: (555) 555-5555</p>
	</div>
	</body>
</html>



