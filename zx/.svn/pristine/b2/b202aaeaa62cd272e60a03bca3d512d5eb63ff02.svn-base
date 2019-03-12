<%--
  Created by IntelliJ IDEA.
  User: pengyx
  Date: 2018/6/19
  Time: 15:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>履职支撑平台</title>

    <meta name="description" content="top menu &amp; navigation"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0"/>

    <!-- bootstrap & fontawesome -->
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/bootstrap.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/font-awesome.css"/>
    <!--信息提示-->
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/jquery.gritter.css"/>
    <!-- page specific plugin styles -->
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/jquery-ui.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/bootstrap-datepicker3.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/jquery-ui-datetimepicker/css/jquery-ui-timepicker-addon.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/chosen.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/datepicker.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ui.jqgrid.css"/>
    <!-- bootstrap table -->
    <link rel="stylesheet" href="${basePath}/plugin/bootstrap-table-develop/dist/bootstrap-table.min.css"/>
    <!-- text fonts -->
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ace-fonts.css"/>

    <!-- ace styles TODO-->
    <%--<link rel="stylesheet" href="${basePath}/demo/assets/css/ace.css" class="ace-main-stylesheet" id="main-ace-style"/>--%>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ace.css" class="ace-main-stylesheet"
          id="main-ace-style"/>

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ace-part2.css" class="ace-main-stylesheet"/>
    <![endif]-->

    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ace-skins.css"/>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ace-rtl.css"/>

    <!--[if lte IE 9]>
    <link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/ace-ie.css"/>
    <![endif]-->
    <!-- ace settings handler -->
    <script src="${basePath}/plugin/ace/assets/js/ace-extra.js"></script>

    <%--其他样式--%>
    <link rel="stylesheet" href="${basePath}/plugin/uploadifive/uploadifive.css"/>
    <%--<link type="text/css" rel="stylesheet" href="${basePath}/plugin/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>--%>
    <link type="text/css" rel="stylesheet" href="${basePath}/plugin/zTree_v3_master/css/metroStyle/metroStyle.css">
    <%--word样式--%>
    <link rel="stylesheet" type="text/css" href="${basePath}/plugin/wordExport/css/sheets-of-paper-a4.css"/>
    <%--<link rel="stylesheet" type="text/css" href="${basePath}/plugin/wordExport/css/normalize.css"/>--%>
    <%--<link rel="stylesheet" type="text/css" href="${basePath}/plugin/wordExport/css/htmleaf-demo.css"/>--%>

    <%--首页样式--%>
    <link href="${basePath}/css/index/qxj_style.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" href="${basePath}/css/index/common.css" type="text/css"/>

    <!-- HTML5shiv and Respond.js for IE8 to support HTML5 elements and media queries -->
    <!--[if lte IE 8]>
    <script src="${basePath}/plugin/ace/assets/js/html5shiv.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/respond.js"></script>
    <![endif]-->
