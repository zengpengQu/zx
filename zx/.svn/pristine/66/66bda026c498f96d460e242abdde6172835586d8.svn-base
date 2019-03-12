<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<%@ page contentType="text/html; charset=UTF-8" %>--%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
    <%--<meta http-equiv="X-UA-Compatible" content="IE=9,chrome=1"/>--%>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>履职支撑平台</title>
    <%--<link rel="shortcut icon" href="${basePath}/images/login/favicon.ico" />--%>

    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/bootstrap.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/font-awesome.css"/>
    <!-- text fonts -->
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ace-fonts.css"/>
    <!-- ace styles -->
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ace.css"/>
    <!--[if lte IE 9]>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ace-part2.css"/>
    <![endif]-->
    <!--[if lte IE 9]>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ace-ie.css"/>
    <![endif]-->
    <%--<link rel="shortcut icon" href="${basePath}/images/login/favicon.ico"/>--%>

    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/bootstrap.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/font-awesome.css"/>

    <!--信息提示-->
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/jquery.gritter.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/jquery-ui.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/jquery-ui-datetimepicker/css/jquery-ui-timepicker-addon.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/chosen.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ui.jqgrid.css"/>

    <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!--[if lte IE 8]>
    <script src="${basePath}/plugin/ace/assets/js/html5shiv.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/respond.js"></script>
    <![endif]-->

