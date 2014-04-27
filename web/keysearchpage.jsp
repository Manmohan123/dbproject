<%@ page language="java" contentType="text/html; charset=ISO-8859-1" %>
<%@ page import="java.sql.*" %> 
 

<html>
         <head>
		<link type="text/css" rel="stylesheet" href="stylesheet.css"/>
		<title></title>
         </head>
        
        
    <body bgcolor ="#E8E8E8">

	<div id="header">
                <a href="success.jsp" class="button" align="left">Home</a>

                <form id="tfnewsearch" method="post" action="keysearchpage.jsp">
                     <input type="text" class="tftextinput" name="q" id=" q " size="21" maxlength="120"><input type="submit" value="search" class="tfbutton">
		</form>
            
       <div class="tfclear"></div>
       
	</div>
        
	<div id="row">
   
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
      </div >

      <form name="searchpage" action="kewsearchpage.jsp" method="post"> 
            
            <%! public int StringToInt_converter(String str) { 
                        int convrtr=0; 
                        if(str==null) { str="0"; } 
                        else if((str.trim()).equals("null")) { str="0"; }
                        else if(str.equals("")) { str="0"; } 
                        try{ convrtr= Integer.parseInt(str); } 
                        catch(Exception e) { }
                        return convrtr; } 
            %> 
                <%  
             String search = request.getParameter("q");    

             if (search!="") {

                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project",
                        "manmohan", "manmohan");
                       
                        // Number of records displayed on each page 
                        int Rows_PerPage=15;
                        // Number of pages index displayed 
                        int Show_PageCount=10; 
                        int Total_rows=StringToInt_converter(request.getParameter("Total_rows")); 
                        int Total_pages=StringToInt_converter(request.getParameter("Total_pages")); 
                        int initial_count=StringToInt_converter(request.getParameter("initial_count")); 
                        int Current_PageNo=StringToInt_converter(request.getParameter("Current_PageNo"));
                        int iStRsNo=0; 
                        int k=0;
                        int Page_End_RowNo=0; 
                        if(initial_count==0) { initial_count=0; } 
                        else{ initial_count=Math.abs((initial_count-1)*Rows_PerPage); } 
                        
                        ResultSet resltset_Paging = null; 
                        ResultSet resltset_rowcount = null;
                        PreparedStatement statement_Paging=null;
                        Statement statement_rowcount= con.createStatement();
                        
                        String SQL="select * from item where categoryid LIKE '" + search + "%' OR categoryid LIKE '%" + search + "%'OR itemname LIKE '" + search + "%' OR itemname LIKE '%" + search + "%' OR brand LIKE '" + search + "%' OR brand LIKE '%" + search + "%' OR itemtype LIKE '" + search + "%' OR itemtype LIKE '%" + search + "%'  limit "+initial_count+","+Rows_PerPage+""; 
                        statement_Paging=con.prepareStatement(SQL);
                        resltset_Paging=statement_Paging.executeQuery(); 
                        
                        // To Count total number of fetched rows 
                        String SQL_RowCount="select count(*) as cnt  from item where categoryid LIKE '" + search + "%' OR categoryid LIKE '%" + search + "%'OR itemname LIKE '" + search + "%' OR itemname LIKE '%" + search + "%' OR brand LIKE '" + search + "%' OR brand LIKE '%" + search + "%' OR itemtype LIKE '" + search + "%' OR itemtype LIKE '%" + search + "%'";
                        resltset_rowcount=statement_rowcount.executeQuery(SQL_RowCount); 
                        
                        if(resltset_rowcount.next()) {
                            Total_rows=resltset_rowcount.getInt("cnt");
                         out.println("the number of recodrs found " + Total_rows);}
                        %> 

            <div class="right">

                                    <%
                                         if(resltset_rowcount.getString(1)!=null){
                                    %>

                                          <h4> <%= Total_rows%> results are found with keyword  "<%= search%>".... </h4>
                                      <% 
                                         }
                                      %>


                                          <table width="100%" cellpadding="0" cellspacing="0" border="0" > 

                                               <% if(resltset_Paging.next())
                                                               {
                                                      while(resltset_Paging.next()) {
                                               %> 
                                                                <tr>
                                                                    <td><%=resltset_Paging.getString(2)%></td> 
                                                                    <td><%=resltset_Paging.getString(4)%></td>
                                                                    <td><%=resltset_Paging.getString(5)%></td>
                                                                </tr> 
                                                                <% 
                                                                     }} else  {
                                                                           out.println("result not found");
                                                                             }
                                                                 %> 

                                           <% 
                                        // Calculate start and end position
                                          try{ if(Total_rows<(initial_count+Rows_PerPage)) {
                                                    Page_End_RowNo=Total_rows; } 
                                             else { Page_End_RowNo=(initial_count+Rows_PerPage); }
                                             iStRsNo=(initial_count+1);
                                             Total_pages=((int)(Math.ceil((double)Total_rows/Rows_PerPage))); }
                                        
                                         catch(Exception e) {
                                            e.printStackTrace(); }
                                         %> 
                                               <tr> <td colspan="3"> 

                                        <% 
                                            //  index of pages 
                                            int i=0; int cPge=0;
                                            if(Total_rows!=0) { 
                                            cPge=((int)(Math.ceil((double)Page_End_RowNo/(Show_PageCount*Rows_PerPage))));
                                            int prePageNo=(cPge*Show_PageCount)-((Show_PageCount-1)+Show_PageCount); 
                                            if((cPge*Show_PageCount)-(Show_PageCount)>0) { 
                                         %> 
                                                    <a href="keysearchpage.jsp?initial_count=<%=prePageNo%>&Current_PageNo=<%=prePageNo%>&q=<%=search%>"><< Previous</a>
                                                    <% 
                                                       } 
                                           for(i=((cPge*Show_PageCount)-(Show_PageCount-1));i<=(cPge*Show_PageCount);i++) {
                                                if(i==((initial_count/Rows_PerPage)+1)) {
                                                    %> 
                                                  <a href="keysearchpage.jsp?initial_count=<%=i%>&q=<%=search%>" style="cursor:pointer;color:red"><b><%=i%></b></a>
                                                   <% 
                                                     } 
                                                else if(i<=Total_pages) { 
                                                   %> 
                                                      <a href="keysearchpage.jsp?initial_count=<%=i%>&q=<%=search%>"><%=i%></a>
                                                           <% } } 
                                       if(Total_pages>Show_PageCount&& i<Total_pages) {
                                          %>
                                              <a href="keysearchpage.jsp?initial_count=<%=i%>&Current_PageNo=<%=i%>&q=<%=search%>">>> Next</a>
                                         <% } }
                                          %> 
                                              <b>Rows <%=iStRsNo%> - <%=Page_End_RowNo%> Total Result <%=Total_rows%></b>
                                                </td> 
                                                </tr> 
                                             </table>  
                    
         </div>
                   <%} else {out.println("you must enter a word ");}%> 
        </form> 
                    
    </body> 
 </html> 

