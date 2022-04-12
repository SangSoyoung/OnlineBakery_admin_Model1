<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%

	String driver = "oracle.jdbc.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userName = "system";
	String password = "1234";		
		
	try {
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, userName, password);	
		Statement stmt = con.createStatement();
		
		String sql = "truncate table b_product";
		stmt.executeQuery(sql);
		
		out.print("<script> alert('모든 제품 정보를 삭제하였습니다!'); location.href='productList.jsp'; </script>");
		
		stmt.close();
		con.close();
		
	} catch (Exception e) {
		e.printStackTrace();
	}
%>	

</body>
</html>