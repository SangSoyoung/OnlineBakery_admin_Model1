<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
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

	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	String driver = "oracle.jdbc.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userName = "system";
	String password = "1234";	
	
	try {
		
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, userName, password);	
	
		Statement stmt = con.createStatement();
		String sql = "select id, pw from b_member where id='"+ id +"'";
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()){
			
			if(pw.equals(rs.getString("pw"))){
				// 로그인 성공	
				session.setAttribute("id", id);
				session.setAttribute("pw", pw);
				
				out.print("<script> alert('로그인 성공!'); location.href='main.jsp'; </script>");
				
			} else { // 비밀번호 오류
					out.print("<script> alert('비밀번호를 다시 확인해주세요~'); location.href='login_form.jsp'; </script>");
			}
		} else { // 아이디 오류
			out.print("<script> alert('아이디를 다시 확인해주세요~'); location.href='login_form.jsp'; </script>");
		}
		
		rs.close();
		stmt.close();
		con.close();
	
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
</body>
</html>