</head>
<body class="no-skin">
<!-- #section:basics/navbar.layout -->
<%-- h-navbar  container--%>
<div id="navbar" class="navbar navbar-default    navbar-collapse      ace-save-state">
    <div class="navbar-container  ace-save-state" id="navbar-container">
        <div class="navbar-header pull-left">
            <!-- #section:basics/navbar.layout.brand -->
            <a href="#" class="navbar-brand">
                <small>
                    <i class="fa fa-leaf"></i>
                    履 职 支 撑 平 台
                </small>
            </a>

            <!-- /section:basics/navbar.layout.brand -->

            <!-- #section:basics/navbar.toggle -->
            <%--<button class="pull-right navbar-toggle navbar-toggle-img collapsed" type="button" data-toggle="collapse"--%>
            <%--data-target=".navbar-buttons,.navbar-menu">--%>
            <%--<span class="sr-only">Toggle user menu</span>--%>

            <%--<img src="${basePath}/plugin/ace/assets/avatars/user.jpg" alt="${currentUser.empName}的照片"/>--%>
            <%--</button>--%>

            <%--<button class="pull-right navbar-toggle collapsed" type="button" data-toggle="collapse"--%>
            <%--data-target="#sidebar">--%>
            <%--<span class="sr-only">Toggle sidebar</span>--%>

            <%--<span class="icon-bar"></span>--%>

            <%--<span class="icon-bar"></span>--%>

            <%--<span class="icon-bar"></span>--%>
            <%--</button>--%>

            <!-- /section:basics/navbar.toggle -->
        </div>

        <!-- #section:basics/navbar.dropdown -->
        <div class="navbar-buttons navbar-header pull-right  collapse navbar-collapse" role="navigation">
            <ul class="nav ace-nav">
                <!-- #section:basics/navbar.user_menu -->

                <li class="light-blue dropdown-modal ">
                    <a data-toggle="dropdown" href="#" class="dropdown-toggle">
                        <img class="nav-user-photo" src="${basePath}/plugin/ace/assets/avatars/avatar4.png"
                             alt="${currentUser.empName}的照片"/>
                        <span class="user-info" style="line-height: 34px;">
									欢迎您：
									${currentUser.empName}
								</span>

                        <i class="ace-icon fa fa-caret-down"></i>
                    </a>

                    <ul class="user-menu dropdown-menu-right dropdown-menu dropdown-yellow dropdown-caret dropdown-close">
                        <li>
                            <a href="#" id="modifyPassword" title="账户信息修改">
                                <i class="ace-icon fa fa-cog"></i>
                                账户信息修改
                            </a>
                        </li>

                        <%--<li>--%>
                        <%--<a href="profile.html">--%>
                        <%--<i class="ace-icon fa fa-user"></i>--%>
                        <%--Profile--%>
                        <%--</a>--%>
                        <%--</li>--%>

                        <li class="divider"></li>


                    </ul>
                </li>
                <li>
                    <a href="${basePath}/logout.do" title="退出系统" style="background: transparent;">
                        <i class="ace-icon fa fa-power-off"></i>
                        <%--退出系统--%>
                    </a>
                </li>
                <!-- /section:basics/navbar.user_menu -->
            </ul>
        </div>

       <%-- 通讯录图标，孙毅添加--%>
        <c:forEach items="${userSecPopeDomViewList}" var="userSecPopeDomView">
            <c:if test="${userSecPopeDomView.id eq '48'}">
                <div class="navbar-header pull-right">
                    <!-- #section:basics/navbar.layout.brand -->
                    <a href="#page/contacts/contacts-list?SubSecPopeDomViewId=48" class="navbar-brand">
                        <small>
                            <i class="glyphicon glyphicon-phone-alt"></i>
                        </small>
                    </a>
                </div>
            </c:if>
        </c:forEach>
        <%-- 添加结束 --%>

        <!-- /section:basics/navbar.dropdown -->
        <%--<nav role="navigation" class="navbar-menu pull-left collapse navbar-collapse">--%>
        <%--<!-- #section:basics/navbar.nav -->--%>
        <%--<ul class="nav navbar-nav">--%>
        <%--<li>--%>
        <%--<a href="#" class="dropdown-toggle" data-toggle="dropdown">--%>
        <%--Overview--%>
        <%--&nbsp;--%>
        <%--<i class="ace-icon fa fa-angle-down bigger-110"></i>--%>
        <%--</a>--%>

        <%--<ul class="dropdown-menu dropdown-light-blue dropdown-caret">--%>
        <%--<li>--%>
        <%--<a href="#">--%>
        <%--<i class="ace-icon fa fa-eye bigger-110 blue"></i>--%>
        <%--Monthly Visitors--%>
        <%--</a>--%>
        <%--</li>--%>

        <%--<li>--%>
        <%--<a href="#">--%>
        <%--<i class="ace-icon fa fa-user bigger-110 blue"></i>--%>
        <%--Active Users--%>
        <%--</a>--%>
        <%--</li>--%>

        <%--<li>--%>
        <%--<a href="#">--%>
        <%--<i class="ace-icon fa fa-cog bigger-110 blue"></i>--%>
        <%--Settings--%>
        <%--</a>--%>
        <%--</li>--%>
        <%--</ul>--%>
        <%--</li>--%>

        <%--<li>--%>
        <%--<a href="#">--%>
        <%--<i class="ace-icon fa fa-envelope"></i>--%>
        <%--Messages--%>
        <%--<span class="badge badge-warning">5</span>--%>
        <%--</a>--%>
        <%--</li>--%>
        <%--</ul>--%>

        <%--<!-- /section:basics/navbar.nav -->--%>

        <%--<!-- #section:basics/navbar.form -->--%>
        <%--<form class="navbar-form navbar-left form-search" role="search">--%>
        <%--<div class="form-group">--%>
        <%--<input type="text" placeholder="search" />--%>
        <%--</div>--%>

        <%--<button type="button" class="btn btn-mini btn-info2">--%>
        <%--<i class="ace-icon fa fa-search icon-only bigger-110"></i>--%>
        <%--</button>--%>
        <%--</form>--%>

        <%--<!-- /section:basics/navbar.form -->--%>
        <%--</nav>--%>
    </div><!-- /.navbar-container -->
