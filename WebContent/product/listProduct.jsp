<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">
	
<head>
	<meta charset="EUC-KR">
	<title>${param.menu eq 'search' ? "��ǰ �����ȸ" : "��ǰ ����"}</title>
	
	<!-- ���� : http://getbootstrap.com/css/   ���� -->
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
   
   
   <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	
	<!--  ///////////////////////// CSS ////////////////////////// -->
	<style>
	  body {
            padding-top : 50px;
        }
    </style>
    
     <!--  ///////////////////////// JavaScript ////////////////////////// -->
	<script type="text/javascript">
	
	//�˻� / page �ΰ��� ��� ��� Form ������ ���� JavaScript �̿�
	function fncGetList(currentPage){
		/* document.getElementById("currentPage").value = currentPage; */
		$("#currentPage").val(currentPage)
	   	/* document.detailForm.submit(); */		
	  	$("form").attr("method" , "POST").attr("action" , "/product/listProduct?menu=${param.menu}").submit(); 
	} 
	//===========================================//
	//==> �߰��Ⱥκ� : "�˻�" ,  userId link  Event ���� �� ó��
	 $(function() {
		 
		//==> �˻� Event ����ó���κ�
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
		//==> 1 �� 3 ��� ���� : $("tagName.className:filter�Լ�") �����. 
		 $( "td.ct_btn01:contains('�˻�')" ).on("click" , function() {
			//Debug..
			//alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
			fncGetList(1);
		});
	
		//============= prodName�� ������  Event  ó��(Click) =============	
 		$(  "td:nth-child(2)" ).on("click" , function() {
				//Debug..
				//alert(  $( this ).text().trim() );
				console.log($($(this).find('input')[1]).val());
				/* self.location ="/product/getProduct?prodNo="+$($(this).find('input')).val()+"&menu="+$($(this).find('input')[1]).val() */
				self.location ="/product/getProduct?prodNo="+$($(this).find('input')).val()+"&menu="+$($(this).find('input')[1]).val();

		}); 
				
		//==> �Ʒ��� ���� ������ ������ ??
		//==> �Ʒ��� �ּ��� �ϳ��� Ǯ�� ���� �����ϼ���.					
		$(".ct_list_pop:nth-child(2n+1)" ).css("background-color" , "whitesmoker");
		//console.log ( $(".ct_list_pop:nth-child(1)" ).html() );
		/* console.log ( $(".ct_list_pop:nth-child(2)" ).html() ); */
		//console.log ( $(".ct_list_pop:nth-child(3)" ).html() );
		//console.log ( $(".ct_list_pop:nth-child(4)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(5)" ).html() ); 
		//console.log ( $(".ct_list_pop:nth-child(6)" ).html() ); //==> ok
		//console.log ( $(".ct_list_pop:nth-child(7)" ).html() ); 
	});	

	//============= prodNo �������� Event  ó�� (double Click)=============
	 $(function() {
		 
		//==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
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
															+"��ǰ��ȣ    : "+JSONData.prodNo+"<br/>"
															+"��ǰ��	  : "+JSONData.prodName+"<br/>"
															+"��ǰ�̹��� : "+JSONData.fileName+"<br/>"
															+"������    : "+JSONData.prodDetail+"<br/>"
															+"��������    : "+JSONData.manuDate+"<br/>"
															+"�� ��	  : "+JSONData.price+"<br/>"
															+"�������    : "+JSONData.regDate+"<br/>"
															+"</h6>";
								$("h6").remove();
								$( "#"+prodNo+"" ).html(displayValue);
							}
					});
					////////////////////////////////////////////////////////////////////////////////////////////
				
		});
				
		//==> �Ʒ��� ���� ������ ������ ??
		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
	});	
	
	</script>
	
</head>

