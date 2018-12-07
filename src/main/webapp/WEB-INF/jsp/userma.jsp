<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="description" content="">
<meta name="author" content="ThemeBucket">
<title>Welcome</title>
<script src="/bmlfms/plugin/script/jquery-1.10.2.min.js"></script>
<link href="/bmlfms/plugin/css/style.css" rel="stylesheet">
<link href="/bmlfms/plugin/css/style-responsive.css" rel="stylesheet">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
  <script src="/bmlfms/plugin/script/html5shiv.js"></script>
  <script src="/bmlfms/plugin/script/respond.min.js"></script>
  <![endif]-->
<script>
	$(document).ready(function() {
		if(!<%=session.getAttribute("role_id")%>){
			alert("登录信息过期，请登录");
			location.href = "/bmlfms/login"
		}else{
		var role_id = '<%=session.getAttribute("role_id")%>';
		var account_name = '<%=session.getAttribute("account_name")%>' ;
		$("#account_name").html(account_name+'<span class="caret"></span>');
		$("#account_name2").html(account_name+'<span class="caret"></span>');
		$.ajax({
			url : "/bmlfms/menux",
			data : {
				i : role_id
			},
			type : "post",
			dataType : "json",
			success : function(data) {
				console.log(data);
				$.each(data,function(i,v){  
					var $li; 
					if(v.pid==0){
						$li='<li class="menu-list"><a href="#"><i class="'+v.icon+'"></i><span>'+v.menuText+'</span></a><ul class="sub-menu-list"></ul></li>';
						$("#menuBar").append($li);
					}if(v.children && v.children.length > 0){ 
						var m= $("#menuBar li:last ul")
						$.each(v.children,function(ii,vv){ 
						m.append('<li><a href="'+vv.url+'"> '+vv.menuText+'</a></li>') 
						})  
						
					} 
					
				})

			},
			error : function() {
				console.log("失败");
			}
		})
		 jQuery('#menuBar').on("click",".menu-list > a",function() {
		      
		      var parent = jQuery(this).parent();
		      var sub = parent.find('> ul');
		      
		      if(!jQuery('body').hasClass('left-side-collapsed')) {
		         if(sub.is(':visible')) {
		            sub.slideUp(200, function(){
		               parent.removeClass('nav-active');
		               jQuery('.main-content').css({height: ''});
		               mainContentHeightAdjust();
		            });
		         } else {
		            visibleSubMenuClose();
		            parent.addClass('nav-active');
		            sub.slideDown(200, function(){
		                mainContentHeightAdjust();
		            });
		         }
		      } 
		      return false;
		   });
		
		
		
		$("#upanel").on("click","#edit",function(){
			$("#u1").val($(this).parent().parent().children().eq(0).text());
			$("#u2").val($(this).parent().parent().children().eq(1).text());
			$("#u3").val($(this).parent().parent().children().eq(2).text());
			if($(this).parent().parent().children().eq(3).text().trim()=="男"){
				$("input:radio[value='0']").attr('checked', true)
			}else{
				$("input:radio[value='1']").attr('checked', true)
			}
			$("#u5").val($(this).parent().parent().children().eq(4).text());
			if($(this).parent().parent().children().eq(5).text().trim()=="审核未通过"){
				$("#vpass").attr("disabled",false); 
			}else{ 
				$("#vpass").attr("disabled",true); 
			} 
		})
		 
		$("#edsub").on("click",function(){
			$.ajax({ 
				url : "/bmlfms/usered",
				data : $(".form-horizontal").serialize(),
				type : "post",
				dataType : "json",
				success : function(data) {
					location.href = "/bmlfms/jump/jumpuser";
				},
				error : function() { 
					console.log("失败");
				}
			})
		})
		
		$("#vpass").on("click",function(){
			var eid=$("#u1").val().trim();
			$.ajax({ 
				url : "/bmlfms/vpass",
				data : {id:eid},
				type : "post",
				dataType : "json",
				success : function(data) {
					location.href = "/bmlfms/jump/jumpuser";
				},
				error : function() {
					console.log("失败");
				}
			})
			
		})
		
		
		}
	}) 
	   function mainContentHeightAdjust() {
      var docHeight = jQuery(document).height();
      if(docHeight > jQuery('.main-content').height())
         jQuery('.main-content').height(docHeight); 
   } 
		   function visibleSubMenuClose() {
		      jQuery('.menu-list').each(function() {
		         var t = jQuery(this); 
		         if(t.hasClass('nav-active')) {
		            t.find('> ul').slideUp(200, function(){
		               t.removeClass('nav-active');
		            });
		         }
		      });
		   }