</div>

<!-- /section:basics/navbar.layout -->
<div class="main-container" id="main-container" style="position: relative;">
    <script type="text/javascript">
        try {
            ace.settings.loadState('main-container', 'fixed')
        } catch (e) {
        }
    </script>

    <!-- #section:basics/sidebar.horizontal -->
    <div id="sidebar" class="sidebar  navbar-collapse ">
        <script type="text/javascript">
            try {
                ace.settings.check('sidebar', 'fixed')
            } catch (e) {
            }
        </script>
        <!-- /.sidebar-shortcuts -->
        <div class="sidebar-img">
            <ul class="nav nav-list">
                <c:forEach items="${userSecPopeDomViewList}" var="userSecPopeDomView">
                    <c:if test="${userSecPopeDomView.id eq '1'}">
                        <li class="active open ">
                            <a data-url="${userSecPopeDomView.url}" href="#${userSecPopeDomView.url}">
                                <i class="${userSecPopeDomView.description}" style="display: inline-block"></i>
                                <span class="menu-text"> 首页 </span>
                            </a>
                            <b class="arrow"></b>
                        </li>
                    </c:if>
                    <c:if test="${userSecPopeDomView.id eq '2'}">
                        <li class="">
                            <a data-url="${userSecPopeDomView.url}" href="#${userSecPopeDomView.url}">
                                <i class="${userSecPopeDomView.description}" style="display: inline-block"></i>
                                <span class="menu-text"> 我的工作面板 </span>
                            </a>
                            <b class="arrow"></b>
                        </li>
                    </c:if>
                    <c:if test="${userSecPopeDomView.type eq '1' and userSecPopeDomView.id ne '1' and userSecPopeDomView.id ne '2' }">
                        <li class="">
                            <a data-url="${userSecPopeDomView.url}" href="#${userSecPopeDomView.url}"
                               class="dropdown-toggle">
                                <i class="${userSecPopeDomView.description}" style="display: inline-block"></i>
                                <span class="menu-text">
                                        ${userSecPopeDomView.name}
                                </span>
                                <b class="arrow fa fa-angle-down"></b>
                            </a>
                            <b class="arrow"></b>
                            <ul class="submenu" style="margin-left: 25px;">
                                <c:forEach items="${userSecPopeDomViewList}" var="userSubSecPopeDomView">
                                    <c:if test="${userSubSecPopeDomView.type eq '2' and userSubSecPopeDomView.parentId eq userSecPopeDomView.id}">
                                        <li class="hover">
                                            <a data-url="${userSubSecPopeDomView.url}?SubSecPopeDomViewId=${userSubSecPopeDomView.id}"
                                               href="#${userSubSecPopeDomView.url}?SubSecPopeDomViewId=${userSubSecPopeDomView.id}"
                                               class="dropdown-toggle">
                                                <i class="menu-icon fa fa-caret-right"></i>
                                                    ${userSubSecPopeDomView.name}
                                            </a>
                                            <b class="arrow"></b>
                                            <ul class="submenu">
                                                <c:forEach items="${userSecPopeDomViewList}"
                                                           var="userLeafSecPopeDomView">
                                                    <c:if test="${userLeafSecPopeDomView.type eq '3' and userLeafSecPopeDomView.parentId eq userSubSecPopeDomView.id}">
                                                        <li class="hover">
                                                            <a data-url="${userLeafSecPopeDomView.url}?SubSecPopeDomViewId=${userLeafSecPopeDomView.id}"
                                                               href="#${userLeafSecPopeDomView.url}?SubSecPopeDomViewId=${userLeafSecPopeDomView.id}">
                                                                <i class="menu-icon fa fa-caret-right"></i>${userLeafSecPopeDomView.name}
                                                            </a>
                                                        </li>
                                                    </c:if>
                                                </c:forEach>
                                            </ul>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </ul>
                        </li>
                    </c:if>
                </c:forEach>
            </ul>
            <!-- #section:basics/sidebar.layout.minimize -->

            <!-- /section:basics/sidebar.layout.minimize -->
            <script type="text/javascript">
                try {
                    ace.settings.check('sidebar', 'collapsed')
                } catch (e) {
                }
            </script>
        </div>

    </div>
    <!-- /section:basics/sidebar.horizontal -->
    <div class="main-content" style="background: #fff;position: relative">
        <div class="main-content-inner">

            <%--导航栏--%>
            <div class="breadcrumbs ace-save-state" id="breadcrumbs">
                <ul class="breadcrumb" id="breadcrumb">
                    <li>
                        <i class="ace-icon fa fa-home home-icon"></i>
                        <a href="#page/index/main">当前位置</a>
                    </li>
                </ul>
            </div>

            <div class="page-content">
                <!-- /.ace-settings-container -->
                <%--<div class="ace-settings-container" id="ace-settings-container">--%>
                <%--<div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">--%>
                <%--<i class="ace-icon fa fa-cog bigger-130"></i>--%>
                <%--</div>--%>

                <%--<div class="ace-settings-box clearfix" id="ace-settings-box">--%>
                <%--<div class="pull-left width-50">--%>
                <%--<!-- #section:settings.container -->--%>
                <%--<div class="ace-settings-item">--%>
                <%--<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container"/>--%>
                <%--<label class="lbl" for="ace-settings-add-container">--%>
                <%--固定宽度内容--%>

                <%--</label>--%>

                <%--</div>--%>

                <%--<div class="ace-settings-item">--%>
                <%--<input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-highlight"/>--%>
                <%--<label class="lbl" for="ace-settings-highlight"> 菜单选中样式</label>--%>
                <%--</div>--%>

                <%--<!-- /section:settings.container -->--%>
                <%--</div>--%>
                <%--</div>--%>
                <%--<!-- /.ace-settings-box -->--%>
                <%--</div>--%>


                <%--内容部分--%>
                <div class="page-content-area" data-ajax-content="true">
                    <!-- ajax content goes here -->
                </div><!-- /.page-content-area -->

            </div>
            <!-- /.page-content -->

        </div>
        <div class="footer">
            <%--<div class="footer-inner">--%>
            <%--<!-- #section:basics/footer -->--%>
            <%--<div class="footer-content">--%>
            <span class="bigger-120">
							<span class="blue bolder">北京太极信息系统技术有限公司</span>

						</span>
            <%--</div>--%>
            <%--</div>--%>


        </div>
        <!-- /.main-content -->


        <a href="#" id="btn-scroll-up" class="btn-scroll-up btn btn-sm btn-inverse">
            <i class="ace-icon fa fa-angle-double-up icon-only bigger-110"></i>
        </a>
    </div>
    <!-- /.main-container -->

    <%--修改密码--%>
    <div id="modifyPasswordDialog" class="hide">
        <div class="row">
            <div class="col-xs-12">
                <div class="widget-body" style="border-top-width: 1px;background: #fff;">
                    <div class="widget-main" >
                            <form class="form-horizontal" id="modifyPasswordForm" action="${basePath}/login/modifyPassword.do"
                                  method="post">
                                <input type="hidden" name="userId" value="${curUserId}"/>

                                <div class="form-group mar_t_12">
                                    <label class="col-xs-2 no-padding-right control-label">密码：<span class="required">*</span>&nbsp;
                                    </label>

                                    <div class="col-xs-10 no-padding-left">
                                        <input type="password" name="oldPassword" id="login-old-password" class="form-control"/>
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label class="col-xs-2 no-padding-right control-label">新密码：
                                    </label>

                                    <div class="col-xs-10 no-padding-left">
                                        <input type="password" name="newPassword" id="newPassword" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <label class="col-xs-2 no-padding-right control-label">确认密码：
                                    </label>

                                    <div class="col-xs-10 no-padding-left">
                                        <input type="password" name="rePassword" class="form-control"/>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <div class="col-xs-10">
                                        <span class="red">输入正确密码即可修改用户信息</span>
                                    </div>
                                    <div class="col-xs-2">
                                        <button class="btn btn-success btn-sm pull-right" type="button"
                                                id="passwardBtn">
                                            <span class="ace-icon fa fa-lock icon-on-right bigger-110"></span>
                                            修改密码
                                        </button>
                                    </div>
                                </div>
                            </form>
                            <div class="row">
                                <div class="space-10"></div>
                            </div>
                            <form class="form-horizontal" id="userInfoForm" action="${basePath}/login/editUserInfo.do"
                                  method="post">

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-userInfoId">用户姓名:</label>
                                            <div class="col-sm-8">
                                                <input type="text" id="form-field-userInfoId" name="userInfoId"
                                                       class="hide" value="${curUserId}"/>
                                                <input type="text" class="form-control" id="empName"
                                                       name="empName" value="" style="cursor: pointer;"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="mobile">手机号:</label>
                                            <div class="col-sm-8">
                                                <input type="text" id="mobile" name="mobile"
                                                       class="form-control"/>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="email">邮箱:</label>
                                            <div class="col-sm-8">
                                                <input type="text" id="email" name="email"
                                                       class="form-control"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="fax">传真:</label>
                                            <div class="col-sm-8">
                                                <input type="text" id="fax" name="fax"
                                                       class="form-control"/>

                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="notes">备注:</label>
                                            <div class="col-sm-8">
                                                <input type="text" id="notes" name="notes"
                                                       class="form-control"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <button class="btn btn-success btn-sm pull-right" type="button"
                                                id="userInfoBtn">
                                            <span class="ace-icon fa fa-lock icon-on-right bigger-110"></span>
                                            修改个人信息
                                        </button>
                                    </div>
                                </div>
                            </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 声音提醒 -->
    <div id="alertAudio" class="hide">
        <audio id="media" src="${basePath}/audio/notice.mp3" loop="loop"> 您的浏览器不支持HTML5，请升级浏览器</audio>
    </div>

    <!-- basic scripts -->
    <script type="text/javascript">
        window.jQuery || document.write("<script src='${basePath}/plugin/ace/assets/js/jquery.js'>" + "<" + "/script>");
    </script>
    <!-- <![endif]-->

    <!--[if IE]>
    <script type="text/javascript">
        window.jQuery || document.write("<script src='${basePath}/plugin/ace/assets/js/jquery1x.js'>" + "<" + "/script>");
    </script>
    <![endif]-->

    <!--[if lte IE 8]>
    <script src="${basePath}/plugin/ace/assets/js/excanvas.js"></script>
    <![endif]-->
    <script src="${basePath}/plugin/ace/assets/js/bootstrap.js"></script>
    <%--上传控件--%>
    <script type="text/javascript" src="${basePath}/plugin/uploadifive/jquery.uploadifive.js"></script>
    <!-- ace scripts -->
    <script src="${basePath}/plugin/ace/assets/js/jquery-ui.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/jquery-ui.custom.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/date-time/moment.js"></script>
    <script src="${basePath}/plugin/jquery-ui-datetimepicker/js/jquery-ui-timepicker-addon.js"></script>
    <script src="${basePath}/plugin/jquery-ui-datetimepicker/js/jquery-ui-timepicker-zh-CN.js"></script>
    <script src="${basePath}/plugin/jquery-ui-datetimepicker/js/jquery-ui-datepicker-zh-CN.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/ace/elements.scroller.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/ace/ace.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/ace/ace.ajax-content.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/ace/ace.widget-box.js"></script>

    <script src="${basePath}/demo/assets/js/ace/elements.aside.js"></script>
    <script src="${basePath}/demo/assets/js/ace/ace.touch-drag.js"></script>
    <script src="${basePath}/demo/assets/js/ace/ace.sidebar.js"></script>
    <script src="${basePath}/demo/assets/js/ace/ace.sidebar-scroll-1.js"></script>
    <script src="${basePath}/demo/assets/js/ace/ace.submenu-hover.js"></script>
    <script src="${basePath}/demo/assets/js/ace/ace.settings.js"></script>
    <script src="${basePath}/demo/assets/js/ace/ace.settings-rtl.js"></script>
    <script src="${basePath}/demo/assets/js/ace/ace.settings-skin.js"></script>
    <!--消息-->
    <script src="${basePath}/plugin/ace/assets/js/jquery.gritter.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/date-time/bootstrap-datepicker.js"></script>
    <!-- wizard控件-->
    <script src="${basePath}/plugin/ace/assets/js/fuelux/fuelux.wizard.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/ace/elements.wizard.js"></script>
    <%--验证控件--%>
    <script src="${basePath}/plugin/jquery.form.js"></script>
    <script src="${basePath}/plugin/jquery-validation/jquery.validate.min.js"></script>
    <script src="${basePath}/plugin/jquery-validation/additional-methods.min.js"></script>
    <script src="${basePath}/plugin/jquery-validation/localization/messages_zh.min.js"></script>
    <%--弹框控件--%>
    <script src="${basePath}/plugin/bootstrap-modal/js/bootstrap-modal.js"></script>
    <script src="${basePath}/plugin/bootstrap-modal/js/bootstrap-modalmanager.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/bootbox.js"></script>
    <!--引用echarts-->
    <script src="${basePath}/plugin/echarts-2.2.7/echarts-all.js"></script>
    <!--引用jqgrid-->
    <script src="${basePath}/plugin/ace/assets/js/jqGrid/jquery.jqGrid.js"></script>
    <script src="${basePath}/plugin/ace/assets/js/jqGrid/i18n/grid.locale-cn.js"></script>
    <script src="${basePath}/plugin/jquery.jqGrid-4.4.4/plugins/grid.postext.js"></script>

    <!--引用bootstrap table-->
    <script src="${basePath}/plugin/bootstrap-table-develop/dist/bootstrap-table.min.js"></script>
    <script src="${basePath}/plugin/bootstrap-table-develop/dist/bootstrap-table-locale-all.min.js"></script>

    <!--引用handleBar-->
    <script src="${basePath}/plugin/handlebars-v4.0.11.js"></script>

    <!--引用二维码-->
    <script type="text/javascript" src="${basePath}/plugin/jquery-qrcode-master/jquery.qrcode.min.js"></script>

    <!--打印插件-->
    <%--<script type="text/javascript" src="${basePath}/plugin/LodopFuncs.js"></script>--%>
    <!--引用ueditor-->
    <script charset="utf-8" src="${basePath}/plugin/ueditor1_4_3_3/utf8-jsp/ueditor.config.js"></script>
    <script charset="utf-8" src="${basePath}/plugin/ueditor1_4_3_3/utf8-jsp/ueditor.all.min.js"></script>
    <script charset="utf-8" src="${basePath}/plugin/ueditor1_4_3_3/utf8-jsp/lang/zh-cn/zh-cn.js"></script>
    <%--Ztree控件--%>
    <%--<script type="text/javascript" src="${basePath}/plugin/zTree_v3/js/jquery.ztree.all-3.5.min.js"></script>--%>
    <script type="text/javascript" src="${basePath}/plugin/zTree_v3_master/js/jquery.ztree.all.min.js"></script>

    <%--<script type="text/javascript" src="${basePath}/plugin/zTree_v3_master/js/jquery.ztree.core.js"></script>--%>
    <script type="text/javascript" src="${basePath}/plugin/zTree_v3_master/js/jquery.ztree.exhide.js"></script>
    <script type="text/javascript" src="${basePath}/plugin/zTree_v3_master/demo/js/fuzzysearch.js"></script>
    <%--lodash--%>
    <script src="${basePath}/plugin/lodash-master/lodash.js"></script>

    <script src="${basePath}/plugin/jquery.serializeObject.js"></script>
    <script src="${basePath}/plugin/global.js"></script>
    <!-- inline scripts related to this page -->
    <script type="text/javascript">

        jQuery(function ($) {
            var $sidebar = $('.sidebar').eq(0);
            if (!$sidebar.hasClass('h-sidebar')) return;

            $(document).on('settings.ace.top_menu', function (ev, event_name, fixed) {
                if (event_name !== 'sidebar_fixed') return;

                var sidebar = $sidebar.get(0);
                var $window = $(window);

                //return if sidebar is not fixed or in mobile view mode
                var sidebar_vars = $sidebar.ace_sidebar('vars');
                if (!fixed || (sidebar_vars['mobile_view'] || sidebar_vars['collapsible'])) {
                    $sidebar.removeClass('lower-highlight');
                    //restore original, default marginTop
                    sidebar.style.marginTop = '';

                    $window.off('scroll.ace.top_menu')
                    return;
                }
                var done = false;
                $window.on('scroll.ace.top_menu', function (e) {

                    var scroll = $window.scrollTop();
                    scroll = parseInt(scroll / 4);//move the menu up 1px for every 4px of document scrolling
                    if (scroll > 17) scroll = 17;


                    if (scroll > 16) {
                        if (!done) {
                            $sidebar.addClass('lower-highlight');
                            done = true;
                        }
                    }
                    else {
                        if (done) {
                            $sidebar.removeClass('lower-highlight');
                            done = false;
                        }
                    }

                    sidebar.style['marginTop'] = (17 - scroll) + 'px';
                }).triggerHandler('scroll.ace.top_menu');

            }).triggerHandler('settings.ace.top_menu', ['sidebar_fixed', $sidebar.hasClass('sidebar-fixed')]);

            $(window).on('resize.ace.top_menu', function () {
                $(document).triggerHandler('settings.ace.top_menu', ['sidebar_fixed', $sidebar.hasClass('sidebar-fixed')]);
            });


        });

        //首次登陆时摘报提示
        var firstTraceNotice = true;
        var firstSpecNotice = true;
        var pasterMgr;  //wordpaster控件
        var playnow = false;//判断音乐是否现正在响
        var alertAudio;
        var $downloadDialog = $("#download-dialog");

        $(document).ready(function () {
            //加载首页
            G.pjaxLoadPageContentDiv("#page/index/main");

            //紧急通知声音
            alertAudio = document.getElementById("media");

            //菜单调整
            $("#sidebar").find('.submenu').each(function () {
                var childNode = $(this).children();
                if (childNode.length === 0) {
                    $(this).prev().remove();
                    $(this).prev().removeClass('dropdown-toggle');
                    $(this).remove();
                }
            });

            /*--此处以下都是系统定时刷新数据--*/

            //密码修改提醒
            freshPassword();


            /*--此处以上都是系统定时刷新数据--*/

            //修改密码
            var $modifyPasswordForm = $('#modifyPasswordForm');
            var $modifyPasswordDialog = $('#modifyPasswordDialog');
            var $userInfoForm = $('#userInfoForm');

            $modifyPasswordForm.tjForm({
                form: {
                    success: function (data) {
                        if (data) {

                            G.alert({message: "密码修改成功！"});
                            $modifyPasswordForm.tjForm('resetForm');
                        }
                        else {
                            G.alert({message: "密码修改失败！"});
                        }
                    }
                },
                validate: {
                    focusInvalid: false,
                    rules: {
                        oldPassword: {
                            required: true,
                            remote: {
                                url: "${basePath}/login/checkOldPassword.do",
                                type: "post",               //数据发送方式
                                dataType: "json",           //接受数据格式
                                async: false,	        //防止重复提交
                                data: {
                                    userId: '${curUserId}',          //要传递的数据
                                    oldPassword: function () {
                                        return $("#login-old-password").val();
                                    }
                                }
                            }
                        },
                        newPassword: {
                            required: true
                        },
                        rePassword: {
                            required: true,
                            equalTo: '#newPassword'
                        }
                    },
                    messages: {
                        oldPassword: {
                            required: "旧密码必须填写.",
                            remote: "旧的密码不正确."
                        },
                        newPassword: {
                            required: "新密码必须填写."
                        },
                        rePassword: {
                            required: "确认密码必须填写.",
                            equalTo: '确认密码必须跟密码相同'
                        }
                    }
                }
            })
            $passwardBtn.click(function () {
                $modifyPasswordForm.submit();
            })


            $userInfoForm.tjForm({
                validate: {
                    focusInvalid: false,
                    rules: {
                        empName: {
                            required: true,
                            maxlength: 32
                        },
                        mobile: {
                            isMobile: true
                        },
                        email: {
                            email: true
                        },
                        fax: {
                            isFax: true
                        }
                    },
                    messages: {
                        empName: {
                            required: "用户名必须填写！"
                        },
                        mobile: {
                            isMobile: "请填写正确的手机号码！"
                        },
                        email: {
                            email: "请填写正确的邮箱！"
                        },
                        fax: {
                            isFax: "请填写正确的传真！"
                        }
                    }
                },
                form: {
                    success: function (data) {
                        if (data) {

                            G.alert({message: "用户信息修改成功！"});
                        }
                        else {
                            G.alert({message: "用户信息修改失败！"});
                        }
                    }
                }
            })
            $userInfoBtn.click(function () {
                $userInfoForm.submit();
            })
            $('#modifyPassword').click(function () {
                loadUserInfo();
                $modifyPasswordDialog.removeClass('hide').dialog({
                    resizable: false,
                    height: 'auto',
                    maxHeight: 600,
                    width: 800,
                    close: function () {
                        $modifyPasswordDialog.addClass('hide');
                        $modifyPasswordForm.tjForm('resetForm');
                        $userInfoForm.tjForm('resetForm');
                    },
                    modal: true,
                    title: "<div class='widget-header header-bg'><h4 class='smaller' style='margin-top: 12px'><i class='ace-icon fa fa-user red'></i>&nbsp;&nbsp;个人信息修改</h4></div>",
                    title_html: true,
                    buttons: [

                        {
                            html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 关闭",
                            "class": "btn btn-warning btn-sm",
                            click: function () {
                                $(this).dialog("close");
                            }
                        }
                    ]
                })
            });
            var str = "!important;"
            var htmlHeight = $("html").height() - $("#navbar").height();
            $(".sidebar-img").css("height", "" + htmlHeight + "");



        });

        var $empName = $("#empName");
        var $mobile = $("#mobile");
        var $email = $("#email");
        var $fax = $("#fax");
        var $notes = $("#notes");
        var $passwardBtn = $("#passwardBtn");
        var $userInfoBtn = $("#userInfoBtn");
        var $loginOldPassword = $("#login-old-password");
        $loginOldPassword.unbind().bind('change', function () {
            var value = $(this).val();
            $.post("${basePath}/index/checkOldPassword.do", {
                userId: '${curUserId}',
                oldPassword: value
            }, function (response) {
                if (response.result == "true") {
                    $empName.attr("disabled", false);
                    $mobile.attr("disabled", false);
                    $email.attr("disabled", false);
                    $fax.attr("disabled", false);
                    $notes.attr("disabled", false);
                    $userInfoBtn.removeClass('hide');
                } else {
                    $empName.attr("disabled", true);
                    $mobile.attr("disabled", true);
                    $email.attr("disabled", true);
                    $fax.attr("disabled", true);
                    $notes.attr("disabled", true);
                    $userInfoBtn.addClass('hide');

                }
            }, 'json')
        })

        function loadUserInfo() {
            $.post("${basePath}/index/loadUserInfo.do", {id: "${curUserId}"}, function (response) {

                if (response.result) {
                    var userInfo = response.userInfo;
                    $empName.val(userInfo.empName);
                    $mobile.val(userInfo.mobile);
                    $email.val(userInfo.email);
                    $fax.val(userInfo.fax);
                    $notes.val(userInfo.notes);
                    $empName.attr("disabled", true);
                    $mobile.attr("disabled", true);
                    $email.attr("disabled", true);
                    $fax.attr("disabled", true);
                    $notes.attr("disabled", true);
                    $userInfoBtn.addClass('hide');
                }
            }, 'json')
        }


        //检测浏览器是否支持html5
        if (!window.applicationCache) {
            jQuery.gritter.add({
                title: '<div style="margin: 0 auto;width: 350px;">您的浏览器版本过低，请尽快升级!</div>',
                text: '<div style="margin: 0 auto;width: 100px;"><button class="html5-Remind btn btn-mini btn-success">&nbsp;&nbsp;确 定&nbsp;&nbsp;</button></div>',
                sticky: true,
                class_name: 'gritter-center gritter-info'
            });

            //确定按钮
            $(".html5-Remind").unbind().click(function () {

                $(this).parent().parent().parent().find('.gritter-close').trigger('click');
            });

        }


        function freshPassword() {
            var url = "${basePath}/index/freshPassword.do?rd=" + Math.random();
            $.getJSON(url, function (data) {
                if (data.result) {
                    if (data.password) {
                        jQuery.gritter.add({
                            title: '<div style="margin: 0 auto;width: 250px;">当前密码为初始密码，请尽快修改！</div>',
                            text: '<div style="margin: 0 auto;width: 100px;"><button class="password-Remind btn btn-mini btn-success">&nbsp;&nbsp;确 定&nbsp;&nbsp;</button></div>',
                            sticky: true,
                            class_name: 'gritter-center gritter-info'
                        });

                        //确定按钮
                        $(".password-Remind").unbind().click(function () {

                            $(this).parent().parent().parent().find('.gritter-close').trigger('click');
                        });
                    }
                }
            });
        }

        //系统全局变量
        //记录部门结构树
        TREE_NODE = ${treeNode};
        //记录表格初始化参数
        initGridParam = { //用于记录表格初始化参数
            currentPage : 1,//记录表格页
            selectedRowIndex : 0,//记录表格索引位置
            gridSearchForm : null//记录表格查询条件
        }
    </script>
</body>
</html>
