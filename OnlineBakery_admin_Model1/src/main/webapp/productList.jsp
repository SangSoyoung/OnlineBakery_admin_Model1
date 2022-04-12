<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
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
<div>${id }님 안녕하세요^^</div>

<%
	
	String driver = "oracle.jdbc.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userName = "system";
	String password = "1234";		
		
	try {
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, userName, password);	
		Statement stmt = con.createStatement();
		
		String sql = "select pcode, pname, price, img from b_product";
		ResultSet rs = stmt.executeQuery(sql);
%>

<h1>상품 조회</h1>
<table border="1" style="text-align: center;">
	<tr>
		<th>상품코드</th>
		<th>상품명</th>
		<th>가격</th>
		<th>상품 이미지</th>
	</tr>
<%	
		while(rs.next()) {
%>		
	<tr>
		<td>
			<a href="productDetail.jsp?pcode=<%=rs.getString("pcode") %>">
				<%=rs.getString("pcode") %>
			</a>
		</td>
		<td><%=rs.getString("pname") %></td>
		<td><%=rs.getString("price") %></td>
		<td>
			<img src="upload/<%=rs.getString("img") %>" style="width:100px;height:auto;" alt="이미지 없음">
		</td>
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
	<tr>
		<td colspan="4">
			<button name="pRegist" onclick="location.href='productRegist_form.jsp'">상품등록</button>
			<button onclick="location.href='productTruncate.jsp'">초기화</button>
			<button onclick="location.href='main.jsp'">메인 페이지 가기</button>
		</td>
	</tr>

</table>

</body>
</html>