</head>
<body class="login-layout  light-login">
<div class="main-container">
    <div style="padding: 0;margin:0px auto;">
        <div class="row" style="margin-left: 0px;margin-right: 0px;">
            <div class="col-sm-10 col-sm-offset-1">
                <div class="space-30"></div>
                <div class="space-10"></div>
                <div class="center">
                    <h1>
                        <%--<img src="${basePath}/images/login/logo.gif" width="60">--%>
                        <span class="white large bolder">履 职 支 撑 平 台</span>
                    </h1>
                </div>

                <div class="space-20"></div>

                <div id="add-dialog" class="hide">
                    <form class="form-horizontal" id="addForm" role="form">
                        <div>
                            <div>
                                <div class="col-xs-12">
                                    <%--<h4 class="smaller header lighter blue"--%>
                                    <%--style="margin-top: 0px;margin-bottom:10px ">--%>
                                    <%--<i class="ace-icon fa fa-user"></i>--%>
                                    <%--基本信息--%>
                                    <%--</h4>--%>

                                    <%--<div class="col-xs-4">--%>
                                    <%--<div class="form-group">--%>
                                    <%--<label class="col-xs-6 control-label">性别：<span class="red">*</span></label>--%>

                                    <%--<div class="col-xs-6 ">--%>
                                    <%--<label>--%>
                                    <%--<input name="sex" class="ace input-lg" checked--%>
                                    <%--value="0" type="radio">--%>
                                    <%--<span class="lbl bigger-120"> 男</span>--%>
                                    <%--</label>--%>
                                    <%--&nbsp;&nbsp;--%>
                                    <%--<label>--%>
                                    <%--<input name="sex" class="ace input-lg" value="1"--%>
                                    <%--type="radio">--%>
                                    <%--<span class="lbl bigger-120"> 女</span>--%>
                                    <%--</label>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>

                                    <%--<div class="row">--%>
                                    <%--<div class="col-xs-4">--%>
                                    <%--<div class="form-group">--%>
                                    <%--<label class="col-xs-6 control-label">--%>
                                    <%--电话：--%>
                                    <%--&lt;%&ndash;<span class="red">*</span>&ndash;%&gt;--%>
                                    <%--</label>--%>

                                    <%--<div class="col-xs-6">--%>
                                    <%--<input type="text" id="mobile" name="mobile" class="form-control"--%>
                                    <%--placeholder="电话"/>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--<div class="col-xs-8">--%>
                                    <%--<div class="form-group">--%>
                                    <%--<label class="col-xs-3 control-label">--%>
                                    <%--邮箱：--%>
                                    <%--&lt;%&ndash;<span class="red">*</span>&ndash;%&gt;--%>
                                    <%--</label>--%>

                                    <%--<div class="col-xs-9">--%>
                                    <%--<input type="text" id="email" name="email" class="form-control"--%>
                                    <%--placeholder="邮箱"/>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>

                                    <%--</div>--%>
                                    <%--<div class="row" >--%>
                                    <%--<div class="col-xs-4" id="password-div">--%>
                                    <%--<div class="form-group">--%>
                                    <%--<label id="password-label" class="col-xs-6 control-label">初始密码：<span class="red">*</span></label>--%>

                                    <%--<div class="col-xs-6 ">--%>
                                    <%--<input type="text" id="firstPassword" name="password" value="123456" readonly="readonly"--%>
                                    <%--class="form-control" />--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>

                                    <%--<h4 class="smaller header lighter blue"--%>
                                    <%--style="margin-top: 0px;margin-bottom:10px ">--%>
                                    <%--<i class="ace-icon fa fa-list"></i>--%>
                                    <%--职能信息--%>
                                    <%--</h4>--%>
                                    <div class="row" style="margin-top: 10px;margin-left: 10px">
                                        <div class="col-xs-5">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">用户姓名：<span
                                                        class="red">*</span></label>

                                                <div class="col-xs-6 ">
                                                    <input type="text" id="role-name" name="empName"
                                                           class="form-control" readonly="readonly"
                                                           placeholder="用户姓名"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-5">
                                            <div class="form-group">
                                                <label class="col-xs-6 control-label">登录名：<span class="red">*</span></label>

                                                <div class="col-xs-6">
                                                    <input type="text" id="userId" name="userId"
                                                           class="form-control remote"
                                                           placeholder="登录名"/>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row"  style="margin-top: 10px;margin-left: 10px">
                                        <div class="col-xs-5">
                                            <label class="col-xs-6 control-label">所属机构：<span
                                                    class="red">*</span></label>

                                            <div class="col-xs-6 ">
                                                <select id="org-id" name="orgId" class="form-control">

                                                </select>
                                            </div>
                                        </div>
                                        <div class="col-xs-5">

                                            <label class="col-xs-6 control-label">所属部门：<span
                                                    class="red">*</span></label>

                                            <div class="col-xs-6 ">
                                                <select id="dept-id" name="deptId" class="form-control">
                                                    <option value="">请选择</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="row">--%>
                                    <%--<div class="col-xs-4">--%>
                                    <%--<div class="form-group">--%>
                                    <%--<label class="col-xs-6 control-label">--%>
                                    <%--传真：--%>
                                    <%--&lt;%&ndash;<span class="red">*</span>&ndash;%&gt;--%>
                                    <%--</label>--%>

                                    <%--<div class="col-xs-6 ">--%>
                                    <%--<input type="text" id="fax" name="fax" class="form-control"--%>
                                    <%--placeholder="传真"/>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--<div class="col-xs-4">--%>
                                    <%--<div class="form-group">--%>
                                    <%--<label class="col-xs-6 control-label">--%>
                                    <%--办公电话：--%>
                                    <%--&lt;%&ndash;<span class="red">*</span>&ndash;%&gt;--%>
                                    <%--</label>--%>

                                    <%--<div class="col-xs-6">--%>
                                    <%--<input type="text" id="phone" name="phone" class="form-control"--%>
                                    <%--placeholder="办公电话"/>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--<div class="col-xs-4">--%>
                                    <%--<div class="form-group">--%>
                                    <%--<label class="col-xs-6 control-label">--%>
                                    <%--单位职务：--%>
                                    <%--&lt;%&ndash;<span class="red">*</span>&ndash;%&gt;--%>
                                    <%--</label>--%>

                                    <%--<div class="col-xs-6 ">--%>
                                    <%--<input type="text" id="position" name="position"--%>
                                    <%--class="form-control"--%>
                                    <%--placeholder="单位职务"/>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--<div class="row">--%>
                                    <%--<div class="col-xs-4">--%>
                                    <%--<div class="form-group">--%>
                                    <%--<label class="col-xs-6 control-label">--%>
                                    <%--专业类别：--%>
                                    <%--&lt;%&ndash;<span class="red">*</span>&ndash;%&gt;--%>
                                    <%--</label>--%>
                                    <%--<div class="col-xs-6">--%>
                                    <%--<select id="professionalId" name="professionalId"--%>
                                    <%--class="form-control">--%>

                                    <%--</select>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--<div class="col-xs-8">--%>
                                    <%--<div class="form-group">--%>
                                    <%--<label class="col-xs-3 control-label">--%>
                                    <%--NOTES：--%>
                                    <%--&lt;%&ndash;<span class="red">*</span>&ndash;%&gt;--%>
                                    <%--</label>--%>

                                    <%--<div class="col-xs-9">--%>
                                    <%--<input type="text" id="notes" name="notes" class="form-control"--%>
                                    <%--placeholder="NOTES"/>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--<div class="row">--%>
                                    <%--<div class="col-xs-12">--%>
                                    <%--<div class="form-group">--%>
                                    <%--<label class="col-xs-2 control-label">--%>
                                    <%--人员职责：--%>
                                    <%--&lt;%&ndash;<span class="red">*</span>&ndash;%&gt;--%>
                                    <%--</label>--%>

                                    <%--<div class="col-xs-10 ">--%>
                                    <%--<input type="text" readonly="readonly" id="profession"--%>
                                    <%--name="dutynames" class="form-control"--%>
                                    <%--placeholder="人员职责"/>--%>
                                    <%--<input type="hidden" id="profession-id" name="dutyids"/>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                    <%--</div>--%>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>

                <div class="row">
                    <div class="col-xs-12">
                        <div id="profession-dialog" class="hide">
                            <ul class="scrollable pro-ul" data-size="420" id="dicPosition">
                            </ul>
                        </div>
                    </div>
                </div>


                <div class="position-relative login-container">
                    <div id="login-box" class="login-box visible widget-box no-border">
                        <div class="widget-body">
                            <div class="widget-main">
                                <h4 class="header blue lighter bigger">
                                    <i class="ace-icon fa fa-coffee green"></i>
                                    请登录
                                </h4>

                                <div class="space-6"></div>

                                <form action="${basePath}/login.do" class="form-horizontal login_form" method="post"
                                      id="userloginForm">
                                    <fieldset>
                                        <input type="hidden" id="givenName" name="j_givenName"
                                               placeholder="G码"/>
                                        <div style="height: 80px;width: 300px;">
                                            <label class="block clearfix">
                                                    <span class="block input-icon">
                                                        <input type="text" id="username" name="j_username"
                                                               placeholder="用户名"
                                                               class="form-control input-lg login_form_input_validate"
                                                               style="padding-left: 40px;" value="${logUserName}"/>
                                                        <i class="ace-icon  fa fa-user bigger-200"
                                                           style="top:9px;left:8px;"></i>
                                                    </span>
                                            </label>
                                        </div>

                                        <div style="height: 80px;width: 300px;">
                                            <label class="block clearfix">
                                                    <span class="block input-icon">
                                                        <input type="password" id="password" name="j_password"
                                                               placeholder="密　码"
                                                               class="form-control input-lg login_form_input_validate"
                                                               style="padding-left: 40px;"/>
                                                        <i class="ace-icon  fa fa-lock bigger-200"
                                                           style="top:9px;left:8px;"></i>
                                                    </span>
                                            </label>
                                        </div>

                                        <div class="clearfix">
                                            <div class="row">
                                                <label class="pull-left red" id="errorLabel">
                                                    <c:if test="${message_login ne null}">
                                                        ${message_login}
                                                    </c:if>
                                                </label>
                                            </div>
                                            <button type="button" id="auth-login-http" class="width-35 pull-left btn btn-sm btn-success">
                                                <i class="ace-icon fa fa-book "></i>
                                                <span class="bigger-110">UKey登录</span>
                                            </button>
                                            <%--<a>--%>
                                            <button type="submit"
                                                    class="width-35 pull-right btn btn-sm btn-primary">
                                                <i class="ace-icon fa fa-key"></i>
                                                <span class="bigger-110">密码登录</span>
                                            </button>
                                        </div>

                                        <div class="space-4"></div>
                                    </fieldset>
                                </form>

                            </div>
                            <!-- /.widget-main -->
                        </div>
                        <!-- /.widget-body -->
                    </div>
                    <!-- /.login-box -->

                </div>
                <!-- /.position-relative -->


                <%--<div class="position-relative login-container">--%>
                <%--<div id="auth-login-box" class="login-box visible widget-box no-border">--%>
                <%--<div class="widget-body">--%>
                <%--<div class="widget-main">--%>
                <%--<h4 class="header blue lighter bigger">--%>
                <%--<i class="ace-icon fa fa-coffee green"></i>--%>
                <%--统一认证测试--%>
                <%--</h4>--%>

                <%--<div class="space-6"></div>--%>
                <%--&lt;%&ndash;<h3>资源同步测试</h3>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<h4>资源接收地址：http://ip:port/westone-trustService-example/saveresource</h4>&ndash;%&gt;--%>
                <%--<h3>单点登录测试</h3>--%>
                <%--<button type="button" id="auth-login-http" class="pull-left btn btn-sm btn-success">--%>
                <%--<i class="ace-icon fa fa-book "></i>单点登录-httppost</button>--%>
                <%--<br>--%>
                <%--<br>--%>
                <%--&lt;%&ndash;<a href="${basePath}/WEB-INF/jsp/auth-login.jsp">单点登录-httppost</a><br/>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<button type="button" id="auth-login-webservice" class="pull-left btn btn-sm btn-success">&ndash;%&gt;--%>
                <%--&lt;%&ndash;<i class="ace-icon fa fa-book "></i>单点登录-webservice</button>&ndash;%&gt;--%>
                <%--&lt;%&ndash;<a href="${basePath}/WEB-INF/jsp/auth-loginws.jsp">单点登录-webservice</a>&ndash;%&gt;--%>
                <%--<div class="space-16"></div>--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--</div>--%>

            </div>
            <!-- /.col -->
        </div>
        <!-- /.row -->
    </div>
    <!-- /.main-content -->
    <div style="position: absolute;bottom: 1px;right: 2px;font-family: 仿宋_GB2312, Arial, Helvetica, sans-serif;color: yellowgreen;">
        <span class="smaller-90 bolder">技术支持：任君球</span>&nbsp;&nbsp;
        <span class="smaller-90 bolder">联系电话：13021106006</span>
    </div>
