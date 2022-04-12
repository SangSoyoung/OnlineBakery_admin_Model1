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
<div>${id }님 안녕하세요^^</div>

<%

	String pcode = request.getParameter("pcode");
	
	String driver = "oracle.jdbc.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userName = "system";
	String password = "1234";		
		
	try {
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, userName, password);	
		Statement stmt = con.createStatement();
		
		String sql = "select * from b_product where pcode='" + pcode + "'";
		ResultSet rs = stmt.executeQuery(sql);
		
		if(rs.next()) {

%>

<h1>상품 상세 정보</h1>
<form name="p_reg_frm" action="productUpdate_process.jsp" method="post" enctype="multipart/form-data">
<table>
	<tr>
		<th>상품코드<br>(중복불가)</th>
		<td><input type="text" name="pcode" value="<%=rs.getString("pcode") %>" readonly></td>
		<td rowspan="5">
			<img src="upload/<%=rs.getString("img") %>" style="width:100px; height:auto;" alt="이미지 없음">
			<br>
			<input type="file" name="img">
		</td>
	</tr>
	<tr>
		<th>상품명</th>
		<td><input type="text" name="pname" value="<%=rs.getString("pname") %>"></td>
	</tr>
	<tr>
		<th>가격</th>
		<td><input type="text" name="price" value="<%=rs.getInt("price") %>"></td>
	</tr>
	<tr>
		<th>보관방법</th>
		<td><input type="text" name="storage" value="<%=rs.getString("storage") %>"></td>
	</tr>
	<tr>
		<th>유통기한</th>
		<td><input type="text" name="expiration" value="<%=rs.getString("expiration") %>"></td>
	</tr>
	<tr>
		<th>상품설명</th>
		<td colspan="2"><textarea rows="5" cols="50" name="description"><%=rs.getString("description") %></textarea></td>	
	</tr>
	<tr>
		<td colspan="3">
			<input type="submit" value="수정" onclick="return inputCheck()">
			<input type="button" value="삭제" onclick="location.href='productDelete.jsp?pcode=<%=rs.getString("pcode") %>'">
			<input type="button" value="목록보기" onclick="location.href='productList.jsp'">
		</td>
	</tr>
</table>
</form>
<%
		}	
		
		rs.close();
		stmt.close();
		con.close();
		
	} catch (Exception e) {
		e.printStackTrace();
	}
%>	
<script>

	document.p_reg_frm.pname.focus();
	
	// 유효성 검사 함수
	function inputCheck(){
		if(document.p_reg_frm.pname.value.length == 0){
			alert("상품명을 입력해주세요");
			document.p_reg_frm.pname.focus();
			return false;
		}
		if(document.p_reg_frm.pcode.value.length == 0){
			alert("상품코드를 입력해주세요");
			document.p_reg_frm.pcode.focus();
			return false;
		}
		if(document.p_reg_frm.pprice.value.length == 0){
			alert("가격을 입력해주세요");
			document.p_reg_frm.price.focus();
			return false;
		}
		if(document.p_reg_frm.storage.value.length == 0){
			alert("보관방법을 입력해주세요");
			document.p_reg_frm.storage.focus();
			return false;
		}
		if(document.p_reg_frm.expiration.value.length == 0){
			alert("유통기한을 입력해주세요");
			document.p_reg_frm.expiration.focus();
			return false;
		}
		if(document.p_reg_frm.description.value.length == 0){
			alert("상품설명을 입력해주세요");
			document.p_reg_frm.description.focus();
			return false;
		}
		if(document.p_reg_frm.img.value.length == 0){
			alert("상품의 이미지 파일을 선택해주세요");
			document.p_reg_frm.img.focus();
			return false;
		}
		
		return true;
	}
	
</script>	
</body>
</html>