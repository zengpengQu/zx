<%--
  Created by IntelliJ IDEA.
  User: BT4900
  Date: 2018/8/17
  Time: 15:40
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

<%--word导出--%>
<script src="${basePath}/plugin/wordExport/js/FileSaver.js"></script>
<script src="${basePath}/plugin/wordExport/js/jquery.wordexport.js"></script>

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
                                        <input type="text" id="form-field-planId" name="planId"
                                               class="hide" value="${planId}"/>
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-deptId">单位名称:</label>
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
                                                           for="form-field-status">状态:</label>

                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-status"
                                                                name="status">
                                                            <c:choose>
                                                                <c:when test="${fn:contains(curOperateAuth,'53_14')}">
                                                                    <option value="1,2">-----请选择-----</option>
                                                                    <option value="1">已反馈</option>
                                                                    <option value="2">已查收</option>
                                                                </c:when>
                                                                <c:otherwise>
                                                                    <option value="">-----请选择-----</option>
                                                                    <option value="0">未反馈</option>
                                                                    <option value="1">已反馈</option>
                                                                    <option value="2">已查收</option>
                                                                </c:otherwise>
                                                            </c:choose>
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
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <button class="btn btn-sm btn-info" id="backBtn" style="top: 6px;right: 15px;">
                        <i class="ace-icon fa fa-undo bigger-110"></i>
                        返回
                    </button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">领导活动安排反馈</div>
                <div class="table-content  col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div id="preview-dialog" class="hide"></div>
