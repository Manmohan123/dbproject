
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
<a href="success.jsp" class="button" align="left">Home</a>	

<!-- HTML for SEARCH BAR -->
                <form id="tfnewsearch" method="post" action="keysearchpage.jsp">
	           <input type="text" class="tftextinput" name="q" id ="q" size="21" maxlength="120"><input type="submit" value="search" class="tfbutton">
		</form>
		
	<div class="tfclear"></div>

</div>
	
    <div id="row">    
       <form method="get" action="women_search.jsp">
         <button class="button" align="right" type="submit">WOMEN</button> &nbsp;
         </form>
        
                                        <%
    if ((session.getAttribute("userid") == null) || (session.getAttribute("userid") == "")) {
%>
You are not logged in<br/>
<a href="index.jsp">Please Login</a>
<%} else {
%>   
 
<ritht> <%=session.getAttribute("userid")%> <a href='index.jsp'>Log out</a></right> 
<%
    }
%>

      
</div>

		<div class="left">
                    <form >
                        <h4> Category </h4>
                       
                        <input type="checkbox" name="Category" value="Men1">Shirts</br>
                        <input type="checkbox" name="Category" value="Men2">Sweatshirts</br>
                        <input type="checkbox" name="Category" value="Men3">Sweaters</br>
                        <input type="checkbox" name="Category" value="Men4">Suits</br>
                        <input type="checkbox" name="Category" value="Men5">Jeans</br>
                        <input type="checkbox" name="Category" value="Men6">Pants</br>
                        <input type="checkbox" name="Category" value="Men7">Shorts</br>
                        <input type="checkbox" name="Category" value="Men8">Jackets</br>
                        
			<h4> Size </h4>
                         
			<input type="checkbox" name="Size" value="XS">XS</br>
                        <input type="checkbox" name="Size" value="S">S<%{};%> </br> 
			<input type="checkbox" name="Size" value="M">M</br>
                        <input type="checkbox" name="Size" value="L">L</br> 
			<input type="checkbox" name="Size" value="XL">XL</br>
			
			<h4> Price </h4>
                        
                       <input type="checkbox" name="Price" value="40">below 40$</br>
                       <input type="checkbox" name="Price" value="79">40$-80$ </br>
                       <input type="checkbox" name="Price" value="80">80$ Above</br>
                       <br> <INPUT TYPE=submit name=submit Value="Submit">
	
		</form>
		</div>
 
	
