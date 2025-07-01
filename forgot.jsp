<%@ page import="java.sql.*" %>

<%
    String forgotMessage = "";
    Connection con = null;
    PreparedStatement ps = null;

    if (request.getParameter("forgot") != null) {
        String email = request.getParameter("email");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_db", "root", "Root");

            ps = con.prepareStatement("SELECT email FROM users WHERE email=?");
            ps.setString(1, email);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
            	ps = con.prepare
                forgotMessage = "Your password is: " + recoveredPassword; // 🚨 For demo ONLY
            } else {
                forgotMessage = "Email not found in our records.";
            }

            con.close();
        } catch (Exception e) {
            forgotMessage = "Error: " + e.getMessage();
        }
    }
%>
