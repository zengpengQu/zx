<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>

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

                        <div class="widget-body" style="border-top-width: 1px;background: #fff;">
                            <div class="widget-main" >
                                <div class="col-xs-12" >
                                    <form class="form-horizontal" role="form" id="searchForm"autocomplete="off">
                                        <input value="${placeIndexMainId}"id="placeIndexMainId" name="placeIndexMainId" class="hidden">
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px;">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-title">标题:</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-title"
                                                               name="title" type="text">
                                                        </input>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">

                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-deptId">承办单位:</label>
                                                    <div class="col-sm-8 deptDiv">
                                                        <input type="text" id="form-field-deptId" name="deptId"
                                                               class="hide" value="${curDept.id}"/>
                                                        <input type="text" class="form-control" id="form-field-deptName"
                                                               name="deptName" value="${curDept.absName}" style="cursor: pointer;" readonly="readonly"/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-actType">类别:</label>

                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-actType" name="actType">
                                                            <option value="">-----请选择-----</option>
                                                            <option value="视察">视察</option>
                                                            <option value="考察">考察</option>
                                                            <option value="调研">调研</option>

                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="space-10"></div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-createTime">上报日期:</label>

                                                    <div class="col-sm-8 ">
                                                        <div class="input-group">
                                                            <input class="form-control date-picker"
                                                                   name="createTime"
                                                                   id="form-field-createTime"
                                                                   data-date-format="yyyy-mm-dd"
                                                                   value="" type="text"/>
                                                            <span class="input-group-addon"><i
                                                                    class="fa fa-calendar bigger-110"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-nodeTime">年度:</label>
                                                    <div class="col-sm-8">
                                                        <div class="input-group">
                                                            <input class="form-control yearpicker"
                                                                   name="nodeTime" id="form-field-nodeTime"
                                                                   data-date-format="yyyy" value="" type="text"/>
                                                            <span class="input-group-addon"><i
                                                                    class="fa fa-calendar bigger-110"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>


                                            <div class="col-xs-4 hide">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-status">状态:</label>

                                                    <div class="col-sm-8 ">
                                                        <c:forEach items="${curOperateAuth}" var="curOpertate">
                                                            <c:if test="${'76_1' eq curOpertate}">
                                                                    <input type="text" class="form-control" id="form-field-status"
                                                                           name="status" value="1" style="cursor: pointer;" readonly="readonly"/>
                                                            </c:if>
                                                        </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>



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
                        <c:if test="${'76_1' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right: 125px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增活动安排
                            </button>
                        </c:if>
                    </c:forEach>
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'76_10' eq curOpertate}">
                            <button class="btn btn-sm btn-success" type="button" id="clashBtn"
                                    style="float: right;margin-bottom: 5px;top: 6px;right: 15px;">
                                <span class="ace-icon fa fa-inbox icon-on-right bigger-110"></span>
                                安排冲突
                            </button>
                        </c:if>
                    </c:forEach>
                </div>
                <%--<div class="pull-right">--%>
                <%--<i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>--%>
                <%--</div>--%>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">视察考察调研活动安排浏览</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
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
                    <div class="profile-info-name" style="width: 15%"> 年度</div>
                    <div class="profile-info-value" style="width: 35%">
                        <span class="editable " id="nowTime"></span>
                    </div>
                    <div class="profile-info-name" style="width: 15%"> 活动标题</div>
                    <div class="profile-info-value" style="width: 35%">
                        <span class="editable " id="title"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 来源类别</div>

                    <div class="profile-info-value">
                        <span class="editable " id="actTypeName"></span>
                    </div>

                    <div class="profile-info-name"> 承办单位</div>

                    <div class="profile-info-value">
                        <span class="editable " id="dicDeptName"></span>
                    </div>
                </div>
                <div class="profile-info-row">

                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 活动时间</div>
                    <div class="profile-info-value">
                        <div class="editable " id="dataTime" style="width: 90%;margin-top: 8px;margin-left: -8px"></div>
                    </div>

                    <div class="profile-info-name"> 省份</div>
                    <div class="profile-info-value">
                        <div class="editable " id="place"  style="width: 90%;margin-top: 8px;margin-left: -8px"></div>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 状态</div>

                    <div class="profile-info-value">
                        <span class="editable " id="statusName"></span>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>


