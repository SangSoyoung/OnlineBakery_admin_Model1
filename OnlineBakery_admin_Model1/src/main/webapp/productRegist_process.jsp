<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
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
	//******인코딩 설정******//
	request.setCharacterEncoding("utf-8");
	response.setContentType("text/html; charset=utf-8");
	
	//******파일 업로드******//
	// 1. 파일 저장 경로 변수
	String savePath = "upload";
	// 2. 파일 업로드 최대 크기
	int uploadFileSizeLimit = 5 * 1024 * 1024;
	
	// 3. 인코딩 타입
	String encType = "utf-8";
	
	// 4. 서버상 실제 저장 디렉토리 
	ServletContext context = getServletContext();
	String uploadFilePath = context.getRealPath(savePath);
	
	// 5. MultipartRequest 객체 선언
	MultipartRequest multi = null;
	
	try {
		multi = new MultipartRequest(
				request, 
				uploadFilePath,
				uploadFileSizeLimit,
				encType,
				new DefaultFileRenamePolicy()
				);
		
		// 6. 업로드된 파일 이름
		String filename = multi.getOriginalFileName("img");
		
		if(filename == null) {
			System.out.println("파일이 업로드 되지 않았음");
		} else {
			System.out.println("파일 업로드 성공");
		}
		
	} catch (Exception e) {
		System.out.println("예외 발생 : " + e);
	}	
	
	
	//******수정 내용 저장******//
	String driver = "oracle.jdbc.OracleDriver";
	String url = "jdbc:oracle:thin:@localhost:1521:xe";
	String userName = "system";
	String password = "1234";	
	
	try {
		
		Class.forName(driver);
		Connection con = DriverManager.getConnection(url, userName, password);	
	
		String sql = "insert into b_product values (?, ?, ?, ?, ?, ?, ?)";
		PreparedStatement pstmt = con.prepareStatement(sql);
		
		pstmt.setString(1, multi.getParameter("pcode"));
		pstmt.setString(2, multi.getParameter("pname"));
		pstmt.setInt(3, Integer.parseInt(multi.getParameter("price")));
		pstmt.setString(4, multi.getParameter("storage"));
		pstmt.setString(5, multi.getParameter("expiration"));
		pstmt.setString(6, multi.getParameter("description"));
		pstmt.setString(7, multi.getFilesystemName("img"));
		
		int result = pstmt.executeUpdate();
		
		if(result > 0){
			
			out.print("<script> alert('제품 정보 등록을 성공하셨습니다^^'); location.href='productList.jsp'; </script>");
			
		} else {
			
			out.print("<script> alert('제품 정보 등록 실패 ㅠㅠ 다시 시도해주세요~'); location.href='productRegist_form.jsp'; </script>");
		
		}
		
		pstmt.close();
		con.close();
	
	} catch (Exception e) {
		e.printStackTrace();
	}

%>

</body>
</html>