</script>

</head>
<body class="sticky-header">

	<section> <!-- left side start-->
	<div class="left-side sticky-left-side">

		<!--logo and iconic logo start-->
		<div class="logo">
			<a href="welcome"><img src="/bmlfms/img/logo.png" alt=""></a>
		</div>

		<div class="logo-icon text-center">
			<a href="welcome"><img src="/bmlfms/img/logo_icon.png" alt=""></a>
		</div>
		<!--logo and iconic logo end-->


		<div class="left-side-inner">

			<!-- visible to small devices only -->
			<div class="visible-xs hidden-sm hidden-md hidden-lg">
				<div class="media logged-user">
					<div class="media-body">
						<h4>
							<a href="#" id="account_name2">John Doe</a>
						</h4>
						<span>"Hello There..."</span>
					</div>
				</div>

				<h5 class="left-nav-title">Account Information</h5>
				<ul class="nav nav-pills nav-stacked custom-nav">
					<li><a href="#"><i class="fa fa-user"></i> <span>Profile</span></a></li>
					<li><a href="#"><i class="fa fa-cog"></i> <span>Settings</span></a></li>
					<li><a href="#"><i class="fa fa-sign-out"></i> <span>Sign
								Out</span></a></li>
				</ul>
			</div>

			<!--sidebar nav start-->
			<ul class="nav nav-pills nav-stacked custom-nav" id="menuBar">
				<li id="welcomeli"><a href="welcome"><i class="fa fa-home"></i> <span>主页</span></a></li>
				
				
			</ul>
			<!--sidebar nav end-->

		</div>
	</div>
	<!-- left side end--> <!-- main content start-->
	<div class="main-content">

		<!-- header section start-->
		<div class="header-section">

			<!--toggle button start-->
			<a class="toggle-btn"><i class="fa fa-bars"></i></a>
			<!--toggle button end-->

			<!--notification menu start -->
			<div class="menu-right">
				<ul class="notification-menu">
					<li><a href="#"
						class="btn btn-default dropdown-toggle info-number"
						data-toggle="dropdown"> <i class="fa fa-tasks"></i>
					</a></li>
					<li><a href="#"
						class="btn btn-default dropdown-toggle info-number"
						data-toggle="dropdown"> <i class="fa fa-envelope-o"></i>
					</a></li>
					<li><a href="#"
						class="btn btn-default dropdown-toggle info-number"
						data-toggle="dropdown"> <i class="fa fa-bell-o"></i>
					</a></li>
					<li>Hello!<a href="#" class="btn btn-default dropdown-toggle"
						data-toggle="dropdown" id="account_name"> John Doe <span class="caret"></span>
					</a>
						<ul class="dropdown-menu dropdown-menu-usermenu pull-right">
							<li><a href="#"><i class="fa fa-user"></i> Profile</a></li>
							<li><a href="#"><i class="fa fa-cog"></i> Settings</a></li>
							<li><a href="logout"><i class="fa fa-sign-out"></i> Log Out</a></li>
						</ul></li>

				</ul>
			</div>
			<!--notification menu end -->

		</div>
		<!-- header section end-->

		<!-- page heading start-->
		<div class="page-heading">用户管理</div>
		<!-- page heading end-->

		<!--body wrapper start-->
		<div class="wrapper">
	 			
	 			<table border="1" style="text-align:center;margin-left:30px"> 
					<strong>按姓名搜索：</strong>
						<form action="userTable" method="get" class="form-search"> 
							<input class="input-medium search-query" name="queryCondition" 
								value="${page.queryCondition}" id="condition" type="text">
							<button class="btn btn-info" type="submit">查询</button>
						</form>
					</table> 
	 			<section class="panel">
                    <header class="panel-heading">
                        用户信息表
                            <span class="tools pull-right">
                                <a href="javascript:;" class="fa fa-chevron-down"></a>
                             </span>
                    </header>
                    <div class="panel-body" id="upanel">
                        <table class="table table-striped">
                            <thead> 
                            <tr>
                                <th>用户名</th>
                                <th>真实姓名</th>
                                <th>年龄</th>
                                <th>性别</th>
                                <th>邮箱</th>
                                <th>状态</th>
                                <th>操作</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${user_Tables}" var="u">
                            <tr>
                                <td>${u.userName}</td>
                                <td>${u.realName}</td>
                                <td>${u.age}</td>
                                <td>  <c:if test="${u.gender=='0' }">
      							 男
   								</c:if><c:if test="${u.gender=='1' }">
      							女
   								</c:if>
   								</td>
                                <td>${u.email}</td>
                                <td><c:if test="${u.state=='1' }">
      							 审核通过
   								</c:if><c:if test="${u.state=='0' }">
      							 审核未通过
   								</c:if></td>
   								<td><a href="#myModal" data-toggle="modal" id="edit">修改</a></td>
                               
                            </tr>
                            </c:forEach>
                          
                            </tbody>
                        </table>
                    </div>
					<center>  
						<label>第${page.currentPage}/${page.totalPage}页
							共${page.totalRows}条</label> <a href="userTable?currentPage=0">首页</a> <a
							href="userTable?currentPage=${page.currentPage-1}" 
							onclick="return checkFirst()">上一页</a> <a 
							href="userTable?currentPage=${page.currentPage+1}"
							onclick="return checkNext()">下一页</a> <a
							href="userTable?currentPage=${page.totalPage}">尾页</a> 跳转到: <input
							type="text" style="width:30px" id="turnPage" />页 <button
							class="btn"  onclick="startTurn()">跳转</button>
					</center>
                </section>

