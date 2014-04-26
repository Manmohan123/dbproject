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
            <%! public int Converter(String str) { 
    int convrtr=0; 
    if(str==null) { str="0"; } 
    else if((str.trim()).equals("null")) { str="0"; }
    else if(str.equals("")) { str="0"; } 
    try{ convrtr= Integer.parseInt(str); } 
    catch(Exception e) { }
    return convrtr; } %> 
<%  
String search = request.getParameter("q");    

if (search!="") {
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project",
            "manmohan", "manmohan");
ResultSet rsPgin = null; 
ResultSet rsRwCn = null;
PreparedStatement psPgintn=null;
Statement psRwCn= con.createStatement();
// Number of records displayed on each page 
int iSwRws=15;
// Number of pages index displayed 
int iTotSrhRcrds=10; 
int iTotRslts=Converter(request.getParameter("iTotRslts")); 
int iTotPags=Converter(request.getParameter("iTotPags")); 
int iPagNo=Converter(request.getParameter("iPagNo")); 
int cPagNo=Converter(request.getParameter("cPagNo"));
int iStRsNo=0; 
int k=0;
int iEnRsNo=0; 
if(iPagNo==0) { iPagNo=0; } 
else{ iPagNo=Math.abs((iPagNo-1)*iSwRws); } 
String sqlPgintn="select * from item where categoryid LIKE '" + search + "%' OR categoryid LIKE '%" + search + "%'OR itemname LIKE '" + search + "%' OR itemname LIKE '%" + search + "%' OR brand LIKE '" + search + "%' OR brand LIKE '%" + search + "%' OR itemtype LIKE '" + search + "%' OR itemtype LIKE '%" + search + "%'  limit "+iPagNo+","+iSwRws+""; 
psPgintn=con.prepareStatement(sqlPgintn);
rsPgin=psPgintn.executeQuery(); 
// Count total number of fetched rows 
String sqlRwCnt="select count(*) as cnt  from item where categoryid LIKE '" + search + "%' OR categoryid LIKE '%" + search + "%'OR itemname LIKE '" + search + "%' OR itemname LIKE '%" + search + "%' OR brand LIKE '" + search + "%' OR brand LIKE '%" + search + "%' OR itemtype LIKE '" + search + "%' OR itemtype LIKE '%" + search + "%'";
rsRwCn=psRwCn.executeQuery(sqlRwCnt); 
if(rsRwCn.next()) {
    iTotRslts=rsRwCn.getInt("cnt");
 out.println("the number of recodrs found " + iTotRslts);}
%> 

   <div class="right">
       
        <%
      if(rsRwCn.getString(1)!=null){
             %>
         
         <h4> <%= iTotRslts%> results are found with keyword  "<%= search%>".... </h4>
         <% 
          }
         %>
        
            
            <table width="100%" cellpadding="0" cellspacing="0" border="0" > 
                
                <% if(rsPgin.next())
                   {
                    while(rsPgin.next()) {
                    %> 
                    <tr>
                        <td><%=rsPgin.getString(2)%></td> 
                        <td><%=rsPgin.getString(4)%></td>
                        <td><%=rsPgin.getString(5)%></td>
                    </tr> 
                    <% 
                }} else  {
                            out.println("result not found");
                           }
                    %> 
   
                    <% 
// Calculate next recor d start and end position
                try{ if(iTotRslts<(iPagNo+iSwRws)) {
                    iEnRsNo=iTotRslts; } 
else { iEnRsNo=(iPagNo+iSwRws); }
                iStRsNo=(iPagNo+1);
                iTotPags=((int)(Math.ceil((double)iTotRslts/iSwRws))); }
                catch(Exception e) {
                    e.printStackTrace(); }
                %> 
                <tr> <td colspan="3"> 
           
                            <% 
// Create index of pages 
int i=0; int cPge=0;
if(iTotRslts!=0) { 
cPge=((int)(Math.ceil((double)iEnRsNo/(iTotSrhRcrds*iSwRws))));
int prePageNo=(cPge*iTotSrhRcrds)-((iTotSrhRcrds-1)+iTotSrhRcrds); 
if((cPge*iTotSrhRcrds)-(iTotSrhRcrds)>0) { 
                            %> 
                            <a href="keysearchpage.jsp?iPagNo=<%=prePageNo%>&cPagNo=<%=prePageNo%>&q=<%=search%>"><< Previous</a>
                            <% 
                     } 
for(i=((cPge*iTotSrhRcrds)-(iTotSrhRcrds-1));i<=(cPge*iTotSrhRcrds);i++) {
    if(i==((iPagNo/iSwRws)+1)) {
        %> 
        <a href="keysearchpage.jsp?iPagNo=<%=i%>&q=<%=search%>" style="cursor:pointer;color:red"><b><%=i%></b></a>
        <% 
    } 
else if(i<=iTotPags) { 
        %> 
        <a href="keysearchpage.jsp?iPagNo=<%=i%>&q=<%=search%>"><%=i%></a>
        <% } } 
if(iTotPags>iTotSrhRcrds&& i<iTotPags) {
    %>
    <a href="keysearchpage.jsp?iPagNo=<%=i%>&cPagNo=<%=i%>&q=<%=search%>">>> Next</a>
    <% } }
%> 
<b>Rows <%=iStRsNo%> - <%=iEnRsNo%> Total Result <%=iTotRslts%></b>
                    </td> 
                </tr> 
            </table>  
                    
         </div>
<%} else {out.println("you must enter a word ");}%> 
        </form> 
                    
    </body> 
</html> 