<div class="right">
	<h4>Results</h4>
                <%! String[] Prices; %>
                 <%! String[] Sizes; %>
                <%!String[] sesssize ;%>
                <%!String[] Categories ;%>
         
      <% 
             
  Prices = request.getParameterValues("Price");
  Sizes=   request.getParameterValues("Size");
  Categories =request.getParameterValues("Category");
  
  int k = 40;
  int l = 80;
  int m = 80; 
  String n="Men1";
  String o="Men2";
  String p="Men3";
  String q="Men4";
  String r="Men5";
  String s="Men6";
  String t="Men7";
  String u="Men8";
  
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
 
 if(Categories != null){
            n="";
          o="";
             p="";
         q= "";
         r="";
         s="";
         t="";
         u="";
         
        for(int i=0;i<Categories.length; i++){
        if(Categories[i].equals("Men1")){n="Men1";}
        if(Categories[i].equals("Men2")){o="Men2";}
        if(Categories[i].equals("Men3")){p="Men3";}
        if(Categories[i].equals("Men4")){q="Men4";}
        if(Categories[i].equals("Men5")){r="Men5";}
        if(Categories[i].equals("Men6")){s="Men6";}
        if(Categories[i].equals("Men7")){t="Men7";}
        if(Categories[i].equals("Men8"))u="Men8";
            }
        }
 
 
    ResultSet result;   

    CallableStatement cstmt = null;

   String SQL = "{call Mens_Items_search   (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
   cstmt = con.prepareCall (SQL);
   
   
   
   cstmt.setString(1,v); 
   cstmt.setString(2,w);
   cstmt.setString(3,x);
   cstmt.setString(4,y); 
   cstmt.setString(5,z);
   cstmt.setInt(6,k);
   cstmt.setInt(7,l);
   cstmt.setInt(8,m);
   cstmt.setString(9,n);
   cstmt.setString(10,o); 
   cstmt.setString(11,p);
   cstmt.setString(12,q);
   cstmt.setString(13,r);
   cstmt.setString(14,s);
   cstmt.setString(15,t); 
   cstmt.setString(16,u);
   
   result = cstmt.executeQuery();
   
    
     ResultSet result1=null;  
     CallableStatement cstmt1 = null;   
     String SQL1 = "{call sizes_counts_mens   ('XS',?,?,?,?,?,?,?,?,?,?,?)}";
     cstmt1 = con.prepareCall (SQL1);
    
     cstmt1.setInt(1,k);
   cstmt1.setInt(2,l);
   cstmt1.setInt(3,m);
   cstmt1.setString(4,n);
   cstmt1.setString(5,o); 
   cstmt1.setString(6,p);
   cstmt1.setString(7,q);
   cstmt1.setString(8,r);
   cstmt1.setString(9,s);
   cstmt1.setString(10,t); 
   cstmt1.setString(11,u);
   
   result1 = cstmt1.executeQuery();
   
    ResultSet result2=null;  
     CallableStatement cstmt2 = null;   
     String SQL2 = "{call sizes_counts_mens   ('S',?,?,?,?,?,?,?,?,?,?,?)}";
     cstmt2 = con.prepareCall (SQL2);
    
   cstmt2.setInt(1,k);
   cstmt2.setInt(2,l);
   cstmt2.setInt(3,m);
    cstmt2.setString(4,n);
   cstmt2.setString(5,o); 
   cstmt2.setString(6,p);
   cstmt2.setString(7,q);
   cstmt2.setString(8,r);
   cstmt2.setString(9,s);
   cstmt2.setString(10,t); 
   cstmt2.setString(11,u);
   result2 = cstmt2.executeQuery();
   
    ResultSet result3=null;  
     CallableStatement cstmt3 = null;   
     String SQL3 = "{call sizes_counts_mens   ('M',?,?,?,?,?,?,?,?,?,?,?)}";
     cstmt3 = con.prepareCall (SQL3);
    
     cstmt3.setInt(1,k);
   cstmt3.setInt(2,l);
   cstmt3.setInt(3,m);
    cstmt3.setString(4,n);
   cstmt3.setString(5,o); 
   cstmt3.setString(6,p);
   cstmt3.setString(7,q);
   cstmt3.setString(8,r);
   cstmt3.setString(9,s);
   cstmt3.setString(10,t); 
   cstmt3.setString(11,u);
   result3 = cstmt3.executeQuery();
   
    ResultSet result4=null;  
     CallableStatement cstmt4 = null;   
     String SQL4 = "{call sizes_counts_mens   ('L',?,?,?,?,?,?,?,?,?,?,?)}";
     cstmt4 = con.prepareCall (SQL4);
    
     cstmt4.setInt(1,k);
   cstmt4.setInt(2,l);
   cstmt4.setInt(3,m);
   cstmt4.setString(4,n);
   cstmt4.setString(5,o); 
   cstmt4.setString(6,p);
   cstmt4.setString(7,q);
   cstmt4.setString(8,r);
   cstmt4.setString(9,s);
   cstmt4.setString(10,t); 
   cstmt4.setString(11,u);
   
   result4 = cstmt4.executeQuery();
   
    ResultSet result5=null;  
     CallableStatement cstmt5 = null;   
     String SQL5 = "{call sizes_counts_mens   ('XL',?,?,?,?,?,?,?,?,?,?,?)}";
     cstmt5 = con.prepareCall (SQL5);
    
     cstmt5.setInt(1,k);
   cstmt5.setInt(2,l);
   cstmt5.setInt(3,m);
   cstmt5.setString(4,n);
   cstmt5.setString(5,o); 
   cstmt5.setString(6,p);
   cstmt5.setString(7,q);
   cstmt5.setString(8,r);
   cstmt5.setString(9,s);
   cstmt5.setString(10,t); 
   cstmt5.setString(11,u);
   result5 = cstmt5.executeQuery();
   
   ResultSet result6=null;  
     CallableStatement cstmt6 = null;   
     String SQL6 = "{call price_ranges_counts_men  (?,?,?,?,?,'40',?,?,?,?,?,?,?,?)}";
     cstmt6 = con.prepareCall (SQL6);
    
     cstmt6.setString(1,v);
   cstmt6.setString(2,w);
   cstmt6.setString(3,x);
    cstmt6.setString(4,y);
   cstmt6.setString(5,z);
    cstmt6.setString(6,n);
   cstmt6.setString(7,o); 
   cstmt6.setString(8,p);
   cstmt6.setString(9,q);
   cstmt6.setString(10,r);
   cstmt6.setString(11,s);
   cstmt6.setString(12,t); 
   cstmt6.setString(13,u);
   
   result6 = cstmt6.executeQuery();
   
   ResultSet result7=null;  
     CallableStatement cstmt7 = null;   
     String SQL7 = "{call price_ranges_counts_men  (?,?,?,?,?,'79',?,?,?,?,?,?,?,?)}";
     cstmt7 = con.prepareCall (SQL7);
    
    cstmt7.setString(1,v);
   cstmt7.setString(2,w);
   cstmt7.setString(3,x);
   cstmt7.setString(4,y);
    cstmt7.setString(5,z);
     cstmt7.setString(6,n);
   cstmt7.setString(7,o); 
   cstmt7.setString(8,p);
   cstmt7.setString(9,q);
   cstmt7.setString(10,r);
   cstmt7.setString(11,s);
   cstmt7.setString(12,t); 
   cstmt7.setString(13,u);
   result7 = cstmt7.executeQuery();
   
   ResultSet result8=null;  
     CallableStatement cstmt8 = null;   
     String SQL8 = "{call price_ranges_counts_men  (?,?,?,?,?,'80',?,?,?,?,?,?,?,?)}";
     cstmt8 = con.prepareCall (SQL8);
    
    cstmt8.setString(1,v);
   cstmt8.setString(2,w);
   cstmt8.setString(3,x);
    cstmt8.setString(4,y);
   cstmt8.setString(5,z);
   cstmt8.setString(6,n);
   cstmt8.setString(7,o); 
   cstmt8.setString(8,p);
   cstmt8.setString(9,q);
   cstmt8.setString(10,r);
   cstmt8.setString(11,s);
   cstmt8.setString(12,t); 
   cstmt8.setString(13,u);
   result8 = cstmt8.executeQuery();
   
   ResultSet result9=null;  
     CallableStatement cstmt9 = null;   
     String SQL9 = "{call category_counts_mens (?,?,?,?,?,?,?,?,'Men1')}";
     cstmt9 = con.prepareCall (SQL9);
    
    cstmt9.setString(1,v);
   cstmt9.setString(2,w);
   cstmt9.setString(3,x);
    cstmt9.setString(4,y);
   cstmt9.setString(5,z);
   cstmt9.setInt(6,k);
   cstmt9.setInt(7,l);
   cstmt9.setInt(8,m);
   result9 = cstmt9.executeQuery();
   
   ResultSet result10=null;  
     CallableStatement cstmt10 = null;   
     String SQL10 = "{call category_counts_mens (?,?,?,?,?,?,?,?,'Men2')}";
     cstmt10 = con.prepareCall (SQL10);
    
    cstmt10.setString(1,v);
   cstmt10.setString(2,w);
   cstmt10.setString(3,x);
    cstmt10.setString(4,y);
   cstmt10.setString(5,z);
   cstmt10.setInt(6,k);
   cstmt10.setInt(7,l);
   cstmt10.setInt(8,m);
   result10 = cstmt10.executeQuery();
   
   
   ResultSet result11=null;  
     CallableStatement cstmt11 = null;   
     String SQL11 = "{call category_counts_mens (?,?,?,?,?,?,?,?,'Men3')}";
     cstmt11 = con.prepareCall (SQL11);
    
    cstmt11.setString(1,v);
   cstmt11.setString(2,w);
   cstmt11.setString(3,x);
    cstmt11.setString(4,y);
   cstmt11.setString(5,z);
   cstmt11.setInt(6,k);
   cstmt11.setInt(7,l);
   cstmt11.setInt(8,m);
   result11 = cstmt11.executeQuery();
   
  ResultSet result12=null;  
     CallableStatement cstmt12 = null;   
     String SQL12 = "{call category_counts_mens (?,?,?,?,?,?,?,?,'Men4')}";
     cstmt12 = con.prepareCall (SQL12);
    
    cstmt12.setString(1,v);
   cstmt12.setString(2,w);
   cstmt12.setString(3,x);
    cstmt12.setString(4,y);
   cstmt12.setString(5,z);
   cstmt12.setInt(6,k);
   cstmt12.setInt(7,l);
   cstmt12.setInt(8,m);
   result12 = cstmt12.executeQuery();
   
   
   ResultSet result13=null;  
     CallableStatement cstmt13 = null;   
     String SQL13 = "{call category_counts_mens (?,?,?,?,?,?,?,?,'Men5')}";
     cstmt13 = con.prepareCall (SQL13);
    
    cstmt13.setString(1,v);
   cstmt13.setString(2,w);
   cstmt13.setString(3,x);
    cstmt13.setString(4,y);
   cstmt13.setString(5,z);
   cstmt13.setInt(6,k);
   cstmt13.setInt(7,l);
   cstmt13.setInt(8,m);
   result13 = cstmt13.executeQuery();
   
   
   ResultSet result14=null;  
     CallableStatement cstmt14 = null;   
     String SQL14 = "{call category_counts_mens (?,?,?,?,?,?,?,?,'Men6')}";
     cstmt14 = con.prepareCall (SQL14);
    
    cstmt14.setString(1,v);
   cstmt14.setString(2,w);
   cstmt14.setString(3,x);
    cstmt14.setString(4,y);
   cstmt14.setString(5,z);
   cstmt14.setInt(6,k);
   cstmt14.setInt(7,l);
   cstmt14.setInt(8,m);
   result14 = cstmt14.executeQuery();
   
   ResultSet result15=null;  
     CallableStatement cstmt15 = null;   
     String SQL15 = "{call category_counts_mens (?,?,?,?,?,?,?,?,'Men7')}";
     cstmt15 = con.prepareCall (SQL15);
    
    cstmt15.setString(1,v);
   cstmt15.setString(2,w);
   cstmt15.setString(3,x);
    cstmt15.setString(4,y);
   cstmt15.setString(5,z);
   cstmt15.setInt(6,k);
   cstmt15.setInt(7,l);
   cstmt15.setInt(8,m);
   result15 = cstmt15.executeQuery();
   
   
   ResultSet result16=null;  
     CallableStatement cstmt16 = null;   
     String SQL16 = "{call category_counts_mens (?,?,?,?,?,?,?,?,'Men8')}";
     cstmt16 = con.prepareCall (SQL16);
    
    cstmt16.setString(1,v);
   cstmt16.setString(2,w);
   cstmt16.setString(3,x);
    cstmt16.setString(4,y);
   cstmt16.setString(5,z);
   cstmt16.setInt(6,k);
   cstmt16.setInt(7,l);
   cstmt16.setInt(8,m);
   result16 = cstmt16.executeQuery();
   
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
    if(result9.next()){};
   session.setAttribute("count9",result9.getString(1));
   if(result10.next()){};
   session.setAttribute("count10",result10.getString(1));
   if(result11.next()){};
   session.setAttribute("count11",result11.getString(1));
   if(result12.next()){};
   session.setAttribute("count12",result12.getString(1));
   if(result13.next()){};
   session.setAttribute("count13",result13.getString(1));
    if(result14.next()){};
   session.setAttribute("count14",result14.getString(1));
   if(result15.next()){};
   session.setAttribute("count15",result15.getString(1));
   if(result16.next()){};
   session.setAttribute("count16",result16.getString(1));