<div id="report-dialog" class="hide"></div>
<div id="export-dialog" class="hide" style="background-color: darkseagreen"></div>
<div id="printReceipt" class="hide"></div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        //初始化页面
        var curOperateAuth = '${curOperateAuth}';

        if (curOperateAuth.indexOf('53_14') !== -1) {

            G.initDept('deptDiv',true,['{}'],TREE_NODE);
        } else {
            G.initDept('deptDiv',false,['${curDept}'],TREE_NODE);
        }

        var initParam = G.initGridParam($("#searchForm"));

        G.datepicker();

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //元素类全局变量
        var $deptId = $("#form-field-feedbackDeptId");
        var $status = $("#status");
        var $planId = $("#form-field-planId");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $backBtn = $("#backBtn");
        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        //弹窗类全局变量
        var $previewDialog = $("#preview-dialog");
        var $exportDialog = $("#export-dialog");

        //url
        var loadUrl = '${basePath}/plan-receipt/load-receipt-list.do';
        var editUrl = '#page/plan-receipt/plan-receipt-edit';
        var deleteUrl = '${basePath}/plan-receipt/receipt-delete.do';

        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'planId', index: 'planId', hidden: true},
            {name: 'deptName', header: '反馈部门', index: 'deptName', sortable: true},
            {name: 'creatorName', header: '反馈人', index: 'creatorName', sortable: true},
            {name: 'phone', header: '联系方式', index: 'phone', sortable: true},
            {name: 'leaderName', header: '领导姓名', index: 'leaderName', sortable: false},
            {name: 'feedbackTimeStr', header: '报送日期', index: 'feedbackTimeStr', sortable: false},
            {name: 'status', header: '状态', index: 'status', sortable: false, hidden: true},
            {
                name: 'statusName',
                header: '状态',
                index: 'statusName',
                align: 'center',
                sortable: false,
                formatter: statusOperationFormatter
            },
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {name: 'work', header: '业务操作', sortable: false, width: 150, fixed: true, formatter: workOperationFormatter}
        ];

        $gridTable.tjGrid({
            initParam : initParam,
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'status',
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
                    viewPlanReceipt(rowData);

                } else if (className.indexOf('row-record-edit') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
                    //编辑
                    var planId = rowData.planId;
                    G.pjaxLoadPageContentDiv(editUrl + "?id=" + planId + '&date=' + new Date().getTime());

                } else if (className.indexOf('row-record-delete') !== -1) {
                    //删除
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
                } else if (className.indexOf('checkPlan') !== -1) {
                    //查收
                    checkPlanReceipt(rowData);

                } else if (className.indexOf('row-record-feedback') !== -1) {

                    //反馈
                    reportPlanReceipt(rowData);
                } else if (className.indexOf('backFeedback') !== -1) {

                    //撤回
                    backPlanReceipt(rowData);
                } else if (className.indexOf('exportBtn') !== -1) {

                    //导出
                    exportPlanReceipt(rowData);
                } else {
                    //do nothing
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        // 查看领导活动安排反馈
        function viewPlanReceipt(rowData) {

            var id = rowData.id;
            var viewUrl = '${basePath}/plan-receipt/view-plan-receipt.do';
            $.ajax({
                url: viewUrl,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $previewDialog.html(String);
                    //初始化弹出框
                    initPreviewDialog($previewDialog);
                },
                error: function (e) {
                    G.alert({message: "操作失败！"});
                }
            });
        }

        //初始化领导活动安排反馈弹出框
        function initPreviewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 700,
                width: 1200,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>领导活动安排反馈</h4></div>",
                title_html: true,
                close: function () {
                    $container.addClass("hide");
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 关闭",
                        "class": "btn btn-success",
                        click: function () {
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }

        //查收领导活动安排反馈
        function checkPlanReceipt(rowData) {

            var id = rowData.id;
            var deptName = rowData.deptName;
            var checkUrl = '${basePath}/plan-receipt/check-plan-receipt.do';
            G.confirm({
                message: '确认查收' + deptName + '反馈的信息吗？',
                callback: function (result) {
                    if (result) {
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: checkUrl,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            if (map.result) {
                                G.showGritterSuccess("查收成功!");
                            } else {
                                G.showGritterFail("查收失败,请稍后重试!");
                            }
                            //更新表格数据
                            G.search($searchForm,$gridTable);
                        });
                    }
                }
            });
        }

        //上报领导活动安排反馈
        function reportPlanReceipt(rowData) {

            var id = rowData.id;
            var reportUrl = '${basePath}/plan-receipt/report-receipt.do';
            G.confirm({
                message: '确认上报反馈信息吗？',
                callback: function (result) {
                    if (result) {
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: reportUrl,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            if (map.result) {
                                G.showGritterSuccess("上报成功!");
                            } else {
                                G.showGritterFail("上报失败,请稍后重试!");
                            }
                            //更新表格数据
                            G.search($searchForm,$gridTable);
                        });
                    }
                }
            });
        }

        //撤回领导活动反馈
        function backPlanReceipt(rowData) {

            var id = rowData.id;
            var backUrl = '${basePath}/plan-receipt/back-receipt.do';
            G.confirm({
                message: '确认撤回会议回执反馈信息吗？',
                callback: function (result) {
                    if (result) {
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: backUrl,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            if (map.result) {
                                G.showGritterSuccess("撤回成功!");
                            } else {
                                G.showGritterFail("撤回失败,请稍后重试!");
                            }
                            //更新表格数据
                            G.search($searchForm,$gridTable);
                        });
                    }
                }
            });
        }
        //根据所选行导出领导活动安排
        function exportPlanReceipt(rowData) {

            var id = rowData.id;
            var url = '${basePath}/plan-receipt/plan-receipt-preview.do';

            G.confirm({
                message: '确认导出已查收的会议回执信息吗？',
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            url: url,
                            type: "GET",
                            data: {id : id},
                            dataType: "html",
                            success: function (String) {
                                $exportDialog.html(String);
                                G.doneAjaxLoading(loadId);
                                //初始化弹出框
                                initExportDialog($exportDialog);
                            },
                            error: function (e) {
                                G.doneAjaxLoading(loadId);
                                G.alert({message: "操作失败！"});
                            }
                        });


                    }
                }
            });
        }

        //初始化领导活动安排弹出框
        function initExportDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 700,
                width: 1200,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>会议回执导出预览</h4></div>",
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
                            $container.wordExport("领导活动安排${sysDate}");
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }


        $searchBtn.click(function () {
            G.search($searchForm,$gridTable);
        });

        $resetBtn.click(function () {
            $searchForm.resetForm();
            G.search($searchForm,$gridTable);
        });

        $backBtn.on('click', function () {
            G.back();

        });

        function attendOperationFormatter(cellvalue, options, rowData) {

            var isAttend = rowData.isAttend;

            var operations = [];

            if (isAttend === '0') {
                operations.push('<span class="label label-sm label-primary arrowed arrowed-right">出席</span>');
            } else if (isAttend === '1') {
                operations.push('<span class="label label-sm label-warning arrowed arrowed-right">缺席</span>');
            } else {
                //do nothing
            }
            operations.push('</div>');
            cellvalue = operations.join('');
            return cellvalue;
        }

        function statusOperationFormatter(cellvalue, options, rowData) {

            var status = rowData.status;

            var operations = [];

            if (status === '0') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-warning">未反馈</span>');
            } else if (status === '1') {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-success">已反馈</span>');
            } else {
                operations.push('<span class="label label-sm  arrowed arrowed-right label-info">已查收</span>');
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
            <c:if test="${'53_10' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'53_11' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'53_8' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="删除" class="btn btn-minier btn-white btn-danger row-record-delete">');
                operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
                operations.push('</button>');
            }
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function workOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            var status = rowData.status;

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'53_9' eq curOpertate}">
            if (status === '1') {
                operations.push(' <button title="查收" class="btn btn-minier btn-white btn-primary checkPlan">');
                operations.push('<i class="ace-icon glyphicon glyphicon-check checkPlan"></i> 查收');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'53_7' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="反馈" class="btn btn-minier btn-white btn-warning row-record-feedback">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-up row-record-feedback"></i> 反馈');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'53_12' eq curOpertate}">
            if (status === '1') {
                operations.push(' <button title="撤回" class="btn btn-minier btn-white btn-warning backFeedback">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-down backFeedback"></i> 撤回');
                operations.push('</button>');
            }
            </c:if>

            <c:if test="${'53_13' eq curOpertate}">
            if (status === '2') {
                operations.push(' <button title="导出" class="btn btn-minier btn-white btn-success exportBtn">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-down exportBtn"></i> 导出');
                operations.push('</button>');
            }
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $(document).one('ajaxloadstart.page', function (e) {

            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });


    });
</script>