<body>
	
	<!-- ToolBar Start /////////////////////////////////////-->
	<jsp:include page="/layout/toolbar.jsp" />
   	<!-- ToolBar End /////////////////////////////////////-->
	
	<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
	<div class="container">
		
		<form name="detailForm" action="/product/listProduct?menu=${param.menu }" method="post">
		
		<div class="page-header text-info">
	       <h3>${param.menu eq 'search'? "��ǰ �����ȸ" : "��ǰ����" }</h3>
	    </div>
	    
	    <!-- table ���� �˻� Start /////////////////////////////////////-->
	    <div class="row">
	    
		    <div class="col-md-6 text-left">
		    	<p class="text-primary">
		    		��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
		    	</p>
		    </div>
		    
		    <div class="col-md-6 text-right">
			    <form class="form-inline" name="detailForm">
			    
				  <div class="form-group">
				    <select class="form-control" name="searchCondition" >
						<option value="0" ${ ! empty search.searchCondition && search.searchCondition eq 0 ? "selected" : "" }>��ǰ��</option>
						<option value="1" ${ ! empty search.searchCondition && search.searchCondition eq 1 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="2" ${ ! empty search.searchCondition && search.searchCondition eq 2 ? "selected" : "" }>��ǰ����</option>
					</select>
				  </div>
				  
				  <div class="form-group">
				    <label class="sr-only" for="searchKeyword">�˻���</label>
				    <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
				    			 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
				  </div>
				  
				  <button type="button" class="btn btn-default">�˻�</button>
				  
				  <!-- PageNavigation ���� ������ ���� ������ �κ� -->
				  <input type="hidden" id="currentPage" name="currentPage" value=""/>
				  
				</form>
	    	</div>
	    	
		</div>
		<!-- table ���� �˻� Start /////////////////////////////////////-->
		
	  
        <!--  table Start /////////////////////////////////////-->
      <table class="table table-hover table-striped" >
      
        <thead>
          <tr>
            <th align="center">No</th>
            <th align="left">��ǰ��</th>           
            <th align="left">����</th>
            <th align="left">�����</th>
            <th align="left">�������</th>
            <th align="left">��������</th>
          </tr>
        </thead>
       
		<tbody>
		  <c:set var="i" value="0" />
		  <c:forEach var="product" items="${list}">
			<c:set var="i" value="${ i+1 }" />
			<tr id="prodName">
			  <td class="ct_list_pop" align="center">${ i }</td>
			  <td align="left" title="Click : ������ Ȯ��">${product.prodName}
			  								<input type="hidden" value="${product.prodNo}">
											<input type="hidden" value="${param.menu}">
			  </td>					
			  <td align="left">${ product.price } �� </td>
			  <td align="left">${ product.regDate }</td>
			  <td align="left">
					
					<%-- <c:if test="${ param.menu eq 'search' }">
						${product.proTranCode ne '' ? "������" : "�Ǹ���" }
						<input type="text" value="${product.proTranCode}">
					</c:if> --%>
					
					<%--<c:if test="${param.menu eq 'manage' }">
						<c:choose>
							<c:when test="${product.proTranCode=='1  ' }">
								���ſϷ� / <a href="/product/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2">����ϱ�</a>
							</c:when>
							<c:when test="${product.proTranCode=='2  ' }">
								�����
							</c:when>
							<c:when test="${product.proTranCode=='3  ' }">
								��ۿϷ�
							</c:when>
							<c:otherwise>
							 	�Ǹ���
					 		</c:otherwise>
						</c:choose>
					</c:if> --%>
	
					<c:if test="${empty product.proTranCode}">
						�Ǹ���
					</c:if>		
					<c:if test="${!empty product.proTranCode}">				
					
						<c:if test="${sessionScope.user.role=='admin'}">
							<c:choose >
								<c:when test="${product.proTranCode=='1  ' }">								
									���ſϷ� &nbsp; 
									<a href="/purchase/updateTranCodeByProd?prodNo=${product.prodNo}&tranCode=2">����ϱ�</a>
								</c:when>
		
								<c:when test="${product.proTranCode=='2  ' }">
									����� 
								</c:when>
								<c:otherwise>
									��ۿϷ�
								</c:otherwise>
						</c:choose>				
					</c:if>	
							
						<c:if test="${empty sessionScope.user || sessionScope.user.role=='user'}">
							������
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
 	<!--  ȭ�鱸�� div End /////////////////////////////////////-->
 	
 	
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