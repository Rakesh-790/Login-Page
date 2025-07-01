<%@ page import="java.sql.*" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_db", "root", "Root");

        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, email);
        stmt.setString(2, password); // Should hash in real apps
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            response.sendRedirect("http://localhost:1300/my_project/utkal.html");
        } else {
            response.sendRedirect("http://localhost:1300/my_project/login/login.html");
        }
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
