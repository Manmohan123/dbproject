
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
 
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<!DOCTYPE html>
<html>
<head>
		<link type="text/css" rel="stylesheet" href="stylesheet.css"/>
		<title></title>
</head>
<body bgcolor ="#E8E8E8">
    
    <%
Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project",
            "manmohan", "manmohan");
    Statement st = con.createStatement();
    
     
    
    
    
   
    %>  
    

	<div id="header">
<a href="#" class="button" align="left">Home</a>	

<!-- HTML for SEARCH BAR -->
<form id="tfnewsearch" method="post" action="keysearchpage.jsp">
	        <input type="text" class="tftextinput" name="q" id ="q" size="21" maxlength="120"><input type="submit" value="search" class="tfbutton">
		</form>
		
		<div class="tfclear"></div>

	</div>
	
<div id="row">
<center>
    <form method="get" action="select.jsp">
       <button type="submit">MEN</button> &nbsp;
       
   </form>
    <form method="get" action="select.jsp">
       <button type="submit">WOMEN</button> &nbsp;
   </form>
</center>
</div>

		<div class="left">
                    <form >
			<h4> Size </h4>
                        
                        <% if(session.getAttribute("count1")!=null){%><label for="male">(<%=session.getAttribute("count1")%>) </label><%} 
                        else {%> <label for="male">(580)</label> <%}%>
                         
			<input type="checkbox" name="Size" value="XS">XS</br>
                        
                        <% if(session.getAttribute("count2")!=null){%><label for="male">(<%=session.getAttribute("count2")%>) </label><%} 
                        else {%> <label for="male">(580)</label> <%}%>
                        
                        <input type="checkbox" name="Size" value="S">S<%{};%> </br> 
                        
                         <% if(session.getAttribute("count3")!=null){%><label for="male">(<%=session.getAttribute("count3")%>) </label><%} 
                        else {%> <label for="male">(580)</label> <%}%>
                       
			<input type="checkbox" name="Size" value="M">M</br>
                        
                         <% if(session.getAttribute("count4")!=null){%><label for="male">(<%=session.getAttribute("count4")%>) </label><%} 
                        else {%> <label for="male">(580)</label> <%}%>
                        <input type="checkbox" name="Size" value="L">L</br> 
                        
                         <% if(session.getAttribute("count5")!=null){%><label for="male">(<%=session.getAttribute("count5")%>) </label><%} 
                        else {%> <label for="male">(580)</label> <%}%>
			<input type="checkbox" name="Size" value="XL">XL</br>
			
			<h4> Price </h4>
                        
                         <% if(session.getAttribute("count6")!=null){%><label for="male">(<%=session.getAttribute("count6")%>) </label><%} 
                        else {%> <label for="male">(580)</label> <%}%>
                        
                       <input type="checkbox" name="Price" value="40">below 40$</br>
                       
                        <% if(session.getAttribute("count7")!=null){%><label for="male">(<%=session.getAttribute("count7")%>) </label><%} 
                        else {%> <label for="male">(580)</label> <%}%>
                       <input type="checkbox" name="Price" value="79">40$-80$ </br>
                       
                        <% if(session.getAttribute("count8")!=null){%><label for="male">(<%=session.getAttribute("count8")%>) </label><%} 
                        else {%> <label for="male">(580)</label> <%}%>
                       <input type="checkbox" name="Price" value="80">80$ Above</br>
                       
                       <br> <INPUT TYPE=submit name=submit Value="Submit">

			
			
		</form>
		</div>
	
		<div class="right">
			<h4>Results</h4>
                <%! String[] Prices; %>