%> 

                     
 <table border="1" width="100%">
<tr>
     <th> Image</th>
     <th> Item </th>
      <th>price</th>
   <th>size</th>
   <th> Category </th>
   
   <%
while(result.next()){
%>
<tr>
    <td><img src= "<%=result.getString(1)%>" height="50" width="50"</td>
    <td><%=result.getString(3)%></td>
    <td><%=result.getString(4)%></td>
    <td><%=result.getString(5)%></td>
    <td><%=result.getString(6)%></td>
</tr>
<%
}
%>
</table>
                </div>

<div class="left">
    <h4> </h4> 
           </br>
            </br>
    <label for="male">(<%=session.getAttribute("count9")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count10")%>) </label>  </br> 
    <label for="male">(<%=session.getAttribute("count11")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count12")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count13")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count14")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count15")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count16")%>) </label> </br>
   
    <h4> </h4>
    </br>
    </br>
    <label for="male">(<%=session.getAttribute("count1")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count2")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count3")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count4")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count5")%>) </label> </br>
    <h4> </h4>
    </br>
    </br>
    <label for="male">(<%=session.getAttribute("count6")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count7")%>) </label> </br>
    <label for="male">(<%=session.getAttribute("count8")%>) </label> </br>
    
</div>        
        

	</body>
</html>
