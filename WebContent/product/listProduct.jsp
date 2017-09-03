<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	<title>${param.menu eq 'search' ? "상품 목록조회" : "상품 관리"}</title>
	
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
		/* document.getElementById("currentPage").value = currentPage; */
		$("#currentPage").val(currentPage)
	   	/* document.detailForm.submit(); */		
	  	$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit(); 
	} 
	//===========================================//
	//==> 추가된부분 : "검색" ,  userId link  Event 연결 및 처리
	 $(function() {
		 
		//==> 검색 Event 연결처리부분
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함. 
		 $( "td.ct_btn01:contains('검색')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('검색')" ).html() );
			fncGetList(1);
		});
	
		//============= prodName에 상세정보  Event  처리(Click) =============	
 		$(  "td:nth-child(2)" ).on("click" , function() {
				//Debug..
				//alert(  $( this ).text().trim() );
				console.log($($(this).find('input')[1]).val());
				/* self.location ="/product/getProduct?prodNo="+$($(this).find('input')).val()+"&menu="+$($(this).find('input')[1]).val() */
				self.location ="/product/getProduct?prodNo="+$($(this).find('input')).val()+"&menu="+$($(this).find('input')[1]).val();

		}); 
				
		//==> 아래와 같이 정의한 이유는 ??
		//==> 아래의 주석을 하나씩 풀어 가며 이해하세요.					
		$(".ct_list_pop:nth-child(2n+1)" ).css("background-color" , "whitesmoker");
		//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
		/* console.log ( $(".ct_list_pop:nth-child(2)" ).html() ); */
		//console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
		//console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 
	});	

	//============= prodNo 간략정보 Event  처리 (double Click)=============
	 $(function() {
		 
		//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		$(  "td:nth-child(6) > i" ).on("click" , function() {

				var prodNo = $(this).next().val();
			
				$.ajax( 
						{
							url : "/product/json/getProduct/"+prodNo ,
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
	
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<form name="detailForm" action="/product/listProduct?menu=${param.menu }" method="post">
		
		<div class="page-header text-info">
	       <h3>${param.menu eq 'search'? "상품 목록조회" : "상품관리" }</h3>
	    </div>
	    
	    <!-- table 위쪽 검색 Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		전체  ${resultPage.totalCount } 건수, 현재 ${resultPage.currentPage}  페이지
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ ! empty search.searchCondition && search.searchCondition eq 0 ? "selected" : "" }>상품명</option>
						<option value="1" ${ ! empty search.searchCondition && search.searchCondition eq 1 ? "selected" : "" }>상품번호</option>
						<option value="2" ${ ! empty search.searchCondition && search.searchCondition eq 2 ? "selected" : "" }>상품가격</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">검색어</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="검색어"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">검색</button>
				  
				  <!-- PageNavigation 선택 페이지 값을 보내는 부분 -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table 위쪽 검색 Start /////////////////////////////////////-->
		
	  
        <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left">상품명</th>           
            <th align="left">가격</th>
            <th align="left">등록일</th>
            <th align="left">현재상태</th>
            <th align="left">간략정보</th>
          </tr>
        </thead>
       
		<tbody>
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr id="prodName">
			  <td class="ct_list_pop" align="center">${ i }</td>
			  <td align="left" title="Click : 상세정보 확인">${product.prodName}
			  								<input type="hidden" value="${product.prodNo}">
											<input type="hidden" value="${param.menu}">
			  </td>					
			  <td align="left">${ product.price } 원 </td>
			  <td align="left">${ product.regDate }</td>
			  <td align="left">
					
					<%-- <c:if test="${ param.menu eq 'search' }">
						${product.proTranCode ne '' ? "재고없음" : "판매중" }
						<input type="text" value="${product.proTranCode}">
					</c:if> --%>
					
					<%--<c:if test="${param.menu eq 'manage' }">
						<c:choose>
							<c:when test="${product.proTranCode=='1  ' }">
								구매완료 / <a href="/product/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2">배송하기</a>
							</c:when>
							<c:when test="${product.proTranCode=='2  ' }">
								배송중
							</c:when>
							<c:when test="${product.proTranCode=='3  ' }">
								배송완료
							</c:when>
							<c:otherwise>
							 	판매중
					 		</c:otherwise>
						</c:choose>
					</c:if> --%>
	
					<c:if test="${empty product.proTranCode}">
						판매중
					</c:if>		
					<c:if test="${!empty product.proTranCode}">				
					
						<c:if test="${sessionScope.user.role=='admin'}">
							<c:choose >
								<c:when test="${product.proTranCode=='1  ' }">								
									구매완료 &nbsp; 
									<a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2">배송하기</a>
								</c:when>
		
								<c:when test="${product.proTranCode=='2  ' }">
									배송중 
								</c:when>
								<c:otherwise>
									배송완료
								</c:otherwise>
						</c:choose>				
					</c:if>	
							
						<c:if test="${empty sessionScope.user || sessionScope.user.role=='user'}">
							재고없음
						</c:if>	
					</c:if>
 				</td>
			  
			  <td align="left">
			  	<i class="glyphicon glyphicon-ok" id= "${product.prodNo}"></i>
			  	<input type="hidden" value="${product.prodNo}">
			  </td>
			</tr>
          </c:forEach>
        
        </tbody>
      
      </table>
	  <!--  table End /////////////////////////////////////-->
	  
	  
	  
	  
 	</div>
 	<!--  화면구성 div End /////////////////////////////////////-->
 	
 	
 	<!-- PageNavigation Start... -->
<!--  	<table width="100%" border="0" cellspacing="0" cellpadding="0"	style="margin-top:10px;"> -->
<!-- 		<tr> -->
<!-- 			<td align="center"> -->
<!-- 				<input type="hidden" id="currentPage" name="currentPage" value=""/>			 -->
<!-- 				<jsp:include page="../common/pageNavigator.jsp"/>		 -->
<!-- 	    	</td> -->
<!-- 		</tr> -->
<!-- 	</table> -->
	<!-- <input type="hidden" id="currentPage" name="currentPage" value=""/> -->	
	<jsp:include page="../common/pageNavigator_new.jsp"/>
	<!-- PageNavigation End... -->

</form>
</body>

</html>