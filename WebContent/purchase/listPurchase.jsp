<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	<title>구매 목록조회</title>
	
	<!-- 참조 : http://getbootstrap.com/css/   참조 -->
	<meta name="viewport" content="width=device-width, initial-scale=1.0" />
	
	<!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>
	
	
	<!-- Bootstrap Dropdown Hover CSS -->
   <link href="/css/animate.min.css" rel="stylesheet">
   <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">
    <!-- Bootstrap Dropdown Hover JS -->
   <script src="/javascript/bootstrap-dropdownhover.min.js"></script>
   
   
   <!-- jQuery UI toolTip 사용 CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip 사용 JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//검색 / page 두가지 경우 모두 Form 전송을 위해 JavaScript 이용
	function fncGetList(currentPage){
		$("#currentPage").val(currentPage)
	  	$("form").attr("method" , "POST").attr("action" , "/purchase/listPurchase").submit(); 
	} 

	//===========================================//
	 $(function() {
		 
		//==> 검색 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
		 $( "td:nth-child(1)" ).on("click" , function() {
			 self.location = "/purchase/getPurchase?tranNo="+$(this).find("input[type='hidden']").val(); 			 		
		});
	
		//============= prodName에 상세정보  Event  처리(Click) =============	
 		$( "#buyer" ).on("click" , function() {
				alert(  $( this ).text().trim() );
				self.location = "/user/getUser?userId="+${buyer};	
		}); 
			
		$("#arrive").on("click", function(){
			self.location = "/purchase/updateTranCode?tranNo="+${purchase.tranNo}+"&tranCode=3";		
		});
		
		//==> 아래와 같이 정의한 이유는 ??
		//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
		$(".ct_list_pop:nth-child(2n+1)" ).css("background-color" , "whitesmoker");
	});	

	//============= prodNo 간략정보 Event  처리 (double Click)=============
/* 	 $(function() {
		 
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(  "td:nth-child(6) > i" ).on("click" , function() {

				var prodNo = $(this).next().val();
			
				$.ajax( 
						{
							url : "/purchase/json/getProduct/"+prodNo ,
							method : "GET" ,
							dataType : "json" ,
							headers : {
								"Accept" : "application/json",
								"Content-Type" : "application/json"
							},
							success : function(JSONData , status) {

								//alert("JSONData : \n"+JSONData);
								
								var displayValue = "<h6>"
															+"상품번호    : "+JSONData.prodNo+"<br/>"
															+"상품명	  : "+JSONData.prodName+"<br/>"
															+"상품이미지 : "+JSONData.fileName+"<br/>"
															+"상세정보    : "+JSONData.prodDetail+"<br/>"
															+"제조일자    : "+JSONData.manuDate+"<br/>"
															+"가 격	  : "+JSONData.price+"<br/>"
															+"등록일자    : "+JSONData.regDate+"<br/>"
															+"</h6>";
								$("h6").remove();
								$( "#"+prodNo+"" ).html(displayValue);
							}
					});
					////////////////////////////////////////////////////////////////////////////////////////////
				
		});
				
		//==> 아래와 같이 정의한 이유는 ??
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	});	
 */	
	</script>
	
</head>

<body>
	
<!-- ToolBar Start /////////////////////////////////////-->
<jsp:include page="/layout/toolbar.jsp" />
 	<!-- ToolBar End /////////////////////////////////////-->

<!--  화면구성 div Start /////////////////////////////////////-->
<div class="container">
	
<form name="detailForm" action="/purchase/listPurchase" method="post">
<form name="menu" value=${param.menu } type="hidden"/>

	<div class="page-header text-info">
	      <h3>구매 목록조회</h3>
	</div>
   
<!-- table 위쪽  Start /////////////////////////////////////-->
	<div class="row">
   
	    <div class="col-md-6 text-left">
	    	<p class="text-primary">
	    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
	    	</p>
	    </div> 
	    <div class="col-md-6 text-right">	    		  
			  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
			  	  
	   	</div>  	
	</div>
<!-- table 위쪽  Start /////////////////////////////////////-->

 
<!--  table Start /////////////////////////////////////-->
	<table class="table table-hover table-striped" >
    
      <thead>
        <tr>
          <th align="center">No</th>         
          <th align="left">회원ID</th>
		  <th align="left">상품명</th>                     
          <th align="left">회원명</th>
          <th align="left">전화번호</th>
          <th align="left">배송현황</th>
          <th align="left">정보수정</th>
        </tr>
	</thead>
     
	<tbody>
	  <c:set var="i" value="0" />
	  <c:forEach var="purchase" items="${list}">
		<c:set var="i" value="${ i+1 }" />
		<tr>
		  <td align="center">
			<c:if test="${purchase.tranCode == '1' }">
				<input type="hidden" value="${purchase.tranNo}">
				${i}
			</c:if>
			<c:if test="${purchase.tranCode != '1'}">
				<input type="hidden" value="${purchase.tranNo}">
				${i}
			</c:if>		 
		  </td>
		  <td id="buyer" align="left" title="Click : 회원상세정보 확인">${buyer}
		  </td>
		  <td align="left">${purchaseProd.prodName}</td>					
		  <td align="left">${purchase.receiverName}</td>
		  <td align="left">${purchase.receiverPhone}</td>
		  <td align="left">현재	
			<c:choose>
				<c:when test="${purchase.tranCode == '1  '}">
					구매완료 
				</c:when>
				
				<c:when test="${purchase.tranCode == '2  '}">
					배송중
				</c:when>
				<c:when test="${purchase.tranCode == '3  '}">
					배송완료
				</c:when>
				
				<c:otherwise>
				 	purchase.tranCode가 1 ~3 이 아닙니다.
		 		</c:otherwise>
			</c:choose>
				상태 입니다.
			</td>
		  
		  <td align="left" id="arrive">
			  <c:if test="${purchase.tranCode == '2  '}">
				<a href="/purchase/updateTranCode?tranNo=${purchase.tranNo }&tranCode=3">물건도착</a>
			  </c:if>
		  </td>
		
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${purchase.tranNo}"></i>
			  	<input type="hidden" value="${purchase.tranNo}">
			  </td>
			
		</tr>
	   </c:forEach>
      
	</tbody>
    
    </table>
 <!--  table End /////////////////////////////////////-->
  
</div>
<!--  화면구성 div End /////////////////////////////////////-->
<input type="hidden" id="currentPage" name="currentPage" value=""/>
<jsp:include page="../common/pageNavigator_new.jsp"/>
<!-- PageNavigation End... -->

</form>
</body>
</html>