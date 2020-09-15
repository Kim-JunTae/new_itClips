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
            <h1>Board List Page</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="/adminHome">Home</a></li>
              <li class="breadcrumb-item active">Board List Page</li>
            </ol>
          </div>
        </div>
        <div class="row mb-2">
         	<div class="col-sm-12">
         		<ol class="breadcrumb float-sm-right">
      				<li><button id='regBtn' type="button" class="btn btn-primary btn-xs breadcrumb-item">Register New Board</button></li>
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
				<div class="panel-body">
					<table class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>#번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>수정일</th>
							</tr>
						</thead>
						<c:forEach items="${list}" var="board">
							<tr>
								<td><c:out value="${board.boardId}"/></td>
								<td>
									<a class="move" href='<c:out value="${board.boardId}"/>'>
										<c:out value="${board.title}"/>
									</a>
								</td>
								<td><c:out value="${board.writer}"/></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.regdate}"/></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}"/></td>
							</tr>
						</c:forEach>
					</table>
					
					<div class="row">
						<div class="col-lg-12">
							<form id="searchForm" action="/board/list" method="get">
								<select name="type">
									<option value=""><c:out value="${pageMaker.cri.type == null?'selected':''}"/>--</option>
									<option value="T"><c:out value="${pageMaker.cri.type eq 'T'?'selected':''}"/>제목</option>
									<option value="C"><c:out value="${pageMaker.cri.type eq 'C'?'selected':''}"/>내용</option>
									<option value="W"><c:out value="${pageMaker.cri.type eq 'W'?'selected':''}"/>작성자</option>
									<option value="TC"><c:out value="${pageMaker.cri.type eq 'TC'?'selected':''}"/>제목 or 내용</option>
									<option value="TW"><c:out value="${pageMaker.cri.type eq 'TW'?'selected':''}"/>제목 or 작성자</option>
									<option value="TWC"><c:out value="${pageMaker.cri.type eq 'TWC'?'selected':''}"/>제목 or 내용 or 작성자</option>
								</select>
								<input type="text" name="keyword" value="<c:out value='${pageMaker.cri.keyword}'/>" />
							  	<input type="hidden" name="pageNum" value="<c:out value='${pageMaker.cri.pageNum}'/>" />
							  	<input type="hidden" name="amount" value="<c:out value='${pageMaker.cri.amount}'/>"/>
							  	<button class="btn btn-default">Search</button>
							 </form>
						</div>
					</div>
					
				</div>
				<!-- /. panel-body -->
			</div>
			<!-- /. col-lg-12 -->
		</div>
		<!-- /. row -->
		
		<div class="row float-right">
			<!-- 페이징  -->
			<nav aria-label="Page navigation">
				<ul class="pagination float-right">
					<c:if test="${pageMaker.prev}">
						<li class="paginate_button previous page-item">
							<a class="page-link" href="${pageMaker.startPage -1}">Previous</a>
						</li>
					</c:if>
					
					<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
						<li class="paginate_button page-item ${pageMaker.cri.pageNum == num ? 'active':''}">
							<a class="page-link" href="${num}">${num}</a>
						</li>
					</c:forEach>
					
					<c:if test="${pageMaker.next}">
						<li class="paginate_button next page-item">
							<a class="page-link" href="${pageMaker.endPage +1}">Next</a>
						</li>
					</c:if>
				</ul>
			</nav>
			<!-- end Pagination -->
		</div>
		<!-- /. row -->
		
		<div class="row">
			<div class="col-lg-12">
				<div class="panel-body">
					<!-- Modal 추가 -->
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					     aria-labelledby="myModalLabel" aria-hidden="true">
					     <div class="modal-dialog">
					     	<div class="modal-content">
					     		<div class="modal-header">
					     			<h4 class="modal-title" id="myModalLabel">Modal title</h4> 
					     			<button type="button" class="close" data-dismiss="modal"
					     			        aria-hidden="true">&times;</button>      
					     		</div>
					     		<div class="modal-body">처리가 완료되었습니다.</div>
					     		<div class="modal-footer">
					     			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
									<button type="button" class="btn btn-primary">Save changes</button>
					     		</div>
					     	</div>
					     </div>
					</div>
				</div>
				<!-- /. panel-body -->
			</div>
			<!-- /. col-lg-12 -->
		</div>
		<!-- /. row -->
      </div><!-- /.container-fluid -->
    </section>
    <!-- /.content -->
  </div>
  <form id="actionForm" action="/board/list" method="get">
  	<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
  	<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
  	<input type="hidden" name="type" value="${pageMaker.cri.type}">
  	<input type="hidden" name="keyword" value="${pageMaker.cri.keyword}">
  </form>
 
  <!-- /.content-wrapper -->
  <script type="text/javascript">
	$(document).ready(function(){
		var result = '<c:out value="${result}"/>';
	
		checkModal(result);
		
		history.replaceState({},null,null);
		
		function checkModal(result){
			if(result === '' || history.state){
				return;
			}
			
			if(parseInt(result) > 0){
				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}
			
			$("#myModal").modal("show");
		}
		
		$("#regBtn").on("click", function(){
			self.location = "/board/register";
		});
		
		var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			
			console.log('click');
			
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});
		
		$(".move").on("click", function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='boardId' value='"+
					$(this).attr("href")+"'>");
			actionForm.attr("action", "/board/get");
			actionForm.submit();
		});
		
		
		<!--검색-->
		var searchForm = $("#searchForm");
		
		$("#searchForm button").on("click", function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색 종류를 선택하세요");
				return false;
			}
			
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요");
				return false;
			}
			
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			
			searchForm.submit();
		});
	});
  </script>
<%@include file="../includes/footer.jsp" %>
