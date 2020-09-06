<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp" %>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Board Read Page</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Board Read Page</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
					<!-- <div class="panel-heading">Board Register</div> -->
					<div class="panel-body">
						<form role="form" action="/board/modify" method="post">
							<input type="hidden" id="pageNum" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
							<input type="hidden" id="amount" name="amount" value="<c:out value='${cri.amount}'/>"> 	
							<input type="hidden" id="amount" name="keyword" value="<c:out value='${cri.keyword}'/>">  
							<input type="hidden" id="amount" name="type" value="<c:out value='${cri.type}'/>">
							
							<div class="form-group">
								<label>Bno</label>
								<input class="form-control" name='bno'
								       value='<c:out value="${board.bno}"/>' readonly="readonly">
							</div>
							
							<div class="form-group">
								<label>Title</label>
								<input class="form-control" name="title"
									   value='<c:out value="${board.title}"/>'>
							</div>
							
							<div class="form-group">
								<label>Text area</label>
								<textarea class="form-control" rows="3" 
										  name="content"><c:out value="${board.content}"/></textarea>
							</div>
							
							<div class="form-group">
								<label>Writer</label> 
								<input class="form-control" name="writer"
								       value='<c:out value="${board.writer}"/>' readonly="readonly">
							</div>
							
							<div class="form-group">
								<label>RegDate</label> 
								<input class="form-control" name="regDate"
								       value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate}"/>' readonly="readonly">
							</div>
							
							<div class="form-group">
								<label>Update Date</label> 
								<input class="form-control" name="updateDate"
								       value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>' readonly="readonly">
							</div>
							
							<button type="submit" data-oper='modify' 
							        class="btn btn-primary">Modify</button>
							<button type="submit" data-oper='remove' 
							        class="btn btn-danger">Remove</button>
							<button type="submit" data-oper='list' 
							        class="btn btn-info">List</button>        
						</form> 
					</div>
				</div>
			</div>
			<!-- /. col-lg-12 -->
		</div>
		<!-- /. row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  <script>
  //data-oper 속성을 이용한 기능 동작 처리
	$(document).ready(function(){
		var formObj = $("form");
		
		$('button').on("click", function(e){
			//기본적으로 submit 동작 막음
			e.preventDefault();
			
			var operation = $(this).data("oper");
			
			console.log(operation);
			
			if(operation === 'remove'){
				formObj.attr("action", "/board/remove");
			}else if(operation === 'list'){
				//move to list
				formObj.attr("action","/board/list").attr("method","get");
				var pageNumTag = $("input[name='pageNum']").clone();
				var amountTag = $("input[name='amount']").clone();
				var keywordTag = $("input[name='keyword']").clone();
				var typeTag = $("input[name='type']").clone();
				
				formObj.empty();
				formObj.append(pageNumTag);
				formObj.append(amountTag);
				formObj.append(keywordTag);
				formObj.append(typeTag);
			}
			formObj.submit();
		});
	});
  </script>
<%@include file="../includes/footer.jsp" %>