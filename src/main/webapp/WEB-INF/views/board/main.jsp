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
    	loadList();
    	$("#regBtn").click(function(){
    		$("#msg").css("display","none");
    		$("#formDiv").css("display","block");
    	});
    	$("#register").click(function(){
    		// title, content, writer,,,,
    		// var title=$("#title").val();
    		var fData=$("#frm").serialize(); //title=XXX&content=XXX&writer=XXXX
    		$.ajax({
    			url : "${cpath}/api/boards",
    			type : "POST",
    			//data : {"title":title,"content":content,"writer":writer},
    			data : fData,
    			success : loadList,
    			error : function(){ alert("error"); }    			
    		});  
    		// form 초기화
    		//$("#frm")[0].reset();
    		$("button[type='reset']").trigger("click");
    	});
    });                          //     0      1      2 --> index
    function loadList(){
    	$.ajax({
			url: "${cpath}/api/boards",
			type : "GET",  // GET : read(select)
			dataType : "json",
			success : resultHTML,
			error : function(){ alert("error"); }    			
		});
    	$("#msg").css("display","block");
		$("#formDiv").css("display","none");
    }
    function resultHTML(result){ // [{    },{    },{     }]
    	var tbl="<table class='table'>";
    	tbl+="<tr>";
    	tbl+="<td>번호</td>";
    	tbl+="<td>제목</td>";
    	tbl+="<td>작성자</td>";
    	tbl+="<td>작성일</td>";
    	tbl+="<td>조회수</td>";
    	tbl+="</tr>";
    	$.each(result,function(index,data){
	    	tbl+="<tr>";
	    	tbl+="<td>"+data.idx+"</td>";
	    	tbl+="<td id='t"+data.idx+"'><a href='javascript:goView("+data.idx+")'>"+data.title+"</a></td>";
	    	tbl+="<td>"+data.writer+"</td>";
	    	tbl+="<td>"+data.indate.split(' ')[0]+"</td>";
	    	tbl+="<td id='cnt"+data.idx+"'>"+data.count+"</td>";
	    	tbl+="</tr>";	
	    	tbl+="<tr id='c"+data.idx+"' style='display:none;'>";
	    	tbl+="<td>내용</td>";
	        tbl+="<td colspan='2'>";
	        tbl+="<textarea id='ta"+data.idx+"' rows='7' readonly='readonly' class='form-control'>"+data.content+"</textarea>";
	        tbl+="</td>";
	        tbl+="<td colspan='2'>";
	        tbl+="<span id='b"+data.idx+"'><button class='btn btn-sm btn-info' onclick='goUpdate("+data.idx+")'>수정</button></span>";
	        tbl+="&nbsp;&nbsp;";
	        tbl+="<button class='btn btn-sm btn-warning' onclick='goDel("+data.idx+")'>삭제</button>";
	        tbl+="</td>";
	    	tbl+="</tr>";
    	});    	    	
    	tbl+="</table>";
    	$("#msg").html(tbl);
    }    
    function goUpdate(idx){
    	// 1. 제목부분 수정
    	var title=$("#t"+idx).text();
    	var newTitle="<input type='text' class='form-control' id='nt"+idx+"' value='"+title+"'/>";
    	$("#t"+idx).html(newTitle);
    	// 2. textarea 속성 수정
    	$("#ta"+idx).attr("readonly",false);
    	// 3. 수정->수정하기 변경
    	var newBtn="<button class='btn btn-sm btn-success' onclick='update("+idx+")'>수정하기</button>";
    	$("#b"+idx).html(newBtn);
    	
    }
    function update(idx){    	
    	var title=$("#nt"+idx).val();    	
    	var content=$("#ta"+idx).val();
    	//var reqData="{'idx': idx,'title':title,'content':content}";
    	$.ajax({
    		url : "${cpath}/api/boards",
    		type : "PUT", // POST
    		contentType : "application/json;charset=utf-8",
    		data : JSON.stringify({"idx":idx,"title":title,"content":content}),
    		success : loadList,
    		error : function(){ alert("error"); }
    	});
    }
    function goDel(idx){
    	// ${cpath}/api/boards/3  --> @PathVariable("idx")
    	$.ajax({ 
    		url : "${cpath}/api/boards/"+idx,
    		type : "DELETE",
    		success : loadList,
    		error : function(){ alert("error"); }
    	}); 
    }
    function goView(idx){
    	if($("#c"+idx).css("display")=="none"){
    		$("#c"+idx).css("display","table-row");
    		//$("#c"+idx).find("textarea").css("readonly",true);
    	}else{
    		// 조회수 누적
    		$.ajax({
    			url : "${cpath}/api/boards/"+idx,
    			type : "GET",
    			dataType : "json",
    			success : function(obj){ // Board : {         ,"count":3}
    				$("#cnt"+idx).text(obj.count);
    			},
    			error : function(){ alert("error");}
    		});
    		$("#c"+idx).css("display","none");
    	}
    }
  </script>
</head>
<body>
 
<div class="container">
  <h2>Spring MVC</h2>
  <div class="panel panel-default">
    <div class="panel-heading">BOARD(Ajax+JSON)</div>
    <div class="panel-body" id="msg"></div>
    <div class="panel-body" id="formDiv" style="display: none;">
        <form id="frm" class="form-horizontal" method="post">
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="title">제목:</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="title" placeholder="Enter title">
		    </div>
		  </div>
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="content">내용:</label>
		    <div class="col-sm-10">
		      <textarea rows="10" class="form-control" name="content"></textarea>
		    </div>
		  </div>		  
		  <div class="form-group">
		    <label class="control-label col-sm-2" for="writer">작성자:</label>
		    <div class="col-sm-10">
		      <input type="text" class="form-control" name="writer">
		    </div>
		  </div>
		  <div class="form-group">
		    <div class="col-sm-offset-2 col-sm-10">
		      <button id="register" type="button" class="btn btn-primary">등록</button>
		      <button type="reset" class="btn btn-warning">취소</button>
		    </div>
		  </div>
		</form>     
      </div>
      <button id="regBtn" class="btn btn-sm btn-primary">글쓰기</button>  
    <div class="panel-footer">빅데이터 분석서비스 개발자 과정</div>
  </div>
</div>
</body>
</html>
