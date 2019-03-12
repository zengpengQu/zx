<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>

<div class="row">
    <div class="col-xs-12">
        <input type="hidden" name="curOperateAuth" value="" id="curOperateAuthId"/>
        <input type="hidden" name="result" value="" id="flagId"/>
        <div class="tabable">
            <!--Tab页-->
            <ul class=" tabbale-uls" id="myTab" style="margin-bottom: 10px;">
                <c:choose>
                    <c:when test="${result eq 'file'}">
                        <!--电报管理-->
                        <li style="    flex: unset;">
                            <a data-toggle="tab" href="#telegraph_manage" class="grid_tab">
                                电报管理
                            </a>
                        </li>
                        <!--文件管理-->
                        <li class="active" style="    flex: unset;">
                            <a data-toggle="tab" href="#file_manage" class="grid_tab">
                                文件管理
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <!--电报管理-->
                        <li class="active" style="    flex: unset;">
                            <a data-toggle="tab" href="#telegraph_manage" class="grid_tab">
                                电报管理
                            </a>
                        </li>
                        <!--文件管理-->
                        <li style="    flex: unset;">
                            <a data-toggle="tab" href="#file_manage" class="grid_tab">
                                文件管理
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
            <!--每个Tab页的内容-->
            <div class="tab-content" style="border: 0px;padding: 0px;">
                <!--电报管理-->
                <div id="telegraph_manage" class="tab-pane fade in active">
                    <%--<h4 align="center" >电报管理</h4>--%>
                    <div id="page-telegraph_manage">

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="row">
                                    <div class="col-xs-12 widget-container-col ">
                                        <!-- #section:custom/widget-box -->
                                        <div class="accordion-style2 accordion">
                                            <div class="group group-bottom">
                                                <h5 class="group-header accordion-header" style="width: 160px;">
                            <span class="searchTj">
                                查询条件
                            </span>
                                                </h5>

                                                <div class="widget-body"
                                                     style="border-top-width: 1px;background: #fff;">
                                                    <div class="widget-main">
                                                        <div class="col-xs-12">
                                                            <form class="form-horizontal" role="form" autocomplete="off"
                                                                  id="searchFormTele">
                                                                <div class="row">
                                                                    <!-- 密级 -->
                                                                    <%--<div class="col-xs-4">--%>
                                                                        <%--<div class="form-group"--%>
                                                                             <%--style="margin-top: 5px;margin-bottom: 5px">--%>
                                                                            <%--<label class="col-sm-4 control-label"--%>
                                                                                   <%--for="form-field-secClass">密级:</label>--%>
                                                                            <%--<div class="col-sm-8">--%>
                                                                                <%--<input type="text"--%>
                                                                                       <%--id="form-field-secClass"--%>
                                                                                       <%--name="secClass"--%>
                                                                                       <%--class="form-control" value=""/>--%>
                                                                            <%--</div>--%>
                                                                        <%--</div>--%>
                                                                    <%--</div>--%>
                                                                    <div class="col-xs-4">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-4 control-label"
                                                                                   for="form-field-secClass">密级：</label>
                                                                            <div class="col-sm-8 ">
                                                                                <select class="form-control" id="form-field-secClass"
                                                                                        name="secClass">
                                                                                    <option value="">--------请选择--------</option>
                                                                                    <c:forEach items="${secClassList}" var="secClass">
                                                                                        <option value="${secClass.name}">${secClass.name}</option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <!-- 来文类型 -->
                                                                    <div class="col-xs-4">
                                                                        <div class="form-group"
                                                                             style="margin-top: 5px;margin-bottom: 5px">
                                                                            <label class="col-sm-4 control-label"
                                                                                   for="form-field-telegramType">来文类型:</label>
                                                                            <div class="col-sm-8">
                                                                                <input type="text"
                                                                                       id="form-field-telegramType"
                                                                                       name="telegramType"
                                                                                       class="form-control" value=""/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <!-- 接收时间 -->
                                                                    <!-- 录入人 -->
                                                                    <div class="col-xs-4">
                                                                        <div class="form-group"
                                                                             style="margin-top: 5px;margin-bottom: 5px">
                                                                            <label class="col-sm-4 control-label"
                                                                                   for="form-field-recoder">录入人:</label>
                                                                            <div class="col-sm-8">
                                                                                <input type="text"
                                                                                       id="form-field-recoder"
                                                                                       name="recoder"
                                                                                       class="form-control" value=""/>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-xs-4">
                                                                        <div class="form-group"
                                                                             style="margin-top: 5px;margin-bottom: 5px">
                                                                            <label class="col-sm-4 control-label" for="form-field-receiveTime"
                                                                            style="padding-right: 0px;">接收时间：</label>
                                                                            <div class="col-sm-8 ">
                                                                                <div class="input-group">
                                                                                    <input class="form-control date-picker"
                                                                                           name="receiveTimeStr"
                                                                                           id="form-field-receiveTime"
                                                                                           data-date-format="yyyy-mm-dd"
                                                                                           value=""
                                                                                           type="text"/>
                                                                                    <span class="input-group-addon"><i
                                                                                            class="fa fa-calendar bigger-110"></i></span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>

                                                                    <div class="col-xs-4 pull-right"
                                                                         style="margin-top: 5px;margin-bottom: 5px">
                                                                        <div class="btn-group pull-right">
                                                                            <button class="btn btn-success btn-sm"
                                                                                    type="button" id="searchBtnTele">
                                                                                <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                                                查询
                                                                            </button>
                                                                            <button class="btn btn-warning btn-sm"
                                                                                    type="button" id="resetBtnTele">
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
                                        <!-- /section:custom/widget-box -->
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="btn-group pull-right contacts-exportBtn">
                                            <c:forEach items="${curOperateAuth}" var="curOpertate">
                                                <c:if test="${'72_4' eq curOpertate}">
                                                    <button class="btn btn-info btn-sm" type="button" id="addBtnTele"
                                                            style="top: 6px;right:23px;">
                                                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                                        新增
                                                    </button>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="header-table-th">电报管理信息</div>
                                        <div class="table-content  col-md-12">
                                            <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                                                <table id="grid-table" class="table_list"></table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--文件管理-->
                <div id="file_manage" class="tab-pane fade ">
                    <%--<h4 align="center" >文件管理</h4>--%>
                    <div id="page-file_manage">

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="row">
                                    <div class="col-xs-12 widget-container-col ">
                                        <!-- #section:custom/widget-box -->
                                        <div class="accordion-style2 accordion">
                                            <div class="group group-bottom">
                                                <h5 class="group-header accordion-header" style="width: 160px;">
                            <span class="searchTj">
                                查询条件
                            </span>
                                                </h5>

                                                <div class="widget-body"
                                                     style="border-top-width: 1px;background: #fff;">
                                                    <div class="widget-main">
                                                        <div class="col-xs-12">
                                                            <form class="form-horizontal" role="form" autocomplete="off"
                                                                  id="searchFormFile">
                                                                <div class="row">
                                                                    <!-- 密级 -->
                                                                    <%--<div class="col-xs-4">--%>
                                                                        <%--<div class="form-group">--%>
                                                                            <%--<label class="col-sm-4 control-label"--%>
                                                                                   <%--for="form-fi-secDeadline">--%>
                                                                                <%--密级：</label>--%>
                                                                            <%--<div class="col-sm-8 ">--%>
                                                                                <%--<input type="text"--%>
                                                                                       <%--id="form-fi-secDeadline"--%>
                                                                                       <%--name="secClassStr"--%>
                                                                                       <%--class="form-control " value=""/>--%>
                                                                            <%--</div>--%>
                                                                        <%--</div>--%>
                                                                    <%--</div>--%>
                                                                    <div class="col-xs-4">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-4 control-label"
                                                                                   for="form-fi-secDeadline">密级：</label>
                                                                            <div class="col-sm-8 ">
                                                                                <select class="form-control" id="form-fi-secDeadline"
                                                                                        name="secClassStr">
                                                                                    <option value="">--------请选择--------</option>
                                                                                    <c:forEach items="${secClassList}" var="secClass">
                                                                                        <option value="${secClass.name}">${secClass.name}</option>
                                                                                    </c:forEach>
                                                                                </select>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <!-- 来文类型 -->
                                                                    <div class="col-xs-4">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-4 control-label"
                                                                                   for="form-fi-fileType">
                                                                                来文类型：</label>
                                                                            <div class="col-sm-8 ">
                                                                                <input type="text" id="form-fi-fileType"
                                                                                       name="fileType"
                                                                                       class="form-control " value=""/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                </div>
                                                                <div class="row">
                                                                    <!-- 来文单位 -->
                                                                    <div class="col-xs-4">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-4 control-label"
                                                                                   for="form-fi-senderOrg">
                                                                                来文单位：</label>
                                                                            <div class="col-sm-8 ">
                                                                                <input type="text"
                                                                                       id="form-fi-senderOrg"
                                                                                       name="senderOrg"
                                                                                       class="form-control " value=""/>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-4">
                                                                        <div class="form-group">
                                                                            <label class="col-sm-4 control-label" for="form-fi-receiveTime">
                                                                                收件时间：</label>
                                                                            <div class="col-sm-8 ">
                                                                                <div class="input-daterange input-group">
                                                                                    <input class="form-control date-picker"
                                                                                           name="receiveTimeStr"
                                                                                           id="form-fi-receiveTime"
                                                                                           data-date-format="yyyy-mm-dd"
                                                                                           value="" type="text"/>
                                                                                    <span class="input-group-addon"><i
                                                                                            class="fa fa-calendar bigger-110"></i></span>
                                                                                </div>
                                                                            </div>
                                                                        </div>
                                                                    </div>
                                                                    <div class="col-xs-4 pull-right"
                                                                         style="margin-top: 5px;margin-bottom: 5px">
                                                                        <div class="btn-group pull-right">
                                                                            <button class="btn btn-success btn-sm"
                                                                                    type="button" id="searchBtnFile">
                                                                                <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                                                查询
                                                                            </button>
                                                                            <button class="btn btn-warning btn-sm"
                                                                                    type="button" id="resetBtnFile">
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
                                        <!-- /section:custom/widget-box -->
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="btn-group pull-right contacts-exportBtn">
                                            <c:forEach items="${curOperateAuth}" var="curOpertate">
                                                <c:if test="${'72_11' eq curOpertate}">
                                                    <button class="btn btn-info btn-sm" type="button" id="addBtn"
                                                            style="top: 6px;right:23px;">
                                                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                                        新增
                                                    </button>
                                                </c:if>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="header-table-th">文件管理信息</div>
                                        <div class="table-content  col-md-12">
                                            <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                                                <table id="grid-table-file" class="table_list"></table>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
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
                    <div class="profile-info-name"> 接收日期</div>

                    <div class="profile-info-value">
                        <span class="editable " id="receiveTimeStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 密级</div>

                    <div class="profile-info-value">
                        <span class="editable " id="secClass"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 来文类型</div>

                    <div class="profile-info-value">
                        <span class="editable " id="telegramType"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 来文标题</div>

                    <div class="profile-info-value">
                        <span class="editable " id="telegramTitle"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 录入人</div>

                    <div class="profile-info-value">
                        <span class="editable " id="dicUser"></span>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group form-horizontal" id="uploadedDiv">
                    <label class="col-sm-2 control-label" for="download-view"
                           style="font-weight: bold;color: deepskyblue;">
                        已上传的附件：
                    </label>
                    <div class="col-sm-10">
                        <span id="download-view"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="view-dialog-file" class="hide">

    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 内部序号</div>

                    <div class="profile-info-value">
                        <span class="editable " id="inSerialNum"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 来文类型</div>

                    <div class="profile-info-value">
                        <span class="editable " id="fileType"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 来文标题</div>

                    <div class="profile-info-value">
                        <span class="editable " id="fileTitle"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 密级</div>

                    <div class="profile-info-value">
                        <span class="editable " id="secClassStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 收件时间</div>

                    <div class="profile-info-value">
                        <span class="editable " id="receiveTimeSt"></span>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="form-group form-horizontal" id="uploaded-div-file">
                    <label class="col-sm-2 control-label" for="download-view-file"
                           style="font-weight: bold;color: deepskyblue;">
                        已上传的附件：
                    </label>
                    <div class="col-sm-10">
                        <span id="download-view-file"></span>
                    </div>
                </div>
            </div>

        </div>
    </div>


