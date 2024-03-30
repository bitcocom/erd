<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>     
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Document</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-giJF6kkoqNQ00vy+HMDP7azOuL0xtbfIcaT9wjKHr8RbDVddVHyTfAAsrekwKmP1" crossorigin="anonymous">

</head>
<body>
  <!-- nav.jsp -->
  <jsp:include page="nav.jsp"/>
  
  <main class="mt-3">
    <div class="container">
      <h2 class="text-center">제품 사진 등록</h2>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">제품ID</label>
        <div id="picid" class="col-md-9">
           ${pic.id}
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">제품명</label>
        <div class="col-md-9">
           ${pic.product_name}
        </div>
      </div>  
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">쎔네일이미지</label>
        <div class="col-md-9">
         <div class="row">
            <c:forEach var="img" items="${mlist}">
             <c:if test="${img.type==1}">
	             <div class="col-lg-3 col-md-4 col-sm-2">
	               <div class="position-relative">
	                <img src="p_download/${img.product_id}/${img.path}" class="img-fluid" />
	                <div class="position-absolute top-0 end-0" style="cursor:pointer;" onclick="deleteImage(${img.id})">X</div>
	               </div>
	             </div>
             </c:if>
            </c:forEach>
          </div>
          <input data-type="1" class="form-control" id="type1" type="file" name="files" accept="image/png,image/jpeg" multiple>          
          <div class="alert alert-secondary" role="alert">
            <ul>
               <li>이미지 사이즈 : 350*350</li>
               <li>파일 사이즈 : 1M 이하</li>
               <li>파일 확장자 : png, jpg만 가능</li>
            </ul>
          </div>
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">제품이미지</label>
        <div class="col-md-9">
          <div class="row">
            <c:forEach var="img" items="${mlist}">
             <c:if test="${img.type==2}">
	             <div class="col-lg-3 col-md-4 col-sm-2">
	               <div class="position-relative">
	                <img src="p_download/${img.product_id}/${img.path}" class="img-fluid" />
	                <div class="position-absolute top-0 end-0" style="cursor:pointer;" onclick="deleteImage(${img.id})">X</div>
	               </div>
	             </div>
             </c:if>
            </c:forEach>
          </div>
          <input data-type="2" class="form-control" type="file" accept="image/png,image/jpeg" multiple>
          <div class="alert alert-secondary" role="alert">
            <ul>
               <li>최대 5개 가능</li>
               <li>이미지 사이즈 : 700*700</li>
               <li>파일 사이즈 : 1M 이하</li>
               <li>파일 확장자 : png, jpg만 가능</li>
            </ul>
          </div>
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">제품설명이미지</label>
        <div class="col-md-9">
          <div class="row">
             <div class="col-lg-6 col-md-8">
              <input data-type="3" class="form-control" type="file" accept="image/png,image/jpeg">
               <div class="alert alert-secondary" role="alert">
               <ul>             
                 <li>파일 사이즈 : 5M 이하</li>
                 <li>파일 확장자 : png, jpg만 가능</li>
               </ul>
             </div>             
            </div>
            <c:forEach var="img" items="${mlist}">
             <c:if test="${img.type==3}">
	             <div class="col-lg-6 col-md-4">
	               <div class="position-relative">
	                <img src="p_download/${img.product_id}/${img.path}" class="img-fluid" />
	                <div class="position-absolute top-0 end-0" style="cursor:pointer;" onclick="deleteImage(${img.id})">X</div>
	               </div>
	             </div>
             </c:if>
            </c:forEach>
          </div>
        </div>
      </div>
       <div class="mb-3 row m-auto">
        <button type="button" class="btn btn-lg btn-dark" onclick="location.href='p_sales'">확인</button>
      </div>
    </div>
  </main>
  
  <!-- footer.jsp -->
  <jsp:include page="footer.jsp"/>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
	/*   $("#type1").on("change", function (e) {
		  if (e.target.files && e.target.files[0]) {
	            var reader = new FileReader();
	            reader.onload = function (e) {
	                $('#preview').attr('src', e.target.result);
	                uploadFile(e.target.result);
	            };
	            reader.readAsDataURL(e.target.files[0]);
	        } else {
	            document.getElementById('preview').src = "";
	        }
	});	   */
	 /*  $("#type1").on("change", function(e) {		  
		  var formData = new FormData();
		  var inputFile=$("input[name='files']");
		  var files=inputFile[0].files;
		  console.log(files);	  
		  for (var i = 0; i < files.length; i++) {
		       formData.append("files", files[i]);
		  }         
		  uploadFiles(formData);		    
		}); */
	  $("input[type=file]").on("change", function(e) {		
		    var files = e.target.files;
		    if (files && files.length > 0) {
		        var formData = new FormData();
		        for (var i = 0; i < files.length; i++) {
		            formData.append("files", files[i]);
		        }
		        var type=$(this).data("type");
		        uploadFiles(formData, type);
		    }
		});
  });  
  function uploadFiles(formData, type) {
	    var product_id=$("#picid").text();	
	    formData.append('product_id', product_id);
	    formData.append('type', type);
	    $.ajax({
	        url: 'upload.do',
	        contentType: false,
	        processData: false,
	        type: 'POST',
	        data: formData,
	        success: function(response) {
	            alert("Uploaded");
	            location.href="p_image?id="+parseInt(product_id);
	        },
	        error: function(xhr, status, error) {
	           alert(error);
	        }
	    });
	}
  function deleteImage(id) {	
	    var product_id=$("#picid").text();	
	    $.ajax({
	        url: 'p_imageDelete',
	        type: 'GET',
	        data: {id : id},
	        success: function(response) {
	            alert("Deleted");
	            location.href="p_image?id="+parseInt(product_id);
	        },
	        error: function(xhr, status, error) {
	           alert(error);
	        }
	    });
	}

  </script> 
</body>
</html>