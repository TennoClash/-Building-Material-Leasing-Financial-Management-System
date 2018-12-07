<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
 <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="ThemeBucket">
    <script src="/bmlfms/plugin/script/jquery-1.10.2.min.js"></script>
    <script src="/bmlfms/plugin/script/md5.js"></script>
    <link href="/bmlfms/plugin/css/style.css" rel="stylesheet">
  <link href="/bmlfms/plugin/css/style-responsive.css" rel="stylesheet">
<title>registration</title>
<script>
	$(document).ready(function() {
		 $("#repass").on("keyup",function () {
             var keyValue = $(this).val().trim();
             var reKeyValue =$("#password").val().trim();
            // console.log(keyValue+"++++"+reKeyValue);
             if(keyValue==reKeyValue){
                 $(this).css("background","#eaeaec");
                 isRePasswordRight=true;
             }else {
                 $(this).css("background","#ff9191");
                 isRePasswordRight=false;
             }

         }).keyup();
		
		$("#register_sub").on("click",function(){
			var reg=$("#reg").serialize();
			
			
			
			$.ajax({
				url:"/bmlfms/ajax_registration",
				data:reg,
				type:"post",
				dataType:"json",
				success:function(data){
					location.href = "/bmlfms/jump/jumplogin"
				},
				error:function(){
					console.log("失败");
				}
			})
		})
	})
	
	
	</script>


</head>


<body class="login-body">

<div class="container">

    <form class="form-signin" id="reg" action="">
        <div class="form-signin-heading text-center">
            <h1 class="sign-title">Registration</h1>
            <img src="img/login-logo.png" alt=""/>
        </div>


        <div class="login-wrap">
            <p>请填写你的个人信息</p>
            <input type="text" name="realName" autofocus="" placeholder="真实姓名" class="form-control">
            <input type="text" name="age" autofocus="" placeholder="年龄" class="form-control">
            <input type="text" name="email" autofocus="" placeholder="电子邮箱" class="form-control">
            <div class="radios">
                <label for="radio-01" class="label_radio col-lg-6 col-sm-6">
                    <input type="radio" checked="" value="0" name="gender" name="sample-radio"> 男
                </label>
                <label for="radio-02" class="label_radio col-lg-6 col-sm-6">
                    <input type="radio" value="1" name="gender" name="sample-radio"> 女
                </label>
            </div>

            <p> 请填写你的账号信息</p>
            <input type="text" name="userName" autofocus="" placeholder="用户名" class="form-control">
            <input type="password" id="password" name="password" placeholder="密码" class="form-control">
            <input type="password" id="repass" placeholder="确认密码" class="form-control">
            <button type="button" id="register_sub" class="btn btn-lg btn-login btn-block">
                <i class="fa fa-check"></i>
            </button>

            <div class="registration">
                	已经有账号了？
                <a href="/bmlfms/login" class="">
                    	登录
                </a>
            </div>

        </div>

    </form>

</div>


<script src="/bmlfms/plugin/script/bootstrap.min.js"></script>
<script src="/bmlfms/plugin/script/modernizr.min.js"></script>

</body>
</html>