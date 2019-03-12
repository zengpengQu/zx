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
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label" for="form-field-groupNumber">团组活动编号:</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-groupNumber" name="groupNumber" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label" for="form-field-groupName">团组活动名称:</label>
                                                    <div class="col-sm-8">
                                                        <input class="form-control" id="form-field-groupName" name="groupName" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label" for="form-field-orgId">主办单位:</label>

                                                    <div class="col-sm-8 deptDiv">
                                                        <input type="text" id="form-field-orgId" name="orgId"
                                                               class="hide" value=""/>
                                                        <input type="text" id="form-field-deptName" class="form-control"
                                                               name="deptName" value="" style="cursor: pointer;" readonly="readonly"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label" for="form-field-batchNumber">任务批件号:</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-batchNumber" name="batchNumber" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label">出访时间: </label>
                                                    <div class="col-sm-8">
                                                        <div class="input-daterange input-group" data-date-format="yyyy-mm-dd">
                                                            <input id="form-field-startTime" type="text" class="form-control"
                                                                   name="startTime" placeholder="开始日期"/>
                                                            <span class="input-group-addon"><i class="fa fa-exchange"></i></span>
                                                            <input id="form-field-endTime" type="text" class="form-control"
                                                                   name="endTime" placeholder="结束日期"/>
                                                        </div>
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
            </div>
        </div>

        <div class="row">
            <div class="space-10"></div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'58_1' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top:6px;right:15px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
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
                <div class="header-table-th">出访活动列表</div>
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
                    <div class="profile-info-name" style="width: 15%"> 团长</div>
                    <div class="profile-info-value" style="width: 35%">
                        <span class="editable " id="leaderName"></span>
                    </div>
                    <div class="profile-info-name" style="width: 15%"> 团组活动类别</div>
                    <div class="profile-info-value" style="width: 35%">
                        <span class="editable " id="abroadTypeName"></span>
                    </div>
                </div>

                <div class="profile-info-row">

                    <div class="profile-info-name" style="width: 15%;"> 团组活动级别</div>
                    <div class="profile-info-value" style="width: 35%">
                        <span class="editable " id="groupLevelName"></span>
                    </div>
                    <div class="profile-info-name"> 是否计划内</div>
                    <div class="profile-info-value">
                        <span class="editable " id="planFlagName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 团组活动编号</div>
                    <div class="profile-info-value">
                        <span class="editable " id="groupNumber"></span>
                    </div>
                    <div class="profile-info-name"> 团组活动名称</div>
                    <div class="profile-info-value">
                        <span class="editable " id="groupName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 开始日期</div>
                    <div class="profile-info-value">
                        <span class="editable " id="startDateStr"></span>
                    </div>
                    <div class="profile-info-name"> 结束日期</div>
                    <div class="profile-info-value">
                        <span class="editable " id="endDateStr"></span>
                    </div>
                </div>


                <div class="profile-info-row">
                    <div class="profile-info-name"> 主办单位</div>
                    <div class="profile-info-value">
                        <span class="editable " id="orgName"></span>
                    </div>
                    <div class="profile-info-name"> 任务批件号</div>
                    <div class="profile-info-value">
                        <span class="editable " id="batchNumber"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 出访任务</div>
                    <div class="profile-info-value">
                        <span class="editable " id="abroadTaskName"></span>
                    </div>
                    <div class="profile-info-name"> 团组总人数</div>
                    <div class="profile-info-value">
                        <span class="editable " id="totalNum"></span>
                    </div>
                </div>

            </div>
            <div class="profile-user-info profile-user-info-striped" style="border-top: none">

                <div class="profile-info-row">
                    <div class="profile-info-name" style="width: 15% !important"> 任务描述</div>
                    <div class="profile-info-value" >
                        <span class="editable " id="taskDesc"  style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                    </div>
                </div>
            </div>

            <div class="profile-user-info profile-user-info-striped" style="border-top: none">

                <div class="profile-info-row">
                    <div class="profile-info-name" style="width: 15%;"> 费用来源</div>
                    <div class="profile-info-value" style="width: 35%;">
                        <span class="editable " id="costSourceName"></span>
                    </div>
                    <div class="profile-info-name" style="width: 15%"> 在外停留天数</div>
                    <div class="profile-info-value" style="width: 35%">
                        <span class="editable " id="abroadDays"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 费用说明</div>
                    <div class="profile-info-value">
                        <span class="editable " id="costInstruct"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 备注信息</div>
                    <div class="profile-info-value">
                        <span class="editable " id="remark"></span>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        var initParam = G.initGridParam($("#searchForm"));

        $('.input-daterange').datepicker({autoclose: true, todayHighlight: true});
        G.datepicker();

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        G.initDept('deptDiv',true,null,TREE_NODE);

        //元素类全局变量
        var $groupNumber = $("#form-field-groupNumber");
        var $groupName = $("#form-field-groupName");
        var $orgId = $("#form-field-orgId");
        var $deptName = $("#form-field-deptName");
        var $batchNumber = $("#form-field-batchNumber");

        var $startTime = $('#form-field-startTime');
        var $endTime = $('#form-field-endTime');
        $startTime.datepicker({
            autoclose: true,
            format: 'yyyy-mm-dd',
            todayHighlight: true,
            todayBtn: 'linked'
        }).on('change', function () {
            var endDate = $endTime.val();

            if (endDate != '') {
                var startDate = $startTime.val();
                if (compareDate(startDate, endDate)) {
                    $endTime.val(startDate)
                }
            }
        });
        $endTime.datepicker({
            autoclose: true,
            format: 'yyyy-mm-dd',
            todayHighlight: true,
            todayBtn: 'linked'
        }).on('change', function () {
            var startDate = $startTime.val();
            if (startDate != '') {
                var endDate = $endTime.val();
                if (compareDate(startDate, endDate)) {
                    $startTime.val(endDate)
                }
            }
        });
        function compareDate(date1, date2) {
            return (new Date(date1.replace(/-/g, "//"))) >= (new Date(date2.replace(/-/g, "//")));
        }

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");
        var $viewDialog = $("#view-dialog");

        var loadUrl = '${basePath}/abroad-info/load-abroad-list.do';
        var editUrl = '#page/abroad-info/load-abroad-edit';
        var deleteUrl = '${basePath}/abroad-info/abroad-info-delete.do';
        var configUrl = '#page/abroad-info/load-abroad-config';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'leaderName', header: '团长', hidden: true},
            {name: 'abroadType', header: '团组活动类别', index: 'abroadType', hidden: true},
            {name: 'abroadTypeName', header: '团组活动类别', index: 'abroadTypeName', hidden: true},
            {name: 'groupLevelName', header: '团组活动级别', index: 'groupLevelName', hidden: true},
            {name: 'planFlagName', header: '是否计划内', index: 'planFlagName', hidden: true},
            {name: 'groupNumber', header: '团组活动编号', index: 'groupNumber', sortable: true},
            {name: 'groupName', header: '团组活动名称', index: 'groupName', sortable: true},
            {name: 'startDateStr', header: '开始日期', index: 'startDateStr', sortable: true},
            {name: 'endDateStr', header: '结束日期', index: 'endDateStr', sortable: true},
            {name: 'orgName', header: '主办单位', index: 'orgName', sortable: true},
            {name: 'batchNumber', header: '任务批件号', index: 'batchNumber', sortable: true},
            {name: 'groupLeaderName', header: '团长', index: 'groupLeader', hidden: true},
            {name: 'totalNum', header: '团组总人数', index: 'totalNum', hidden: true},
            {name: 'abroadTaskName', header: '出访任务', index: 'abroadTaskName', hidden: true},
            {name: 'taskDesc', header: '任务描述', index: 'taskDesc', hidden: true},
            {name: 'costSourceName', header: '费用来源', index: 'costSourceName', hidden: true},
            {name: 'abroadDays', header: '在外停留天数', index: 'abroadDays', hidden: true},
            {name: 'costInstruct', header: '费用说明', index: 'costInstruct', hidden: true},
            {name: 'remark', header: '备注信息', index: 'remark', hidden: true},
            {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatter},
            {name: 'work', header: '业务操作', sortable: false, width: 140, fixed: true, formatter: workOperationFormatter}
        ];

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            operations.push("<div style='margin-left:5px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'58_2' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'58_3' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'58_4' eq curOpertate}">
            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function workOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            var abroadType = rowData.abroadType;
            operations.push("<div style='margin-left:5px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'58_5' eq curOpertate}">
            if (abroadType === '0') {
                operations.push(' <button title="详情" class="btn btn-minier btn-white btn-info btn-sm btn-purple row-record-config">');
                operations.push('<i class="ace-icon glyphicon glyphicon-import icon-on-right bigger-110 row-record-config"></i> 详情');
                operations.push('</button>');
            }
            </c:if>

            <c:if test="${'58_6' eq curOpertate}">
            if (abroadType === '0') {
                operations.push(' <button title="导出" class="btn btn-minier btn-white btn-primary export">');
                operations.push('<i class="ace-icon fa fa-cloud-download"></i> 导出');
                operations.push('</button>');
            }
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            initParam : initParam,
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'updateTime',
            sortorder: 'desc',
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }

                if (className.indexOf('row-record-view') !== -1) {
                    var rowData = $gridTable.jqGrid('getRowData', id);
                    viewAbroadInfo(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条出访信息吗？',
                        callback: function (result) {
                            if (result) {
                                var loadId = G.showAjaxLoading();
                                $.post(deleteUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        G.doneAjaxLoading(loadId);
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
                } else if (className.indexOf('row-record-config') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }

                    G.pjaxLoadPageContentDiv(configUrl + "?id=" + id);
                } else if (className.indexOf('export') !== -1) {
                    var exportUrl = '${basePath}/abroad-info/export-abroad.do?abroadInfoId=' + id;

                    var $downloadForm = $("<form method='post'></form>");
                    $downloadForm.attr("action", exportUrl);
                    $(document.body).append($downloadForm);
                    $downloadForm.submit();
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        $searchBtn.click(function () {
            search();
        });

        function search() {
            var groupNumber = $groupNumber.val();
            var groupName = $groupName.val();
            var orgId = $orgId.val();
            var batchNumber = $batchNumber.val();
            var startTime = $startTime.val();
            var endTime = $endTime.val();
            $gridTable.tjGrid('setPostData', {
                groupNumber: groupNumber,
                groupName: groupName,
                orgId: orgId,
                batchNumber: batchNumber,
                startTime: startTime,
                endTime: endTime,
            });
            reloadGrid();
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();

        });

        $addBtn.click(function () {
            G.pjaxLoadPageContentDiv(editUrl);
        });

        function viewAbroadInfo(rowData) {
            $viewDialog.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });
            initViewDialog($viewDialog);
        }

        function initViewDialog($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看出访信息</h4></div>",
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

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy("#grid-table");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>
