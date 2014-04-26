<%@ page import ="java.sql.*" %>
<%
    String user = request.getParameter("uname");    
    String pwd = request.getParameter("pass");
    String fname = request.getParameter("fname");
    String lname = request.getParameter("lname");
    String email = request.getParameter("email");
    String gender = request.getParameter("fname");
    String address = request.getParameter("address");
    String ph = request.getParameter("phone");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/project",
            "manmohan", "manmohan");
    Statement st = con.createStatement();
    //ResultSet rs;
    int i = st.executeUpdate("insert into customers(first_name, last_name, email,Gender, Address,Phone, uname, pass, regdate) values ('" + fname + "','" + lname + "','" + email + "','" + gender + "','" + address + "','" + ph + "','" + user + "','" + pwd + "', CURDATE())");
    if (i > 0) {
        //session.setAttribute("userid", user);
        response.sendRedirect("success.jsp");
       // out.print("Registration Successfull!"+"<a href='index.jsp'>Go to Login</a>");
    } else {
        response.sendRedirect("index.jsp");
    }
%>