</div>
<!-- /.main-container -->
</body>
</html>
<!-- basic scripts -->

<!--[if !IE]> -->
<script type="text/javascript">
    window.jQuery || document.write("<script src='${basePath}/plugin/ace/assets/js/jquery.js'>" + "<" + "/script>");
</script>
<!-- <![endif]-->

<!--[if IE]>
<script type="text/javascript">
window.jQuery || document.write("<script src='${basePath}/pladditional-methougin/ace/assets/js/jquery1x.js'>" + "<" + "/script>");
</script>
<![endif]-->
<script src="${basePath}/plugin/jquery.form.js"></script>

<script src="${basePath}/plugin/ace/assets/js/bootstrap.js"></script>
<script src="${basePath}/plugin/bootstrap-modal/js/bootstrap-modal.js"></script>
<script src="${basePath}/plugin/bootstrap-modal/js/bootstrap-modalmanager.js"></script>
<script src="${basePath}/plugin/ace/assets/js/bootbox.js"></script>
<script src="${basePath}/plugin/ace/assets/js/date-time/moment.js"></script>
<script src="${basePath}/plugin/ace/assets/js/ace-elements.js"></script>
<script src="${basePath}/plugin/jquery.cookie.js"></script>
<script src="${basePath}/plugin/jquery-validation/jquery.validate.min.js" type="text/javascript"
        charset="utf-8"></script>