<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header"> 
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title">用户修改</h4>
                                        </div>

                                        <div class="modal-body row">
                                        <section class="panel">
                    <header class="panel-heading">
                       用户信息
                    </header>
                    <div class="panel-body">
                        <form class="form-horizontal" role="form">
                            <div class="form-group">
                                <label class="col-lg-3 col-sm-3 control-label">用户名:</label>
                                <div class="col-lg-9">
                                    <div class="iconic-input">
                                        <input type="text" name="userName" id="u1" class="form-control" placeholder="用户">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 col-sm-3 control-label">真实姓名:</label>
                                <div class="col-lg-9">
                                    <div class="iconic-input right">   
                                        <input type="text" name="realName" id="u2"  class="form-control" placeholder="真实姓名">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-lg-3 col-sm-3 control-label">年龄:</label> 
                                <div class="col-lg-9">
                                    <div class="iconic-input right">  
                                        <input type="text" name="age" id="u3"  class="form-control" placeholder="年龄">
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">性别:</label>
                                <div class="col-lg-9">
                                    <div class="iconic-input right">
                                    男<input type="radio" name="gender" value="0"/>
                                    女<input type="radio" name="gender" value="1"/>


                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">邮箱:</label>
                                <div class="col-lg-9">
                                    <div class="iconic-input right">
                                        <input type="text" name="email" id="u5"  class="form-control" placeholder="邮箱">
                                    </div>
                                </div>
                            </div> 
                            
                        </form>
                    </div> 
                </section>					<button type="button" id="vpass" class="btn btn-primary btn-lg btn-block">通过审核</button>
                                        	<button type="button" id="edsub" class="btn btn-primary btn-lg btn-block">提交修改</button>
                                        </div> 
 
                                    </div>
                                </div>
                            </div>
                            <!-- edit END -->


</div>
		<!--body wrapper end-->

		<!--footer section start-->
		<footer class="sticky-footer"> </footer>
		<!--footer section end-->


	</div>
	<!-- main content end--> </section>


	<script src="/bmlfms/plugin/script/jquery-ui-1.9.2.custom.min.js"></script>
	<script src="/bmlfms/plugin/script/jquery-migrate-1.2.1.min.js"></script>
	<script src="/bmlfms/plugin/script/bootstrap.min.js"></script>
	<script src="/bmlfms/plugin/script/modernizr.min.js"></script>
	<script src="/bmlfms/plugin/script/jquery.nicescroll.js"></script>


	<script src="/bmlfms/plugin/script/scripts.js"></script>
	<script type="text/javascript">
    
    function checkFirst(){
         if(${page.currentPage>1}){
         
           return true;
         
         }
         alert("已到页首,无法加载更多");
        
       return false;
    }
    
    function checkNext(){
    
    if(${page.currentPage<page.totalPage}){
    
      return true;
    
    }
    alert("已到页尾，无法加载更多页");
    return false;
    
    }
     
    
    function startTurn(){
    
    var turnPage=document.getElementById("turnPage").value;
    
    if(turnPage>${page.totalPage}){
    
      alert("对不起已超过最大页数");
     
      return false;
    
    }
    
    var shref="initt.do?currentPage="+turnPage;
    
    window.location.href=shref;
}
</script>
</body>
</html>