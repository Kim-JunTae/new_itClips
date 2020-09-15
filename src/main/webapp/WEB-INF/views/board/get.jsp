<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="../includes/header.jsp" %>
  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- <!-- Content Header (Page header)
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
      </div>/.container-fluid
    </section> -->

    <!-- Main content -->
    <section class="content">
      <div class="container-fluid">
        <div class="row">	
        	<div class="col-lg-12">
        		<h1 class="page-header">Board Read</h1>
        	</div>
        </div>
        
        <div class="row">	
			<div class="col-lg-12">
				<div class="panel panel-default">
				
					<div class="card-header">Board Read Page</div>
					
					<div class="panel-body">
							
							<div class="form-group">
								<label>boardId</label>
								<input class="form-control" name='boardId'
								       value='<c:out value="${board.boardId}"/>' readonly="readonly">
							</div>
							
							<div class="form-group">
								<label>Title</label>
								<input class="form-control" name="title"
									   value='<c:out value="${board.title}"/>' readonly="readonly">
							</div>
							
							<div class="form-group">
								<label>Text area</label>
								<textarea class="form-control" rows="3" name="content" 
								          readonly="readonly"><c:out value="${board.content}"/></textarea>
							</div>
							
							<div class="form-group">
								<label>Writer</label> 
								<input class="form-control" name="writer"
								       value='<c:out value="${board.writer}"/>' readonly="readonly">
							</div>
							
							<button data-oper='modify' class="btn btn-primary">Modify</button>
							
							<button data-oper='list' class="btn btn-info">List</button>
							        
							<form id="operForm" action="/board/modify" method="get">
								<input type="hidden" id="boardId" name="boardId" value="<c:out value='${board.boardId}'/>"> 
								<input type="hidden" id="pageNum" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
								<input type="hidden" id="amount" name="amount" value="<c:out value='${cri.amount}'/>">  
								<input type="hidden" id="amount" name="keyword" value="<c:out value='${cri.keyword}'/>">  
								<input type="hidden" id="amount" name="type" value="<c:out value='${cri.type}'/>">  		
							</form>        
					</div>
				</div>
			</div><!-- /. col-lg-12 -->
		</div><!-- /. row -->
	</div>
		
	<div class="container-fluid">
		<div class="row">
			<div class="col-lg-12">
				<div class="card card-default">
					<div class="card-header">
						<i class="fa fa-comments fa-fw"></i>
						Reply
						<button id='addReplyBtn' class='btn btn-primary btn-xs float-right'>New Reply</button>
					</div>
					
					<div class="card-body">
						<ul class="chat">
						<!-- Start Reply -->
							<!-- <li class="left clearfix" data-rno='12'>
								<div>
									<div class="card-header">
										<strong class="primary-font">user00</strong>
										<small class="pull-right text-muted">2020-09-06 13:25</small>
									</div>
									<p>Good Job!</p>
								</div>
							</li> -->
						<!-- End Reply -->
						</ul>
					</div>
					<!-- 추가 -->
					<div class="card-footer"></div>
				</div>
			</div>
		</div>
      </div><!-- /.container-fluid -->
    </section><!-- /.content -->
  </div>
  <!-- /.content-wrapper -->
  
  <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
       aria-labelledby="myModalLabel" aria-hidden="true">
     <div class="modal-dialog">
       <div class="modal-content">
         <div class="modal-header">
           <h4 class="modal-title">REPLY Modal</h4>
           <button type="button" class="close" data-dismiss="modal" aria-label="Close">
             <span aria-hidden="true">&times;</span>
           </button>
         </div>
         <div class="modal-body">
           <div class="form-group">
           	<label>Reply</label>
           	<input class="form-control" name="reply" value="new Reply">
           </div>
           <div class="form-group">
           	<label>Replyer</label>
           	<input class="form-control" name="replyer" value="replyer">
           </div>
           <div class="form-group">
           	<label>Reply Date</label>
           	<input class="form-control" name="replyDate" value="">
           </div>
         </div>
         <div class="modal-footer justify-content-between">
           <button id="modalModBtn" type="button" class="btn btn-warning">Modify</button>
           <button id="modalRemoveBtn" type="button" class="btn btn-danger">Remove</button>
           <button id="modalCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
           <button id="modalRegisterBtn" type="button" class="btn btn-primary" data-dismiss="modal">Register</button>
         </div>
       </div>
       <!-- /.modal-content -->
     </div>
     <!-- /.modal-dialog -->
   </div>
   <!-- /.modal -->
   
  <script type="text/javascript" src="/resources/admin/js/reply.js"></script>
  <script type="text/javascript">
  
  	//console.log("===================================");
  	//console.log("JS TEST");
  	
  	//var bnoValue = '<c:out value="${board.bno}"/>';
  	
  	/* //for replyService add test
  	replyService.add(
  		{reply:"JS TEST", replyer:"tester", bno:bnoValue},
  		function(result){
  			alert("RESULT : " + result);
  		}
  	); */
  	
  	/* //for replyService getList test
  	replyService.getList({bno:bnoValue, page:1}, function(list){
  		for(var i = 0, len = list.length || 0; i < len; i++){
  			console.log(list[i]);
  		}
  	}); */
  	
  	/* //for replyService delete test , 24번 댓글 삭제 테스트
  	replyService.remove(24, function(count){
  		console.log(count);
  		
  		if(count === 'success'){
  			alert("REMOVED");
  		}
  	}, function(err){
  		alert("ERROR...");
  	}); */
  	
  	/* //for replyService update test, 23번 댓글 수정
  	replyService.update({
  		rno : 23,
  		bno : bnoValue,
  		reply : "Modified Reply..."
  	}, function(result){
  		alert("수정 완료...");
  	});
  	
  	replyService.get(10, function(data){
  		console.log(data);
  	}); */
  	
	$(document).ready(function(){
		var boardIdValue = '<c:out value="${board.boardId}"/>';
		var replyUL = $(".chat");
		
		showList(1);
		
		function showList(page){
			
			console.log("show list " + page);
			
			replyService.getList({boardId:boardIdValue, page: page||1}, 
			function(replyCnt, list){
				
				console.log("replyCnt : " + replyCnt);
				console.log("list : " + list);
				console.log(list);
				
				if(page == -1){
					pageNum = Math.ceil(replyCnt/10.0);
					showList(pageNum);
					return;
				}
				
				var str="";
				if(list == null || list.length == 0){
					//replyUL.html("");
					return;
				}
				
				for(var i = 0, len =list.length || 0; i <len; i++){
					str +="<li class='left clearfix' data-replyId='"+list[i].replyId+"'>";
					str +=" <div><div class='header'><strong class='primary-font'>[" 
							+ list[i].replyId +"] " 
							+ list[i].replyer+"</strong>";
					str +="  <small class='pull-right text-muted'>"+replyService.displayTime(list[i].replyDate)+"</small></div>";
					str +="   <p>"+list[i].reply+"</p></div></li><hr>";
				}
				
				replyUL.html(str);
				
				showReplyPage(replyCnt);
			});
		}//end showList
		
		var modal = $(".modal");
		var modalInputReply = modal.find("input[name='reply']");
		var modalInputReplyer = modal.find("input[name='replyer']");
		var modalInputReplyDate = modal.find("input[name='replyDate']");
		
		var modalModBtn = $("#modalModBtn");
		var modalRemoveBtn = $("#modalRemoveBtn");
		var modalRegisterBtn = $("#modalRegisterBtn");
		
		$("#addReplyBtn").on("click", function(e){
			modal.find("input").val("");
			modalInputReplyDate.closest("div").hide();
			modal.find("button[id !='modalCloseBtn']").hide();
			
			modalRegisterBtn.show();
			
			$(".modal").modal("show");
		});
		
		//댓글 쓰기
		modalRegisterBtn.on("click", function(e){
			var reply = {
				reply: modalInputReply.val(),
				replyer: modalInputReplyer.val(),
				boardId:boardIdValue
			};
			
			replyService.add(reply, function(result){
				alert(result);
				modal.find("input").val("");
				modal.modal("hide");
				
				//showList(1);
				showList(-1);
			});
		});
		
		//댓글 클릭
		$(".chat").on("click", "li", function(e){
			var replyId = $(this).data('replyId');
			//console.log(rno);
			
			replyService.get(replyId, function(reply){
				modalInputReply.val(reply.reply);
				modalInputReplyer.val(reply.replyer);
				modalInputReplyDate.val(replyService.displayTime(reply.replyDate))
				.attr("readonly","readonly");
				modal.data("replyId", reply.replyId);
				
				modal.find("button[id != 'modalCloseBtn']").hide();
				modalModBtn.show();
				modalRemoveBtn.show();
				
				$(".modal").modal("show");
			});
		});
		
		//댓글 수정
		modalModBtn.on("click", function(e){
			var reply = {
				replyId:modal.data("replyId"),
				reply:modalInputReply.val()
			};
			
			replyService.update(reply, function(result){
				alert(result);
				modal.modal("hide");
				
				showList(pageNum);
			});
		});
		
		//댓글 삭제
		modalRemoveBtn.on("click", function(e){
			var replyId = modal.data("replyId");
						
			replyService.remove(replyId, function(result){
				alert(result);
				modal.modal("hide");
				
				showList(pageNum);
			});
		});
		
		//댓글 페이지 번호 출력
		var pageNum = 1;
		var replyPageFooter = $(".card-footer");
		
		function showReplyPage(replyCnt){
			
			var endNum = Math.ceil(pageNum/10.0)*10;
			var startNum = endNum - 9;
			
			var prev = startNum != 1;
			var next = false;
			
			if(endNum * 10 >= replyCnt){
				endNum = Math.ceil(replyCnt/10.0);
			}
			
			if(endNum * 10 < replyCnt){
				next = true;
			}
			
			var str = "<ul class='pagination float-right'>";
			
			if(prev){
				str += "<li class='page-item'><a class='page-link' href='"+(startNum-1)+"'>Previous</a></li>";
			}
			
			for(var i = startNum; i <= endNum; i++){
				var active = pageNum == i ? "active":"";
				str += "<li class='page-item "+active+" '><a class='page-link' href='" + i + "'>"+i+"</a></li>";
			}
			
			if(next){
				str += "<li class='page-item'><a class='page-link' href='"+(endNum+1)+"'>Next</a></li>";
			}
			
			str += "</ul></div>";
			
			console.log(str);
			
			replyPageFooter.html(str);
		}
		
		replyPageFooter.on("click", "li a", function(e){
			e.preventDefault();
			console.log("page click");
			
			var targetPageNum = $(this).attr("href");
			
			console.log("targetPageNum : " + targetPageNum);
			
			pageNum = targetPageNum;
			
			showList(pageNum);
		});
		
		
		
	});
  </script>
  
  <script>
  //data-oper 속성을 이용한 기능 동작 처리
	$(document).ready(function(){
		var operForm = $("#operForm");
		
		$('button[data-oper="modify"]').on("click", function(e){
			operForm.attr("action", "/board/modify").submit();
		});
		
		$('button[data-oper="list"]').on("click", function(e){
			operForm.find("#boardId").remove();
			operForm.attr("action", "/board/list").submit();
		});
	});
  </script>
<%@include file="../includes/footer.jsp" %>