</div>
<%--<script type="text/javascript" src="${basePath}/js/telegraphManage/telegraph-manage-list.js"></script>--%>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        //切换tab页
        var flag = '${result}';
        if (flag == "file") {
            $("#telegraph_manage").removeClass().attr("class", "tab-pane fade ");
            $("#file_manage").removeClass().attr("class", "tab-pane fade in active");
        }
        if (flag == "telegraph") {
            $("#telegraph_manage").removeClass().attr("class", "tab-pane fade in active");
            $("#file_manage").removeClass().attr("class", "tab-pane fade ");
        }

        var auth = '${curOperateAuth}';

        $("#curOperateAuthId").attr("value", auth);

        //当通过标签切换显示的时候,第二个jqgrid的宽度不能自适应。
        //解决:当标签切换完成的时候,重新设置jqgrid的宽度值等于其父元素的宽度值即可。
        // $('.grid_tab').on('shown.bs.tab', function () {
        //     $($(this).attr('href')).find('.table_list').jqGrid(
        //         'setGridWidth', $($(this).attr('href')).find('.jqgrid_box').width());
        // });
        $('.grid_tab').on('shown.bs.tab', function () {
            $($(this).attr('href')).find('.table_list').tjGrid("triggerResizeGrid");
        });

        G.datepicker({
            ormat: 'yyyy-mm-dd',
            autoclose: true,
            todayHighlight: true
        })

        //电报时间控件校验
        $('.input-daterange').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true
            }
        );

        //电报搜索条件
        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });
        //文件搜索条件
        $(".accordions").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        // 显示附件信息
        function appendAttach($div, jsonFileObject) {

            $div.empty();
            var html = [];
            if (_.isEmpty(jsonFileObject)) {
                html.push('<ul class="list-unstyled list-striped pricing-table-header"><li style="margin-top:5px">');
                html.push('暂无上传附件！');
                html.push('</li></ul>');
            } else {
                html.push('<ul class="list-unstyled list-striped pricing-table-header">');
                for (var i = 0; i < jsonFileObject.length; i++) {
                    html.push('<li class="blue"  style="cursor:pointer;background-color: white;">');
                    html.push('<a class="filePreview" fileId="' + jsonFileObject[i].id + '" style="color:#478FCA;font-family:仿宋, Arial, Helvetica, sans-serif;font-size: 18px;">');
                    html.push(jsonFileObject[i].fileName);
                    html.push('</a>&nbsp&nbsp&nbsp');
                    html.push('<a style="color:grey" href="${basePath}/file/download.action?id=' + jsonFileObject[i].id + '&type=0">');
                    html.push('<i class="ace-icon fa fa-download grey bigger-130"></i>下载</a>&nbsp;&nbsp;&nbsp;&nbsp;');
                    html.push('</li>');
                }
                html.push('</ul>');
            }
            $div.append(html.join(""));
        }

        jQuery(function ($) {
            //元素类全局变量
            var $secClass = $("#form-field-secClass");
            var $telegramType = $("#form-field-telegramType");
            var $receiveTime = $("#form-field-receiveTime");
            var $recoder = $("#form-field-recoder");

            //控件类全局变量
            var $searchBtnTele = $("#searchBtnTele");
            var $resetBtnTele = $("#resetBtnTele");
            var $addBtnTele = $("#addBtnTele");

            //表单类全局变量
            var $gridTable = $("#grid-table");
            var $viewDialog = $("#view-dialog");
            var $searchFormTele = $("#searchFormTele");

            //存放用户选择的表格列
            var item_selected = [];

            //本页面url
            /***************电报*******************/
            var localUrl = '${basePath}/telegraph-manage/load-telegraph-manage-list.do';
            var deleteUrl = '${basePath}/telegraph-manage/load-telegraph-manage-delete.do';
            var editUrl = '#page/telegraph-manage/load-telegraph-manage-edit';
            var insertUrl = '#page/circulate-record/load-circulate-record-insert';
            var viewUrl = '#page/circulate-record/load-circulate-file-show';

            var colModel = [
                {name: 'id', index: 'id', hidden: true},
                /*{name: 'inSerialNum', header: '内部序号', index: 'inSerialNum', sortable: true},*/
                {name: 'receiveTimeStr', header: '接收日期', index: 'receiveTime', sortable: true},
                /*{name: 'telegramNum', header: '报号', index: 'telegramNum', sortable: true},*/
                {name: 'secClass', header: '密级', index: 'secClass', sortable: true},
                /*{name: 'quantity', header: '数量', index: 'quantity', sortable: true},*/
                /*{name: 'senderOrg', header: '来文单位', index: 'senderOrg', sortable: true},*/
                {name: 'telegramType', header: '来文类型', index: 'telegramType', sortable: true},
                {name: 'telegramTitle', header: '来文标题', index: 'telegramTitle', sortable: true},
                {name: 'dicUser', header: '录入人', index: 'dicUser.empName', sortable: true},
                {name: 'dicUserId', header: '录入人标识', index: 'dicUser.id', sortable: true, hidden: true},
                {
                    name: 'basic',
                    header: '基本操作',
                    sortable: false,
                    width: 220,
                    fixed: true,
                    formatter: basicOperationFormatter
                },
                {
                    name: 'basic',
                    header: '业务操作',
                    sortable: false,
                    width: 220,
                    fixed: true,
                    formatter: workOperationFormatter
                }
            ];


            //电报管理基本操作
            function basicOperationFormatter(cellvalue, options, rowData, action) {
                var operations = [];
                var status = rowData.status;
                operations.push("<div style='margin-left:8px;font-size: 20px;'>");
                <c:forEach items="${curOperateAuth}" var="curOpertate">
                <c:if test="${'72_1' eq curOpertate}">
                operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
                operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
                operations.push('</button>');
                </c:if>
                <c:if test="${'72_2' eq curOpertate}">
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                operations.push('<i class="ace-icon fa fa-pencil bigger-120"></i> 编辑');
                operations.push('</button>');
                </c:if>
                <c:if test="${'72_3' eq curOpertate}">
                operations.push(' <button title="删除" class="btn btn-minier btn-white btn-danger row-record-delete">');
                operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
                operations.push('</button>');
                </c:if>
                </c:forEach>
                operations.push("<div>");
                cellvalue = operations.join('');
                return cellvalue;
            }

            function workOperationFormatter(cellvalue, options, rowData, action) {
                var operations = [];
                var status = rowData.status;
                operations.push("<div style='margin-left:8px;font-size: 20px;'>");
                <c:forEach items="${curOperateAuth}" var="curOpertate">
                <c:if test="${'72_5' eq curOpertate}">
                operations.push(' <button title="新增传阅" class="btn btn-minier btn-white btn-danger row-circulate-insert">');
                operations.push(' <i class="ace-icon glyphicon glyphicon-plus"></i> 新增传阅');
                operations.push('</button>');
                </c:if>
                <c:if test="${'72_7' eq curOpertate}">
                operations.push(' <button title="查看传阅" class="btn btn-minier btn-white btn-danger row-circulate-view">');
                operations.push(' <i class="ace-icon glyphicon glyphicon-zoom-in"></i> 查看传阅');
                operations.push('</button>');
                </c:if>
                </c:forEach>
                operations.push("<div>");
                cellvalue = operations.join('');
                return cellvalue;
            }

            //电报管理表格展示
            $gridTable.tjGrid({
                loadUrl: localUrl,
                height: '100%',
                autowidth: true,
                colModel: colModel,
                postData: {
                    secClass: $secClass.val(),
                    telegramType: $telegramType.val(),
                    receiveTime: $receiveTime.val(),
                    recoder: $recoder.val()
                },
                sortname: 'receiveTime',
                sortorder: 'desc',
                onSelectRow: function(id, stat, e) {
                    if (e === undefined) {
                        return false;
                    }
                    var className = $(e.target).attr('class');
                    if (!className) {
                        return false;
                    }
                    var rowData = $gridTable.jqGrid('getRowData', id);

                    if (className.indexOf('row-record-view') !== -1) {
                        //查看
                        viewTelegraph(rowData);
                    } else if (className.indexOf('row-record-edit') !== -1) {
                        //编辑
                        var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                        G.pjaxLoadPageContentDiv(editHash);
                    } else if (className.indexOf('row-record-delete') !== -1) {
                        //删除
                        G.confirm({
                            message: '确认删除记录!',
                            callback: function (result) {
                                if (result) {
                                    $.post(
                                        deleteUrl, {id: id}, function (data) {
                                            if (data.result) {
                                                $gridTable.tjGrid('reloadGrid');
                                            }
                                        }
                                    );
                                }
                            }
                        });
                    } else if (className.indexOf('row-circulate-insert') !== -1) {
                        //新增电报传阅
                        var insertHash = insertUrl + "?id=" + id + '&data=' + new Date().getTime();
                        G.pjaxLoadPageContentDiv(insertHash);
                    } else if (className.indexOf('row-circulate-view') !== -1) {
                        //查看电报传阅
                        var viewHash = viewUrl + "?id=" + id + '&data=' + new Date().getTime();
                        G.pjaxLoadPageContentDiv(viewHash);
                    }
                }
            });

            //页面自适应
            $gridTable.tjGrid("triggerResizeGrid");

            //查看电报
            function viewTelegraph(rowData) {

                var fileUrl = '${basePath}/telegraph-manage/get-telegraph-file-list.do';
                var $fileList = $viewDialog.find('#download-view');
                var id = rowData.id;

                //为弹出框赋值
                $viewDialog.find('.editable').each(function () {
                    $(this).html(rowData[$(this).attr('id')]);
                });

                $.ajax({
                    url: fileUrl,
                    type: "POST",
                    data: {id: id},
                    dataType: "json",
                    success: function (result) {
                        appendAttach($fileList, result.fileList);
                        initViewTelegraph($viewDialog);
                    },
                    error: function () {
                        G.alert({message: "操作失败！"});
                    }
                });
            }

            //初始化查看电报弹框
            function initViewTelegraph($container) {
                $container.removeClass('hide').dialog({
                    resizable: false,
                    height: 'auto',
                    maxHeight: 600,
                    width: 800,
                    modal: true,
                    title: "<div class='widget-header header-bg'><h4 class='smaller' style='margin-top: 12px'><i class='ace-icon fa fa-globe green'></i>查看电报管理</h4></div>",
                    title_html: true,
                    close: function () {
                        $container.addClass("hide");
                    },
                    buttons: [
                        {
                            html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp;  确定",
                            "class": "btn btn-success",
                            click: function () {
                                $(this).dialog("close");
                            }
                        }
                    ]
                });
            }

            //电报条件查询
            $searchBtnTele.click(function () {
                searchTele();
            });

            function searchTele() {
                var secClass = $secClass.val();
                var telegramType = $telegramType.val();
                var receiveTime = $receiveTime.val();
                var recoder = $recoder.val();
                $gridTable.tjGrid('setPostData', {
                    secClass: secClass,
                    telegramType: telegramType,
                    receiveTime: receiveTime,
                    recoder: recoder
                });
                reloadGrid();
            }

            function reloadGrid() {
                $gridTable.tjGrid('reloadGrid');
            }

            //电报重置
            $resetBtnTele.click(function () {
                $searchFormTele.resetForm();
                item_selected = [];
                searchTele();
            });

            //电报新增或修改页面跳转
            $addBtnTele.unbind('click').bind('click', function (e) {
                G.pjaxLoadPageContentDiv(editUrl);
            });
        });

        jQuery(function ($) {

            var fileLocalUrl = '/file-manage/load-file-manage-list.do';
            var fileEditUrl = '#page/file-manage/load-file-manage-edit';
            var fileDeleteUrl = '/file-manage/load-file-manage-delete.do';
            var fileInsertUrl = '#page/circulate-record/load-circulate-record-add';
            var fileViewUrl = '#page/circulate-record/load-circulate-record-view';

            var curOperateAu = $("#curOperateAuthId").val();
            //获取按钮操作权限
            var dd = curOperateAu.substring(0, curOperateAu.length - 1).substring(1, curOperateAu.length - 1);
            var curOperateAuth = new Array();
            curOperateAuth = dd.split(",");

            //元素类全局变量
            var $secClassStr = $("#form-fi-secDeadline");
            var $fileType = $("#form-fi-fileType");
            var $receiveTimeS = $("#form-fi-receiveTime");
            var $senderOrg = $("#form-fi-senderOrg");
            //控件类全局变量
            var $searchBtnFile = $("#searchBtnFile");
            var $resetBtnFile = $("#resetBtnFile");
            var $addBtn = $("#addBtn");
            //表单类全局变量
            var $searchFormFile = $("#searchFormFile");
            var $viewDialogFile = $("#view-dialog-file");
            var $gridTableFile = $("#grid-table-file");

            //存放用户选择的表格列
            var item_selected_file = [];

            var colModelFile = [
                {name: 'id', index: 'id', hidden: true},
                {name: 'inSerialNum', header: '内部序号', index: 'inSerialNum', sortable: true},
                {name: 'secClassStr', header: '密级', index: 'secClassStr', sortable: true},
                {name: 'fileType', header: '来文类型', index: 'fileType', sortable: true},
                {name: 'fileTitle', header: '来文标题', index: 'fileTitle', sortable: true},
                {name: 'receiveTimeSt', header: '收件时间', index: 'receiveTimeSt', sortable: true},
                {
                    name: 'basic',
                    header: '基本操作',
                    sortable: false,
                    width: 220,
                    fixed: true,
                    formatter: basicOperationFormatters
                },
                {
                    name: 'work',
                    header: '业务操作',
                    sortable: false,
                    width: 220,
                    fixed: true,
                    formatter: workOperationFormatters
                }
            ];


            //文件管理基本操作
            function basicOperationFormatters(cellvalue, options, rowData, action) {
                var operations = [];
                var status = rowData.status;
                operations.push("<div style='margin-left:8px;font-size: 20px;'>");
                for (var i = 0; i < curOperateAuth.length; i++) {
                    if ('72_8' == curOperateAuth[i].trim()) {
                        operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-file-view">');
                        operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
                        operations.push('</button>');
                    }
                    if ('72_9' == curOperateAuth[i].trim()) {
                        operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-file-edit">');
                        operations.push('<i class="ace-icon fa fa-pencil bigger-120"></i> 编辑');
                        operations.push('</button>');
                    }
                    if ('72_91' == curOperateAuth[i].trim()) {
                        operations.push(' <button title="删除" class="btn btn-minier btn-white btn-danger row-file-delete">');
                        operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
                        operations.push('</button>');
                    }
                }
                operations.push("<div>");
                cellvalue = operations.join('');
                return cellvalue;
            }

            //文件管理业务操作
            function workOperationFormatters(cellvalue, options, rowData, action) {
                var operations = [];
                var status = rowData.status;
                operations.push("<div style='margin-left:8px;font-size: 20px;'>");
                for (var j = 0; j < curOperateAuth.length; j++) {
                    if ('72_12' == curOperateAuth[j].trim()) {
                        operations.push(' <button title="新增传阅" class="btn btn-minier btn-white btn-danger row-circulate-file-insert">');
                        operations.push(' <i class="ace-icon glyphicon glyphicon-plus"></i> 新增传阅');
                        operations.push('</button>');
                    }
                    if ('72_14' == curOperateAuth[j].trim()) {
                        operations.push(' <button title="查看传阅" class="btn btn-minier btn-white btn-danger row-circulate-file-view">');
                        operations.push(' <i class="ace-icon glyphicon glyphicon-zoom-in"></i> 查看传阅');
                        operations.push('</button>');
                    }
                }
                operations.push("<div>");
                cellvalue = operations.join('');
                return cellvalue;
            }

            //文件管理表格展示
            $gridTableFile.tjGrid({
                loadUrl: fileLocalUrl,
                height: '100%',
                autowidth: true,
                colModel: colModelFile,
                postData: {
                    secClassStr: $secClassStr.val(),
                    fileType: $fileType.val(),
                    receiveTime: $receiveTimeS.val(),
                    senderOrg: $senderOrg.val()
                },
                sortname: 'receiveTime',
                sortorder: 'desc',
                onSelectRow: function(id, stat, e) {
                    if (e === undefined) {
                        return false;
                    }
                    var className = $(e.target).attr('class');
                    if (!className) {
                        return false;
                    }
                    var rowData = $gridTableFile.jqGrid('getRowData', id);
                    if (className.indexOf('row-file-view') !== -1) {
                        //查看
                        viewFile(rowData);
                    } else if (className.indexOf('row-file-edit') !== -1) {
                        //编辑
                        var editHash = fileEditUrl + "?id=" + id + '&date=' + new Date().getTime();
                        G.pjaxLoadPageContentDiv(editHash);
                    } else if (className.indexOf('row-file-delete') !== -1) {
                        //删除
                        G.confirm({
                            message: '确认删除记录!',
                            callback: function (result) {
                                if (result) {
                                    $.post(
                                        fileDeleteUrl, {id: id}, function (data) {
                                            if (data.result) {
                                                $gridTableFile.tjGrid('reloadGrid');
                                            }
                                        }
                                    );
                                }
                            }
                        });
                    } else if (className.indexOf('row-circulate-file-insert') !== -1) {
                        //新增文件传阅
                        var addHash = fileInsertUrl + "?id=" + id + '&date=' + new Date().getTime();
                        G.pjaxLoadPageContentDiv(addHash);
                    } else if (className.indexOf('row-circulate-file-view') !== -1) {
                        //查看文件传阅
                        var showHash = fileViewUrl + "?id=" + id + '&date=' + new Date().getTime();
                        G.pjaxLoadPageContentDiv(showHash);
                    }
                }
            });
            //页面自适应
            $gridTableFile.tjGrid("triggerResizeGrid");

            //查看
            function viewFile(rowData) {
                var fileUrl = '${basePath}/file-manage/get-filemanage-file-list.do';
                var $fileList = $viewDialogFile.find('#download-view-file');
                var id = rowData.id;

                //为弹出框赋值
                $viewDialogFile.find('.editable').each(function () {
                    $(this).html(rowData[$(this).attr('id')]);
                });

                $.ajax({
                    url: fileUrl,
                    type: "POST",
                    data: {id: id},
                    dataType: "json",
                    success: function (result) {
                        appendAttach($fileList, result.fileList);
                        initViewFile($viewDialogFile);
                    },
                    error: function () {
                        G.alert({message: "操作失败！"});
                    }
                });

            }

            function initViewFile($container) {
                $container.removeClass('hide').dialog({
                    resizable: false,
                    height: 'auto',
                    maxHeight: 600,
                    width: 800,
                    modal: true,
                    title: "<div class='widget-header header-bg'><h4 class='smaller'style='height: 39px;line-height: 39px;'>查看文件管理</h4></div>",
                    title_html: true,
                    close: function () {
                        $container.addClass('hide');
                    },
                    buttons: [
                        {
                            html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp;  确定",
                            "class": "btn btn-success",
                            click: function () {
                                $(this).dialog('close');
                            }
                        }
                    ]
                });
            }

            //条件查询
            $searchBtnFile.click(function () {
                searchFile();
            });

            function searchFile() {
                $gridTableFile.tjGrid('setPostData', {
                    secClassStr: $secClassStr.val(),
                    fileType: $fileType.val(),
                    receiveTime: $receiveTimeS.val(),
                    senderOrg: $senderOrg.val()
                });
                reloadGridFile();
            }

            function reloadGridFile() {
                $gridTableFile.tjGrid('reloadGrid');
            }

            //重置
            $resetBtnFile.click(function () {
                $searchFormFile.resetForm();
                item_selected_file = [];
                searchFile();
            });

            //文件管理新增或编辑页面跳转
            $addBtn.unbind('click').bind('click', function (e) {
                G.pjaxLoadPageContentDiv(fileEditUrl);
            });

        });


    });
</script>