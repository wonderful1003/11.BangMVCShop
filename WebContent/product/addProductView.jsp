<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="UTF-8"%>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
	
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
	
	<title>상품등록</title>
	
	<link rel="stylesheet" href="/css/admin.css" type="text/css">
	
	<script type="text/javascript" src="../javascript/calendar.js"></script>
	<script type="text/javascript">

	 function fncAddProduct(){
		//Form 유효성 검증
	
		var name = $("input[name='prodName']").val();
		var detail = $("input[name='prodDetail']").val();
		var manuDate = $("input[name='manuDate']").val();
		var price = $("input[name='price']").val();
		
		if(name == null || name.length<1){
			alert("상품명은 반드시 입력하여야 합니다.");
			return;
		}
		if(detail == null || detail.length<1){
			alert("상품상세정보는 반드시 입력하여야 합니다.");
			return;
		}
		if(manuDate == null || manuDate.length<1){
			alert("제조일자는 반드시 입력하셔야 합니다.");
			return;
		}
		if(price == null || price.length<1){
			alert("가격은 반드시 입력하셔야 합니다.");
			return;
		}
	
		$("form").attr("method" , "POST").attr("action" , "/product/addProduct").submit();
	 
	 }

 
	//============= "등록"  Event 연결 =============
	 $(function() {
		$( "button.btn.btn-primary" ).on("click" , function() {
			fncAddProduct();
		});
	});	
	
 	
	//==> 추가된부분 : "취소"  Event 연결 및 처리
	 $(function() {
		 $("a[href='#' ]").on("click" , function() {
			$("form")[0].reset();
		});
	});

	$( function() {
	    $( "#manuDate" ).datepicker({
	      showOn: "button",
	      buttonImage: "../images/ct_icon_date.gif",
	      buttonImageOnly: true,
	    });
	});
		
	</script>
	
</head>

<body>

	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  화면구성 div Start /////////////////////////////////////-->
	<div class="container">
		
		<h1 class="text-center"><span class="label label-default">상품등록</span></h1>
		<br/>
	
		<!-- form Start /////////////////////////////////////-->
		<form class="form-horizontal" enctype="multipart/form-data">
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->		
		  <div class="form-group">
		    <label for="prodName" class="col-sm-offset-1 col-sm-3 control-label">상품명</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodName" name="prodName" placeholder="상품명을 입력하세요" >
		    </div>
		  </div>
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->		  
		  <div class="form-group">
		    <label for="prodDetail" class="col-sm-offset-1 col-sm-3 control-label">상품상세정보</label>
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="prodDetail" name="prodDetail" placeholder="상품상세정보">
		    </div>
		  </div>
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->		  
		  <div class="form-group">
		    <label for="manuDate" class="col-sm-offset-1 col-sm-3 control-label">제조일자</label>
		    <div class="col-sm-4">
			<p><input type="text" readonly="readonly" readonly="readonly" id="manuDate" name="manuDate" placeholder="달력을 클릭해주세요"></p>
		   
		    </div>
		  </div>
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->		  
		  <div class="form-group">
		    <label for="price" class="col-sm-offset-1 col-sm-3 control-label">가격</label>&nbsp;원				
		    <div class="col-sm-4">
		      <input type="text" class="form-control" id="price" name="price" placeholder="가격을입력하세요">
		    </div>
		  </div>
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->		  
		  <div class="form-group">
		    <label for="fileName" class="col-sm-offset-1 col-sm-3 control-label" >상품이미지</label>
		    <!-- <div class="col-sm-4"> -->
<!-- 		      <input type="file" class="form-control" id="fileName" 
		      style="width:400" name="fileName" placeholder="상품이미지">
 -->		   
				<p><input name="file" id="fileToUpload" type="file" /></p>  				
  
<!-- 			  <div class="fileinput fileinput-new" data-provides="fileinput">
			  <div class="fileinput-preview thumbnail" data-trigger="fileinput" style="width: 200px; height: 150px;"></div>
			  <div class="col-sm-4">
			  <div>
			    <span class="btn btn-default btn-file">
			    <span class="fileinput-new">Select image</span>
			    <span class="fileinput-exists">Change</span>
			    <input type="file" name="file" id="fileToUpload"></span>
			    <a href="#" class="btn btn-default fileinput-exists" data-dismiss="fileinput">Remove</a>
			  </div>
			</div> -->
  

  
		    </div>
		  </div>
<!-- /////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// -->		  		  
		  <div class="form-group">
		    <div class="col-sm-offset-4  col-sm-4 text-center">
		      <button type="button" class="btn btn-primary"  >등 &nbsp;록</button>
			  <a class="btn btn-primary btn" href="#" role="button">취&nbsp;소</a>
		    </div>
		  </div>
		</form>
		<!-- form Start /////////////////////////////////////-->
		
 	</div>
	<!--  화면구성 div end /////////////////////////////////////-->
	
</body>

</html>