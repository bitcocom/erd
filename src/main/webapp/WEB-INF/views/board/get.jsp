<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> 
<c:set var="cpath" value="${pageContext.request.contextPath}"/>   
<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  <script type="text/javascript">
   $(document).ready(function(){
	  $("button").click(function(){
		   var formObj=$("#frm");
		   var oper=$(this).data("oper");
		   if(oper=='modify'){
			   formObj.attr("action","${cpath}/board/modify"); // idx
		   }else if(oper=='remove'){
			   formObj.attr("action","${cpath}/board/remove"); // idx
		   }else{
			   formObj.attr("action","${cpath}/board/list");
		   }
		   formObj.submit(); // 폼전송
	  });
   });
  </script>
</head>
<body>
 
<div class="container">
  <h2>Spring MVC</h2>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD VIEW</div>
    <div class="panel-body">
		<form id="frm" class="form-horizontal">
		  <input type="hidden" name="idx" value="${vo.idx}"/>
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="title">제목:</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" value="${vo.title}" readonly="readonly">
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="content">내용:</label>
		    <div class="col-sm-10">
		      <textarea rows="10" class="form-control" readonly="readonly">${vo.content}</textarea>
		    </div>
		  </div>		  
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="writer">작성자:</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" value="${vo.writer}" readonly="readonly">
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		     <c:if test="${mvo.memId eq vo.memId}"> 
		      <button type="button" data-oper="modify" class="btn btn-primary">수정</button>
		      <button type="button" data-oper="remove" class="btn btn-warning">삭제</button>
		     </c:if> 
		     <c:if test="${mvo.memId ne vo.memId}">
		      <button type="button" disabled="disabled" data-oper="modify" class="btn btn-primary">수정</button>
		      <button type="button" disabled="disabled" data-oper="remove" class="btn btn-warning">삭제</button>
		      </c:if>
		      <button type="button" data-oper="list" class="btn btn-success">목록</button>
		    </div>
		  </div>
		</form>
    </div>
    <div class="panel-footer">빅데이터 분석서비스 개발자 과정</div>
  </div>
</div>

</body>
</html>