<script src="${basePath}/plugin/ace/assets/js/jquery-ui.js" type="text/javascript"
        charset="utf-8"></script>
<script src="${basePath}/plugin/jquery-validation/additional-methods.min.js" type="text/javascript"
        charset="utf-8"></script>
<script src="${basePath}/plugin/jquery-validation/localization/messages_zh.min.js" type="text/javascript"
        charset="utf-8"></script>
<script src="${basePath}/plugin/global.js"></script>

<%--单点登录插件--%>
<script src="${basePath}/js/auth/jquery.idauth.min.js"></script>

<script language="javascript" type="text/javascript">
    if (self != top) top.location = "<%=request.getContextPath()%>/login.jsp";

    $(document).ready(function () {

        if('${logUserName}'=='' || '${logUserName}'=='undefined'){
            $('input[name="j_username"]').focus();
        }else{
            $('input[name="j_password"]').focus();
        }

        $(document).keydown(function (event) {
            $('#errorLabel').html('');
            if (event.keyCode == 13) {
                if ($('#userloginForm').validate().form()) {
                    $('#userloginForm').submit();
                }
                return false;
            }
        });

        var $authHttpBtn = $("#auth-login-http");

        $authHttpBtn.on('click', function (e) {
            e.preventDefault();

            $.idauth({
                challengeUrl: 'identitychallengehttp',
                idauthUrl: 'identitytickethttp',
                controlId: 'authClientCtrl',
                onSuccess: function () {
                    window.location.href = '${basePath}/loginNoUser.do';
                },
                onSubmit: function () {
                    //alert("正在登录中。。。");
                },
                onError: function (message) {

                    G.alert({message: message});
                }

            });
        });


        //登录表单校验
        $('#userloginForm').validate({
            errorElement : 'span',
            errorClass   : 'help-block red',
            focusInvalid : false,
            rules        : {
                j_username : {
                    required : true
                },
                j_password : {
                    required : true
                }
            },
            messages     : {
                j_username : {
                    required : "用户名必须填写."
                },
                j_password : {
                    required : "密码必须填写."
                }
            },

            highlight : function (element) {
                $(element).closest('.login_form_input_validate').addClass('has-error');
            },

            success : function (label) {
                label.closest('.login_form_input_validate').removeClass('has-error');
                label.remove();
            },

            errorPlacement : function (error, element) {
                element.parents('label').append(error);
            },

            submitHandler : function (form) {
                form.submit();
            }
        });

        $('#userLoginBtn').click(function () {
            if ($('#userloginForm').validate().form()) {
                $("#userloginForm").submit();
            }
        });






        var $addDialog = $('#add-dialog');
        var $professionDialog = $("#profession-dialog");
        var $addForm = $('#addForm');
        var $roleName = $('#role-name');
        var $userId = $('#userId');
        var $mobile = $('#mobile');
        var $email = $('#email');
        var $firstPassword = $('#firstPassword');
        var $orgId= $('#org-id');
        var $deptId =$('#dept-id');
        var $fax = $('#fax');
        var $phone = $('#phone');
        var $position = $('#position');
        var $professionalId = $('#professionalId');
        var $notes = $('#notes');
        var $profession = $('#profession');
        var $professionId = $('#profession-id');
        var $dicPosition = $('#dicPosition');


        function showDialog(given) {
            $.get('${basePath}/loadOrgAndPro.do', function (response) {
                if (response.result) {
                    $orgId.empty();
                    var dicOrgList = response.dicOrgList;
                    var html = [];
                    html.push('<option value="">请选择</option>')
                    for (var i = 0; i < dicOrgList.length; i++) {
                        var org = dicOrgList[i];
                        html.push(' <option value="' + org.id + '">' + org.orgName + '</option>');
                    }
                    $orgId.append(html.join(''));

                    $professionalId.empty();
                    var dicProfessionList = response.dicProfessionList;
                    var html1 = [];

                    for (var i = 0; i < dicProfessionList.length; i++) {
                        var professional = dicProfessionList[i];
                        html1.push(' <option value="' + professional.id + '">' + professional.proName + '</option>');
                    }
                    $professionalId.append(html1.join(''));


                    var positionList = response.positionList;
                    $dicPosition.empty();
                    var html2 = [];

                    for (var i = 0; i < positionList.length; i++) {
                        var position = positionList[i];
                        html2.push(' <li><div class="checkbox"><label> <input value="' + position.id + '" proname="' + position.postName + '" name="profession-check"class="ace" type="checkbox">');
                        html2.push(' <span class="lbl"> ' + position.postName + '</span> </label> </div> </li>')
                    }
                    $dicPosition.append(html2.join(''));
                }
            });
            G.confirm({
                message: '证书当前无用户，是否申请应急管理系统用户？',
                callback: function (result) {
                    if (result) {
                        $.post('${basePath}/loadLDAPData.do',{given:given}, function (response) {

                        });
                        $.cookie('KOAL_CERT_CN', "王刚")
                        var name = $.cookie('KOAL_CERT_CN');
                        $roleName.val(name);
                        $addDialog.removeClass('hide').dialog({
                            resizable: false,
                            height: 300,
                            width: 980,
                            modal: true,
                            title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> CA证书用户申请</div>",
                            title_html: true,
                            close: function () {
                                $addForm.resetForm();
                            },
                            buttons: [
                                {
                                    html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                                    "class": "btn btn-warning",
                                    click: function () {
                                        G.confirm({
                                            message: '确定取消操作？',
                                            callback: function (result) {
                                                if (result) {
                                                    $addDialog.dialog("close");
                                                }
                                            }
                                        })

                                    }
                                },
                                {
                                    html: "<i class='ace-icon glyphicon	glyphicon-tag  bigger-110'></i>&nbsp; 提交",
                                    "class": "btn btn-primary",
                                    click: function () {
                                        addPerson();
                                    }
                                }
                            ]
                        });
                    }
                }
            })
        }


        $('#certification').click(function () {
            $.cookie('KOAL_CERT_GN', 22222);
            var given = $.cookie('KOAL_CERT_GN');
            if (given == undefined) {
                G.alert({
                    message: "无证书信息，请选择密码登录！"
                });
            } else {
                $.post('${basePath}/loadUserByGN.do?rd=' + Math.random(), {given: given}, function (response) {
                    if (response.result) {
                        var username = response.username;
                        var password = response.password;
                        if (response.isGiven) {
                            $('#username').val(username);
                            $('#password').val(password);
                            $('#givenName').val(given);
                            $('#userloginForm').submit();
                        } else {
                            showDialog(given);
                        }
                    }
                }, 'json');
            }
        });

        //人员职责点击
        $profession.click(function () {
            appendCheckProfession();
            $professionDialog.removeClass('hide').dialog({
                resizable: false,
                height: 400,
                width: 250,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i> 选择人员职责</h4></div>",
                title_html: true,
                close: function () {
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            getCheckedProfession();
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        });

        //选中人员职责
        function appendCheckProfession() {
            var professionId = $professionId.val();
            professionId = professionId.split(",");
            $(".pro-ul").find('input[name="profession-check"]').each(function () {
                var $this = $(this);
                var value = $this.val();
                for (var i in professionId) {
                    if (value == professionId[i]) {
                        $this.prop("checked", true);
                    }
                }
            });
        }

        //获取选择的人员职责
        function getCheckedProfession() {
            var proIds = [];
            var proName = [];
            $(".pro-ul").find('input[name="profession-check"]').each(function () {
                var $this = $(this);
                if ($this.prop('checked')) {
                    var value = $this.val();
                    var name = $this.attr('proname');
                    proIds.push(value);
                    proName.push(name);
                }
            });
            $profession.val(proName.join(","));
            $professionId.val(proIds.join(","));
        }

        $orgId.bind('change',function () {
            var id = $orgId.val();
            $.post('${basePath}/address/loadDept.do', {id: id}, function (response) {
                if (response.result) {
                    $deptId.empty();
                    var DeptList = response.dicDeptList;
                    var html = [];
                    html.push('<option value="">请选择</option>')
                    for (var i in DeptList) {
                        var dicDept = DeptList[i];
                        html.push('<option value="' + dicDept.id + '">' + dicDept.deptName + '</option>');
                    }
                    $deptId.append(html.join(''));
                }
            }, 'json')
        });

        $addForm.tjForm({
            validate : {
                focusInvalid: false,
                rules: {
                    userId: {
                        required: true,
                        maxlength: 20
                    },
                    orgId: {
                        required: true
                    },
                    deptId: {
                        required: true
                    }
                },
                messages: {
                    userId: {
                        required: "登录名必须填写"
                    },
                    orgId: {
                        required: "机构必须填写"
                    },
                    deptId: {
                        required: "部门必须填写"
                    }
                }
            }
        });



        function addPerson(){
            if ($addForm.validate().form()) {
                addNews();
            }
        }

        function addNews() {
            var roleName = $roleName.val();
            var userId = $userId.val();
            var firstPassword = $firstPassword.val();
            var mobile = $mobile.val();
            var email = $email.val();
            var orgId = $orgId.val();
            var deptId = $deptId.val();
            var fax = $fax.val();
            var phone = $phone.val();
            var position = $position.val();
            var professionalId = $professionalId.val();
            var notes = $notes.val();
            var sex =  $('input[name="sex"]').val();
            var dutynames = $profession.val();
            var dutyids = $professionId.val();
            var givenName = $.cookie('KOAL_CERT_GN');
            var newsData = {
                empName: roleName,
                userId: userId,
                password: firstPassword,
                mobile: mobile,
                email: email,
                orgId: orgId,
                deptId: deptId,
                fax: fax,
                phone: phone,
                sex:sex,
                professionalId: professionalId,
                notes: notes,
                dutynames: dutynames,
                dutyids:dutyids,
                position: position,
                givenName:givenName
            };
            $.post('${basePath}/save.do', newsData, function (response) {
                if (response.result) {
                    G.alert({
                        message:"申请已提交成功，请等待！"
                    });
                    $addDialog.dialog('close');
                }
                else {
                    G.alert({
                        message:"提交失败！"
                    });
                    $addDialog.dialog("close");
                }
            }, 'json')
        }
    });
</script>