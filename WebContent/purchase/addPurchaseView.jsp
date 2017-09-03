<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	
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
   
   	<!-- Favicons -->
	<link rel="apple-touch-icon-precomposed" sizes="144x144" href="../assets/ico/apple-touch-icon-144-precomposed.png">
	<link rel="shortcut icon" href="../assets/ico/favicon.png">
   
   
    <!-- Bootstrap Dropdown Hover JS -->
   	<script src="/javascript/bootstrap-dropdownhover.min.js"></script>

	<!-- JQUERY Date Picker -->
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  	<link rel="stylesheet" href="/resources/demos/style.css">
  	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
 		body {
            padding-top : 50px;
        }
     </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
		
	 function fncAddPurchase(){
			//Form 유효성 검증
		 	var receiverName = document.addPurchase.receiverName.value;
			var receiverPhone = document.addPurchase.receiverPhone.value;
			var dlvyAddr = document.addPurchase.dlvyAddr.value;
			var dlvyDate = document.addPurchase.dlvyDate.value;
	
		 	var receiverName = $("input[name='receiverName']").val();
			var receiverPhone = $("input[name='receiverPhone']").val();
			var dlvyAddr = $("input[name='dlvyAddr']").val();
			var dlvyDate = $("input[name='dlvyDate']").val();

			
			if(receiverName == null || receiverName.length<1){
				alert("구매자이름은 반드시 입력하여야 합니다.");
				return;
			}
			if(receiverPhone == null || receiverPhone.length<1){
				alert("연락처는 반드시 입력하여야 합니다.");
				return;
			}
			if(dlvyAddr == null || dlvyAddr.length<1){
				alert("주소는 반드시 입력하셔야 합니다.");
				return;
			}
			if(dlvyDate == null || dlvyDate.length<1){
				alert("배송희망일자는 반드시 입력하셔야 합니다.");
				return;
			}
	
			$("form").attr("method", "POST").attr("action", "/purchase/addPurchase").submit();	
		 };
		
	 	$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $( "button.btn.btn-primary" ).on("click" , function() {			
				fncAddPurchase();
			});
		});	 
			
	 	$(function() {
			//==> DOM Object GET 3가지 방법 ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
			//==> 1 과 3 방법 조합 : $("tagName.className:filter함수") 사용함.	
			 $( "td.ct_btn01:contains('취소')" ).on("click" , function() {			
				 history.go(-1);
			});
		});	 
	 	 
		
		$( function() {
		    $( "#dlvyDate" ).datepicker({
		      showOn: "button",
		      buttonImage: "../images/ct_icon_date.gif",
		      buttonImageOnly: true,		     
		      dateFormat: 'yymmdd',
		    });
		});

	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	<form class="form-horizontal" name="addPurchase" method="post" enctype="multipart/form-data">
		<input type="hidden" name="prodNo" value="${product.prodNo}" />
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
	
		<div class="page-header">
	       <h3 class=" text-info">상품구매정보</h3>
	       <h5 class="text-muted">상품 구매정보를 <strong class="text-danger">확인</strong>해 주세요.</h5>
	    </div>
	
		<div class="row">
	  		<div class="col-xs-4 col-md-2"><strong>상품 번호</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodNo}</div>
		</div>
		
		<br/>

  		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>상품명</strong></div>
			<div class="col-xs-8 col-md-4">${product.prodName}</div>
		</div>
		
		<br/>
		
		<div class="row">
			<table width="1400" border="0" >
		  		<div class="col-xs-4 col-md-2 "><strong>상품상세정보</strong></div>
				<div class="col-xs-8 col-md-4">${ product.prodDetail }</div>								
			</table>		
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>제조일자</strong></div>
			<div class="col-xs-8 col-md-4">${ product.manuDate }</div>
		</div>
	
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>가격</strong></div>
			<div class="col-xs-8 col-md-4">${product.price}</div>
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>등록일자</strong></div>
			<div class="col-xs-8 col-md-4">${product.regDate}</div>
		</div>
		
		<br/>
 	
		<div class="row" name = "Id">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자아이디</strong></div>
			<div class="col-xs-8 col-md-4">${ user.userId }</div>
			<input type="hidden" name="buyerId" value="${user.userId}" />
		</div>
		
		<br/>
		
 		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매방법</strong></div>			
				<select name="paymentOption" class="ct_input_g" style="width: 100px; height: 19px" maxLength="20">
					<option value="1" selected="selected">현금구매</option>
					<option value="2">신용구매</option>
				</select>		
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자이름</strong></div>
			<div class="col-xs-8 col-md-4">
				<input type="text" name="receiverName" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" value="${user.userName}" />
			</div>
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자연락처</strong></div>
			<div class="col-xs-8 col-md-4">
				<input 	type="text" name="receiverPhone" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" value="${user.phone}" />			
			</div>
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매자주소</strong></div>
			<div class="col-xs-8 col-md-4">
				<input 	type="text" name="dlvyAddr" class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" 	value="${user.addr}" />
			</div>
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>구매요청사항</strong></div>
			<div class="col-xs-8 col-md-4">
				<input	type="text" name="dlvyRequest" 	class="ct_input_g" 
						style="width: 100px; height: 19px" maxLength="20" />
			</div>
		</div>
		
		<br/>
		
		<div class="row">
	  		<div class="col-xs-4 col-md-2 "><strong>배송희망일자</strong></div>
			<div class="col-xs-8 col-md-4">				
				<p><input type="text" readonly="readonly" readonly="readonly" id="dlvyDate" name="dlvyDate" placeholder="달력을 클릭해주세요"></p>						
			</div>
		</div> 
 		
		<br/>
		
		<div class="row">
	  		<div class="col-md-12 text-center ">
	  			<button type="button" class="btn btn-primary"  >구 &nbsp;매</button>
			 	<a class="btn btn-primary btn" title="상세목록조회" href="#" role="button">이&nbsp;전</a>
	  		
	  		
	  		</div>
		</div>
		
		<br/>
		
 	</div>
 	</form>
 	<!--  화면구성 div Start /////////////////////////////////////-->

</body>

</html>