<div id="edit-dialog" class="hide"></div>
<div id="feedback-dialog" class="hide"></div>

<div id="correct-edit-dialog" class="hide"></div>
<div id="correct-load-dialog" class="hide"></div>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        //初始化页面
        var curOperateAuth = '${curOperateAuth}';
        if (curOperateAuth.indexOf('76_13') !== -1) {
            G.initDept('deptDiv',true,['{}'],TREE_NODE);
        } else {
            G.initDept('deptDiv',false,['${curDept}'],TREE_NODE);
        }
        var initParam = G.initGridParam($("#searchForm"));

        G.datepicker({autoclose: true, todayHighlight: true});
        $('.yearpicker').datepicker({
            starView:'decade',
            minView:'decade',
            format:'yyyy',
            maxViewMode:2,
            minViewMode:2,
            autoclose:true
        });

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //查询条件全局变量
        var $title= $("#form-field-title");
        var $deptName = $("#form-field-deptName");
        var $place = $("#form-field-place");
        var $nodeTime = $("#form-field-nodeTime");
        var $actType = $("#form-field-actType");
        var $createTime = $("#form-field-createTime");
        var $deptId = $("#form-field-deptId");
        var $status = $("#form-field-status");
        //主页点击过来的ID
        var $placeIndexMainId = $("#placeIndexMainId");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");
        var $clashBtn = $("#clashBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");
        var $viewDialog = $("#view-dialog");

        //弹窗类全局变量，，查看反馈
        var $feedbackDialog = $("#feedback-dialog");
        //调整页面
        var $correctEditDialog = $("#correct-edit-dialog");
        var $correctLoadDialog = $("#correct-load-dialog");

        //存放用户选择的表格列
        var item_selected = [];
        //PLACE查看，
        var loadUrl = '${basePath}/place/load-place-List.do';

        //反馈
        var feedbackUrl = '#page/feedback/handle-feedback';
        //添加，删除，查看反馈
        var editUrl = '#page/place/load-place-edit';
        var deleteUrl = '${basePath}/place/place-delete.do';
        var loadfeedbackUrl = '${basePath}/feedback/load-feedback-place.do';
        var clashBtnUrl ="#page/place/load-clash";
        //调整页面跳转URL
        var toCorrectEditUrl = '${basePath}/correct/correct-edit.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'placeId', index: 'placeId', hidden: true},
            {name: 'dicDeptId', index: 'dicDeptId',hidden: true},
            {name: 'actTypeName', header: '类别', index: 'actTypeName', width: 24,sortable: false},
            {name: 'title', header: '活动标题', index: 'title',width: 70,sortable: true},
            {name: 'dicDeptName', header: '承办单位', index: 'dicDeptName',width: 60,  sortable: false},
            {name: 'place', header: '省份', index: 'place', sortable: false,width: 50,title:false, formatter: placeFormatter},
            {name: 'dataTime', header: '活动时间', index: 'dataTime', sortable: false,width: 62,title:false,formatter: DateTimeFormatter},
            {name: 'createTime', header: '上报时间', index: 'createTime', sortable: true, width: 62},
            {name: 'nowTime', header: '年度', index: 'nowTime',hidden: true, sortable: true},
            {name: 'feedbackId', header: '反馈ID', index: 'feedbackId',hidden: true, sortable: true},
            {
                name: 'statusName',
                header: '状态',
                index: 'statusName',
                align: 'center',
                width: 36,
                sortable:false,
                formatter: statusOperationFormatter
            },
            {name: 'status', header: '状态', index: 'status', hidden: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 210,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {name: 'work', header: '业务操作', sortable: false, width: 252, fixed: true,
                formatter: workOperationFormatter}
        ];
        //地点
        function placeFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            var dateTypes = rowData.dateType;
            var isClashDate = rowData.isClashDate;
            var isClashDateDay = rowData.isClashDateDay;
            var isClashDateYear = rowData.isClashDateYear;
            if(dateTypes!="") {
                if (dateTypes.length === 1) {
                    operations.push('<span style="');
                    if (isClashDate[0] === "0" && isClashDateDay[0] === "0" && isClashDateYear[0] === "0") {
                        operations.push('color:#0f0f0f');
                    } else {
                        operations.push('color:red');
                    }
                    operations.push('">&nbsp;&nbsp;&nbsp;&nbsp;');
                    operations.push(dateTypes[0]);
                    operations.push('</span>');
                } else {
                    operations.push('<table width="115%"  style="margin-left: -5px;margin-top: -14px;margin-bottom: -8px">')
                    for (var i = 0; i < dateTypes.length; i++) {
                        operations.push('<tr width="100%" >');
                        if(i===0){
                            operations.push('<td style="height: 44px;"><span style=" display: block;margin-bottom: -12px;');
                        }else {
                            operations.push('<td style="height: 38px;"><span style="');
                        }
                        if (isClashDate[i] === "0" && isClashDateDay[i] === "0" && isClashDateYear[i] === "0") {
                            operations.push('color:#0f0f0f');
                        } else {
                            operations.push('color:red');
                        }
                        operations.push('">&nbsp;&nbsp;&nbsp;&nbsp;');
                        operations.push(dateTypes[i]);
                        operations.push('</span></td></tr>');
                    }
                    operations.push('</table>');
                }
            }
            cellvalue = operations.join('');
            return cellvalue;
            }
        //时间 dataTimes
        function DateTimeFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            var dataTimes = rowData.dataTimes;
            var isClashDate = rowData.isClashDate;
            var isClashDateDay = rowData.isClashDateDay;
            var isClashDateYear = rowData.isClashDateYear;
            if(dataTimes!=""){
                if(dataTimes.length===1){
                    operations.push('<span style="');
                    if(isClashDate[0]==="0" && isClashDateDay[0] === "0" && isClashDateYear[0] ==="0") {
                        operations.push('color:#0f0f0f');
                    }else {
                        operations.push('color:red');
                    }
                    operations.push('">&nbsp;&nbsp;&nbsp;&nbsp;');
                    operations.push(dataTimes[0]+'&nbsp;&nbsp;&nbsp;&nbsp;');
                    operations.push('</span>');
                }else {
                operations.push('<table width="115%"  style="margin-left: -5px;margin-top: -14px;margin-bottom: -8px;">');
                for (var i=0;i<dataTimes.length;i++) {
                        operations.push('<tr width="100%">');
                        if(i===0){
                            operations.push('<td style="height: 44px;"><span style=" display: block;margin-bottom: -12px;');
                        }else {
                            operations.push('<td style="height: 38px;"><span style="');
                        }


                    if(isClashDate[i]==="0" && isClashDateDay[i] === "0" && isClashDateYear[i] ==="0") {
                        operations.push('color:#0f0f0f');
                    }else {
                        operations.push('color:red');
                    }
                    operations.push('">&nbsp;&nbsp;&nbsp;&nbsp;');
                    operations.push(dataTimes[i]+'&nbsp;&nbsp;&nbsp;&nbsp;');
                    operations.push('</span></td></tr>');
                }
                operations.push('</table>');
                }
            }
            cellvalue = operations.join('');
            return cellvalue;
        }
        
        //状态显示
        function statusOperationFormatter(cellvalue, options, rowData, action) {

            var status = rowData.status;

            var operations = [];

            if (status == '0') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-warning">未上报</span>');
            } else if (status == '1') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-success">已上报</span>');
            } else if(status == '2'){
                operations.push('<span class="label label-sm  arrowed arrowed-right label-info">已确认</span>');
            }else if (status == '3') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-warning">未收到调整</span>');
            }else if (status == '4') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-success">已发起调整</span>');
            }else if (status == '5') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-success">已调整</span>');
            }else if (status == '6') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-info">已调整已确认</span>');
            }else if (status == '8') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-info">已反馈</span>');
            }
            operations.push('</div>');
            cellvalue = operations.join('');
            return cellvalue;
        }
        //查看编辑  操作按钮
        function basicOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];

            var status = rowData.status;
            operations.push("<div style='margin-left:6px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'76_2' eq curOpertate}">
                operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
                operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view"></i> 查看');
                operations.push('</button>');
            </c:if>
            <c:if test="${'76_3' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit"></i> 编辑');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'76_4' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="删除" class="btn btn-minier btn-white btn-danger row-record-delete">');
                operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除');
                operations.push('</button>');
            }
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }
        //业务操作  上报查收反馈等
        function workOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            var status = rowData.status;
            var isClashYes = rowData.isClashYes;
            var dicDeptId = rowData.dicDeptId;
            var dept = '${dicDept}';

            operations.push("<div style='margin-left:6px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'76_5' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="上报" class="btn btn-minier btn-white btn-info reportPlace ');
                if(isClashYes) {
                    operations.push(' reportPlaceIsClashYes');
                }else {
                    operations.push(' reportPlaceIsClashNo');
                }
                operations.push(' ">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-up reportPlace "></i> 上报');
                operations.push('</button>');

            }
            </c:if>
            <c:if test="${'76_6' eq curOpertate}">
            if (status === '1' || status === '5') {
                operations.push(' <button title="确认" class="btn btn-minier btn-white btn-warning checkPlace">');
                operations.push('<i class="ace-icon glyphicon glyphicon-ok "></i> 确认');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'76_7' eq curOpertate}">
            if (status === '1' || status === '4'|| status === '5' || status === '2') {
                operations.push(' <button title="发起调整" class="btn btn-minier btn-white btn-primary correctOpenPlace">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-right "></i> 发起调整');
                operations.push('</button>');
            }
            </c:if>
           <c:if test="${'76_9' eq curOpertate}">
            if (status === '4'||status === '5') {
                operations.push(' <button title="查看调整" class="btn btn-minier btn-white btn-primary loadCorrectPlace">');
                operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out "></i> 查看调整');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'76_8' eq curOpertate}">
            if (status === '4' || status === '1' || status === '2') {
                operations.push(' <button title="调整" class="btn btn-minier btn-white btn-primary correctUpPlace">');
                operations.push('<i class="ace-icon glyphicon glyphicon-retweet "></i>调整');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'76_11' eq curOpertate}">
            if (status === '2' && dicDeptId === dept){
                operations.push(' <button title="反馈" class="btn btn-minier btn-white btn-primary feedbackPlace">');
                operations.push('<i class="ace-icon glyphicon glyphicon-check "></i> 反馈');
                operations.push('</button>');
            }
            </c:if> <c:if test="${'76_12' eq curOpertate}">
            if (status === '8') {
                operations.push(' <button title="查看反馈" class="btn btn-minier btn-white btn-primary loadFeedBackPlace">');
                operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out "></i> 查看反馈');
                operations.push('</button>');
            }
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }
        //表格数据展示

        $gridTable.tjGrid({
            initParam : initParam,
            loadUrl: loadUrl,
            height: '100%',
            width:'100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'beginTime',
            sortorder: 'desc',
            // caption: "视察考察调研活动安排浏览",
            onSelectRow: function (id, stat, e) {
                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $gridTable.jqGrid('getRowData', id);
                //查看
                if (className.indexOf('row-record-view') !== -1) {
                    viewPlace(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条视察考察调研活动信息吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        G.showGritterSuccess("删除成功");
                                        $gridTable.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-edit') !== -1) {
                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
                    G.pjaxLoadPageContentDiv(editUrl + "?id=" + id);
                }
                //上报
                if (className.indexOf('reportPlace') !== -1) {
                    if (className.indexOf('reportPlaceIsClashYes') !== -1) {
                        handlePlace(id, '1',true);
                    }else if(className.indexOf('reportPlaceIsClashNo') !== -1){
                        handlePlace(id, '1',false);
                    }
                }
                //查收
                if (className.indexOf('checkPlace') !== -1) {
                    handlePlace(id, '2');
                }
                //反馈
                if (className.indexOf('feedbackPlace') !== -1) {
                    G.pjaxLoadPageContentDiv(feedbackUrl + "?id=" + id);
                }

                //发起调整
                if (className.indexOf('correctOpenPlace') !== -1) {
                    correctOpenPlace(id);
                }
                //调整，修改
                if (className.indexOf('correctUpPlace') !== -1) {
                    G.pjaxLoadPageContentDiv(editUrl + "?id=" + id +"&type=correct");
                }
                //查看调整
                if (className.indexOf('loadCorrectPlace') !== -1) {
                    loadCorrectPlace(id);
                }
                //已调整待确认
                if (className.indexOf('correctYesPlace') !== -1) {
                    correctPlace(id);
                }


                //查看反馈
                if (className.indexOf('loadFeedBackPlace') !== -1) {
                    loadFeedBackPlace(id);
                }

                //以调整请查收
                if (className.indexOf('checkCorPlace') !== -1) {
                    handlePlace(id, '6');
                }


            },
            gridComplete: function () {
                var _this = this;
                if (item_selected.length > 0) {
                    for (var i = 0; i < item_selected.length; i++) {
                        $(_this).tjGrid('setSelection', item_selected[i]);
                    }
                }
                //调整表格宽度
                var parent_column = $gridTable.closest('[class*="col-"]');
                $gridTable.tjGrid("triggerResizeGrid");
                $gridTable.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});

                if (initParam === undefined) {
                    $gridTable.setSelection(0, false);
                } else {
                    $gridTable.setSelection(initParam.rowIndex, false);
                }
            },
            onSelectAll: function (aRowIds, status) {
                if (status) {
                    item_selected = _.union(item_selected, aRowIds);
                } else {
                    item_selected = _.difference(item_selected, aRowIds);
                }
            },
            beforeSelectRow: function (rowId) {
                var index = _.indexOf(item_selected, rowId);
                if (index == -1) {
                    item_selected.push(rowId);

                } else {
                    item_selected = _.pull(item_selected, rowId);
                }
            }
        });
        $gridTable.tjGrid("triggerResizeGrid");
        //发起调整
        function correctOpenPlace(id) {
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: toCorrectEditUrl,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $correctEditDialog.html(String);
                    G.doneAjaxLoading(loadId);
                    //初始化弹出框
                    initCorrectEditDialog($correctEditDialog);
                },
                error: function () {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }
        //调整页面
        function initCorrectEditDialog($container) {
            var $form = $("#saveForm");
            $container.removeClass('hide').dialog({
                resizable: false, height: 'auto',
                width: 800, modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>活动安排信息-调整</h4></div>",
                title_html: true,
                close: function () {
                    $container.empty();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            if ($form.validate().form()) {
                                $form.ajaxSubmit({
                                    success: function (map) {
                                        if (map.result) {
                                            G.showGritterSuccess("调整信息 保存成功!");
                                            $container.dialog("close");
                                            //更新表格数据
                                            G.search($searchForm, $gridTable);
                                        } else {
                                            G.showGritterFail("保存失败,请稍后重试!");
                                        }
                                    }
                                });
                            }
                        }
                    }
                ]
            });
        }

        //查看调整
        function loadCorrectPlace(id) {
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: "${basePath}/correct/correct-load.do",
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $correctLoadDialog.html(String);
                    G.doneAjaxLoading(loadId);
                        //初始化弹出框
                    initCorrectLoadDialog($correctLoadDialog);
                    },
                    error: function () {
                        G.doneAjaxLoading(loadId);
                        G.alert({message: "操作失败！"});
                    }
                });
            }
        //初始化 查看调整
        function initCorrectLoadDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false, height: 'auto',
                width: 800, modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看-调整信息</h4></div>",
                title_html: true,
                close: function () {
                    $container.empty();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 确认",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    }
                ]
            });
        }


        //查看按钮
        function viewPlace(rowData) {
            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });
            initViewDialog($viewDialog);
        }
        //初始化查看视察考察调研活动安排
        function initViewDialog($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看视察考察调研活动安排</h4></div>",
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

        //添加
        $addBtn.click(function () {
            G.pjaxLoadPageContentDiv(editUrl);
        });
        //冲突安排
        $clashBtn.click(function () {
            G.pjaxLoadPageContentDiv(clashBtnUrl);
        });


        //查看反馈
        function loadFeedBackPlace(id){
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: loadfeedbackUrl,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $feedbackDialog.html(String);
                    G.doneAjaxLoading(loadId);
                    initFeedbackDialog($feedbackDialog);
                },
                error: function () {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }
        //反馈页面初始化
        function initFeedbackDialog($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 510,
                width: 900,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>当前活动安排反馈信息</h4></div>",
                title_html: true,
                close: function () {
                    $container.empty();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 确认",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    }
                ]
            });
        }


        //调整 页面跳转
        function correctPlace(id){
            G.pjaxLoadPageContentDiv("page/feedback/place-feedback-correct?id="+id);
        }

        //上报查收 调整查收  活动安排
        function handlePlace(id, type,types) {
            var operName1 = "",messages="";
            var reportUrl = '${basePath}/place/handle-place.do';
            if (type === '1') {
                operName1 = '上报';
            } else if (type === '2') {
                operName1 = '查收';
            }else if(type ==="6"){
                operName1 = '以调整请查收';
            }
            if (types) {
                messages = "此活动安排存在冲突！确认" + operName1 + "此活动安排信息吗？";
            }else{
                messages = "确认" + operName1 + "此活动安排信息吗？";
            }

            G.confirm({
                message:messages,
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: reportUrl,
                            data: {id: id, type: type},
                            async: true
                        }).done(function (map) {
                            G.doneAjaxLoading(loadId);
                            if (map.result) {
                                if(map.isResult !== "0"){
                                    G.confirm({
                                        message: '此活动安排信息存在冲突，确认'+operName1+'？',
                                        callback: function (result) {
                                            if (result) {
                                                G.showGritterSuccess("活动安排信息" + operName1 + "成功!");
                                                G.pjaxLoadPageContentDiv("#page/place/place-list");
                                            } else {
                                                var loadId = G.showAjaxLoading();
                                                $.ajax({
                                                    type: 'post',
                                                    dataType: 'json',
                                                    url: '${basePath}/place/place-cancel.do',
                                                    data: {id: id,status:"yes"},
                                                    async: true
                                                }).done(function (map) {
                                                    G.doneAjaxLoading(loadId);
                                                    if (map.result) {
                                                        G.search($searchForm, $gridTable);

                                                    }
                                                });
                                            }
                                        }
                                    });
                                }else {
                                    G.showGritterSuccess(operName1 + '成功');
                                    G.pjaxLoadPageContentDiv("#page/place/place-list");
                                }
                            } else {
                                G.showGritterFail("活动安排信息" + operName1 + "失败,请稍后重试!");
                            }
                            //更新表格数据
                            console.log('')
                        });
                    }
                }
            });
        }

        $searchBtn.click(function () {
            search();
        });

        function search() {
            var deptName = $deptName.val();
            var title = $title.val();
            var place = $place.val();
            var nodeTime = $nodeTime.val();
            var actType = $actType.val();
            var createTime = $createTime.val();
            var placeIndexMainId = $placeIndexMainId.val();
            var deptId = $deptId.val();
            var status = $status.val();

            $gridTable.tjGrid('setPostData', {
                deptName:deptName,
                title: title,
                place: place,
                nodeTime: nodeTime,
                actType: actType,
                createTime:createTime,
                placeIndexMainId:placeIndexMainId,
                deptId:deptId,
                status:status
            });
            reloadGrid();
        }

        function reloadGrid() {
            item_selected = [];
            $gridTable.tjGrid('reloadGrid');
        }

        $resetBtn.click(function () {
            $searchForm.resetForm();
            item_selected = [];
            search();
        });
        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>





