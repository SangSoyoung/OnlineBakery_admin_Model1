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
		String sql = "select * from b_member";
		
		ResultSet rs = stmt.executeQuery(sql);
%>

<h1>회원 목록</h1>
<form action="memberDelete.jsp" method="get">
<table border="1">
	<tr>
		<th>선택</th>
		<th>아이디</th>
		<th>비밀번호</th>
		<th>이름</th>
		<th>권한등급</th>
	</tr>
<%	
		while(rs.next()) {
%>		
	<tr>
		<td><input type="checkbox" name="mCheck" value="<%=rs.getString("id") %>"></td>
		<td><%=rs.getString("id") %></td>
		<td><%=rs.getString("pw") %></td>
		<td><%=rs.getString("name") %></td>
		<td><%=rs.getString("grade") %></td>
	</tr>
<%			
		}	
		
		rs.close();
		stmt.close();
		con.close();
		
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
</table>
	<input type="submit" value="선택회원삭제"><br>
</form>
<button onclick="location.href='main.jsp'">메인 페이지 가기</button>


</body>
</html>