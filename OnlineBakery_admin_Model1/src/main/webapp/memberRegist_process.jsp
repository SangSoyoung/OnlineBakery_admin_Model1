<%@page import="java.sql.PreparedStatement"%>
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
	
		String sql = "insert into b_member values (?, ?, ?, ?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, request.getParameter("id"));
		pstmt.setString(2, request.getParameter("pw"));
		pstmt.setString(3, request.getParameter("name"));
		pstmt.setString(4, request.getParameter("grade"));
		
		int result = pstmt.executeUpdate();
		
		if(result > 0){
			
			out.print("<script> alert('회원가입에 성공하셨습니다^^'); location.href='main.jsp'; </script>");
			

		} else {
			
			out.print("<script> alert('회원가입 실패 ㅠㅠ 다시 시도해주세요~'); location.href='memberRegist_form.jsp'; </script>");
		
		}
		
		pstmt.close();
		con.close();
	
	} catch (Exception e) {
		e.printStackTrace();
	}

%>
</body>
</html>