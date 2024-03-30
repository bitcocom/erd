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
  <style>
      .card{
        margin-bottom: 10px;
      }
  </style> 
</head>
<body>
 <!-- nav.jsp -->
  <jsp:include page="nav.jsp"/>
  
  <main class="mt-3">
    <div class="container">
    <div class="float-end mb-1">
      <button type="button" class="btn btn-dark btn-sm" onclick="location.href='p_create'">제품등록</button>
    </div>
    <table class="table table-bordered">
       <thead>
        <tr>
          <th>이미지</th>
          <th>제품명</th>
          <th>제품가격</th>
          <th>배송비</th>
          <th>추가 배송비</th>            
          <th>메뉴</th>             
        </tr>
       </thead>       
       <tbody>
       <c:forEach var="pic" items="${list}">
         <tr>
           <td>
             <c:if test="${!empty pic.path}"> 
              <img src="p_download/${pic.id}/${pic.path}" style="height:50px;width:auto;"/>
             </c:if>
           </td>
           <td>${pic.product_name}</td>
           <td>${pic.product_price}</td>
           <td>${pic.delivery_price}</td>
           <td>${pic.add_delivery_price}</td>
           <td>
             <button type="button" class="btn btn-info me-1 btn-sm" onclick="location.href='p_image?id=${pic.id}'">사진등록</button>
             <button type="button" class="btn btn-warning me-1 btn-sm" onclick="location.href='p_update?id=${pic.id}'">수정</button>
             <button type="button" class="btn btn-danger btn-sm" onclick="location.href='p_delete?id=${pic.id}'">삭제</button>
           </td>           
         </tr>
         </c:forEach>
       </tbody>
    </table> 
    </div>  
  </main>
  <!-- footer.jsp -->
  <jsp:include page="footer.jsp"/>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>