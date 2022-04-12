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
<%

	String driver = "oracle.jdbc.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userName = "system";
	String password = "1234";	
	
	try {
			
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, userName, password);	
		Statement stmt = con.createStatement();
			
		String[] mCheckList = request.getParameterValues("mCheck");
		
		int result = 0;
		
		for(int i = 0; i < mCheckList.length; i++) {
			
			String id = mCheckList[i];
			
			String sql = "delete from b_member where id='" + id + "'";
			result = stmt.executeUpdate(sql);
		}
		
		if(result > 0){
				
			out.print("<script> alert('회원 삭제를 성공하였습니다!'); location.href='memberList_form.jsp'; </script>");
				
		} else {
				
			out.print("<script> alert('회원 삭제 실패;; 다시 시도해주세요~'); location.href='memberList_form.jsp'; </script>");
			
		}
			
		stmt.close();
		con.close();
	
	} catch (Exception e) {
		e.printStackTrace();
	}

	
%>

</body>
</html>