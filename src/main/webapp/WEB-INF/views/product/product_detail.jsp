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
      <div class="row">
        <div class="col-md-5">
          <div id="carouselExampleIndicators" class="carousel carousel-dark slide" data-bs-ride="carousel">
            <ol class="carousel-indicators">
              <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></li>
              <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></li>
              <li data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"></li>
            </ol>
            <div class="carousel-inner">
              <c:forEach var="img" items="${imglist}" varStatus="status">
	              <div class="carousel-item ${status.index==0 ? 'active' : ''}">
	                <img src="p_download/${pic.id}/${img.path}" class="d-block w-100" alt="...">
	              </div>             
              </c:forEach>
            </div>
            <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-bs-slide="prev">
              <span class="carousel-control-prev-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Previous</span>
            </a>
            <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-bs-slide="next">
              <span class="carousel-control-next-icon" aria-hidden="true"></span>
              <span class="visually-hidden">Next</span>
            </a>
          </div>
        </div>
        <div class="col-md-7">
          <div class="card shadow-sm">
            <div class="card-body">
              <h5 class="card-title">${pic.product_name}</h5>
              <h5 class="card-title pt-3 pb-3 border-top">${pic.product_price}원</h5>
              <p class="card-text border-top pt-3">
                      <span class="badge bg-dark">${pic.category1}</span>
                      <span class="badge bg-dark">${pic.category2}</span>
                      <span class="badge bg-dark">${pic.category3}</span>
              </p>
              <p class="card-text pb-3">
                배송비 ${pic.delivery_price}원 | 도서산간(제주도) 배송비 추가 ${pic.add_delivery_price}원 | 택배배송 | ${pic.outbound_days}일 이내 출고 (주말,공휴일 제외)
              </p>
              <p class="card-text border-top pb-3">
                <div class="row">
                  <div class="col-auto">
                    <label class="col-form-label">구매수량</label>
                  </div>
                  <div class="col-auto">
                    <div class="input-group">
                      <span class="input-group-text" style="cursor: pointer;" onclick="calculatePrice(-1);">-</span>
                      <input type="text" class="form-control" style="width:40px;" value="1" id="total">
                      <span class="input-group-text" style="cursor: pointer;" onclick="calculatePrice(1);">+</span>
                    </div>
                  </div>
                </div>
              </p>
              <div class="row pt-3 pb-3 border-top">
                <div class="col-6">
                  <h3>총 상품 금액</h3>
                </div>
                <div class="col-6" style="text-align: right;">
                  <h3 class="totalPrice"><fmt:formatNumber value="${pic.product_price}"  pattern="#,###"/>원</h3>
                </div>
              </div>
              <div class="d-flex justify-content-between align-items-center">
                <div class="col-6 d-grid p-1">
                  <button type="button" class="btn btn-lg btn-dark">장바구니 담기</button>
                </div>
                <div class="col-6 d-grid p-1">
                  <button type="button" class="btn btn-lg btn-danger">주문하기</button>
                </div>
                
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="row">
        <div class="col-12">
          <img src="p_download/${pic.id}/${pic.path}" class="img-fluid" />
        </div>
      </div>
    </div>
  </main>
  
  <!-- footer.jsp -->
  <jsp:include page="footer.jsp"/>
  
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta1/dist/js/bootstrap.bundle.min.js" integrity="sha384-ygbV9kiqUc6oa4msXn9868pTtWMgiQaeYH7/t7LECLbyPA2x65Kgf80OJFdroafW" crossorigin="anonymous"></script>
  <script src="https://code.jquery.com/jquery-3.7.0.min.js"></script>
  <script type="text/javascript">
     function calculatePrice(cnt){
    	let total=parseInt($("#total").val())+parseInt(cnt);
    	if(total<1) total=1;
		$("#total").val(total);
		var totalPrice=${pic.product_price}*total;
		$(".totalPrice").html(totalPrice+"원");
	}
  </script>
</body>
</html>