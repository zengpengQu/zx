<%--
  Created by IntelliJ IDEA.
  User: admin
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>


<title>履职支撑平台</title>
<%--word导出--%>
<script src="${basePath}/plugin/wordExport/js/FileSaver.js"></script>
<script src="${basePath}/plugin/wordExport/js/jquery.wordexport.js"></script>
<script src="${basePath}/plugin/jQuery.print.js"></script>


<%--内行文样式--%>
<style id="styleIdNei">
    @media print {
        @page { margin: 0; }
        body { margin: 1.6cm; }
    }
    <!--
    /* Font Definitions */
    @font-face
    {font-family:宋体;
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:宋体;
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:等线;
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:"等线 Light";
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:"\@宋体";
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:"\@等线 Light";
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:"\@等线";
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    /* Style Definitions */
    p.MsoNormal, li.MsoNormal, div.MsoNormal
    {margin:0cm;
        margin-bottom:.0001pt;
        text-align:justify;
        text-justify:inter-ideograph;
        font-size:10.5pt;
        font-family:等线;}
    p.MsoHeader, li.MsoHeader, div.MsoHeader
    {mso-style-link:"页眉 Char";
        margin:0cm;
        margin-bottom:.0001pt;
        text-align:center;
        layout-grid-mode:char;
        border:none;
        padding:0cm;
        font-size:9.0pt;
        font-family:等线;}
    p.MsoFooter, li.MsoFooter, div.MsoFooter
    {mso-style-link:"页脚 Char";
        margin:0cm;
        margin-bottom:.0001pt;
        layout-grid-mode:char;
        font-size:9.0pt;
        font-family:等线;}
    p.MsoTitle, li.MsoTitle, div.MsoTitle
    {mso-style-link:"标题 Char";
        margin-top:12.0pt;
        margin-right:0cm;
        margin-bottom:3.0pt;
        margin-left:0cm;
        text-align:center;
        font-size:16.0pt;
        font-family:"等线 Light";
        font-weight:bold;}
    span.Char
    {mso-style-name:"页眉 Char";
        mso-style-link:页眉;}
    span.Char0
    {mso-style-name:"页脚 Char";
        mso-style-link:页脚;}
    span.Char1
    {mso-style-name:"标题 Char";
        mso-style-link:标题;
        font-family:"等线 Light";
        font-weight:bold;}
    .MsoChpDefault
    {font-family:等线;}
    /* Page Definitions */
    @page WordSection1
    {size:595.3pt 841.9pt;
        margin:72.0pt 89.85pt 72.0pt 89.85pt;
        layout-grid:15.6pt;}
    div.WordSection1
    {page:WordSection1;}
    -->
</style>

<%--外行文样式--%>
<style id="styleId">
    @media print {
        @page { margin: 0; }
        body { margin: 1.6cm; }
    }
    /* Font Definitions */
    @font-face
    {font-family:宋体;
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:宋体;
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:等线;
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:楷体;
        panose-1:2 1 6 9 6 1 1 1 1 1;}
    @font-face
    {font-family:仿宋;
        panose-1:2 1 6 9 6 1 1 1 1 1;}
    @font-face
    {font-family:"\@楷体";
        panose-1:2 1 6 9 6 1 1 1 1 1;}
    @font-face
    {font-family:"\@宋体";
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:"\@等线";
        panose-1:2 1 6 0 3 1 1 1 1 1;}
    @font-face
    {font-family:"\@仿宋";
        panose-1:2 1 6 9 6 1 1 1 1 1;}
    /* Style Definitions */
    p.MsoNormal, li.MsoNormal, div.MsoNormal
    {margin:0cm;
        margin-bottom:.0001pt;
        text-align:justify;
        text-justify:inter-ideograph;
        font-size:10.5pt;
        font-family:等线;}
    p.MsoTitle, li.MsoTitle, div.MsoTitle
    {mso-style-link:"标题 Char";
        margin-top:12.0pt;
        margin-right:0cm;
        margin-bottom:3.0pt;
        margin-left:0cm;
        text-align:center;
        font-size:16.0pt;
        font-family:"等线 Light";
        font-weight:bold;}
    span.Char
    {mso-style-name:"标题 Char";
        mso-style-link:标题;
        font-family:"等线 Light";
        font-weight:bold;}
    .MsoChpDefault
    {font-family:等线;}
    /* Page Definitions */
    @page WordSection1
    {size:595.3pt 841.9pt;
        margin:72.0pt 90.0pt 72.0pt 90.0pt;
        layout-grid:15.6pt;}
    div.WordSection1
    {page:WordSection1;}
</style>


<div class="tabable">
    <%--<ul class="tabbale-uls" id="table" style="margin-bottom: 15px;">
        <li class="active" style="    flex: unset;">
            <a data-toggle="tab" href="#nei" class="grid_tab">内行文</a>
        </li>
        <li style="    flex: unset;">
            <a data-toggle="tab" href="#wai" class="grid_tab">外行文</a>
        </li>
    </ul>--%>

    <!--Tab页-->
    <ul class=" tabbale-uls" id="table" style="margin-bottom: 10px;">
        <c:choose>
            <c:when test="${result eq 'wai'}">
                <!--内行文-->
                <li style="    flex: unset;">
                    <a data-toggle="tab" href="#nei" class="grid_tab">
                        内行文
                    </a>
                </li>
                <!--外行文-->
                <li class="active" style="    flex: unset;">
                    <a data-toggle="tab" href="#wai" class="grid_tab">
                        外行文
                    </a>
                </li>
            </c:when>
            <c:when test="${result eq 'nei'}">
                <!--内行文-->
                <li class="active" style="    flex: unset;">
                    <a data-toggle="tab" href="#nei" class="grid_tab">
                        内行文
                    </a>
                </li>
                <!--外行文-->
                <li style="    flex: unset;">
                    <a data-toggle="tab" href="#wai" class="grid_tab">
                        外行文
                    </a>
                </li>
            </c:when>
            <c:otherwise>
                <!--内行文-->
                <li class="active" style="    flex: unset;">
                    <a data-toggle="tab" href="#nei" class="grid_tab">
                        内行文
                    </a>
                </li>
                <!--外行文-->
                <li style="    flex: unset;">
                    <a data-toggle="tab" href="#wai" class="grid_tab">
                        外行文
                    </a>
                </li>
            </c:otherwise>
        </c:choose>
    </ul>
    <div class="tab-content" style="border: 0px;">
        <div class="tab-pane fade in active" id="nei">
            <div class="row">
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-xs-12 widget-container-col ">
                            <div class="accordion-style2 accordion">
                                <div class="group group-bottom">
                                    <h5 class="group-header accordion-header">
                                               <span class="searchTj">
                                                    查询条件
                                                </span>
                                    </h5>
                                    <div class="widget-body" style="border-top-width: 1px;background: #fff;">
                                        <div class="widget-main">
                                            <div class="col-xs-12">
                                                <form class="form-horizontal" role="form" id="searchForm">
                                                    <%--孙毅添加--%>
                                                    <input class="hidden" id="indexMainBachIdNei"
                                                           name="indexMainBachIdNei"
                                                           value="${indexMainBachId}">
                                                    <input class="hidden" id="batchDraftEditIndexMainIdWai"
                                                           name="batchDraftEditIndexMainIdWai"
                                                           value="${batchDraftEditIndexMainId}">
                                                    <input class="hidden" id="isWai" value="${isWai}">

                                                    <div class="row">
                                                        <div class="col-xs-4">
                                                            <div class="form-group"
                                                                 style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-xs-4 control-label no-padding-left"
                                                                       for="form-title-title">标题：</label>
                                                                <div class="col-xs-8 ">
                                                                    <input class="form-control" type="text"
                                                                           id="form-title-title" name="title">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%--<div class="col-xs-4">
                                                            <div class="form-group"
                                                                 style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-xs-4 control-label no-padding-left"
                                                                       for="form-field-orgName">报送部门：</label>
                                                                <div class="col-xs-8 ">
                                                                    <input class="form-control" type="text"
                                                                           id="form-field-orgName" name="orgName">
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                        <div class="col-xs-4">
                                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-sm-4 control-label"
                                                                       for="form-field-deptId">报送部门:</label>
                                                                <div class="col-sm-8 deptDiv">
                                                                    <input type="text" id="form-field-deptId" name="deptId"
                                                                           class="hide" value="${curDept.id}"/>
                                                                    <input type="text" class="form-control" id="form-field-deptName"
                                                                           name="deptName" value="${curDept.absName}" style="cursor: pointer;" readonly="readonly"/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%--<div class="col-xs-4">
                                                            <div class="form-group">
                                                                <label class="col-sm-4 control-label" for="form-field-department" >编制单位：<span
                                                                        class="required">*</span></label>

                                                                <div class="col-sm-8 deptDiv">
                                                                    <input type="text" id="form-field-department" name="department"
                                                                           class="hide" value=""/>
                                                                    <input type="text" class="form-control" id="form-field-deptName"
                                                                           name="deptName" value="" style="cursor: pointer;" readonly/>
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                        <div class="col-xs-4">
                                                            <div class="form-group"
                                                                 style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-sm-4 control-label">上报时间: </label>
                                                                <div class="col-sm-8">
                                                                    <div class="input-daterange input-group"
                                                                         data-date-format="yyyy-mm-dd">
                                                                        <input type="text" class="form-control"
                                                                               name="sendTimeStr" id="sendTimeStr"/>
                                                                        <span class="input-group-addon">
                                                                                <i class="fa fa-exchange"></i></span>
                                                                        <input type="text" class="form-control"
                                                                               name="endTime" id="endTime"/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-4 pull-right"
                                                             style="margin-top: 5px;margin-bottom: 5px">
                                                            <div class="btn-group pull-right">
                                                                <button class="btn btn-success btn-sm" type="button"
                                                                        id="searchBtn">
                                                                    <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                                    查询
                                                                </button>
                                                                <button class="btn btn-warning btn-sm" type="button" id="resetBtn">
                                                                    <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                                                    重置
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="space-10"></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="btn-group pull-right contacts-exportBtn">
                                <c:forEach items="${curOperateAuth}" var="curOpertate">
                                    <c:if test="${'79_8' eq curOpertate}">
                                        <button class="btn btn-info btn-sm" type="button" id="addBtn"
                                                style="top: 6px;right: 15px;">
                                            <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                            补录
                                        </button>
                                    </c:if>
                                </c:forEach>
                            </div>

                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="header-table-th">呈批件报送</div>
                            <div class="table-content col-md-12">
                                <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                                    <table id="grid-table" class="table_list"></table>
                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>

            <div id="view-dialog" class="hide">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="profile-user-info profile-user-info-striped">

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 标题</div>
                                <div class="profile-info-value">
                                    <span class="editable " id="title"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 报送部门</div>

                                <div class="profile-info-value">
                                    <span class="editable " id="orgName"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 上报时间</div>
                                <div class="profile-info-value">
                                    <span class="editable " id="sendTime"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 部门领导</div>
                                <div class="profile-info-value">
                                    <span class="editable " id="depLeader"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 拟稿人</div>
                                <div class="profile-info-value">
                                    <span class="editable " id="reporter"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 联系电话</div>
                                <div class="profile-info-value">
                                    <span class="editable " id="tel"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 核稿人</div>
                                <div class="profile-info-value">
                                    <span class="editable " id="checker"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 是否会签</div>
                                <div class="profile-info-value">
                                    <span class="editable " id="counterSignFlagStr"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 会签单位</div>
                                <div class="profile-info-value">
                                    <span class="editable " id="counterSignUnit"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 补录理由</div>
                                <div class="profile-info-value">
                                    <span class="editable " id="dicReason"></span>
                                </div>
                            </div>


                            <div class="profile-info-row">
                                <div class="profile-info-name"> 状态</div>
                                <div class="profile-info-value">
                                    <span class="editable " id="status"></span>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="tab-pane fade" id="wai">
            <div class="row" id="inWai">
                <div class="col-xs-12">
                    <div class="row">
                        <div class="col-xs-12 widget-container-col ">
                            <div class="accordion-style2 accordion">
                                <div class="group group-bottom">
                                    <h5 class="group-header accordion-header"><span class="searchTj">查询条件</span></h5>
                                    <div class="widget-body" style="border-top-width: 1px;background: #fff;">
                                        <div class="widget-main">
                                            <div class="col-xs-12">
                                                <form class="form-horizontal" role="form" id="searchFormWai">
                                                    <div class="row">
                                                        <div class="col-xs-4">
                                                            <div class="form-group"
                                                                 style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-xs-4 control-label no-padding-left"
                                                                       for="form-field-titleWai">标题：</label>
                                                                <div class="col-xs-8 ">
                                                                    <input class="form-control" type="text"
                                                                           id="form-field-titleWai">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <%--<div class="col-xs-4">
                                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-xs-4 control-label no-padding-left"
                                                                       for="form-field-orgNameWai">承办部门：</label>
                                                                <div class="col-xs-8 ">
                                                                    <input class="form-control" type="text"
                                                                           id="form-field-orgNameWai">
                                                                </div>
                                                            </div>
                                                        </div>--%>
                                                        <div class="col-xs-4">
                                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-sm-4 control-label no-padding-left"
                                                                       for="form-field-deptId">承办部门:</label>
                                                                <div class="col-sm-8 deptDiv">
                                                                    <input type="text" id="form-field-orgId" name="orgId"
                                                                           class="hide" value="${curDept.id}"/>
                                                                    <input type="text" class="form-control" id="form-field-orgNameWai"
                                                                           name="orgName" value="${curDept.absName}" style="cursor: pointer;" readonly/>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-4">
                                                            <div class="form-group"
                                                                 style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-sm-4 control-label">上报时间: </label>
                                                                <div class="col-sm-8">
                                                                    <div class="input-daterange input-group"
                                                                         data-date-format="yyyy-mm-dd">
                                                                        <input type="text" class="form-control"
                                                                               name="sendTimeWai" id="sendTimeWai"/>
                                                                        <span class="input-group-addon">
                                                                            <i class="fa fa-exchange"></i></span>
                                                                        <input type="text" class="form-control"
                                                                               name="endTimeWai" id="endTimeWai"/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="row">
                                                        <div class="col-xs-4 pull-right"
                                                             style="margin-top: 5px;margin-bottom: 5px">
                                                            <div class="btn-group pull-right">
                                                                <button class="btn btn-success btn-sm" type="button"
                                                                        id="searchBtnWai">
                                                                    <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                                    查询
                                                                </button>
                                                                <button style="margin-right: 10px"
                                                                        class="btn btn-warning btn-sm" type="button"
                                                                        id="resetBtnWai">
                                                                    <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                                                    重置
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="space-10"></div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="btn-group pull-right contacts-exportBtn">

                                <c:forEach items="${curOperateAuth}" var="curOpertate">
                                    <c:if test="${'79_8' eq curOpertate}">
                                        <button class="btn btn-info btn-sm" type="button" id="addBtnWai"
                                                style="top: 6px;right: 15px;">
                                            <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                            补录
                                        </button>
                                    </c:if>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="header-table-th">呈批件报送</div>
                            <div class="table-content col-md-12">
                                <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                                    <table id="grid-table-wai" class="table_list"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div id="view-dialog-wai" class="hide">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="profile-user-info profile-user-info-striped">

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 标题</div>
                                <div class="profile-info-value">
                                    <span class="editable " name="title"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 来文单位</div>

                                <div class="profile-info-value">
                                    <span class="editable " name="orgName"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 承部门</div>

                                <div class="profile-info-value">
                                    <span class="editable " name="deptName"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 上报时间</div>
                                <div class="profile-info-value">
                                    <span class="editable " name="sendTime"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 承办方部门领导</div>
                                <div class="profile-info-value">
                                    <span class="editable " name="depLeader"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 承办人</div>
                                <div class="profile-info-value">
                                    <span class="editable " name="contractor"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 联系电话</div>
                                <div class="profile-info-value">
                                    <span class="editable " name="tel"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 审核人</div>
                                <div class="profile-info-value">
                                    <span class="editable " name="approver"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 是否会签</div>
                                <div class="profile-info-value">
                                    <span class="editable " name="counterSignFlagStr"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 会签单位</div>
                                <div class="profile-info-value">
                                    <span class="editable " name="counterSignUnit"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 补录理由</div>
                                <div class="profile-info-value">
                                    <span class="editable " name="dicReason"></span>
                                </div>
                            </div>

                            <div class="profile-info-row">
                                <div class="profile-info-name"> 状态</div>
                                <div class="profile-info-value">
                                    <span class="editable " name="status"></span>
                                </div>
                            </div>

                            <%--<div class="profile-info-row" hidden>
                                <div class="profile-info-name">打印运行图</div>
                                <div class="profile-info-value">
                                    <span class="editable " name="status"></span>
                                </div>
                            </div>--%>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div id="model" class="page WordSection1 hide" style='layout-grid:15.6pt'>
        <div style="width: 10%;float: left;">
            <div style="padding-left: 15px;">
                <div style="float: left;margin-top: 280px;height: 320px;font-size: 11pt;font-family: 宋体;color: red;line-height: 118px;width: 15px;">
                    装订线
                </div>
                <div style="width: 6px;float: left;margin-top: 325px;height: 310px;color: red;">
                    ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆ ┆
                </div>
            </div>
        </div>
        <div style="width: 90%;float: right;">
            <div style="width: 555px;">
                <p align="center">
                    <span style='font-size:40.0pt;font-family:宋体;color:red;'>呈 &nbsp;批 &nbsp;件</span>
                </p>
            </div>
            <table border=1 cellspacing=0 cellpadding=0 style='border-collapse:collapse;border:none'>
                <tr style='height:254.05pt'>
                    <td width=552 colspan=2 valign=top style='width:414.3pt;border-top:solid red 1.5pt;border-left:none;
                                    border-bottom:solid red 1.5pt;border-right:none;padding:10px 5.4pt 0cm 5.4pt;height:254.05pt'>
                        <p class=MsoNormal><span style='font-size:14.0pt;font-family:宋体;color:red'>领导同志批示：</span></p>
                    </td>
                </tr>
                <tr style='height:125.95pt'>
                    <td width=302 rowspan=2 valign=top style='width:8.0cm;border-top:none;border-left:none;
                            border-bottom:solid red 1.5pt;border-right:solid red 1.5pt;padding:10px 5.4pt 0cm 5.4pt;height:125.95pt'>
                        <p class=MsoNormal>
                            <span style='font-size:14.0pt;font-family:宋体;color:red'>办公厅专委会领导批示：</span>
                        </p>
                    </td>
                    <td width=250 valign=top style='width:187.5pt;border:none;border-bottom:solid red 1.5pt;
                                    padding:10px 5.4pt 0cm 5.4pt;height:125.95pt'>
                        <p class=MsoNormal>
                            <span style='font-size:14.0pt;font-family:宋体;color:red'>会签意见：</span>
                        </p>
                    </td>
                </tr>
                <tr style='height:125.85pt'>
                    <td width=250 valign=top style='width:187.5pt;border:none;border-bottom:solid red 1.5pt;
                                    padding:10px 5.4pt 0cm 5.4pt;height:125.85pt'>
                        <p class=MsoNormal>
                            <span style='font-size:14.0pt;font-family:宋体;color:red'>室局负责人意见：</span>
                        </p>
                    </td>
                </tr>
                <tr style='height:40.9pt'>
                    <td width=552 colspan=2 valign=top style='width:414.3pt;border:none;
                                    border-bottom:solid red 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:40.9pt;line-height: 34pt;'>
                        <p class=MsoNormal>
                            <span style='font-size:14.0pt;font-family:宋体;color:red;'>标 题：</span>
                            <span id="spanTitleNei" style='font-size:14.0pt;font-family:宋体;'></span>
                        </p>
                    </td>
                </tr>
                <tr style='height:40.3pt'>
                    <td width=552 colspan=2 valign=top style='width:414.3pt;border:none;
                                    border-bottom:solid red 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:40.3pt;line-height: 34pt;'>
                        <p class=MsoNormal>
                            <div style="width: 25%;float: left;height: 46px;">
                                <span style='font-size:14.0pt;font-family:宋体;color:red'>部门：</span>
                                <span id="spanOrg" style='font-size:14.0pt;font-family:宋体;'></span>
                            </div>
                            <div style="width: 25%;float: left;height: 46px;">
                                <span style='font-size:14.0pt;font-family:宋体;color:red'>拟稿人：</span>
                                <span id="spanRep" style='font-size:14.0pt;font-family:宋体;'></span>
                            </div>
                            <div style="width: 25%;float: left;height: 46px;">
                                <span style='font-size:14.0pt;font-family:宋体;color:red'>联系电话：</span>
                                <span id="spanTelNei" style='font-size:14.0pt;font-family:宋体;'></span>
                            </div>
                            <div style="width: 25%;float: left;height: 46px;">
                                <span style='font-size:14.0pt;font-family:宋体;color:red'>核稿人：</span>
                                <span id="spanCheck" style='font-size:14.0pt;font-family:宋体;'></span>
                            </div>
                        </p>
                    </td>
                </tr>
            </table>
            <p align="right" style="width: 430pt;margin-top: 5px;padding-right: 0px;">
                <span style='font-size:14.0pt;font-family:宋体;color:red'>政协全国委员会办公厅制</span>
            </p>
        </div>
    </div>

    <div id="model-wai" class="page hide">
        <div class=WordSection1 style='layout-grid:15.6pt'>
            <p class=MsoTitle style='line-height:150%'><span style='font-size:22.0pt;line-height:150%;font-family:宋体;color:red'>收文办理专用单</span></p>
            <div align=center>
                <table class=MsoTableGrid border=1 cellspacing=0 cellpadding=0 style='border-collapse:collapse;border:none'>
                    <tr style='page-break-inside:avoid;height:292.6pt'>
                        <td width=95 style='width:70.9pt;border:solid red 1.5pt;border-left:none;padding:0cm 5.4pt 0cm 5.4pt;height:292.6pt' align="center">
                            <div class=MsoNormal align=center style='width: 1em;font-size: 14pt;color:red;font-family:楷体;line-height:1.5em;'>领导同志批示

                            </div>
                        </td>
                        <td width=496 style='width:371.95pt;border-top:solid red 1.5pt;border-left:none;border-bottom:solid red 1.5pt;border-right:none;padding:0cm 5.4pt 0cm 5.4pt;height:292.6pt'>
                            <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
                        </td>
                    </tr>
                    <tr style='height:148.2pt'>
                        <td width=95 style='width:70.9pt;border-top:none;border-left:none;border-bottom:solid red 1.5pt;border-right:solid red 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:148.2pt'>
                            <p class=MsoNormal align=center style='text-align:center'>
                                <span style='font-size:14.0pt;font-family:楷体;color:red'>办理建议</span>
                            </p>
                        </td>
                        <td width=496 style='width:371.95pt;border:none;border-bottom:solid red 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:148.2pt'>
                            <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
                        </td>
                    </tr>
                    <tr style='height:72.8pt'>
                        <td width=95 style='width:70.9pt;border-top:none;border-left:none;border-bottom:solid red 1.5pt;border-right:solid red 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:72.8pt'>
                            <p class=MsoNormal><span style='font-size:14.0pt;font-family:楷体;color:red'>来文单位及文件标题</span></p>
                        </td>
                        <td width=496 style='fwidth:371.95pt;border:none;border-bottom:solid red 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:72.8pt'>
                            <p class=MsoNormal><span id="spantitle" lang=EN-US style="font-size:14.0pt;font-family:楷体;color:black;">&nbsp;</span></p>
                        </td>
                    </tr>
                    <tr style='height:57.25pt'>
                        <td width=590 colspan=2 style='width:442.85pt;border:none;border-bottom:solid red 1.5pt;padding:0cm 5.4pt 0cm 5.4pt;height:57.25pt'>
                            <div class="MsoNormal">
                               <div style="width: 50%;float: left;">
                                   <p>
                                        <span style='font-size:14.0pt;font-family:楷体;color:red;'>承办部门：
                                            <span id="spandept" style="font-size:14.0pt;font-family:楷体;color:black;"></span>
                                        </span>
                                   </p>
                                   <p>
                                        <span style='font-size:14.0pt;font-family:楷体;color:red'>联系电话：
                                            <span id="spantel" style="font-size:14.0pt;font-family:楷体;color:black;"></span>
                                        </span>
                                   </p>
                               </div>
                                <div style="float: right;width: 50%;">
                                    <p>
                                        <span style='font-size:14.0pt;font-family:楷体;color:red;'>承办人（处室）：
                                            <span id="spancon" style="font-size:14.0pt;font-family:楷体;color:black;"></span>
                                        </span>
                                    </p>
                                    <p>
                                        <span style='font-size:14.0pt;font-family:楷体;color:red'>审核人（室局）：
                                            <span id="spanappro" style="font-size:14.0pt;font-family:楷体;color:black;"></span>
                                        </span>
                                    </p>
                                </div>
                            </div>
                        </td>
                    </tr>
                    <tr style='height:25.15pt'>
                        <td width=590 colspan=2 style='width:442.85pt;border:none;padding:0cm 5.4pt 0cm 5.4pt;height:25.15pt'>
                            <p class=MsoNormal align=right style='text-align:right'>
                                <span lang=EN-US style='font-size:15.0pt;font-family:仿宋;color:red'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>
                                <span style='font-size:15.0pt;font-family:楷体;color:red'>政协全国委员会办公厅制</span>
                            </p>
                        </td>
                    </tr>
                </table>
            </div>
            <p class=MsoNormal><span lang=EN-US>&nbsp;</span></p>
        </div>
    </div>

    <div id="preview-dialog" class="hide" style="background-color: darkseagreen"></div>

    <div id="preview-wai-dialog" class="hide" style="background-color: darkseagreen"></div>

</div>


<script type="text/javascript">
    var scripts = [null, null];
    //当通过标签切换显示的时候,第二个jqgrid的宽度不能自适应。
    //解决:当标签切换完成的时候,重新设置jqgrid的宽度值等于其父元素的宽度值即可。


    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.updateBreadcrumb([
            '公共信息管理',
            '呈批件管理',
            '呈批件报送']);

        //切换tab页
        var flagTab = '${result}';
        if (flagTab == "wai") {
            $("#nei").removeClass().attr("class", "tab-pane fade ");
            $("#wai").removeClass().attr("class", "tab-pane fade in active");
        }
        if (flagTab == "nei") {
            $("#nei").removeClass().attr("class", "tab-pane fade in active");
            $("#wai").removeClass().attr("class", "tab-pane fade ");
        }

        // G.initDept('deptDiv',true,null,TREE_NODE);

        $('.input-daterange').datepicker({autoclose: true, todayHighlight: true});

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });
        //用于判断是有查看所有呈批件的权限
        var flag = true;
        //用于传一个状态码
        var statuss = 0;
        <c:forEach items="${curOperateAuth}" var="curOpertate">
        <c:if test="${'79_9' eq curOpertate}">
            G.initDept('deptDiv',true,['{}', '{}'],TREE_NODE);
            flag = false;
            statuss = 2;
        </c:if>
        </c:forEach>

        if (flag){
            G.initDept('deptDiv',false,['${curDept}', '${curDept}'],TREE_NODE);
        }


        //元素类全局变量
        var $startDate = $("#sendTimeStr");
        var $endDate = $("#endTime");

        var $title = $("#form-title-title");
        var $deptId = $("#form-field-deptId");
        var $reporter = $("#form-field-reporter");

        var $titleWai = $("#form-field-titleWai");
        var $orgId = $("#form-field-orgId");
        var $reporterWai = $("#form-field-reporterWai");
        var $startDateWai = $("#sendTimeWai");
        var $endDateWai = $("#endTimeWai");
        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");
        var $searchBtnWai = $("#searchBtnWai");
        var $resetBtnWai = $("#resetBtnWai");
        var $addBtnWai = $("#addBtnWai");
        //孙毅添加
        var $indexMainBachIdNei = $("#indexMainBachIdNei");
        var $batchDraftEditIndexMainIdWai = $("#batchDraftEditIndexMainIdWai");
        var $isWai = $("#isWai");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $searchFormWai = $("#searchFormWai");
        var $gridTable = $("#grid-table");
        var $gridTableWai = $("#grid-table-wai");
        //弹窗类全局变量
        var $viewDialog = $("#view-dialog");
        var $viewDialogWai = $("#view-dialog-wai");

        // 导出word弹出框
        var $previewDialog = $("#preview-dialog");
        var $previewWaiDialog = $("#preview-wai-dialog");

        $('.grid_tab').on('shown.bs.tab', function () {

            $($(this).attr('href')).find('.table_list').jqGrid(
                'setGridWidth', $($(this).attr('href')).find('.jqgrid_box').width());
            $gridTableWai.tjGrid("triggerResizeGrid");
            $gridTable.tjGrid("triggerResizeGrid");
        });
        //本页面url
        //列表加载
        var loadUrl = '${basePath}/submit-batch/load-batch-submit-list.do';
        var loadUrlWai = '${basePath}/submit-batch-out/load-batch-submit-wai-list.do';
        //核稿
        var checkUrl = '#page/submit-batch/batch-submit-check';
        var checkUrlWai = '#page/submit-batch-out/batch-submit-wai-check';
        //编辑
        var editUrl = '#page/submit-batch/batch-submit-edit';
        var editUrlWai = '#page/submit-batch-out/batch-submit-wai-edit';
        //补录
        var recordUrl = '#page/submit-batch/batch-submit-record';
        var recordUrlWai = '#page/submit-batch-out/batch-submit-wai-record';
        //历史记录
        var feedbackUrl = '#page/submit-batch/batch-submit-register-list';
        var feedbackUrlWai = '#page/submit-batch-out/batch-submit-register-wai-list';
        //上报以及状态修改
        var reportUrl = '${basePath}/submit-batch/batch-load-reporter.do';
        var reportUrlWai = '${basePath}/submit-batch-out/batch-load-wai-reporter.do';
        //删除
        var deleteUrl = '${basePath}/submit-batch/batch-submit-delete.do';
        var deleterUrlWai = '${basePath}/submit-batch-out/batch-submit-wai-delete.do';
        //查收
        var handleUrl = '${basePath}/submit-batch/batch-submit-handle.do';
        var handleUrlWai = '${basePath}/submit-batch-out/batch-submit-wai-handle.do';
        //打印
        var printUrl = '${basePath}/submit-batch/batch-submit-print.do';
        var printUrlWai = '${basePath}/submit-batch-out/batch-submit-wai-print.do';
        //办结
        var overUrl = '${basePath}/submit-batch/batch-submit-over.do';
        var overUrlWai = '${basePath}/submit-batch-out/batch-submit-wai-over.do';

        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'title', header: '标题', index: 'title', sortable: false},
            {name: 'orgName', header: '报送部门', index: 'orgName', sortable: false},
            {name: 'sendTime', header: '上报时间', index: 'sendTime', sortable: false},
            {name: 'depLeader', header: '部门领导', index: 'depLeader', sortable: false,hidden:true},
            {name: 'reporter', header: '拟稿人', index: 'reporter', sortable: false,hidden:true},
            {name: 'tel', header: '联系电话', index: 'tel', sortable: false,hidden:true},
            {name: 'checker', header: '核稿人', index: 'checker', sortable: false,hidden:true},
            {name: 'counterSignFlagStr', header: '是否会签', index: 'counterSignFlagStr', sortable: false,hidden:true},
            {name: 'counterSignUnit', header: '会签单位', index: 'counterSignUnit', sortable: false,hidden:true},
            {name: 'dicReason', header: '补录理由', index: 'dicReason', sortable: false,hidden:true},
            {
                name: 'status',
                header: '状态',
                index: 'status',
                align: 'center',
                sortable: false,
                formatter: statusOperationFormatter
            },
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 200,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {name: 'work', header: '业务操作', sortable: false, width: 400, fixed: true, formatter: workOperationFormatter}
        ];
        var colModelWai = [{name: 'id', index: 'id', hidden: true},
            {name: 'title', header: '标题', index: 'title'},
            {name: 'orgName', header: '来文单位', index: 'orgName'},
            {name: 'deptName', header: '承办部门', index: 'deptName'},
            {name: 'sendTime', header: '上报时间', index: 'sendTime', sortable: false},
            {name: 'depLeader', header: '部门领导', index: 'depLeader', sortable: true,hidden:true},
            {name: 'contractor', header: '承办人', index: 'contractor', sortable: true,hidden:true},
            {name: 'tel', header: '联系电话', index: 'tel', sortable: true,hidden:true},
            {name: 'approver', header: '审核人', index: 'approver', sortable: true,hidden:true},
            {name: 'counterSignFlagStr', header: '是否会签', index: 'counterSignFlagStr', sortable: true,hidden:true},
            {name: 'counterSignUnit', header: '会签单位', index: 'counterSignUnit', sortable: true,hidden:true},
            {name: 'dicReason', header: '补录理由', index: 'dicReason', sortable: true,hidden:true},
            {
                name: 'status',
                header: '状态',
                index: 'status',
                align: 'center',
                sortable: false,
                formatter: statusOperationFormatter
            },
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 200,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {name: 'work', header: '业务操作', sortable: false, width: 400, fixed: true, formatter: workOperationFormatter}
        ];

        $gridTable.tjGrid({
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortable:true,
            sortname: 'updateTime',
            sortorder: 'desc',
            postData: {
                indexMainBachIdNei: $indexMainBachIdNei.val(),
                title: $title.val(),
                deptId: $deptId.val(),
                sendTimeStr: $startDate.val(),
                endTime: $endDate.val(),
                statuss:statuss
            },
            onSelectRow: function (id, stat, e) {
                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $gridTable.jqGrid('getRowData', id);

                if (className.indexOf('row-record-view') !== -1) {
                    viewWeekWork(rowData);

                } else if (className.indexOf('row-record-edit') !== -1) {

                    G.pjaxLoadPageContentDiv(editUrl + "?id=" + id);

                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条记录吗！',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        $gridTable.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-send') !== -1) {
                    //核稿
                    G.pjaxLoadPageContentDiv(checkUrl + "?id=" + id);

                } else if (className.indexOf('row-record-register') !== -1) {
                    //上报
                    reporter(id);
                } else if (className.indexOf('row-record-feedback') !== -1) {
                    //跳转到历史流转记录页面
                    G.pjaxLoadPageContentDiv(feedbackUrl + "?id=" + id + '&date=' + new Date().getTime());
                } else if (className.indexOf('row-record-checkbatch') != -1) {
                    //查收
                    // checkbatch(id);
                } else if (className.indexOf('row-record-print') !== -1) {
                    //先根据id去获取相应的数据,然后打印
                    // printgetdata(id);
                    exportNei(id);
                }else if (className.indexOf('row-record-over') != -1) {
                    //办结
                    overbatch(id);
                }
            }
        });

        $gridTableWai.tjGrid({
            loadUrl: loadUrlWai,
            height: '100%',
            autowidth: true,
            colModel: colModelWai,
            sortable:true,
            sortname: 'updateTime',
            sortorder: 'desc',
            postData: {
                batchDraftEditIndexMainIdWai: $batchDraftEditIndexMainIdWai.val(),
                startDateWai: $startDate.val(),
                endDateWai: $endDate.val(),
                title: $titleWai.val(),
                orgId: $orgId.val(),
                statuss:statuss
            },
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }

                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }

                var rowData = $gridTableWai.jqGrid('getRowData', id);

                if (className.indexOf('row-record-view') !== -1) {

                    viewWeekWorkWai(rowData);

                } else if (className.indexOf('row-record-edit') !== -1) {

                    G.pjaxLoadPageContentDiv(editUrlWai + "?id=" + id + '&date=' + new Date().getTime());

                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条记录吗！',
                        callback: function (result) {
                            if (result) {
                                $.post(deleterUrlWai, {id: id}, function (data) {
                                    if (data.result) {
                                        $gridTableWai.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-send') !== -1) {
                    //核稿
                    G.pjaxLoadPageContentDiv(checkUrlWai + "?id=" + id + '&date=' + new Date().getTime());
                } else if (className.indexOf('row-record-register') !== -1) {
                    //上报
                    reporterwai(id);
                } else if (className.indexOf('row-record-feedback') !== -1) {
                    //历史流转记录
                    G.pjaxLoadPageContentDiv(feedbackUrlWai + "?id=" + id + '&date=' + new Date().getTime());
                } else if (className.indexOf('row-record-checkbatch') !== -1) {
                    //查收
                    // checkbatchwai(id);
                } else if (className.indexOf('row-record-print') !== -1) {
                    //打印，同时生生二维码放到打印的呈批件左上角
                    //将数据封装到页面
                    // printgetdataWai(id)
                    exportWai(id);
                }else if (className.indexOf('row-record-over') !== -1) {
                    //办结
                    overbatchwai(id);
                }
            },
            loadComplete: function () {
                $gridTableWai.tjGrid("triggerResizeGrid");
            }
        });

        //根据所选行导出内行文呈批件
        function exportNei(id) {
            var url = '${basePath}/submit-batch/batch-submit-export.do';
            var title = '呈批件';
            //不跳转页面，直接将页面嵌入弹出框
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: url,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $previewDialog.html(String);
                    G.doneAjaxLoading(loadId);

                    var $qrcode = $previewDialog.find('#qrcode');
                    $qrcode.qrcode({width: 93,height: 93,text: id});
                    var docu = $previewDialog[0];
                    var canvas = docu.querySelector("#qrcode > canvas");
                    var img = $previewDialog.find('#qrcode-img')[0];
                    img.src = canvas.toDataURL();

                    //初始化弹出框
                    $previewDialog.find('#qrcode').remove();
                    // var styleStr = document.getElementById("styleIdNei").innerHTML;
                    var styleLink = '${basePath}/css/pubinfo/export_submit_nei.css';

                    initPreviewDialog($previewDialog, title, styleLink);
                },
                error: function (e) {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }

        //根据所选行导出外行文呈批件
        function exportWai(id) {
            var url = '${basePath}/submit-batch-out/batch-submit-wai-export.do';
            var title = '收文办理专用单';

            //不跳转页面，直接将页面嵌入弹出框
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: url,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $previewWaiDialog.html(String);
                    G.doneAjaxLoading(loadId);

                    var $qrcode = $previewWaiDialog.find('#qrcode');
                    $qrcode.qrcode({width: 93,height: 93,text: id});
                    var docu = $previewWaiDialog[0];
                    var canvas = docu.querySelector("#qrcode > canvas");
                    var img = $previewWaiDialog.find('#qrcode-img')[0];
                    img.src = canvas.toDataURL();

                    $previewWaiDialog.find('#qrcode').remove();
                    // var styleStr = document.getElementById("styleId").innerHTML;
                    var styleLink = '${basePath}/css/pubinfo/export_submit_wai.css';

                    //初始化弹出框
                    initPreviewDialog($previewWaiDialog, title, styleLink);
                },
                error: function (e) {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }

        //初始化呈批件弹出框
        function initPreviewDialog($container, title, styleStr) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 700,
                width: 1200,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>" + title + "预览</h4></div>",
                title_html: true,
                close: function () {
                    $container.addClass("hide");
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 导出",
                        "class": "btn btn-success",
                        click: function () {

                            <%--$container.wordExport(title + "-${year}${month}${day}", styleStr);--%>

                            $container.print({
                                iframe:true,
                                prepend:'<br/>',
                                stylesheet: styleStr,
                            });
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }


        //声明为全局变量为内行文打印服务
        var titles;
        var orgNames;
        var reporters;
        var tels;
        var checkers;
        var draftIds;
        //内行文打印数据的查询
        function printgetdata(id) {
            G.confirm({
                message: '确认打印呈批件吗？',
                callback: function (result) {
                    if (result) {
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: printUrl,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            if (map.result) {
                                titles =  map.title;
                                orgNames = map.orgName;
                                reporters = map.reporter;
                                tels = map.tel;
                                checkers = map.checker;
                                draftIds = map.Id;
                                PrintView();
                            } else {
                                G.showGritterFail("打印失败,请稍后重试!");
                            }
                        });
                    }
                }
            });
        }

        //声明为全局变量为外行文打印服务
        var titlesWai;
        var deptNames;
        var orgNames;
        var contractors;
        var telsWai;
        var approvers;
        var draftIdOut;
        //外行文打印数据的查询
        function printgetdataWai(id) {
            G.confirm({
                message: '确认打印呈批件吗？',
                callback: function (result) {
                    if (result) {
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: printUrlWai,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            if (map.result) {
                                titlesWai =  map.title;
                                deptNames = map.deptName;
                                orgNames = map.orgName;
                                contractors = map.contractor;
                                telsWai = map.tel;
                                approvers = map.approver;
                                draftIdOut = map.Id;
                                PrintViewWai();
                            } else {
                                G.showGritterFail("打印失败,请稍后重试!");
                            }
                        });
                    }
                }
            });
        }


        var LODOP; //声明为全局变量
        //内行文打印
        function PrintView() {
            $("#spanTitleNei").html(titles.toString());
            $("#spanOrg").html(orgNames.toString());
            $("#spanRep").html(reporters.toString());
            $("#spanTelNei").html(tels.toString());
            $("#spanCheck").html(checkers.toString());
            var data = document.getElementById("model").innerHTML;
            var stylestr = "<style>"+document.getElementById("styleIdNei").innerHTML+"</style>";
            var Str = "<!DOCTYPE html><html><head>"+ stylestr + "</head>"+ "<body lang=ZH-CN style='text-justify-trim:punctuation'>"+ data + "</body></html>";

            LODOP = getLodop();
            LODOP.PRINT_INITA(0, 0, 0, 0, "打印控件功能演示_Lodop功能_自定义纸张1");
            LODOP.NEWPAGEA();
            LODOP.SET_PRINT_PAGESIZE(0, 0, 0, "A4");
            //top,left,width,height
            LODOP.ADD_PRINT_HTM("26mm","6mm","591pt","705pt",Str);
            LODOP.ADD_PRINT_BARCODE(100,600,93,93,"QRCode",draftIds.toString());
            LODOP.PREVIEW();
        }

        //外行文打印
        function PrintViewWai() {
            $("#spantitle").html(orgNames.toString()+" "+titlesWai.toString());
            $("#spandept").html(deptNames.toString());
            $("#spancon").html(contractors.toString());
            $("#spantel").html(telsWai.toString());
            $("#spanappro").html(approvers.toString());
            var data = document.getElementById("model-wai").innerHTML;
            var stylestr = "<style>"+document.getElementById("styleId").innerHTML+"</style>";
            var Str = "<!DOCTYPE html><html><head>"+ stylestr + "</head>"+ "<body lang=ZH-CN style='tab-interval:21.0pt;text-justify-trim:punctuation'>"+ data + "</body></html>";

            LODOP = getLodop();
            LODOP.PRINT_INITA(0, 0, 0, 0, "打印控件功能演示_Lodop功能_自定义纸张1");
            LODOP.NEWPAGEA();
            LODOP.SET_PRINT_PAGESIZE(0, 0, 0, "A4");
            //top,left,width,height
            LODOP.ADD_PRINT_HTM("32mm","2.5mm","591pt","705pt",Str);
            LODOP.ADD_PRINT_BARCODE(80,620,93,93,"QRCode",draftIdOut.toString());
            LODOP.PREVIEW();
        }


        $gridTable.tjGrid("triggerResizeGrid");
        $gridTableWai.tjGrid("triggerResizeGrid");

        //新增页面跳转
        $addBtn.unbind('click').bind('click', function () {
            G.pjaxLoadPageContentDiv(recordUrl);
        });
        //新增页面跳转
        $addBtnWai.unbind('click').bind('click', function () {
            G.pjaxLoadPageContentDiv(recordUrlWai);
        });
        $searchBtn.click(function () {
            search();
        });
        $searchBtnWai.click(function () {
            searchWai();
        });

        function search() {

            var startDate = $startDate.val();
            var endDate = $endDate.val();
            var title = $title.val();
            var deptId = $deptId.val();
            var reporter = $reporter.val();

            var statuss = 0;
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'79_9' eq curOpertate}">
                statuss = 2;
            </c:if>
            </c:forEach>

            $gridTable.tjGrid('setPostData', {
                sendTimeStr: startDate,
                endTime: endDate,
                title: title,
                deptId: deptId,
                reporter: reporter,
                statuss:statuss
            });
            reloadGrid();
        }

        function searchWai() {

            var startDateWai = $startDateWai.val();
            var endDateWai = $endDateWai.val();
            var titleWai = $titleWai.val();
            var orgId = $orgId.val();
            var reporterWai = $reporterWai.val();

            var statuss = 0;
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'79_9' eq curOpertate}">
            statuss = 2;
            </c:if>
            </c:forEach>

            $gridTableWai.tjGrid('setPostData', {
                startDateWai: startDateWai,
                endDateWai: endDateWai,
                title: titleWai,
                orgId: orgId,
                reporterWai: reporterWai,
                statuss:statuss
            });
            reloadGridWai();
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        function reloadGridWai() {
            $gridTableWai.tjGrid('reloadGrid');
        }

        $resetBtn.click(function () {
            var statuss = 0;
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'79_9' eq curOpertate}">
            statuss = 2;
            </c:if>
            </c:forEach>
            $searchForm.resetForm();
            search();
        });
        $resetBtnWai.click(function () {
            var statuss = 0;
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'79_9' eq curOpertate}">
            statuss = 2;
            </c:if>
            </c:forEach>
            $searchFormWai.resetForm();

            searchWai();
        });

        //内行文呈批件报送查看
        function viewWeekWork(rowData) {

            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {

                $(this).html(rowData[$(this).attr('id')]);
            });

            initViewDialog($viewDialog);
        }

        //外行文呈批件报送查看
        function viewWeekWorkWai(rowData) {

            //为弹出框赋值
            $viewDialogWai.find('.editable').each(function () {

                $(this).html(rowData[$(this).attr('name')]);
            });

            initViewDialog($viewDialogWai);
        }

        //内行文上报
        function reporter(id) {
            G.confirm({
                message: '确认上报吗？',
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: reportUrl,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            G.doneAjaxLoading(loadId);
                            if (map.result) {
                                G.showGritterSuccess("上报成功!");

                            } else {
                                G.showGritterFail("上报失败,请稍后重试!");
                            }
                            //更新表格数据
                            search();
                        });
                    }
                }
            });
        }

        //内行文办结
        function overbatch(id) {
            G.confirm({
                message: '确认呈批件已经批示完毕吗？',
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: overUrl,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            G.doneAjaxLoading(loadId);
                            if (map.result) {
                                G.showGritterSuccess("办结完毕!");

                            } else {
                                G.showGritterFail("办结失败,请稍后重试!");
                            }
                            //更新表格数据
                            search();
                        });
                    }
                }
            });
        }

        //外行文办结
        function overbatchwai(id) {
            G.confirm({
                message: '确认呈批件已经批示完毕吗？',
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: overUrlWai,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            G.doneAjaxLoading(loadId);
                            if (map.result) {
                                G.showGritterSuccess("办结完毕!");

                            } else {
                                G.showGritterFail("办结失败,请稍后重试!");
                            }
                            //更新表格数据
                            searchWai();
                        });
                    }
                }
            });
        }

        //外行文上报
        function reporterwai(id) {
            G.confirm({
                message: '确认上报吗？',
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: reportUrlWai,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            G.doneAjaxLoading(loadId);
                            if (map.result) {
                                G.showGritterSuccess("上报成功!");
                            } else {
                                G.showGritterFail("上报失败,请稍后重试!");
                            }
                            //更新表格数据
                            searchWai()
                        });
                    }
                }
            });
        }

        //内行文查收
        function checkbatch(id) {
            G.confirm({
                message: '确认查收吗？',
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: handleUrl,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            G.doneAjaxLoading(loadId);
                            if (map.result) {
                                G.showGritterSuccess("查收成功!");

                            } else {
                                G.showGritterFail("查收失败,请稍后重试!");
                            }
                            //更新表格数据
                            search();
                        });
                    }
                }
            });
        }

        //外行文查收
        function checkbatchwai(id) {
            G.confirm({
                message: '确认查收吗？',
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: handleUrlWai,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            G.doneAjaxLoading(loadId);
                            if (map.result) {
                                G.showGritterSuccess("查收成功!");

                            } else {
                                G.showGritterFail("上报失败,请稍后重试!");
                            }
                            //更新表格数据
                            searchWai();
                        });
                    }
                }
            });
        }

        //呈批件报送查看的确定按钮
        function initViewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>呈批件报送查看</h4></div>",
                title_html: true,
                close: function () {
                    $container.addClass("hide");
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }

        function statusOperationFormatter(cellvalue, options, rowData, action) {

            var status = _.trim(rowData.status);

            var operations = [];

            if (status == '0') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-warning">待核稿</span>');
            } else if (status == '1') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-success">已核稿待上报</span>');
            } else if (status == '2') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-pink">已上报待办结</span>')
            // } else if (status == '3') {
            //    operations.push('<span class="label label-sm  arrowed arrowed-right label-primary">已查收待办结</span>')
            } else if (status == '4') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-inverse">已办结</span>')
            }
            operations.push('</div>');
            cellvalue = operations.join('');
            return cellvalue;
        }

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];
            var status = rowData.status;
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'79_1' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'79_2' eq curOpertate}">
            if (status == '0') {
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'79_3' eq curOpertate}">
            if (status == '0') {
                operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
                operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
                operations.push('</button>');
            }
            </c:if>
            </c:forEach>
            //把权限放开，让起草人和值班室都有打印权限
            if (status == '2'|| status == '3'){
                operations.push(' <button title="打印" class="btn btn-minier btn-white btn-primary row-record-print">');
                operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 打印');
                operations.push('</button>');
            }
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function workOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            var status = rowData.status;

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'79_6' eq curOpertate}">
            if (status == '0') {
                operations.push(' <button title="核稿" class="btn btn-minier btn-white btn-primary row-record-send">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-up"></i> 核稿');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'79_7' eq curOpertate}">
            if (status == '1') {
                operations.push(' <button title="上报" class="btn btn-minier btn-white btn-warning row-record-register">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-up"></i> 上报');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'79_4' eq curOpertate}">
            operations.push(' <button title="历史流转记录查看" class="btn btn-minier btn-white btn-warning row-record-feedback">');
            operations.push('<i class="ace-icon glyphicon glyphicon-arrow-down"></i> 历史流转记录查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'79_5' eq curOpertate}">
            // if (status == '2') {
            //     operations.push(' <button title="查收" class="btn btn-minier btn-white btn-primary row-record-checkbatch">');
            //     operations.push('<i class="ace-icon glyphicon glyphicon-check"></i> 查收');
            //     operations.push('</button>');
            // }
            if (status == '2') {
                operations.push(' <button title="办结" class="btn btn-minier btn-white btn-primary row-record-over">');
                operations.push('<i class="ace-icon glyphicon glyphicon-check"></i> 办结');
                operations.push('</button>');

            }
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }
    });
</script>
