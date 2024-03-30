<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
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
      <h2 class="text-center">제품 등록</h2>
      <form id="frm" action="p_create" method="post">
      <input type="hidden" name="category_id" id="category_id"/>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">제품명</label>
        <div class="col-md-9">
          <input type="text" class="form-control" name="product_name">
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">제품가격</label>
        <div class="col-md-9">
          <div class="input-group mb-3">
            <input type="text" class="form-control" name="product_price">
            <span class="input-group-text">원</span>
          </div>           
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">배송비</label>
        <div class="col-md-9">
          <div class="input-group mb-3">
            <input type="text" class="form-control" name="delivery_price">
            <span class="input-group-text">원</span>
          </div>           
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">추가배송비(도서산간)</label>
        <div class="col-md-9">
          <div class="input-group mb-3">
            <input type="text" class="form-control" name="add_delivery_price">
            <span class="input-group-text">원</span>
          </div>           
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">제품카테고리</label>
        <div class="col-md-9">
           <div class="row">
              <div class="col-auto" id="cate1">              
              </div>
              <div class="col-auto" id="cate2">             
              </div>
              <div class="col-auto" id="cate3">
              </div>
           </div>        
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">태그</label>
        <div class="col-md-9">
          <input type="text" class="form-control" name="tags">
        </div>
      </div>
      <div class="mb-3 row">
        <label class="col-md-3 col-form-label">출고일</label>
        <div class="col-md-9">
          <div class="input-group mb-3">
            <input type="number" class="form-control" name="outbound_days">
            <span class="input-group-text">일 이내 출고</span>
          </div>           
        </div>
      </div>      
      <div class="mb-3 row">
        <div class="col-6 d-grid p-1">
          <button type="button" class="btn btn-lg btn-dark" onclick="location.href='p_sales'">취소하기</button>                      
        </div>                  
        <div class="col-6 d-grid p-1">
          <button type="button" class="btn btn-lg btn-danger" onclick="goInsert()">저장하기</button>                     
        </div>  
      </div>
      </form>
    </div>
  </main>
  
  <!-- footer.jsp -->
  <jsp:include page="footer.jsp"/>  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
  <script type="text/javascript">
     $(document).ready(function(){
    	 let categoryList = [];
    	 let category1 =[];
         let category2 =[];
         let category3 =[];
    	 loadCategory();
     });
     function loadCategory(){
    	 $.ajax({
    		 url : "p_categoryList",
    		 type : "get",
    		 dataType : "json",
    		 success : categoryPart,
    		 error : function() { alert("error"); }
    	 });
     }
     function categoryPart(data){    	 
    	 categoryList=data;    	 
    	 let oCategory = {};
    	 $.each(data, function(index, obj){
    		 //console.log(obj);
    		 oCategory[obj.category1]=obj.id;
    	 });
    	 category1 = [];
    	 for(let key in oCategory) {
    	   category1.push(key);
    	 }    	
    	 // select에 저장
    	 var cate1="<select name='cate1' class='form-select' onchange='changeCategory1()'>";
    	 cate1+="<option></option>";
    	 for(let key in category1) {
    	    cate1+="<option value='"+category1[key]+"'>"+category1[key]+"</option>"; 
    	 }
    	 cate1+="</select>";
    	 $("#cate1").html(cate1);
    	 
    	 category2 = [];
    	 $.each(data, function(index, obj){
    		if(obj.category1==category1[0]){
    			category2.push(obj);
    		}
    	 });    	 
    	 let oCategory2 = {};
    	 $.each(category2, function(index, obj){
    		 //console.log(obj);
    		 oCategory2[obj.category2]=obj.id;
    	 });    	
    	 category2 = [];
    	 for(let key in oCategory2) {
    	        category2.push(key);
    	 }
    	 // select에 저장
    	 var cate2="<select name='cate2' class='form-select' onchange='changeCategory2()'>";
    	 cate2+="<option></option>";
    	 for(let key in category2) {
    		 cate2+="<option value='"+category2[key]+"'>"+category2[key]+"</option>"; 
      	 }
    	 cate2+="</select>";
    	 $("#cate2").html(cate2);
     }
     function changeCategory1(){
    	 let category3=[];
    	 let categoryList1=[];
    	 $.each(categoryList, function(index, obj){
     		if(obj.category1==$("#cate1 option:selected").val()){
     			categoryList1.push(obj);
     		}
     	 }); 
    	 console.log(categoryList1);
    	 let oCategory2 = {};
    	 $.each(categoryList1, function(index, obj){
    		 oCategory2[obj.category2]=obj.id;
      	 }); 
    	 category2 = [];
         for(let key in oCategory2) {
           category2.push(key);
         }         
         // select에 저장
    	 var cate2="<select name='cate2' class='form-select' onchange='changeCategory2()'>";
    	 cate2+="<option></option>";
    	 for(let key in category2) {
    		 cate2+="<option value='"+category2[key]+"'>"+category2[key]+"</option>"; 
      	 }
    	 cate2+="</select>";
    	 $("#cate2").html(cate2);
    	 
    	  // select에 저장
    	 var cate3="<select name='cate3' class='form-select'>";
    	 cate3+="<option></option>";
    	 for(let key in category3) {
    		 cate3+="<option value='"+category3[key]+"'>"+category3[key]+"</option>"; 
      	 }
    	 cate3+="</select>";
    	 $("#cate3").html(cate3);
    	 
     }
     function changeCategory2(){
    	 console.log("2OK");
    	 let categoryList1=[];
    	 $.each(categoryList, function(index, obj){
     		if(obj.category1==$("#cate1 option:selected").val() && obj.category2==$("#cate2 option:selected").val()){
     			categoryList1.push(obj);
     		}
     	 });     	
    	 let oCategory3 = {};
    	 $.each(categoryList1, function(index, obj){
    		 oCategory3[obj.category3]=obj.id;
      	 }); 
    	 category3 = [];
         for(let key in oCategory3) {
           category3.push(key);
         }         
         // select에 저장
    	 var cate3="<select name='cate3' class='form-select'>";
    	 cate3+="<option></option>";
    	 for(let key in category3) {
    		 cate3+="<option value='"+category3[key]+"'>"+category3[key]+"</option>"; 
      	 }
    	 cate3+="</select>";
    	 $("#cate3").html(cate3);    	 
     }
     function goInsert(){
    	 let category_id;
    	 $.each(categoryList, function(index, obj){
      		if(obj.category1==$("#cate1 option:selected").val() && obj.category2==$("#cate2 option:selected").val() && obj.category3==$("#cate3 option:selected").val()){
      			category_id=obj.id;
      		}
      	 });
    	 $("#category_id").val(category_id);
    	 //alert($("#category_id").val());
    	 $("#frm").submit();
     }
  </script>
</body>
</html>