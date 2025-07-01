<%@ page import="java.sql.*" %>
<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement stmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/user_db", "root", "Root");

        // Check if email already exists
        String checkSql = "SELECT * FROM users WHERE email = ?";
        stmt = conn.prepareStatement(checkSql);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();

        if (rs.next()) {
            out.println("Email already registered. Please login.");
        } else {
            // Insert new user
            String insertSql = "INSERT INTO users (email, password) VALUES (?, ?)";
            stmt = conn.prepareStatement(insertSql);
            stmt.setString(1, email);
            stmt.setString(2, password); // In production, use hashing
            int rows = stmt.executeUpdate();
            if (rows > 0) {
                out.println("Signup successful!");
            } else {
                out.println("Signup failed.");
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
