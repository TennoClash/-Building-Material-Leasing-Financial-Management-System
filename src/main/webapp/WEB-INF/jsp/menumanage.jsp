<%@ page language="java" pageEncoding="UTF-8"%>
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
<script src="/bmlfms/plugin/script/jsencrypt.min.js"></script>
<script src="/bmlfms/plugin/script/jquery-1.10.2.min.js"></script>
<script src="/bmlfms/plugin/script/jquery.treetable.js"></script>

<link href="/bmlfms/plugin/css/style.css" rel="stylesheet">
<link href="/bmlfms/plugin/css/style-responsive.css" rel="stylesheet">
<link href="/bmlfms/plugin/css/jquery.treetable.theme.default.css" rel="stylesheet">

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
		var data1;
		$.ajax({
			url : "/bmlfms/menux",
			data : {
				i : role_id
			},
			type : "post",
			dataType : "json",
			success : function(data) {
				console.log(data);
				data1=data;
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
		$.ajax({
				url : "/bmlfms/menux",
				data : {
					i : 1
				},
				type : "post", 
				dataType : "json",   
				success : function(data) { 
					$.each(data,function(i,v){   
						if(v.pid==0){ 
							
							$tr='<tr data-tt-id="'+v.menuId+'"><td>'+v.menuText+'</td><td>'+v.menuId+'</td><td>'+v.sort+'</td><td></td><td>'+v.url+'</td><td></td><td><i class="'+v.icon+'"></i></td><td></td><td>'+v.state+'</td><td></td><td><a href="#myModal" id="edit" data-toggle="modal">修改 </a>/<a href="#addLevel2" id="add2" data-toggle="modal">添加菜单 </a>/<a href="#" id="mdel" data-toggle="modal">删除 </a></td></tr>';
							$("#treeTable").append($tr); 
						}if(v.children && v.children.length > 0){ 
							$.each(v.children,function(ii,vv){ 
								$tr2='<tr data-tt-id="'+vv.menuId+'" data-tt-parent-id="'+vv.pid+'"><td>'+vv.menuText+'</td><td>'+vv.menuId+'</td><td>'+vv.sort+'</td><td></td><td>'+vv.url+'</td><td></td><td><i class="'+vv.icon+'"></i></td><td></td><td>'+vv.state+'</td><td></td><td><a href="#myModal" id="edit" data-toggle="modal">修改 </a>/<a href="#addLevel2" id="add2" data-toggle="modal">添加菜单 </a>/<a href="#" id="mdel" data-toggle="modal">删除 </a></td></tr>';
								$("#treeTable").append($tr2);
							}) 
						}	
						
					})
					$("#treeTable").treetable({  
				         expandable : true,
				         initialState:"expanded",
				         clickableNodeNames:true,//点击节点名称也打开子节点.
				         indent : 30//每个分支缩进的像素数。
				     });
					 
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
		$("#admin").attr("disabled",true);
		$(".btn-success").on("click",function(){
			$("#treeTable").html("");
			$(this).attr("disabled",true);
			if($(this).attr('id')=="admin"){
				var ii=1;  
				$("#admin").attr("disabled",true);
				$("#user").attr("disabled",false);
			}else{
				$("#admin").attr("disabled",false);
				$("#user").attr("disabled",true);
				var ii=2; 
			}
			$.ajax({
				url : "/bmlfms/menux",
				data : {
					i : ii 
				}, 
				type : "post", 
				dataType : "json",   
				success : function(data) {
					var $top=' <tr id="treeTitle"><th>菜单名称</th> <th>id</th> <th>排序<th><th>URL<th><th>图标<th><th>状态<th><th>操作</th></th></tr>'
						$("#treeTable").append($top);
					$.each(data,function(i,v){   
						if(v.pid==0){ 
							$tr='<tr data-tt-id="'+v.menuId+'"><td>'+v.menuText+'</td><td>'+v.menuId+'</td><td>'+v.sort+'</td><td></td><td>'+v.url+'</td><td></td><td><i class="'+v.icon+'"></i></td><td></td><td>'+v.state+'</td><td></td><td><a href="#myModal" id="edit" data-toggle="modal">修改 </a>/<a href="#addLevel2" id="add2" data-toggle="modal">添加菜单 </a>/<a href="#" id="mdel" data-toggle="modal">删除 </a></td></tr>';
							$("#treeTable").append($tr);
						}if(v.children && v.children.length > 0){ 
							$.each(v.children,function(ii,vv){ 
								$tr2='<tr data-tt-id="'+vv.menuId+'" data-tt-parent-id="'+vv.pid+'"><td>'+vv.menuText+'</td><td>'+vv.menuId+'</td><td>'+vv.sort+'</td><td></td><td>'+vv.url+'</td><td></td><td><i class="'+vv.icon+'"></i></td><td></td><td>'+vv.state+'</td><td></td><td><a href="#myModal" id="edit" data-toggle="modal">修改 </a>/<a href="#addLevel2" id="add2" data-toggle="modal">添加菜单 </a>/<a href="#" id="mdel" data-toggle="modal">删除 </a></td></tr>';
								$("#treeTable").append($tr2);
							}) 
						}	
						 
					})
					$("#treeTable").treetable({  
				         expandable : true,
				         initialState:"expanded",
				         clickableNodeNames:true,//点击节点名称也打开子节点.
				         indent : 30//每个分支缩进的像素数。
				     });
					 
				},
				error : function() {
					console.log("失败");
				}
			})
			
		})
		$("#treeTable").on("click","#edit",function(){
			var thise=$(this)
			if($("#admin").attr("disabled")=="disabled"){
				var i=1;
			}else{
				var i=2;
			}
				$.ajax({ 
					url : "/bmlfms/menuo",
					data : {  
						i : i 
					},  
					type : "post",  
					dataType : "json",    
					success : function(data) { 
						console.log(data)
						var eid=thise.parent().parent().children().next().html();
						$.each(data,function(i,v){
							
							if(v.menuId==eid){
                            	$("#edId").val(v.menuId)
                            	$("#edText").val(v.menuText)
                            	$("#edSort").val(v.sort)
                            	$("#edUrl").val(v.url)
                            	$("#edIcon").val(v.icon)
                            	$("#edState").val(v.state)
							}
							
						})
						$("#treeTable").treetable({  
					         expandable : true,
					         initialState:"expanded",
					         clickableNodeNames:true,//点击节点名称也打开子节点.
					         indent : 30//每个分支缩进的像素数。
					     });
					}, 
					error : function() { 
						
					}
				})
			 
		}) 
		$("#edsub").on("click",function(){
			var menu=$("#edform").serialize();
			$.ajax({ 
					url : "/bmlfms/menuEdit",
					data : menu,  
					type : "post",  
					dataType : "json",    
					success : function(data) {  
						console.log("修改成功 ")
					}, 
					error : function() { 
						
					}
				})
			
		})
		
		$("#addsub").on("click",function(){
			var menuText=$("#addText").val();
			var menuUrl=$("#addUrl").val();
			var menuIcon=$("#addIcon").val();
			if($("#admin").attr("disabled")=="disabled"){
				var i=1;
			}else{
				var i=2;
			}
			var arr1=[];
			$.ajax({ 
				url : "/bmlfms/menuo",
				data : {  
					i : i 
				},  
				type : "post",  
				dataType : "json",    
				success : function(data) { 
					$.each(data,function(i,v){ 
						arr1.push(v.sort);
					})
					var sort=Math.max.apply(null, arr1)
					$.ajax({ 
					url : "/bmlfms/menuAdd",
					data : {
						sort : sort+1,
						menuType : i,
						menuText : menuText,
						menuUrl : menuUrl,
						menuIcon :menuIcon
					},  
					type : "post",  
					dataType : "json",    
					success : function(data) {  
						console.log("修改成功 ")
					}, 
					error : function() { 
						
					}
				})
				}, 
				error : function() { 
					
				}
			})	
		})
		var pid2;
			var sort2;
		$("#treeTable").on("click","#add2",function(){
			var thise=$(this)
			if($("#admin").attr("disabled")=="disabled"){
				var i=1;
			}else{
				var i=2;
			}
			$.ajax({ 
				url : "/bmlfms/menuo",
				data : {  
					i : i 
				},  
				type : "post",  
				dataType : "json",    
				success : function(data) {
					var eid=thise.parent().parent().children().next().html();
					$.each(data,function(i,v){ 
						if(v.menuId==eid){
							if(v.pid==0){
								pid2=v.menuId;
								sort2=v.sort+1;
							}else{
								pid2=v.pid;
								sort2=v.sort+1;
							}
						}
					})
				}, 
				error : function() { 
					
				} 
			})
		})
		
		$("#add2sub").on("click",function(){
			var menuText2=$("#addText2").val();
			var menuUrl2=$("#addUrl2").val();
			if($("#admin").attr("disabled")=="disabled"){
				var i=1;
			}else{
				var i=2;
			}
			$.ajax({ 
				url : "/bmlfms/menuAdd2",
				data : {
					pid : pid2,
					sort : sort2,
					menuType : i,
					menuText : menuText2,
					menuUrl : menuUrl2
				},  
				type : "post",  
				dataType : "json",    
				success : function(data) {  
					console.log("修改成功 ")
				}, 
				error : function() { 
					
				}
			})
		})
		
		$("#treeTable").on("click","#mdel",function(){
			var eid=$(this).parent().parent().children().next().html();
			if($("#admin").attr("disabled")=="disabled"){
				var i=1;
			}else{
				var i=2;
			}
			$.ajax({
				url : "/bmlfms/menuDel",
				data : {
					menuType : i,
					id : eid
				},
				type : "post",
				dataType : "json",
				success : function(data) {
					window.location.reload();
				},
				error : function() { 
					console.log("失败");
				}
			})
		})
		
		
		/*$("#sub").on("click",function(){
			var name=$("#name").val().trim();
			var pass=$("#pass").val().trim();
			var publickey = '<%=session.getAttribute("publickey")%>' ;
			var encrypt=new JSEncrypt();
			encrypt.setPublicKey(publickey);
			var Enname=encrypt.encrypt(name);
			var Enpass=encrypt.encrypt(pass);
			$.ajax({
				url : "/bmlfms/RSATest",
				data : {
					Enname : Enname,
					Enpass : Enpass,
				},
				type : "post",
				dataType : "json",
				success : function(data) {
					
				},
				error : function() { 
					console.log("失败");
				}
			})
		})*/
		
		
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
					<li><a href="logout"><i class="fa fa-sign-out"></i> <span>Sign
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
		<div class="page-heading">菜单管理</div>
		<!-- page heading end-->

		<!--body wrapper start-->
		<div class="wrapper">
		<!--  <input type="text" id="name"/>
		<input type="text" id="pass"/>
		<input type="button" id="sub"/>-->  
		<center style="margin-bottom:10px;">
		<button id="admin"  class="btn btn-success" type="button">管理员</button>
		<button id="user" class="btn btn-success" type="button">账务人员</button> 
		</center>  
		<center style="margin-bottom:10px;">   
		<a href="#addLevel1" id="edit" data-toggle="modal" class="btn btn-info">添加一级菜单 </a> 
		</center> 
	 <div>
     <table id="treeTable" style="">  
         <tr id="treeTitle">  
              <th>菜单名称</th> 
              <th>id</th> 
              <th>排序<th>
              <th>URL<th>
              <th>图标<th>
              <th>状态<th> 
              <th>操作</th>
          </tr>  
     </table>  
     
 
     <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header"> 
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title">菜单修改</h4>
                                        </div>

                                        <div class="modal-body row">
                                        <center>  
                                        <form id="edform">
                                        	<div><h4 style="display:inline-block"><strong>菜单&nbsp;ID</strong></h4><input type="text" name="menuId" id="edId" readonly="readonly"/></div>
                                        	<div><h4 style="display:inline-block"><strong>菜单名</strong></h4><input type="text" name="menuText" id="edText"/></div>
                                        	<div><h4 style="display:inline-block"><strong>菜单排序</strong></h4><input type="text" name="sort" id="edSort"/></div>
                                        	<div><h4 style="display:inline-block"><strong>链&nbsp;接</strong></h4><input type="text" name="url" id="edUrl"/></div>
                                      		<div><h4 style="display:inline-block"><strong>图&nbsp;标</strong></h4><input type="text" name="icon" id="edIcon"/></div>
                                        	<div><h4 style="display:inline-block"><strong>状&nbsp;态</strong></h4><input type="text" name="state" id="edState"/></div>
                                        	</center>
                                        	</form>
                                        	<button type="button" id="edsub" class="btn btn-primary btn-lg btn-block">提交修改</button>
                                        </div> 
 
                                    </div>
                                </div>
                            </div>
                            <!-- edit END -->
                            
      <div class="modal fade" id="addLevel1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header"> 
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title">添加一级菜单</h4>
                                        </div>

                                        <div class="modal-body row">
                                        <center>  
                                        <form id="edform">
                                        	
                                        	<div><h4 style="display:inline-block"><strong>菜单名</strong></h4><input type="text" name="menuText" id="addText"/></div>
                                        	<div><h4 style="display:inline-block"><strong>链&nbsp;接</strong></h4><input type="text" name="url" id="addUrl"/></div>
                                      		<div><h4 style="display:inline-block"><strong>图&nbsp;标</strong></h4><input type="text" name="icon" id="addIcon"/></div>
                                        	
                                        	</center>
                                        	</form>
                                        	<button type="button" id="addsub" class="btn btn-primary btn-lg btn-block">确认添加</button>
                                        </div> 
 
                                    </div>
                                </div>
                            </div>
      
                            <!-- addLevel2 END -->
                            
      <div class="modal fade" id="addLevel2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" style="display: none;">
                                <div class="modal-dialog">
                                    <div class="modal-content">
                                        <div class="modal-header"> 
                                            <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                                            <h4 class="modal-title">添加一级菜单</h4>
                                        </div>

                                        <div class="modal-body row">
                                        <center>  
                                        <form id="edform">
                                        	
                                        	<div><h4 style="display:inline-block"><strong>菜单名</strong></h4><input type="text" name="menuText" id="addText2"/></div>
                                        	<div><h4 style="display:inline-block"><strong>链&nbsp;接</strong></h4><input type="text" name="url" id="addUrl2"/></div>                                      	
                                        	</center>
                                        	</form>
                                        	<button type="button" id="add2sub" class="btn btn-primary btn-lg btn-block">确认添加</button>
                                        </div> 
                                    </div>
                                </div>
                            </div>
     
    </div> 
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

</body>
</html>