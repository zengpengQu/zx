<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath =  path;
    pageContext.setAttribute("basePath", basePath);
%>
<script>
    var basePath = "${basePath}";
</script>
<title>履职支撑平台</title>
<link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/jquery-ui.css"/>
<link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/jquery-ui.custom.css"/>
<link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/chosen.css"/>
<link type="text/css" rel="stylesheet" href="${basePath}/plugin/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>


<style>
    .modelLi{
        font-size: 14px;
        margin-left: 5px;
        margin-top: 20px;
        cursor: pointer;
        font-family: "微软雅黑";
    }
    .modelLi:hover {
        transition: border linear .4s,text-shadow linear .4s;
        /*border-color: rgba(141,39,142,.75);*/
        text-shadow: 2px 3px 2px rgba(135,184,127,1);
        text-decoration:underline ;
        color:#307ecc ;
        /*font-size: 15px;*/
    }

     .required {
         color: #e02222;
         padding-left: 5px;
     }
    .uploadifive-button {
        background-color: green;
        border: none;
        padding: 0;
    }


</style>
<label class="btn btn-success  btn-sm " id="refresh" style="position: fixed;left: 1200px;z-index: 9998">
    <i class="ace-icon fa fa-refresh bigger-160"></i>
    刷新
</label>
<div style="background-color: white;">
    <div class="boxcenter position_r">
        <div class="positionimg"><img src="${basePath}/images/index/qxj_arrow2.png" width="28" height="29"/></div>
        <div class="positioninfo" style="color: #000000;">您的当前位置：首页
            <i class="ace-icon fa fa-angle-double-right"></i>
            <small style="color: cornflowerblue;">
                我的工作版面
            </small>
        </div>
    </div>
    <div class="row">
        <div class="col-xs-12">
            <div class="row">
                <div class="col-xs-12">
                    <h3 class="header border lighter blue">
                        <i class="ace-icon glyphicon glyphicon-plus orange"></i>新增

                    </h3>
                    <div class="center">
                        <c:forEach items="${curOperateAuth}" var="curOpertate">
                            <c:if test="${'4_01' eq  curOpertate}">
                                <button class="btn btn-primary btn-sm bigger-120" id="add-new-emergency">
                                    <i class="ace-icon fa fa-bell bigger-160"></i>
                                    应急事件
                                </button>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${curOperateAuth}" var="curOpertate">
                            <c:if test="${'8_01' eq  curOpertate}">
                                <button class="btn btn-info btn-sm bigger-120" id="add-new-record" >
                                    <i class="ace-icon fa fa-bolt bigger-160"></i>
                                    突发事件
                                </button>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${curOperateAuth}" var="curOpertate">
                            <c:if test="${'9_01' eq  curOpertate}">
                                <button class="btn btn-success btn-sm bigger-120" id="inner-add-new-record">
                                    <i class="ace-icon fa fa-gg-circle bigger-160"></i>
                                    内部突发
                                </button>
                            </c:if>
                        </c:forEach>
                        <c:forEach items="${curOperateAuth}" var="curOpertate">
                            <c:if test="${'13_01' eq  curOpertate}">
                                <button class="btn btn-warning btn-sm bigger-120" id="addWork">
                                    <i class="ace-icon fa fa-pencil-square-o bigger-160"></i>
                                    特别工作
                                </button>
                            </c:if>
                        </c:forEach>
                        <c:if test="${orgLeaf eq  0}">
                            <c:forEach items="${curOperateAuth}" var="curOpertate">
                                <c:if test="${'8_05' eq  curOpertate}">
                                    <button class="btn btn-purple btn-sm bigger-120" id="add-new-duty">
                                        <i class="ace-icon fa fa-calendar bigger-160"></i>
                                        值班表
                                    </button>
                                </c:if>
                            </c:forEach>
                        </c:if>
                        <button class="btn btn-pink btn-sm bigger-120" id="add-message-btn">
                            <i class="ace-icon fa fa-envelope-o bigger-160"></i>
                            站内信
                        </button>
                        <button class="btn btn-danger btn-sm bigger-120" id="add-notice">
                            <i class="ace-icon fa fa-exclamation-circle bigger-160"></i>
                            紧急通知
                        </button>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-xs-12">
                    <h3 class="header border lighter blue">
                        <i class="ace-icon fa fa-star orange"></i>我的事件
                        <a id="myEvent" class="badge badge-info pull-right" href="#page/emeg-manage/list">更多</a>
                    </h3>

                    <div class="widget-box transparent" id="recent-box">
                        <div class="tabbable">
                            <ul class="nav nav-tabs" id="recent-tab">
                                <li class="active">
                                    <a data-toggle="tab" href="#task-tab" id="emegTab" aria-expanded="true" class="bigger-120"><span></span>应急事件</a>
                                </li>

                                <li>
                                    <a data-toggle="tab" href="#task-tab2" id="accdTab" aria-expanded="false" class="bigger-120">突发事件</a>
                                </li>

                                <li>
                                    <a data-toggle="tab" href="#task-tab3" id="innerAccdTab"  aria-expanded="false" class="bigger-120">内部突发事件</a>
                                </li>

                                <li class="">
                                    <a data-toggle="tab" href="#task-tab4" id="specTab" aria-expanded="false" class="bigger-120">特别工作</a>
                                </li>
                            </ul>

                            <div class="tab-content padding-8">
                                <div id="task-tab" class="tab-pane active">
                                    <div class="message-container" id="emeg-height" style="height: 160px">
                                        <div class="message-list-container scrollable" id="emeg-data-size" data-size="160">
                                            <div class="message-list" id="emegRecord">

                                            </div>
                                        </div>
                                    </div>
                                    <!-- /section:pages/dashboard.tasks -->
                                </div>

                                <div id="task-tab2" class="tab-pane">
                                    <div class="message-container" id="out-accd-div"  style="height: 160px">
                                        <div class="message-list-container scrollable" id="out-scrollable" data-size="160">
                                            <div class="message-list" id="accdRecord">

                                            </div>
                                        </div>
                                    </div>
                                    <!-- /section:pages/dashboard.tasks -->
                                </div>

                                <div id="task-tab3" class="tab-pane">
                                    <div class="message-container"  id="inner-accd-div"  style="height: 160px">
                                        <div class="message-list-container scrollable" id="inner-scrollable"  data-size="160">
                                            <div class="message-list" id="innerAccdRecord">

                                            </div>
                                        </div>
                                    </div>
                                    <!-- /section:pages/dashboard.tasks -->
                                </div>

                                <div id="task-tab4" class="tab-pane">
                                    <div class="message-container" id="spec-record-div" style="height: 160px">
                                        <div class="message-list-container scrollable"  id="spec-scrollable" data-size="160">
                                            <div class="message-list" id="specRecord">

                                            </div>
                                        </div>
                                    </div>
                                    <!-- /section:pages/dashboard.tasks -->
                                </div>
                            </div>

                        </div>
                        <!-- /.widget-main -->
                    </div>
                    <!-- /.widget-body -->
                </div>
            </div>
            <div class="hr hr16 hr-dotted"></div>

            <div class="row">
                <div class="col-xs-6">
                    <h3 class="header border lighter blue">
                        <i class="ace-icon fa fa-bullhorn orange"></i>紧急通知
                        <a class="badge badge-info pull-right" id="toRead" href="#page/notice/receive">更多</a>
                    </h3>
                    <div class="message-container" style="height: 270px">
                        <div class="message-list-container scrollable"  data-size="270">
                            <div class="message-list" id="receive">

                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <h3 class="header border lighter blue">
                        <i class="ace-icon fa  fa-envelope orange"></i>站内信
                        <a class="badge badge-info pull-right" href="#page/message/manage">更多</a>
                    </h3>
                    <div class="message-container" style="height: 270px">
                        <div class="message-list-container scrollable"  data-size="270">
                            <div class="message-list" id="message">

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="hr hr16 hr-dotted"></div>

            <div class="row">
                <div class="col-xs-12">
                    <h3 class="header border lighter blue">
                        <i class="ace-icon fa fa-calendar orange"></i>值班表
                        <a class="badge badge-info pull-right" href="#page/duty-record/show">更多</a>
                    </h3>
                    <div class="message-container" id="duty-div" style="height: 100px">
                        <div class="message-list-container scrollable" id="duty-scrollable"  data-size="100">
                            <div class="message-list" id="duty">

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="hr hr16 hr-dotted"></div>

        </div>
    </div>

    <%--新增应急事件dialog--%>
    <div class="col-xs-12">
        <div id="new-emergency-dialog" class="hide">
            <form class="form-horizontal" id="emegRecordForm" role="form" action="${basePath}/emeg-manage/save.do" method="post">
                <div class="col-xs-12">
                    <input type="hidden" id="fromId" name="fromId"/>
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left">事件名称：<span class="required">*</span></label>

                        <div class="col-xs-10">
                            <input type="text" id="emegTitle" name="title" placeholder="事件名称" class="form-control"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-xs-4 control-label no-padding-left"> 发布机构：<span class="required">*</span></label>

                        <label id="emeg-new-record-orgName" class="col-xs-8 control-label green" style="text-align: left;font-weight: bold;"
                                >${orgName}</label>
                        <input type="hidden" name="dicOrganization.id" value="${orgId}">
                        <input type="hidden" id="emStatus" name="emStatus">
                        <input type="hidden" id="isLeaf" name="isLeaf" value="${orgLeaf}">
                        <input type="hidden" name="id" id="new-record-id">
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-xs-4 control-label no-padding-left">事件类别：<span class="required">*</span></label>

                        <div class="col-xs-8">
                            <input type="hidden"  name="dicEmegType.id" id="emTypeHidden">
                            <input type="text" style="width:100%;background-color: white !important;" readonly="readonly" id="emType1" name="emType" placeholder="点击选择" />
                        </div>
                    </div>
                </div>

                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-xs-4 control-label no-padding-left" for="posgeo">关注点：</label>

                        <div class="col-xs-8">
                            <input type="text" id="posgeo1" placeholder="点击描绘" class="form-control" readonly="readonly"/>
                            <input type="hidden" id="posgeoValue1" name="posgeo" placeholder="点击描绘" class="form-control" readonly="readonly"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-xs-4 control-label no-padding-left" for="definePlace">手输区域：</label>

                        <div class="col-xs-8">
                            <input type="text" id="definePlace1" name="definePlace" placeholder="手输区域" class="form-control"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-xs-4 control-label no-padding-left" >签发时间：<span class="required">*</span></label>

                        <div class="col-xs-8">
                            <div class="input-group date" style="width:100%;">
                                <input class="form-control date-time-picker" id="beginTime" name="startTime" placeholder="签发时间" type="text">
                                <span class="input-group-addon">
                                    <i class="fa fa-calendar bigger-110"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-xs-4 control-label no-padding-left">响应级别：<span class="required">*</span></label>

                        <div class="col-xs-8">
                            <select id="emLevel" name="emegLevel.id" style="width:100%;">
                                <c:forEach items="${levelList}" var="level" varStatus="count">
                                    <option value="${level.id}"
                                            <c:if test="${count.index == 0}">
                                                selected
                                            </c:if>
                                            >${level.levelName}</option>
                                </c:forEach>
                            </select>

                        </div>
                    </div>
                </div>

                <div class="col-xs-12">
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left" for="provNames">应急区域：<span class="required">*</span></label>

                        <div class="col-xs-10">
                            <input type="hidden" id="provIds" name="provIds">
                            <textarea class="form-control " style="background-color: white !important;" readonly="readonly" id="provNames" name="provNames" placeholder="应急区域" ></textarea>
                        </div>
                    </div>
                </div>
                <div class="col-xs-12">
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left">事件内容：<span class="required">*</span></label>
                        <div class="col-xs-10">
                            <!-- 加载编辑器的容器 -->
                            <textarea id="emeg-content" name="content" />

                        </div>
                    </div>
                </div>
                <input id="townFileArray" type="hidden" name="townFileArray"/>
                <div id="fileUp" class="form-group hide">
                    <label class="col-xs-2 control-label no-padding-left"> 附件：</label>
                    <div class="col-xs-10 text-left">
                        <input  id="town-emergency-file"  type="file"/>
                        <div id="town-emergency-file-queue"></div>
                    </div>
                </div>
            </form>
        </div>
    </div>
    <%--新增应急事件结束--%>

    <%--事件类型dialog--%>
    <div class="col-xs-12">
        <div id="type-dialog" class="hide">
            <div class="tabbable">
                <ul class="nav nav-tabs">
                    <c:forEach items="${typeList}" var="type">
                    <c:if test="${type.parentId == '-1' && type.isActive == 1}">
                    <li <c:if test="${type.seqNo==4}">class="active"</c:if>>
                        <a data-toggle="tab" href="#emergency-${type.id}">
                                ${type.typeName}
                        </a>
                        </c:if>
                        </c:forEach>
                </ul>
                <div class="tab-content " >
                    <c:forEach items="${typeList}" var="type">
                        <c:if test="${type.parentId == '-1' && type.isActive == 1}">

                            <div id="emergency-${type.id}"
                                 <c:if test="${type.seqNo==4}">class="tab-pane fade in active scrollable"</c:if>
                                 <c:if test="${type.seqNo !=4}">class="tab-pane fade scrollable"</c:if> data-size="380">
                                <c:forEach items="${typeList}" var="leafType">
                                    <c:if test="${leafType.parentId == type.id}">
                                        <div class="col-xs-4">
                                            <i class="ace-icon glyphicon glyphicon-asterisk blue"></i>
                                            <span class="modelLi" typeName="${leafType.typeName}" typeId="${leafType.id}">
                                                    ${leafType.typeName}
                                            </span>
                                        </div>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>
    <%--事件类型结束--%>

    <div class="col-xs-12">
        <div id="district-dialog" class="hide">
            <div id="tip-info" class="alert alert-block alert-info">
                <i class="ace-icon glyphicon glyphicon-refresh  green"></i>
                <strong class="green">
                    正在加载应急区域！请稍等
                </strong>
            </div>
            <ul id="districtList" class="ztree"></ul>
        </div>
    </div>

    <%--新增突发事件dialog--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="new-record-dialog" class="hide">
                <form class="form-horizontal" id="new-record-form" role="form"  method="post">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left"> 信息来源：<span class="required">*</span></label>

                            <label id="new-record-orgName" class="col-xs-8 control-label green" style="text-align: left;font-weight: bold;"
                                    ></label>
                            <input type="hidden" id="record-id" name="recordId">
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">事件标题：<span class="required">*</span></label>

                            <div class="col-xs-10">
                                <input type="text" id="title" name="title" class="form-control" placeholder="事件标题" />
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left">事件类别：<span class="required">*</span></label>

                            <div class="col-xs-8">
                                <select id="type" name="type" class="form-control">
                                    <c:forEach items="${dicAccdTypeList}" var="accdType">
                                        <option value="${accdType.id}">${accdType.typeName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left">签发人：<span class="required">*</span></label>

                            <div class="col-xs-8">
                                <input type="text" id="issuer" name="issuer" placeholder="签发人" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" for="content">事件内容：<span class="required">*</span></label>
                            <div class="col-xs-10">
                                <!-- 加载编辑器的容器 -->
                                <textarea id="content" name="content" />

                            </div>
                        </div>
                    </div>
                    <!--附件  -->
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" >
                                已上传附件：
                            </label>
                            <div class="col-xs-10">
                                <div id="ready-record-file">

                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" >
                                附件：<span class="required">*</span>
                            </label>
                            <div class="col-xs-10">
                                <input id="record-file"  type="file"/>


                                <div id="record-file-queue"></div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%--新增突发事件dialog结束--%>

    <%--新增内部突发事件dialog--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="inner-new-record-dialog" class="hide">
                <form class="form-horizontal" id="inner-new-record-form" role="form" method="post">
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">事件标题：<span
                                    class="required">*</span></label>

                            <div class="col-xs-10">
                                <input type="text" id="innerTitle" name="title" class="form-control" placeholder="事件标题"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left"> 信息来源：<span class="required">*</span></label>

                            <label class="col-xs-8 control-label green"
                                   style="text-align: left;font-weight: bold;"
                                    >${orgName}</label>
                            <input type="hidden" id="inner-record-id" name="recordId">
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left">签发人：<span
                                    class="required">*</span></label>

                            <div class="col-xs-8">
                                <input type="text" id="innerIssuer" name="issuer" placeholder="签发人" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" for="innerContent">事件内容：<span
                                    class="required">*</span></label>

                            <div class="col-xs-10">
                                <!-- 加载编辑器的容器 -->
                                <textarea id="innerContent" name="content"/>

                            </div>
                        </div>
                    </div>
                    <!--附件  -->
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">
                                已上传附件：
                            </label>

                            <div class="col-xs-10">
                                <div id="inner-ready-record-file">

                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">
                                附件：<span class="required">*</span>
                            </label>

                            <div class="col-xs-10">
                                <input id="inner-record-file" type="file"/>


                                <div id="inner-record-file-queue"></div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%--新增内部突发事件dialog结束--%>

<%--新增特别工作dialog--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="spec-add-dialog" class="hide">
                <form class="form-horizontal" id="specAddForm">
                    <div class="form-group"  style="margin-top: 30px">
                        <input type="hidden" id="spec-id" name="id">
                        <input type="hidden" id="spec-status" name="status">
                        <label class="col-xs-2 control-label no-padding-left">工作名称：<span class="required">*</span></label>
                        <div class="col-xs-10 text-left">
                            <input type="text" id="workTitle" name="title" placeholder="工作名称" class="form-control"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left">
                            签发人：<span class="required">*</span>
                        </label>

                        <div class="col-xs-4">
                            <input type="text" placeholder="签发人" id="specAddIssueEmp" name="issueEmp"
                                   class="form-control"/>
                        </div>
                        <label class="col-xs-2 control-label no-padding-left">
                            签发时间：<span class="required">*</span>
                        </label>

                        <div class="col-xs-4">
                            <div class="input-group date" style="width:100%;">
                                <input id="specAddIssueTime"
                                       class="form-control date-time-picker" style="z-index: 999999"
                                       name="issueTime" placeholder="签发时间" type="text">
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-calendar bigger-110"></i>
                                                        </span>
                            </div>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left">区域信息：<span
                                class="required">*</span></label>

                        <div class="col-xs-10">
                            <input type="hidden" id="specAddProvIds" name="provIds">
                                    <textarea class="form-control " readonly="readonly" id="specAddProvNames"
                                              style="background-color: white !important;width:100%;"
                                              name="provNames" placeholder="区域信息"></textarea>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left">工作内容：<span class="required">*</span></label>
                        <label class="col-xs-10">
                            <textarea id="specContent" name="content"></textarea>
                        </label>
                    </div>
                    <div id="specAddAttach" class="form-group hide">
                        <label class="col-xs-2 control-label no-padding-left"> 已上传附件：</label>

                        <div class="col-xs-10 text-left">
                            <div id="spec-exist-record-file"></div>
                        </div>
                    </div>

                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" >
                                附件：<span class="required">*</span>
                            </label>
                            <div class="col-xs-5">
                                <input id="spec-record-file"  type="file"/>


                                <div id="spec-record-queue"></div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%--新增特别工作dialog结束--%>
    <div class="col-xs-12">
        <div id="spec-district-dialog" class="hide">
            <div id="spec-tip-info" class="alert alert-block alert-info">
                <i class="ace-icon glyphicon glyphicon-refresh  green"></i>
                <strong class="green">
                    正在加载应急区域！请稍等
                </strong>
            </div>
            <ul id="specDistrictList" class="ztree"></ul>
        </div>
    </div>


<%--新增值班表dialog--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="duty-modal-relieve" class="hide" style="padding: 0px">
                <div class="modal-content-relieve" style="width: 100%">
                    <div id="duty-modal-wizard-relieve">
                        <div class="modal-header">
                            <ul class="steps">
                                <li data-step="1" class="active">
                                    <span class="step">1</span>
                                    <span class="title">添加值班</span>
                                </li>

                                <li data-step="2">
                                    <span class="step">2</span>
                                    <span class="title">紧急通知</span>
                                </li>

                            </ul>
                        </div>
                        <div class="modal-body step-content" style="height: 450px">
                            <div class="step-pane active" data-step="1">
                                <div class="scrollable" data-size="400">
                                    <div class="col-xs-12">
                                        <form class="form-horizontal" id="dutyRecordForm" role="form">
                                            <div class="col-xs-12">
                                                <div class="form-group">
                                                    <input type="hidden" id="duty-id">
                                                    <label class="col-xs-2 control-label no-padding-left">值班名称：<span
                                                            class="red">*</span></label>

                                                    <div class="col-xs-10">
                                                        <input type="text" id="dutyName" name="dutyName"
                                                               placeholder="值班名称"
                                                               class="form-control"/>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-xs-2 control-label no-padding-left"> 值班日期：<span
                                                            class="red">*</span></label>

                                                    <div>
                                                        <div class="col-xs-6">
                                                            <div class="input-daterange input-group"
                                                                 data-date-format="yyyy-mm-dd">
                                                                <input id="dutyStartDate" type="text"
                                                                       class="input-sm form-control"
                                                                       name="startDate"/>
																	<span class="input-group-addon">
																		<i class="fa fa-exchange"></i>
																	</span>
                                                                <input id="dutyEndDate" type="text"
                                                                       class="input-sm form-control"
                                                                       name="endDate"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-xs-2 control-label no-padding-left">备注：</label>

                                                    <div class="col-xs-10">
                                                        <!-- 加载编辑器的容器 -->
                                                        <textarea id="dutyContent" name="dscr"/>

                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-xs-2 control-label no-padding-left">
                                                        已上传附件：</label>

                                                    <div class="col-xs-10 text-left">
                                                        <div id="exist-duty-file"></div>
                                                    </div>
                                                </div>
                                                <div class="form-group">

                                                    <label class="col-xs-2 control-label no-padding-left"> 附件：</label>

                                                    <div class="col-xs-10 text-left">
                                                        <input id="duty-file" type="file"/>

                                                        <div id="duty-file-queue"></div>
                                                    </div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                            <div class="step-pane" data-step="2">
                                <div class="scrollable" data-size="430">
                                    <div class="col-xs-12">
                                        <form class="form-horizontal" role="form">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left"> 紧急通知：<span
                                                        class="red">*</span></label>

                                                <div class="col-xs-10 text-left">
                                                    <!-- 加载编辑器的容器 -->
                                                    <textarea id="notice-content"/>

                                                </div>
                                            </div>
                                            <div class="form-group">

                                                <label class="col-xs-2 control-label no-padding-left"> 附件：</label>

                                                <div class="col-xs-10 text-left">
                                                    <input id="notice-file" type="file"/>

                                                    <div id="notice-file-queue"></div>
                                                </div>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer wizard-actions">
                        <button class="btn btn-sm btn-prev">
                            <i class="ace-icon fa fa-arrow-left"></i>
                            上一步
                        </button>

                        <button class="btn btn-success btn-sm btn-next" data-last="提交">
                            下一步
                            <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
                        </button>

                        <button id="cancleRecord" class="btn btn-danger btn-sm pull-left" data-dismiss="modal">
                            <i class="ace-icon fa fa-times"></i>
                            取消
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--新增值班表dialog结束--%>

    <%--新建站内信--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="add-message-dialog" class="modal" style="padding: 0px;">
                <div class="modal-content-relieve" style="width: 100%;">
                    <div id="modal-wizard-message">
                        <div class="modal-header">
                            <ul class="steps">
                                <li data-step="1" class="active">
                                    <span class="step">1</span>
                                    <span class="title">编辑站内信</span>
                                </li>
                                <li data-step="2">
                                    <span class="step">2</span>
                                    <span class="title">收件人</span>
                                </li>
                            </ul>
                        </div>

                        <div class="modal-body step-content" style="height: 399px">
                            <div class="step-pane active" data-step="1">
                                <div data-size="367">
                                    <form class="form-horizontal" id="message-form" role="form" method="post">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left">标题：<span
                                                        class="required">*</span></label>

                                                <div class="col-xs-8">
                                                    <input type="text" id="message-title" name="msgTitle" class="form-control"
                                                           placeholder="标题"/>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left">内容：<span
                                                        class="required">*</span></label>

                                                <div class="col-xs-10">
                                                    <!-- 加载编辑器的容器 -->
                                                    <textarea id="message-content" name="content"/>

                                                </div>
                                            </div>
                                        </div>
                                        <!--附件  -->
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left">
                                                    附件：<span class="required">*</span>
                                                </label>

                                                <div class="col-xs-10">
                                                    <input id="message-file" type="file"/>

                                                    <div id="message-file-queue"></div>
                                                </div>
                                            </div>
                                            <!-- PAGE CONTENT BEGINS -->
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <!--收件人-->
                            <div class="step-pane" data-step="2">
                                <div class="row">
                                    <div class="col-sm-1"></div>
                                    <div class="col-sm-5">
                                        <div class="widget-box widget-color-blue2" style="margin-top: 0px">
                                            <div class="widget-header">
                                                <i class="ace-icon fa fa-table"/>
                                                <h5 class="widget-title bigger lightter">所有人员</h5>
                                            </div>
                                            <div class="widget-body" style="height: 350px">
                                                <div class="widget-main padding-8">
                                                    <div class="scrollable" data-size="315">
                                                        <ul id="dic-emp-list" class="ztree"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-sm-5">
                                        <div class="widget-box widget-color-blue2" style="margin-top: 0px">
                                            <div class="widget-header">
                                                <i class="ace-icon fa fa-check-square-o"/>
                                                <h5 class="widget-title bigger lightter">选中人员</h5>
                                            </div>
                                            <div class="widget-body" style="height: 350px">
                                                <div class="widget-main padding-8">
                                                    <div class="scrollable" data-size="315">
                                                        <div id="checked-emps"></div>
                                                        <input id="empIds" type="hidden"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="space-10"/>
                    <div class="modal-footer wizard-actions">
                        <button class="btn btn-sm btn-prev">
                            <i class="ace-icon fa fa-arrow-left"></i>
                            上一步
                        </button>
                        <button class="btn btn-sm btn-success btn-next" data-last="发送">
                            下一步
                            <i class="ace-icon fa fa-arrow-right icon-on-right"/>
                        </button>
                        <button class="btn btn-sm btn-danger pull-left" id="message-cancel" data-dismiss="modal">
                            <i class="ace-icon fa fa-times"/>
                            取消
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%--站内信结束--%>

    <%--紧急通知dialog--%>
    <div class="col-xs-12">
        <div id="notice-dialog" class="modal" style="padding: 0px">
            <div class="modal-content-relieve" style="width: 100%">
                <div id="model-wizard-notice">
                    <div class="modal-header">
                        <ul class="steps">
                            <li data-step="1" class="active">
                                <span class="step">1</span>
                                <span class="title">编辑通知</span>
                            </li>

                            <li data-step="2">
                                <span class="step">2</span>
                                <span class="title">收件人</span>
                            </li>

                        </ul>
                    </div>

                    <div class="modal-body step-content" style="height: 399px">

                        <div class="step-pane active" data-step="1">
                            <div class="scrollable" data-size="367">
                                <form class="form-horizontal" id="notice-form" role="form" method="post">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left">紧急通知标题：<span
                                                    class="required">*</span></label>

                                            <div class="col-xs-8">
                                                <input type="text" id="notice-title" name="title" class="form-control"
                                                       placeholder="紧急通知标题"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left">紧急通知内容：<span
                                                    class="required">*</span></label>

                                            <div class="col-xs-10">
                                                <!-- 加载编辑器的容器 -->
                                                <textarea id="notice-send-content" name="content"/>

                                            </div>
                                        </div>
                                    </div>
                                    <!--附件  -->
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left">
                                                附件：
                                            </label>

                                            <div class="col-xs-10">
                                                <input id="notice-send-file" type="file"/>

                                                <div id="notice-send-file-queue"></div>
                                            </div>
                                        </div>
                                        <!-- PAGE CONTENT BEGINS -->
                                    </div>
                                </form>
                            </div>
                        </div>

                        <%--收件人--%>
                        <div class="step-pane" data-step="2">
                            <div class="row">
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5">
                                    <div class="widget-box widget-color-blue2" style="margin-top: 0px">
                                        <div class="widget-header">
                                            <i class="ace-icon fa fa-table"></i>
                                            <h5 class="widget-title bigger lighter">
                                                所有人员
                                            </h5>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main padding-8" style="height: 350px">
                                                <div class="scrollable" data-size="315">
                                                    <ul id="dic-emp-send-list" class="ztree"></ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-5">
                                    <div class="widget-box widget-color-blue2" style="margin-top: 0px">
                                        <div class="widget-header">
                                            <i class="ace-icon fa fa-check-square-o "></i>
                                            <h5 class="widget-title bigger lighter">
                                                选中人员
                                            </h5>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main padding-8" style="height: 350px">
                                                <div class="scrollable" data-size="315">
                                                    <div id="checked-emp"></div>
                                                    <input type="hidden" id="sendEmpIds">
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="space-10"/>
                <div class="modal-footer wizard-actions">
                    <button class="btn btn-sm btn-prev">
                        <i class="ace-icon fa fa-arrow-left"></i>
                        上一步
                    </button>

                    <button class="btn btn-success btn-sm btn-next" data-last="发送">
                        下一步
                        <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
                    </button>

                    <button class="btn btn-danger btn-sm pull-left" id="notice-cancel" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        取消
                    </button>
                </div>
            </div>
        </div>
    </div>

    <%--启动应急事件--%>
    <div class="col-xs-12">
        <div id="modal-wizard" class="modal" style="padding: 0px">
            <div class="modal-content" style="width: 100%">
                <div id="modal-wizard-container">
                    <div class="modal-header">
                        <ul class="steps">
                            <li data-step="1" class="active">
                                <span class="step">1</span>
                                <span class="title">事件命令</span>
                            </li>

                            <li data-step="2">
                                <span class="step">2</span>
                                <span class="title">响应单位</span>
                            </li>

                            <li data-step="3">
                                <span class="step">3</span>
                                <span class="title">注意事项</span>
                            </li>

                            <li data-step="4">
                                <span class="step">4</span>
                                <span class="title">紧急通知</span>
                            </li>
                        </ul>
                    </div>

                    <div class="modal-body step-content" style="height: 447px">
                        <div class="step-pane active" data-step="1">
                            <div class="scrollable" data-size="425">
                                <div class="col-xs-12">
                                    <form class="form-horizontal" id="step-1-form" role="form">
                                        <input type="hidden" id="saveSignal">
                                        <input type="hidden" id="start-record-id">
                                        <input type="hidden" id="start-org-id">
                                        <input type="hidden" id="start-org-names">
                                        <input type="hidden" id="start-order-id">
                                        <input type="hidden" id="start-user-orgName">
                                        <input type="hidden" id="maxIssueTime">
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left" >
                                                    事件标题：<span class="required">*</span>
                                                </label>

                                                <div class="col-xs-10">
                                                    <input type="text" id="start-record-title" placeholder="事件标题" name="title" class="form-control"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label no-padding-left">
                                                    命令编号：<span class="required">*</span>
                                                </label>

                                                <div class="col-xs-4">
                                                    <input type="text" id="start-record-year" readonly="readonly" placeholder="命令年份" class="form-control"/>
                                                </div>

                                                <div class="col-xs-4">
                                                    <input type="text" id="start-record-code" name="orderCode" placeholder="命令编号" class="form-control"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label no-padding-left">
                                                    签发人：<span class="required">*</span>
                                                </label>

                                                <div class="col-xs-8">
                                                    <input type="text" placeholder="签发人" id="start-record-issueEmp" name="issueEmp" class="form-control"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label no-padding-left"> 发布机构：<span class="required">*</span></label>

                                                <label  class="col-xs-8 control-label green" style="text-align: left;font-weight: bold;"
                                                        >${orgName}</label>
                                                <input type="hidden" name="dicOrganization.id" value="${orgId}">
                                                <input type="hidden"  name="emStatus">
                                                <input type="hidden"  name="isLeaf" value="${orgLeaf}">
                                                <input type="hidden" name="id" >
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label no-padding-left">事件类别：<span class="required">*</span></label>

                                                <div class="col-xs-8">
                                                    <input type="hidden" name="dicEmegType.id">
                                                    <input type="text" style="background-color: white !important;width:100%;" readonly="readonly" id="emType" name="emType" placeholder="点击选择" />
                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label no-padding-left" for="posgeo">关注点：<span class="required">&nbsp;</span></label>

                                                <div class="col-xs-8">
                                                    <input type="text" id="posgeo" placeholder="点击描绘" class="form-control" readonly="readonly"/>
                                                    <input type="hidden" id="posgeoValue" name="posgeo" placeholder="点击描绘" class="form-control" readonly="readonly"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label no-padding-left" for="definePlace">手输区域：<span class="required">&nbsp;</span></label>

                                                <div class="col-xs-8">
                                                    <input type="text" id="definePlace" name="definePlace" placeholder="手输区域" class="form-control"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label no-padding-left">
                                                    签发时间：<span class="required">*</span>
                                                </label>

                                                <div class="col-xs-8">
                                                    <div class="input-group date" style="width:100%;">
                                                        <input class="form-control date-time-picker" id="start-record-issueTime" name="issueTime" placeholder="签发时间" type="text">
                                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar bigger-110"></i>
                                                    </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label no-padding-left">
                                                    响应级别：<span class="required">*</span>
                                                </label>
                                                <input type="hidden" id="oldLevelName">
                                                <div class="col-xs-8">
                                                    <select id="start-record-level-id" name="emegLevel.id" style="width:100%;">
                                                        <c:forEach items="${levelList}" var="level">
                                                            <option value="${level.id}">${level.levelName}
                                                            </option>
                                                        </c:forEach>
                                                    </select>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left" >
                                                    应急区域：<span class="required">*</span>
                                                </label>

                                                <div class="col-xs-10">
                                                    <input type="hidden" id="start-record-provIds" name="provIds">
                                                    <textarea class="form-control"  style="background-color: white !important;" readonly="readonly" id="start-record-district" name="provNames" placeholder="应急区域" ></textarea>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left">
                                                    命令内容：<span class="required">*</span>
                                                </label>
                                                <div class="col-xs-10">
                                                    <textarea id="start-order-content"  name="content" />

                                                </div>
                                            </div>
                                        </div>
                                        <!--附件  -->
                                        <div class="col-xs-12">

                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left"> 已上传附件：</label>

                                                <div class="col-xs-10 text-left">
                                                    <div id="ready-order-file"></div>
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left"> 附件：<span class="required">*</span></label>
                                                <div class="col-xs-10 text-left">
                                                    <input  id="order-file"  type="file"/>
                                                    <div id="order-file-queue"></div>
                                                </div>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="step-pane" data-step="2">
                            <div class="row" >
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5">
                                    <div class="widget-box widget-color-blue2" style="margin-top: 0px">
                                        <div class="widget-header">
                                            <h5 class="widget-title bigger lighter">
                                                <i class="ace-icon fa fa-table"></i>
                                                所有机构
                                            </h5>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main padding-8" style="height: 250px">
                                                <div class="scrollable" data-size="230">
                                                    <ul id="dic-org-list" class="ztree"></ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-5">
                                    <div class="widget-box widget-color-blue2"  style="margin-top: 0px">
                                        <div class="widget-header">
                                            <h5 class="widget-title bigger lighter">
                                                <i class="ace-icon fa fa-check-square-o "></i>
                                                选中机构
                                            </h5>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main padding-8" style="height: 250px">
                                                <div class="scrollable" data-size="230" id="org">
                                                    <div id="checkedOrg"></div>

                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <form class="form-horizontal" id="step-2-form" role="form">
                                    <input type="hidden" id="orgIds">
                                    <input type="hidden" id="orgNewIds">
                                    <input type="hidden" id="orgNewNames">
                                    <input type="hidden" id="orgDeleteNames">
                                    <input type="hidden" id="orgDelete">
                                    <input type="hidden" id="orgNames">
                                    <input type="hidden" id="orgId">
                                    <div class="col-sm-12">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-4 no-padding-left">
                                            <div class="checkbox">
                                                <label class="block">
                                                    <input name="form-field-checkbox" id="trace-checkbox" class="ace input-lg no-padding-left" type="checkbox">
                                                    <span class="lbl bigger-120">&nbsp;&nbsp;启动摘报上报提醒</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-sm-7">
                                            <div id="trace-div" class="hide">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label no-padding-left ">每日摘报上报次数：</label>

                                                    <div class="radio">
                                                        <label>
                                                            <input name="form-field-radio" class="ace input-lg" checked value="1" type="radio">
                                                            <span class="lbl bigger-120"> 1次</span>
                                                        </label>
                                                        <label>
                                                            <input name="form-field-radio" class="ace input-lg" value="2" type="radio">
                                                            <span class="lbl bigger-120"> 2次</span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label no-padding-left no-padding-right">请各响应单位于每日：</label>
                                                    <div class="col-sm-2 no-padding-left" style="margin-left: 10px">
                                                        <input id="timepick1"  type="text" class="form-control timepicker"  placeholder="签发时间"/>
                                                    </div>
                                                    <div id="time-second" class="hide">
                                                        <div class="col-sm-2 no-padding-left">
                                                            <input id="timepick2" type="text" class="form-control timepicker"  placeholder="签发时间"/>
                                                        </div>
                                                    </div>
                                                    <label class="control-label no-padding-left">前上报</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="step-pane" data-step="3">
                            <div class="scrollable" data-size="380">
                                <div  class="col-xs-12">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right">标题：</label>

                                            <div class="col-xs-10">
                                                <input type="text" id="start-notice-title" placeholder="标题" class="form-control"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right">内容：</label>
                                            <div class="col-xs-10">
                                                <textarea id="start-notice-content" />

                                            </div>
                                        </div>
                                        <!--附件  -->

                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left"> 已上传附件：</label>

                                            <div class="col-xs-10 text-left">
                                                <div id="ready-notice-file"></div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left"> 附件：</label>
                                            <div class="col-xs-10 text-left">
                                                <input  id="emeg-notice-file"  type="file"/>
                                                <div id="emeg-notice-file-queue"></div>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="step-pane" data-step="4">
                            <div class="scrollable" data-size="380">
                                <div  class="col-xs-12">
                                    <form class="form-horizontal" role="form">

                                        <!-- PAGE CONTENT BEGINS -->
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right">内容：<span class="required">*</span></label>
                                            <div class="col-xs-10">
                                                <textarea id="start-emergency-content" />

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left"> 已上传附件：</label>

                                            <div class="col-xs-10 text-left">
                                                <div id="ready-emergency-file"></div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left"> 附件：</label>
                                            <div class="col-xs-10 text-left">
                                                <input  id="emergency-file"  type="file"/>
                                                <div id="emergency-file-queue"></div>
                                            </div>
                                        </div>

                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer wizard-actions">
                    <button class="btn btn-sm btn-prev">
                        <i class="ace-icon fa fa-arrow-left"></i>
                        上一步
                    </button>

                    <button id="pre-save" class="btn btn-primary btn-sm hide" >
                        暂存
                        <i class="ace-icon glyphicon glyphicon-ok  icon-on-right"></i>
                    </button>
                    <button id="btn-final" class="btn btn-success btn-sm btn-next" data-last="启动">
                        下一步
                        <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
                    </button>

                    <button id="emegCancleRecord" class="btn btn-danger btn-sm pull-left" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        取消
                    </button>
                </div>
            </div>
        </div>
    </div>
    <%--启动应急事件结束--%>

    <%--应急事件批示--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="instruct-dialog" class="hide">
                <form class="form-horizontal" id="instructForm" action="${basePath}/emeg-manage/saveInstruct.do">
                    <div class="form-group" style="margin-top: 30px">
                        <input type="hidden" id="instruct-record-id" name="emeg.id">
                        <label class="col-xs-2 control-label no-padding-left">批示人：<span class="required">*</span></label>
                        <div class="col-xs-10 text-left">
                            <input type="text" id="instructName" name="instructName" placeholder="批示人" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left">批示内容：<span class="required">*</span></label>
                        <label class="col-xs-10">
                            <textarea id="instructDscr" name="dscr"></textarea>
                        </label>
                    </div>
                    <div class="form-group">
                        <input type="hidden" id="instruct-file-str" name="instructFileStr" />
                        <label class="col-xs-2 control-label no-padding-left"> 附件：</label>
                        <div class="col-xs-10 text-left">
                            <input  id="instruct-file"  type="file"/>
                            <div id="instruct-file-queue"></div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%--应急事件摘报--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="trace-dialog" class="hide">
                <form class="form-horizontal" id="traceForm" role="form" action="${basePath}/emeg-manage/saveTrace.do" method="post">
                    <div class="form-group" style="margin-top: 30px">
                        <input type="hidden" id="trace-record-id" name="emeg.id">
                        <label class="col-xs-2 control-label no-padding-left">摘报标题：<span class="required">*</span></label>

                        <div class="col-xs-10 text-left">
                            <input type="text" id="traceTitle" name="title" placeholder="摘报标题" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left"> 联系方式：</label>

                        <div class="col-xs-10 text-left">
                            <input type="text"  name="contact" placeholder="联系方式" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left" for="ueTrace">摘报内容：<span class="required">*</span></label>
                        <div class="col-xs-10">
                            <!-- 加载编辑器的容器 -->
                            <textarea id="ueTrace" name="dscr"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="hidden" id="trace-file-str" name="traceFileStr" />
                        <label class="col-xs-2 control-label no-padding-left"> 附件：</label>
                        <div class="col-xs-10 text-left">
                            <input  id="trace-file"  type="file"/>
                            <div id="trace-file-queue"></div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%--应急事件通报--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="bulletin-dialog" class="hide">

                <form class="form-horizontal" id="bulletinForm" role="form" action="${basePath}/emeg-manage/saveBulletin.do" method="post">
                    <div class="form-group" style="margin-top: 30px">
                        <input type="hidden" id="bulletin-record-id" name="emeg.id">
                        <label class="col-xs-2 control-label no-padding-left">通报标题：<span class="required">*</span></label>

                        <div class="col-xs-10 text-left">
                            <input type="text" id="bulletinTitle" name="title" placeholder="通报标题" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group" >
                        <label class="col-xs-2 control-label no-padding-left"> 通报时间：<span class="required">*</span></label>
                        <div class="col-xs-4 text-left" >
                            <div class="input-group date">
                                <input class="form-control date-time-picker" id="startDate" name="startDate" placeholder="开始时间" type="text">
                                <span class="input-group-addon">
                                    <i class="fa fa-calendar bigger-110"></i>
                                </span>
                            </div>
                        </div>
                        <label class="col-xs-2 control-label no-padding-left">通报地点：<span class="required">*</span></label>

                        <div class="col-xs-4 text-left">
                            <input type="text" id="bulletinPlace" name="place" placeholder="通报地点" class="form-control"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left">参与人员：<span class="required">*</span></label>

                        <div class="col-xs-10 text-left">
                            <input type="text" id="bulletinAttend" name="attend" placeholder="参与人员" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left">通报备注：</label>

                        <div class="col-xs-10 text-left">
                            <input type="text" id="bulletinRmks" name="rmks" placeholder="通报备注" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left" for="bulletinDscr">通报内容：<span class="required">*</span></label>
                        <div class="col-xs-10">
                            <!-- 加载编辑器的容器 -->
                            <textarea id="bulletinDscr" name="dscr"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="hidden" id="bulletin-file-str" name="bulletinFileStr" />
                        <label class="col-xs-2 control-label no-padding-left"> 附件：</label>
                        <div class="col-xs-10 text-left">
                            <input  id="bulletin-file"  type="file"/>
                            <div id="bulletin-file-queue"></div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <%--地市级应急事件--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="is-leaf-record-dialog" class="hide">
                <form class="form-horizontal" id="is-leaf-form" role="form" method="post">
                    <div id="is-leaf-hide-div">
                        <div class="col-xs-12">
                            <input type="hidden" id="is-leaf-id">
                            <input type="hidden" id="is-leaf-signal">

                            <div class="form-group">
                                <label class="col-xs-2 control-label no-padding-left">事件标题：<span
                                        class="required">*</span></label>

                                <div class="col-xs-10">
                                    <input type="text" id="is-leaf-title" name="title" class="form-control"
                                           placeholder="事件标题"/>
                                </div>
                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="form-group">
                                <label class="col-xs-4 control-label no-padding-left">响应级别：<span
                                        class="required">*</span></label>

                                <div class="col-xs-8">
                                    <select id="is-leaf-level" name="isLeafLevel" style="width:100%;">
                                        <c:forEach items="${levelList}" var="level">
                                            <option value="${level.id}">${level.levelName}</option>
                                        </c:forEach>
                                    </select>

                                </div>
                            </div>
                        </div>
                        <div class="col-xs-12">
                            <div class="form-group">
                                <label class="col-xs-2 control-label no-padding-left" for="provNames">应急区域：<span
                                        class="required">*</span></label>

                                <div class="col-xs-10">
                                    <input type="hidden" id="is-leaf-provIds" name="provIds">
                                    <textarea class="form-control " readonly="readonly" id="is-leaf-provNames"
                                              name="provNames" placeholder="应急区域"></textarea>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" >事件内容：<span
                                    class="required">*</span></label>

                            <div class="col-xs-10">
                                <!-- 加载编辑器的容器 -->
                                <textarea id="is-leaf-content" name="content"/>

                            </div>
                        </div>
                    </div>
                    <!--附件  -->
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">
                                附件：
                            </label>

                            <div class="col-xs-5">
                                <input id="emeg-record-file" type="file"/>


                                <div id="emeg-record-file-queue"></div>
                            </div>
                        </div>
                        <!-- PAGE CONTENT BEGINS -->

                    </div>
                </form>

            </div>
        </div>
    </div>

    <%--解除应急事件--%>
    <div class="col-xs-12">
        <div id="modal-relieve" class="modal" style="padding: 0px">
            <div class="modal-content-relieve" style="width: 100%">
                <div id="modal-wizard-relieve">
                    <div class="modal-header">
                        <ul class="steps">
                            <li data-step="1" class="active">
                                <span class="step">1</span>
                                <span class="title">解除命令</span>
                            </li>

                            <li data-step="2">
                                <span class="step">2</span>
                                <span class="title">注意事项</span>
                            </li>

                            <li data-step="3">
                                <span class="step">3</span>
                                <span class="title">紧急通知</span>
                            </li>
                        </ul>
                    </div>

                    <div class="modal-body step-content" style="height: 399px">
                        <div class="step-pane active" data-step="1">
                            <div class="scrollable" data-size="380">
                                <div class="col-xs-12">
                                    <form class="form-horizontal" id="relieve-step-1-form" role="form">
                                        <input type="hidden" id="relieve-orgName">
                                        <input type="hidden" id="relieve-org-id">
                                        <input type="hidden" id="relieve-record-id">

                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left"> 事件标题：<span class="required">*</span></label>

                                                <label class="col-xs-10 control-label green" id="relieve-record-title" style="text-align: left;font-weight: bold;"></label>


                                            </div>

                                        </div>
                                        <div class="col-xs-12">
                                                <label class="col-xs-2 control-label no-padding-left">
                                                    命令编号：<span class="required">*</span>
                                                </label>

                                                <div class="col-xs-1">
                                                    <input type="text" id="relieve-year" readonly="readonly"
                                                           placeholder="命令年份" class="form-control"/>
                                                </div>

                                                <div class="col-xs-1">
                                                    <input type="text" id="relieve-code" name="orderCode"
                                                           placeholder="命令编号" class="form-control"/>
                                                </div>
                                                <div class="col-xs-8">
                                                    <label class="col-xs-2 control-label no-padding-left">
                                                        签发人：<span class="required">*</span>
                                                    </label>

                                                    <div class="col-xs-4">
                                                        <input id="relieve-issue-emp" type="text" placeholder="签发人"
                                                               name="issueEmp" class="form-control"/>
                                                    </div>
                                                    <div class="form-group">
                                                    <label class="col-xs-2 control-label no-padding-left">
                                                        签发时间：<span class="required">*</span>
                                                    </label>

                                                    <div class="col-xs-4">
                                                        <div class="input-group date" style="width:100%;">
                                                            <input id="relieve-issue-time"
                                                                   class="form-control date-time-picker"
                                                                   name="issueTime" placeholder="签发时间" type="text">
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-calendar bigger-110"></i>
                                                        </span>
                                                        </div>
                                                    </div>
                                                        </div>
                                                </div>

                                        </div>

                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left">
                                                    命令内容：<span class="required">*</span>
                                                </label>
                                                <div class="col-xs-10">
                                                    <textarea id="relieve-order-content"  name="content" />

                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-right" >
                                                    附件：
                                                </label>
                                                <div class="col-xs-5">
                                                    <input id="relieve-order-file" type="file"/>

                                                    <div id="relieve-order-file-queue"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="step-pane" data-step="2">
                            <div class="scrollable" data-size="380">
                                <div  class="col-xs-12">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right">标题：<span class="required">*</span></label>

                                            <div class="col-xs-10">
                                                <input type="text" id="relieve-notice-title"  placeholder="标题" class="form-control"/>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right">内容：<span class="required">*</span></label>
                                            <div class="col-xs-10">
                                                <textarea id="relieve-notice-content" />

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right" >
                                                附件：
                                            </label>
                                            <div class="col-xs-5">
                                                <input id="relieve-notice-file" type="file"/>

                                                <div id="relieve-notice-queue"></div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="step-pane" data-step="3">
                            <div class="scrollable" data-size="380">
                                <div  class="col-xs-12">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right">内容：<span class="required">*</span></label>
                                            <div class="col-xs-10">
                                                <textarea  id="relieve-emergency-content" />

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right" >
                                                附件：
                                            </label>
                                            <div class="col-xs-5">
                                                <input id="relieve-emergency-file" type="file"/>

                                                <div id="relieve-emergency-queue"></div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer wizard-actions">
                    <button class="btn btn-sm btn-prev">
                        <i class="ace-icon fa fa-arrow-left"></i>
                        上一步
                    </button>

                    <button id="city-final" class="btn btn-success btn-sm btn-next" data-last="解除">
                        下一步
                        <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
                    </button>

                    <button class="btn btn-danger btn-sm pull-left" id="relieve-cancle" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        取消
                    </button>
                </div>
            </div>
        </div>
    </div>

    <%--应急事件评估--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="evaluate-dialog" class="hide">
                <form class="form-horizontal" id="evaluateForm" role="form" action="${basePath}/emeg-manage/saveEvaluate.do">
                    <input type="hidden" id="evaluate-record-id" name="emeg.id"/>
                    <input type="hidden" id="evaluate-isClose" name="isClose" value="0"/>
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left">评估标题：<span class="required">*</span></label>
                        <div class="col-xs-10 text-left">
                            <input type="text" id="evaluateTitle" name="title" placeholder="评估标题" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left">评估内容：<span class="required">*</span></label>
                        <div class="col-xs-10">
                            <!-- 加载编辑器的容器 -->
                            <textarea id="evaluateDscr" name="dscr"></textarea>
                        </div>
                    </div>
                    <div class="form-group">
                        <input type="hidden" id="evaluate-file-str" name="evaluateFileStr" />
                        <label class="col-xs-2 control-label no-padding-left"> 附件：</label>
                        <div class="col-xs-10 text-left">
                            <input  id="evaluate-file"  type="file"/>
                            <div id="evaluate-file-queue"></div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!--特别工作批示dialog-->
    <div class="row">
        <div class="col-xs-12">
            <div id="spec-instruct-dialog" class="hide">

                <form class="form-horizontal" id="specInstructForm" role="form">
                    <div class="form-group" style="margin-top: 30px">
                        <input type="hidden" id="instruct-spec-id" name="spec.id">
                        <label class="col-xs-2 control-label no-padding-left">批示人：<span class="required">*</span></label>

                        <div class="col-xs-10 text-left">
                            <input type="text" id="specInstructName" name="instructName" placeholder="批示人" class="form-control"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left" >批示内容：<span class="required">*</span></label>
                        <div class="col-xs-10">
                            <!-- 加载编辑器的容器 -->
                            <textarea id="specInstructDscr" name="dscr"></textarea>
                        </div>
                    </div>

                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" >
                                附件：
                            </label>
                            <div class="col-xs-5">
                                <input id="spec-instruct-file"  type="file"/>


                                <div id="spec-instruct-file-queue"></div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--特别工作批示dialog结束 -->

    <!--暂停特别工作dialog-->
    <div class="row">
        <div class="col-xs-12">
            <div id="suspend-dialog" class="hide">
                <form class="form-horizontal">
                    <div class="form-group"  style="margin-top: 30px">
                        <input type="hidden" id="suspend-spec-id" name="spec.id">
                        <input type="hidden" id="suspend-org-id">
                        <label class="col-xs-2 control-label no-padding-left" >命令内容：<span class="required">*</span></label>
                        <div class="col-xs-10">
                            <!-- 加载编辑器的容器 -->
                            <textarea id="suspendDscr" name="dscr"></textarea>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" >
                                附件：
                            </label>
                            <div class="col-xs-5">
                                <input id="suspend-file"  type="file"/>

                                <div id="suspend-file-queue"></div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--暂停特别工作dialog结束-->

    <!--启动特别工作dialog-->
    <div class="col-xs-12">
        <div id="spec-modal-wizard" class="modal" style="padding: 0px">
            <div class="modal-content" style="width: 100%">
                <div id="spec-modal-wizard-container">
                    <div class="modal-header">
                        <ul class="steps">
                            <li data-step="1" class="active">
                                <span class="step">1</span>
                                <span class="title">响应机构</span>
                            </li>

                            <li data-step="2">
                                <span class="step">2</span>
                                <span class="title">紧急通知</span>
                            </li>
                        </ul>
                    </div>

                    <div class="modal-body step-content" style="height: 399px">
                        <div class="step-pane active" data-step="1">
                            <div class="row" >
                                <div class="col-sm-1"></div>
                                <div class="col-sm-5">
                                    <div class="widget-box widget-color-blue2" style="margin-top: 0px">
                                        <div class="widget-header">
                                            <h5 class="widget-title bigger lighter">
                                                <i class="ace-icon fa fa-table"></i>
                                                所有机构
                                            </h5>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main padding-8" style="height: 250px">
                                                <div class="scrollable" data-size="230">
                                                    <ul id="spec-dic-org-list" class="ztree"></ul>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-5">
                                    <div class="widget-box widget-color-blue2"  style="margin-top: 0px">
                                        <div class="widget-header">
                                            <h5 class="widget-title bigger lighter">
                                                <i class="ace-icon fa fa-check-square-o "></i>
                                                选中机构
                                            </h5>
                                        </div>
                                        <div class="widget-body">
                                            <div class="widget-main padding-8" style="height: 250px">
                                                <div class="scrollable" data-size="230">
                                                    <div id="specCheckedOrg"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <form class="form-horizontal" id="spec-step-1-form" >
                                    <input type="hidden" id="specOrgIds">
                                    <input type="hidden" id="specOrgNewIds">
                                    <input type="hidden" id="specOrgDelete">
                                    <input type="hidden" id="specOrgNewNames">
                                    <input type="hidden" id="specOrgDeleteNames">
                                    <input type="hidden" id="spec-start-user-orgName">
                                    <input type="hidden" id="spec-start-record-title">
                                    <input type="hidden" id="spec-start-record-year">
                                    <input type="hidden" id="spec-saveSignal">
                                    <input type="hidden" id="spec-start-org-names">
                                    <input type="hidden" id="spec-start-org-id">
                                    <input type="hidden" id="startSpecId" name="spec.id">
                                    <div class="col-sm-12">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-4 no-padding-left">
                                            <div class="checkbox">
                                                <label class="block">
                                                    <input name="form-field-checkbox" id="report-checkbox" class="ace input-lg no-padding-left" type="checkbox">
                                                    <span class="lbl bigger-120">&nbsp;&nbsp;启动情况报告上报提醒</span>
                                                </label>
                                            </div>
                                        </div>
                                        <div class="col-sm-7">
                                            <div id="report-div" class="hide">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label no-padding-left ">每日情况报告上报次数：</label>

                                                    <div class="radio">
                                                        <label>
                                                            <input name="spec-form-field-radio" class="ace input-lg" checked value="1" type="radio">
                                                            <span class="lbl bigger-120"> 1次</span>
                                                        </label>
                                                        <label>
                                                            <input name="spec-form-field-radio" class="ace input-lg" value="2" type="radio">
                                                            <span class="lbl bigger-120"> 2次</span>
                                                        </label>
                                                    </div>
                                                </div>
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label no-padding-left no-padding-right">请各响应单位于每日：</label>
                                                    <div class="col-sm-2 no-padding-left" style="margin-left: 10px">
                                                        <input id="specTimepick1"  type="text" class="form-control timepicker"  placeholder="签发时间"/>
                                                    </div>
                                                    <div id="spec-time-second" class="hide">
                                                        <div class="col-sm-2 no-padding-left">
                                                            <input id="specTimepick2" type="text" class="form-control timepicker"  placeholder="签发时间"/>
                                                        </div>
                                                    </div>
                                                    <label class="control-label no-padding-left">前上报</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </div>
                        </form>

                        <div class="step-pane" data-step="2">
                            <div class="scrollable" data-size="380">
                                <div  class="col-xs-12">
                                    <form class="form-horizontal" role="form">

                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right">内容：<span class="required">*</span></label>
                                            <div class="col-xs-10">
                                                <textarea id="spec-start-notice-content" />
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right" >
                                                附件：
                                            </label>
                                            <div class="col-xs-5">
                                                <input id="spec-file" type="file"/>

                                                <div id="spec-file-queue"></div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer wizard-actions">
                    <button class="btn btn-sm btn-prev">
                        <i class="ace-icon fa fa-arrow-left"></i>
                        上一步
                    </button>
                    <button id="spec-btn-final" class="btn btn-success btn-sm btn-next" data-last="启动">
                        下一步
                        <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
                    </button>

                    <button id="specCancleRecord" class="btn btn-danger btn-sm pull-left" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        取消
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!--启动特别工作dialog结束-->

    <!--重启特别工作dialog-->
    <div class="row">
        <div class="col-xs-12">
            <div id="restart-dialog" class="hide">
                <form class="form-horizontal">
                    <div class="form-group"  style="margin-top: 30px">
                        <input type="hidden" id="restart-spec-id" name="spec.id">
                        <input type="hidden" id="restart-org-id">
                        <label class="col-xs-2 control-label no-padding-left" >命令内容：<span class="required">*</span></label>
                        <div class="col-xs-10">
                            <!-- 加载编辑器的容器 -->
                            <textarea id="restartDscr" name="dscr"></textarea>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" >
                                附件：
                            </label>
                            <div class="col-xs-5">
                                <input id="restart-file"  type="file"/>

                                <div id="restart-file-queue"></div>
                            </div>
                        </div>
                        <!-- PAGE CONTENT BEGINS -->

                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--重启特别工作dialog结束-->

    <!--通报dialog-->
    <div class="row">
        <div class="col-xs-12">
            <div id="spec-bulletin-dialog" class="hide">

                <form class="form-horizontal" id="specBulletinForm" role="form">
                    <div class="form-group" style="margin-top: 30px">
                        <input type="hidden" id="spec-bulletin-id" name="spec.id">
                        <label class="col-xs-2 control-label no-padding-left">通报标题：<span class="required">*</span></label>

                        <div class="col-xs-10 text-left">
                            <input type="text" id="specBulletinTitle" name="title" placeholder="通报标题" class="form-control"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left"> 通报时间：<span class="required">*</span></label>
                        <div class="col-xs-10 text-left" style="z-index: 2">
                            <div class="input-group date"
                                 style="width: 100%;">
                                <input class="form-control date-time-picker" id="specStartDate" name="startDate" placeholder="通报时间" type="text">
                                <span class="input-group-addon">
                                    <i class="fa fa-calendar bigger-110"></i>
                                </span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left">通报内容：<span class="required">*</span></label>
                        <div class="col-xs-10"  style="z-index: 0">
                            <!-- 加载编辑器的容器 -->
                            <textarea id="specBulletinDscr" name="dscr"></textarea>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" >
                                附件：
                            </label>
                            <div class="col-xs-5">
                                <input id="spec-bulletin-file"  type="file"/>


                                <div id="spec-bulletin-file-queue"></div>
                            </div>
                        </div>
                        <!-- PAGE CONTENT BEGINS -->

                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--通报dialog结束-->

    <!--情况报告dialog-->
    <div class="row">
        <div class="col-xs-12">
            <div id="report-dialog" class="hide">

                <form class="form-horizontal" id="reportForm" role="form">
                    <div class="form-group" style="margin-top: 30px">
                        <input type="hidden" id="report-spec-id" name="spec.id">
                        <label class="col-xs-2 control-label no-padding-left">报告标题：<span class="required">*</span></label>

                        <div class="col-xs-10 text-left">
                            <input type="text" id="reportTitle" name="title" placeholder="报告标题" class="form-control"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-xs-2 control-label no-padding-left" >报告内容：<span class="required">*</span></label>
                        <div class="col-xs-10">
                            <!-- 加载编辑器的容器 -->
                            <textarea id="reportDscr" name="dscr"></textarea>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" >
                                附件：
                            </label>
                            <div class="col-xs-5">
                                <input id="report-file"  type="file"/>


                                <div id="report-file-queue"></div>
                            </div>
                        </div>
                        <!-- PAGE CONTENT BEGINS -->

                    </div>
                </form>
            </div>
        </div>
    </div>
    <!--情况报告dialog结束-->

    <!--解除特别工作dialog-->
    <div class="col-xs-12">
        <div id="spec-modal-relieve" class="modal" style="padding: 0px">
            <div class="modal-content-relieve" style="width: 100%">
                <div id="spec-modal-wizard-relieve">
                    <div class="modal-header">
                        <ul class="steps">
                            <li data-step="1" class="active">
                                <span class="step">1</span>
                                <span class="title">解除命令</span>
                            </li>

                            <li data-step="2">
                                <span class="step">2</span>
                                <span class="title">紧急通知</span>
                            </li>
                        </ul>
                    </div>

                    <div class="modal-body step-content" style="height: 399px">
                        <div class="step-pane active" data-step="1">
                            <div class="scrollable" data-size="380">
                                <div class="col-xs-12">
                                    <form class="form-horizontal" id="spec-relieve-step-1-form">
                                        <input type="hidden" id="spec-relieve-orgName">
                                        <input type="hidden" id="spec-relieve-org-id">
                                        <input type="hidden" id="spec-relieve-record-id">
                                        <input type="hidden" id="spec-relieve-title">
                                        <input type="hidden" id="specMaxIssueTime">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left"> 标题：<span class="required">*</span></label>

                                            <div class="col-xs-10">
                                                <input style="margin-left: 8px" type="text" id="spec-relieve-record-title"  placeholder="标题" class="form-control"/>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label no-padding-left">
                                                    签发时间：<span class="required">*</span>
                                                </label>

                                                <div class="col-xs-8">
                                                    <div class="input-group date" style="width:100%;">
                                                        <input id="spec-relieve-issue-time" class="form-control date-time-picker"  name="issueTime" placeholder="签发时间" type="text">
                                                        <span class="input-group-addon">
                                                            <i class="fa fa-calendar bigger-110"></i>
                                                        </span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-6">
                                            <div class="form-group">
                                                <label class="col-xs-4 control-label no-padding-left">
                                                    签发人：<span class="required">*</span>
                                                </label>

                                                <div class="col-xs-8">
                                                    <input id="spec-relieve-issue-emp" type="text" placeholder="签发人"  name="issueEmp" class="form-control"/>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-left">
                                                    命令内容：<span class="required">*</span>
                                                </label>
                                                <div class="col-xs-10">
                                                    <textarea id="spec-relieve-order-content"  name="content" />
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-xs-12">
                                            <div class="form-group">
                                                <label class="col-xs-2 control-label no-padding-right" >
                                                    附件：
                                                </label>
                                                <div class="col-xs-5">
                                                    <input id="spec-relieve-order-file" type="file"/>

                                                    <div id="spec-relieve-order-queue"></div>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <div class="step-pane" data-step="2">
                            <div class="scrollable" data-size="380">
                                <div  class="col-xs-12">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right">内容：<span class="required">*</span></label>
                                            <div class="col-xs-10">
                                                <textarea  id="spec-relieve-emergency-content" />

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right" >
                                                附件：
                                            </label>
                                            <div class="col-xs-5">
                                                <input id="spec-relieve-emergency-file" type="file"/>

                                                <div id="spec-relieve-emergency-queue"></div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer wizard-actions">
                    <button class="btn btn-sm btn-prev">
                        <i class="ace-icon fa fa-arrow-left"></i>
                        上一步
                    </button>

                    <button class="btn btn-success btn-sm btn-next" data-last="解除">
                        下一步
                        <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
                    </button>

                    <button class="btn btn-danger btn-sm pull-left" id="spec-relieve-cancle" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        取消
                    </button>
                </div>
            </div>
        </div>
    </div>
    <!--解除特别工作dialog结束-->

    <!--突发事件批示-->
    <div class="row">
        <div class="col-xs-12">
            <div id="critic-record-dialog" class="hide">
                <div class="space-10" ></div>
                <form class="form-horizontal" id="critic-record-form" role="form"  method="post">
                    <div class="col-xs-6">
                        <input type="hidden" name="recordId" id="critic-record-id">

                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left">状态：<span class="required">*</span></label>

                            <div class="radio">
                                <label>
                                    <input name="form-critic-radio" class="ace input-lg" checked value="2" type="radio">
                                    <span class="lbl bigger-120"> 公开</span>
                                </label>
                                <label>
                                    <input name="form-critic-radio" class="ace input-lg" value="1" type="radio">
                                    <span class="lbl bigger-120"> 内部公开</span>
                                </label>
                                <label>
                                    <input name="form-critic-radio" class="ace input-lg" value="0" type="radio">
                                    <span class="lbl bigger-120"> 不公开</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left">批示人：<span class="required">*</span></label>

                            <div class="col-xs-8">
                                <input type="text" id="critic-issuer" name="issuer" placeholder="批示人" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" for="content">批示内容：<span class="required">*</span></label>
                            <div class="col-xs-10">
                                <!-- 加载编辑器的容器 -->
                                <textarea id="critic-content" name="content" />

                            </div>
                        </div>
                    </div>
                    <!--附件  -->
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" >
                                附件：
                            </label>

                            <div class="col-xs-10">
                                <input id="critic-file"  type="file"/>


                                <div id="critic-file-queue"></div>
                            </div>
                        </div>
                        <!-- PAGE CONTENT BEGINS -->

                    </div>
                </form>
            </div>
        </div>
    </div>
    <%--突发事件批示--%>

    <%--突发事件审核--%>
    <div class="col-xs-12">
        <div id="audit-dialog" class="modal" style="padding: 0px">
            <div class="modal-content-relieve" style="width: 100%">
                <div id="modal-wizard-audit">
                    <div class="modal-header">
                        <ul class="steps">
                            <li data-step="1" class="active">
                                <span class="step">1</span>
                                <span class="title">审核</span>
                            </li>

                            <li data-step="2">
                                <span class="step">2</span>
                                <span class="title">紧急通知</span>
                            </li>

                        </ul>
                    </div>

                    <div class="modal-body step-content" style="height: 399px">
                        <div class="step-pane active" data-step="1">
                            <div class="scrollable" data-size="367">
                                <form class="form-horizontal" id="audit-form" role="form"  method="post">
                                    <input id="audit-record-id" type="hidden">
                                    <input id="record-name" type="hidden">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-xs-4 control-label no-padding-left">状态：<span class="required">*</span></label>

                                            <div class="radio">
                                                <label>
                                                    <input name="form-audit-radio" class="ace input-lg" checked value="1" type="radio">
                                                    <span class="lbl bigger-120"> 通过</span>
                                                </label>
                                                <label>
                                                    <input name="form-audit-radio" class="ace input-lg" value="-1" type="radio">
                                                    <span class="lbl bigger-120"> 不通过</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-xs-4 control-label no-padding-left">审核人：<span class="required">*</span></label>

                                            <div class="col-xs-8">
                                                <input type="text" id="audit-issuer" name="issuer" placeholder="审核人" class="form-control"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left" for="content">审核意见：<span class="required">*</span></label>
                                            <div class="col-xs-10">
                                                <!-- 加载编辑器的容器 -->
                                                <textarea id="audit-content" name="content" />

                                            </div>
                                        </div>
                                    </div>
                                    <!--附件  -->
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left" >
                                                附件：
                                            </label>
                                            <div class="col-xs-10">
                                                <input id="audit-file"  type="file"/>


                                                <div id="audit-file-queue"></div>
                                            </div>
                                        </div>
                                        <!-- PAGE CONTENT BEGINS -->

                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="step-pane" data-step="2">
                            <div class="scrollable" data-size="380">
                                <div  class="col-xs-12">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right">内容：<span class="required">*</span></label>
                                            <div class="col-xs-10">
                                                <textarea  id="accd-notice-content" />

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right" >
                                                附件：
                                            </label>
                                            <div class="col-xs-10">
                                                <input id="accd-notice-file" type="file"/>

                                                <div id="accd-notice-file-queue"></div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer wizard-actions">
                    <button class="btn btn-sm btn-prev">
                        <i class="ace-icon fa fa-arrow-left"></i>
                        上一步
                    </button>

                    <button class="btn btn-success btn-sm btn-next" data-last="审核">
                        下一步
                        <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
                    </button>

                    <button class="btn btn-danger btn-sm pull-left" id="audit-cancle" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        取消
                    </button>
                </div>
            </div>
        </div>
    </div>
    <%--突发事件审核--%>

    <%--突发事件续报--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="continue-record-dialog" class="hide">
                <form class="form-horizontal" id="continue-record-form" role="form"  method="post">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <%--<input type="hidden" name="recordId" id="continue-record-id">--%>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group has-info">
                            <label class="col-xs-2 control-label no-padding-left bolder green">选择突发事件：<span class="required">*</span></label>

                            <div class="col-xs-10">
                                <select id="record-select" name="selectName" class="form-control">

                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">
                                续报次数：
                            </label>
                            <div class="col-xs-10" id="followNum" style="margin-top: 7px;font-weight: bold"><span>1次</span></div>
                        </div>
                        <!-- PAGE CONTENT BEGINS -->
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">标题：<span class="required">*</span></label>

                            <div class="col-xs-10">
                                <input type="text" id="continue-title" name="title" class="form-control" placeholder="事件标题" />
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left">状态：<span class="required">*</span></label>

                            <div class="radio">
                                <label>
                                    <input name="accd-form-field-radio" class="ace input-lg" checked value="0" type="radio">
                                    <span class="lbl bigger-120"> 续报</span>
                                </label>
                                <label>
                                    <input name="accd-form-field-radio" class="ace input-lg" value="1" type="radio">
                                    <span class="lbl bigger-120"> 终报</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left">签发人：<span class="required">*</span></label>

                            <div class="col-xs-8">
                                <input type="text" id="continue-issuer" name="issuer" placeholder="签发人" class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" for="content">事件内容：<span class="required">*</span></label>
                            <div class="col-xs-10">
                                <!-- 加载编辑器的容器 -->
                                <textarea id="continue-content" name="content" />

                            </div>
                        </div>
                    </div>
                    <!--附件  -->
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left" >
                                附件：
                            </label>

                            <div class="col-xs-10">
                                <input id="continue-record-file"  type="file"/>


                                <div id="continue-record-file-queue"></div>
                            </div>
                        </div>
                        <!-- PAGE CONTENT BEGINS -->

                    </div>
                </form>
            </div>
        </div>
    </div>
    <%--突发事件续报--%>

    <%--内部突发事件--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="inner-critic-record-dialog" class="hide">
                <div class="space-10" ></div>
                <form class="form-horizontal" id="inner-critic-record-form" role="form" method="post">
                    <div class="col-xs-6">
                        <input type="hidden" name="recordId" id="inner-critic-record-id">

                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left">状态：<span
                                    class="required">*</span></label>

                            <div class="radio">
                                <label>
                                    <input name="inner-form-critic-radio" class="ace input-lg" value="1" type="radio" checked>
                                    <span class="lbl bigger-120"> 内部公开</span>
                                </label>
                                <label>
                                    <input name="inner-form-critic-radio" class="ace input-lg" value="0" type="radio">
                                    <span class="lbl bigger-120"> 不公开</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left">批示人：<span
                                    class="required">*</span></label>

                            <div class="col-xs-8">
                                <input type="text" id="inner-critic-issuer" name="issuer" placeholder="批示人"
                                       class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">批示内容：<span
                                    class="required">*</span></label>

                            <div class="col-xs-10">
                                <!-- 加载编辑器的容器 -->
                                <textarea id="inner-critic-content" name="content"/>

                            </div>
                        </div>
                    </div>
                    <!--附件  -->
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">
                                附件：
                            </label>

                            <div class="col-xs-10">
                                <input id="inner-critic-file" type="file"/>


                                <div id="inner-critic-file-queue"></div>
                            </div>
                        </div>
                        <!-- PAGE CONTENT BEGINS -->

                    </div>
                </form>
            </div>
        </div>
    </div>
    <%--内部突发事件--%>

    <%--内部突发事件审核--%>
    <div class="col-xs-12">
        <div id="inner-audit-dialog" class="modal" style="padding: 0px">
            <div class="modal-content-relieve" style="width: 100%">
                <div id="inner-modal-wizard-audit">
                    <div class="modal-header">
                        <ul class="steps">
                            <li data-step="1" class="active">
                                <span class="step">1</span>
                                <span class="title">审核</span>
                            </li>

                            <li data-step="2">
                                <span class="step">2</span>
                                <span class="title">紧急通知</span>
                            </li>

                        </ul>
                    </div>

                    <div class="modal-body step-content" style="height: 399px">
                        <div class="step-pane active" data-step="1">
                            <div class="scrollable" data-size="367">
                                <form class="form-horizontal" id="inner-audit-form" role="form" method="post">
                                    <input id="inner-audit-record-id" type="hidden">
                                    <input id="inner-record-name" type="hidden">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-xs-4 control-label no-padding-left">状态：<span
                                                    class="required">*</span></label>

                                            <div class="radio">
                                                <label>
                                                    <input name="inner-form-audit-radio" class="ace input-lg" checked
                                                           value="1" type="radio">
                                                    <span class="lbl bigger-120"> 通过</span>
                                                </label>
                                                <label>
                                                    <input name="inner-form-audit-radio" class="ace input-lg" value="-1"
                                                           type="radio">
                                                    <span class="lbl bigger-120"> 不通过</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-xs-4 control-label no-padding-left">审核人：<span
                                                    class="required">*</span></label>

                                            <div class="col-xs-8">
                                                <input type="text" id="inner-audit-issuer" name="issuer" placeholder="审核人"
                                                       class="form-control"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left"
                                                    >审核意见：<span class="required">*</span></label>

                                            <div class="col-xs-10">
                                                <!-- 加载编辑器的容器 -->
                                                <textarea id="inner-audit-content" name="content"/>

                                            </div>
                                        </div>
                                    </div>
                                    <!--附件  -->
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-left">
                                                附件：
                                            </label>

                                            <div class="col-xs-10">
                                                <input id="inner-audit-file" type="file"/>


                                                <div id="inner-audit-file-queue"></div>
                                            </div>
                                        </div>
                                        <!-- PAGE CONTENT BEGINS -->

                                    </div>
                                </form>
                            </div>
                        </div>

                        <div class="step-pane" data-step="2">
                            <div class="scrollable" data-size="380">
                                <div class="col-xs-12">
                                    <form class="form-horizontal" role="form">
                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right">内容：<span
                                                    class="required">*</span></label>

                                            <div class="col-xs-10">
                                                <textarea id="inner-notice-content"/>

                                            </div>
                                        </div>

                                        <div class="form-group">
                                            <label class="col-xs-2 control-label no-padding-right">
                                                附件：
                                            </label>

                                            <div class="col-xs-10">
                                                <input id="inner-notice-file" type="file"/>

                                                <div id="inner-notice-file-queue"></div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer wizard-actions">
                    <button class="btn btn-sm btn-prev">
                        <i class="ace-icon fa fa-arrow-left"></i>
                        上一步
                    </button>

                    <button class="btn btn-success btn-sm btn-next" data-last="审核">
                        下一步
                        <i class="ace-icon fa fa-arrow-right icon-on-right"></i>
                    </button>

                    <button class="btn btn-danger btn-sm pull-left" id="inner-audit-cancle" data-dismiss="modal">
                        <i class="ace-icon fa fa-times"></i>
                        取消
                    </button>
                </div>
            </div>
        </div>
    </div>
    <%--内部突发事件审核--%>

    <%--内部突发事件续报--%>
    <div class="row">
        <div class="col-xs-12">
            <div id="inner-continue-record-dialog" class="hide">
                <form class="form-horizontal" id="inner-continue-record-form" role="form" method="post">
                    <div class="col-xs-6">
                        <div class="form-group">
                            <%--<input type="hidden" name="recordId" id="continue-record-id">--%>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group has-info">
                            <label class="col-xs-2 control-label no-padding-left bolder green">选择内部事件：<span
                                    class="required">*</span></label>

                            <div class="col-xs-10">
                                <select id="inner-record-select" name="selectName" class="form-control">

                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">标题：<span
                                    class="required">*</span></label>

                            <div class="col-xs-10">
                                <input type="text" id="inner-continue-title" name="title" class="form-control"
                                       placeholder="事件标题"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left">状态：<span
                                    class="required">*</span></label>

                            <div class="radio">
                                <label>
                                    <input name="inner-form-field-radio" class="ace input-lg" checked value="0" type="radio">
                                    <span class="lbl bigger-120"> 续报</span>
                                </label>
                                <label>
                                    <input name="inner-form-field-radio" class="ace input-lg" value="1" type="radio">
                                    <span class="lbl bigger-120"> 终报</span>
                                </label>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-6">
                        <div class="form-group">
                            <label class="col-xs-4 control-label no-padding-left">签发人：<span
                                    class="required">*</span></label>

                            <div class="col-xs-8">
                                <input type="text" id="inner-continue-issuer" name="issuer" placeholder="签发人"
                                       class="form-control"/>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">事件内容：<span
                                    class="required">*</span></label>

                            <div class="col-xs-10">
                                <!-- 加载编辑器的容器 -->
                                <textarea id="inner-continue-content" name="content"/>

                            </div>
                        </div>
                    </div>
                    <!--附件  -->
                    <div class="col-xs-12">
                        <div class="form-group">
                            <label class="col-xs-2 control-label no-padding-left">
                                附件：
                            </label>

                            <div class="col-xs-10">
                                <input id="inner-continue-record-file" type="file"/>


                                <div id="inner-continue-record-file-queue"></div>
                            </div>
                        </div>
                        <!-- PAGE CONTENT BEGINS -->

                    </div>
                </form>
            </div>
        </div>
    </div>
    <%--内部突发事件续报--%>
    <div class=col-xs-12">
        <div id="posgeo-dialog" class="hide">
            <iframe id="gisFrame" frameborder="no" src="${basePath}/cmawgis/eposgeo.html?type=2" style="width: 693px; height: 360px;"></iframe>
        </div>
    </div>
<%--后空行--%>
    <div class="row">
        <div class="space-30"></div>
    </div>


</div>
<script type="text/javascript">
    var scripts = [null, "${basePath}/js/dashboard/emeg.js",
        "${basePath}/js/dashboard/accd.js",
        "${basePath}/js/dashboard/innerAccd.js",
        "${basePath}/js/dashboard/spec.js",
        "${basePath}/js/dashboard/duty.js",
        "${basePath}/js/dashboard/message.js",
        "${basePath}/js/dashboard/send.js",
        null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        //去除浮动层
        G.removeFloatDiv();
        //时间控件
        G.datetimepicker();
        G.timepicker();
        G.datepicker();

        $("#refresh").click(function(){
            G.pjaxLoadPageContentDiv('#page/dashboard/list');
        })

        var orgLeaf = '${orgLeaf}';
        var startDate = '${startDate}';//当前时间
        var orgName='${orgName}';//机构名称
        var orgArray = '${vicDicOrgArray}';//响应单位
        var curOperate = '${curOperateAuth}';
        curOperate = curOperate.substring(1,curOperate.length-1);
        curOperate = curOperate.split(', ');



        //滚动条
        $('.scrollable').each(function () {
            var $this = $(this);
            $(this).ace_scroll({
                size: $this.attr('data-size') || 100
            });
        });
    })
</script>