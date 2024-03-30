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
        <div class="row mb-2">
             <div class="col-12">
              <select class="form-select">
                <option selected></option>
                <option value="1">노트북</option>
                <option value="2">모니터</option>
                <option value="3">마우스/키보드</option>
              </select>
             </div>
        </div>
        <div class="row">
            <c:forEach var="pic" items="${list}">
              <div class="col-xl-3 col-lg-4 col-md-6">
                <div class="card" style="width: 18rem;">
                  <a href="p_detail?id=${pic.id}"><img src="p_download/${pic.id}/${pic.path}" class="card-img-top" alt="..."></a>
                  <div class="card-body">
                    <h5 class="card-title">${pic.product_name}</h5>
                    <p class="card-text">
                      <span class="badge bg-dark">${pic.category1}</span>
                      <span class="badge bg-dark">${pic.category2}</span>
                      <span class="badge bg-dark">${pic.category3}</span>
                    </p>
                    <div class="d-flex justify-content-between align-items-center">
                      <div class="btn-group" role="group" aria-label="Basic example">
                        <button type="button" class="btn btn-sm btn-outline-secondary">장바구니 담기</button>
                        <button type="button" class="btn btn-sm btn-outline-secondary">주문하기</button>         
                      </div>
                      <small class="text-dark">${pic.product_price}원</small>
                    </div>   
                  </div>
                </div>
              </div>
            </c:forEach>           
        </div>        
     </div>
  </main>
  <!-- footer.jsp -->
  <jsp:include page="footer.jsp"/>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
</body>
</html>