<%! String[] Sizes; %>
                <%!String[] sesssize ;%>
         
      <% 
             
  Prices = request.getParameterValues("Price");
  Sizes=   request.getParameterValues("Size");
  int k = 40;
  int l = 80;
  int m = 80; 
  String v="XS";
  String w="S";
  String x="M";
  String y="L";
  String z="XL";
   
  
  sesssize =   request.getParameterValues("Size");
  
  if((Sizes != null)||(Sizes != null)){
for(int i=0;i<Sizes.length;i++){
        
        session.setAttribute(sesssize[i], Sizes[i]);
        }
  }
    
  
    if(Sizes != null){
          v="";
           w=""; 
          x="";
           y="";
           z="";
         
        for(int i=0;i<Sizes.length; i++){
        if(Sizes[i].equals("XS")){v="XS";}
        if(Sizes[i].equals("S")){w="S";}
        if(Sizes[i].equals("M")){x="M";}
        if(Sizes[i].equals("L")){y="L";}
        if(Sizes[i].equals("XL")){z="XL";}
            }
        }

 if(Prices != null){
            k=0;
         l=0;
         m=0;
        for(int i=0;i<Prices.length; i++){
        if(Prices[i].equals("40")){k=40;}
        if(Prices[i].equals("79")){l=80;}
        if(Prices[i].equals("80")){m=80;}
            }
        }
 
 
    ResultSet result;   

    CallableStatement cstmt = null;

   String SQL = "{call Item_search_Men  (?,?,?,?,?,?,?,?)}";
   cstmt = con.prepareCall (SQL);
   
   
   
   cstmt.setString(1,v); 
   cstmt.setString(2,w);
   cstmt.setString(3,x);
   cstmt.setString(4,y); 
   cstmt.setString(5,z);
   cstmt.setInt(6,k);
   cstmt.setInt(7,l);
   cstmt.setInt(8,m);
   result = cstmt.executeQuery();
   
    
     ResultSet result1=null;  
     CallableStatement cstmt1 = null;   
     String SQL1 = "{call size_count_men  ('XS',?,?,?)}";
     cstmt1 = con.prepareCall (SQL1);
    
     cstmt1.setInt(1,k);
   cstmt1.setInt(2,l);
   cstmt1.setInt(3,m);
   result1 = cstmt1.executeQuery();
   
    ResultSet result2=null;  
     CallableStatement cstmt2 = null;   
     String SQL2 = "{call size_count_men  ('S',?,?,?)}";
     cstmt2 = con.prepareCall (SQL2);
    
   cstmt2.setInt(1,k);
   cstmt2.setInt(2,l);
   cstmt2.setInt(3,m);
   result2 = cstmt2.executeQuery();
   
    ResultSet result3=null;  
     CallableStatement cstmt3 = null;   
     String SQL3 = "{call size_count_men  ('M',?,?,?)}";
     cstmt3 = con.prepareCall (SQL3);
    
     cstmt3.setInt(1,k);
   cstmt3.setInt(2,l);
   cstmt3.setInt(3,m);
   result3 = cstmt3.executeQuery();
   
    ResultSet result4=null;  
     CallableStatement cstmt4 = null;   
     String SQL4 = "{call size_count_men  ('L',?,?,?)}";
     cstmt4 = con.prepareCall (SQL4);
    
     cstmt4.setInt(1,k);
   cstmt4.setInt(2,l);
   cstmt4.setInt(3,m);
   result4 = cstmt4.executeQuery();
   
    ResultSet result5=null;  
     CallableStatement cstmt5 = null;   
     String SQL5 = "{call size_count_men  ('XL',?,?,?)}";
     cstmt5 = con.prepareCall (SQL5);
    
     cstmt5.setInt(1,k);
   cstmt5.setInt(2,l);
   cstmt5.setInt(3,m);
   result5 = cstmt5.executeQuery();
   
   ResultSet result6=null;  
     CallableStatement cstmt6 = null;   
     String SQL6 = "{call pricerange_count_men  (?,?,?,?,?,'40')}";
     cstmt6 = con.prepareCall (SQL6);
    
     cstmt6.setString(1,v);
   cstmt6.setString(2,w);
   cstmt6.setString(3,x);
    cstmt6.setString(4,y);
   cstmt6.setString(5,z);
   result6 = cstmt6.executeQuery();
   
   ResultSet result7=null;  
     CallableStatement cstmt7 = null;   
     String SQL7 = "{call pricerange_count_men  (?,?,?,?,?,'79')}";
     cstmt7 = con.prepareCall (SQL7);
    
    cstmt7.setString(1,v);
   cstmt7.setString(2,w);
   cstmt7.setString(3,x);
   cstmt7.setString(4,y);
    cstmt7.setString(5,z);
   result7 = cstmt7.executeQuery();
   
   ResultSet result8=null;  
     CallableStatement cstmt8 = null;   
     String SQL8 = "{call pricerange_count_men  (?,?,?,?,?,'80')}";
     cstmt8 = con.prepareCall (SQL8);
    
    cstmt8.setString(1,v);
   cstmt8.setString(2,w);
   cstmt8.setString(3,x);
    cstmt8.setString(4,y);
   cstmt8.setString(5,z);
   result8 = cstmt8.executeQuery();
   
   if(result1.next()){};
   session.setAttribute("count1",result1.getString(1));
   if(result2.next()){};
   session.setAttribute("count2",result2.getString(1));
   if(result3.next()){};
   session.setAttribute("count3",result3.getString(1));
   if(result4.next()){};
   session.setAttribute("count4",result4.getString(1));
   if(result5.next()){};
   session.setAttribute("count5",result5.getString(1));
    if(result6.next()){};
   session.setAttribute("count6",result6.getString(1));
   if(result7.next()){};
   session.setAttribute("count7",result7.getString(1));
   if(result8.next()){};
   session.setAttribute("count8",result8.getString(1));
%> 

                     
 <table border="1" width="100%">
<tr>
   <th> description </th>
   <th>price</th>
   <th>size</th>
   
   <%
while(result.next()){
%>
<tr><td><%=result.getString(2)%></td>
<td><%=result.getString(6)%></td>
<td><%=result.getString(8)%></td>
</tr>
<%
}
%>
</table>
        

	</body>
</html>
