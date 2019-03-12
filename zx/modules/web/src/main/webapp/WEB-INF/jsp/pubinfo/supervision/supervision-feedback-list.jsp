<%--
  Created by IntelliJ IDEA.
  User: BT4900
  Date: 2018/7/31
  Time: 15:21
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
<%--word导出--%>
<script src="${basePath}/plugin/wordExport/js/FileSaver.js"></script>
<script src="${basePath}/plugin/wordExport/js/jquery.wordexport.js"></script>
<style>
    gritter-index {
        z-index: 10055 !important;
    }
</style>

<div class="row">
    <div class="col-xs-12">

        <form class="form-horizontal" role="form" id="searchForm" autocomplete="off">
            <input type="hidden" id="matterId" name="matterId" value="${matterId}">
            <input type="hidden" id="feedBackId" name="feedBackId" value="${feedBackId}">
            <input type="hidden" id="curDeptId" name="curDeptId" value="${curDeptId}">

        </form>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <button class="btn btn-sm btn-info" id="backBtn" style="top: 6px;right: 15px">
                        <i class="ace-icon fa fa-undo bigger-110"></i>
                        返回
                    </button>
                    <%--<c:forEach items="${curOperateAuth}" var="curOpertate">--%>
                        <%--<c:if test="${'74_5' eq curOpertate}">--%>
                            <%--<button class="btn btn-sm btn-success" id="exportBtn"--%>
                                    <%--style="top: 6px;right: 100px;">--%>
                                <%--<i class="ace-icon glyphicon glyphicon-export icon-on-right bigger-110"></i>--%>
                                <%--导出--%>
                            <%--</button>--%>
                        <%--</c:if>--%>
                    <%--</c:forEach>--%>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">督查事项反馈</div>
                <div class="table-content  col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div id="preview-dialog"  class="hide" style="background-color: darkseagreen"></div>
<div id="preview-dialog-lock"  class="hide"></div>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        //初始化页面
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
        var $matterId = $("#matterId");
        var $feedBackId = $("#feedBackId");

        //控件类全局变量
        var $exportBtn = $("#exportBtn");
        var $backBtn = $("#backBtn");

        //表单类全局变量
        var $gridTable = $("#grid-table");

        //弹窗类全局变量
        var $previewDialog = $("#preview-dialog");
        var $previewDialogLock = $("#preview-dialog-lock");

        //url
        var loadUrl = '${basePath}/supervision-feedback/work-feedback-list.do';
        var editUrl = '#page/supervision-feedback/feedBack';
        var deleteUrl = '${basePath}/supervision-feedback/work-feedback-delete.do';
        var feedbackEditUrl = '#page/supervision-feedback/load-work-feedback';
        var reportUrl = '${basePath}/supervision-feedback/report-feedback.do';
        var backUrl = '${basePath}/supervision-feedback/back-feedback.do';
        var excelUrl = '${basePath}/supervision-feedback/export-excel.do';
        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'matterId', index: 'matterId', hidden: true},
            {name: 'unitId', index: 'unitId', hidden: true},
            {name: 'deptName', header: '承办单位', index: 'deptName', sortable: true},
            {name: 'serialNumber', header: '督查事项编号', index: 'serialNumber', sortable: true},
            {name: 'createName', header: '审批人', index: 'createName', sortable: false},
            {name: 'feedBackDateStr', header: '反馈日期', index: 'feedBackDateStr', sortable: false},
            {name: 'isTransfer', header: '是否办结', index: 'isTransfer', sortable: false},
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
            {name: 'work', header: '业务操作', sortable: false, width: 200, fixed: true, formatter: workOperationFormatter}
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
                    viewWorkFeedback(rowData);

                } else if (className.indexOf('row-record-edit') !== -1) {
                    //编辑
                    var workId = rowData.matterId;
                    var unitId = rowData.unitId;
                    G.pjaxLoadPageContentDiv(editUrl + "?id=" + workId + '&unitId='+ unitId + '&date=' + new Date().getTime());

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
                } else if (className.indexOf('checkDuty') !== -1) {
                    //查收
                    checkWorkFeedback(rowData);

                } else if (className.indexOf('row-record-feedback') !== -1) {

                    //上报
                    reportWorkFeedback(rowData);
                } else if (className.indexOf('backFeedback') !== -1) {

                    //撤回
                    backWorkFeedback(rowData);
                } else if (className.indexOf('feedbackWord') !== -1) {
                    exportFeedback(rowData);
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        /*--------导出start--------*/
        function exportFeedback(rowData) {
            G.confirm({
                message: '确认导出督查事项反馈信息吗?',
                callback: function (result) {
                    if (result) {
                        var matterId = rowData.matterId;
                        var feedBackId = rowData.id;
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            url: excelUrl,
                            type: "GET",
                            data: {matterId: matterId, "feedBackId": feedBackId},
                            dataType: "html",
                            success: function (String) {
                                $previewDialog.html(String);
                                G.doneAjaxLoading(loadId);
                                //初始化弹出框
                                initPreviewDialogWord($previewDialog);
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


        //初始化弹框
        function initPreviewDialogWord($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 700,
                width: 1200,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'>" +
                "<i class='ace-icon fa  fa-globe green'></i>督查事项反馈单预览</h4></div>",
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

                            $container.wordExport('督查事项反馈单${sysDate}');
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }



        /*--------导出end--------*/

        //撤回一周工作情况反馈信息
        function backWorkFeedback(rowData) {

            var id = rowData.id;

            G.confirm({
                message: '确认撤回督查事项反馈信息吗？',
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: backUrl,
                            data: {id: id},
                            async: true
                        }).done(function (map) {
                            G.doneAjaxLoading(loadId);
                            if (map.result) {
                                G.showGritterSuccess("撤回成功!");
                            } else {
                                G.showGritterFail("撤回失败,请稍后重试!");
                            }
                            //更新表格数据
                            search();
                        });
                    }
                }
            });
        }

        //查看一周工作情况反馈信息
        function viewWorkFeedback(rowData) {
            var id = rowData.matterId;
            var unitId = rowData.unitId;
            var viewUrl = '${basePath}/supervision-feedback/feedBack-lock.do';
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: viewUrl,
                type: "GET",
                data: {id: id,unitId:unitId},
                dataType: "html",
                success: function (String) {
                    $previewDialogLock.html(String);
                    G.doneAjaxLoading(loadId);
                    //初始化弹出框
                    initPreviewDialog($previewDialogLock);
                },
                error: function (e) {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }
        //初始化反馈弹出框
        function initPreviewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 660,
                width: 900,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'>" +
                "<i class='ace-icon fa  fa-globe green'></i>督查事项反馈</h4></div>",
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

        //上报督查事项
        function reportWorkFeedback(rowData) {
            var id = rowData.id;
            var name = rowData.createName;
            var dateStr = rowData.feedBackDateStr;
            if(name != "" && dateStr != ""){
                var reportUrl = '${basePath}/supervision-feedback/report-feedback.do';
                G.confirm({
                    message: '确认上报督查事项反馈信息吗？',
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
            }else {
                if(name == "") {
                    G.alert({message: "审批人不能为空！"});
                }else {
                    G.alert({message: "反馈日期不能为空！"});
                }
            }
        }


        //查收一周工作情况反馈信息
        function checkWorkFeedback(rowData) {
            var id = rowData.id;
            var deptName = rowData.deptName;
            var checkUrl = '${basePath}/supervision-feedback/check-work-feedback.do';
            G.confirm({
                message: '确认查收' + deptName + '反馈的信息吗？',
                callback: function (result) {
                    if (result) {
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            type: 'post',
                            dataType: 'json',
                            url: checkUrl,
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


        function search() {

            var matterId = $matterId.val();

            $gridTable.tjGrid('setPostData', {
                matterId: matterId
            });
            reloadGrid();
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        $backBtn.on('click', function () {
            G.pjaxLoadPageContentDiv("#page/supervision-matter/supervision-matter-list");

        });

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
            <c:if test="${'74_9' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'74_10' eq curOpertate}">
            if (status === '0') {
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
                operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'74_11' eq curOpertate}">
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
            var unitId = rowData.unitId;
            var curDeptId = $("#curDeptId").val();

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'74_13' eq curOpertate}">
            if (status === '1') {
                operations.push(' <button title="查收" class="btn btn-minier btn-white btn-primary checkDuty">');
                operations.push('<i class="ace-icon glyphicon glyphicon-check checkDuty"></i> 查收');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'74_14' eq curOpertate}">
            if (status === '0' && unitId === curDeptId) {
                operations.push(' <button title="上报" class="btn btn-minier btn-white btn-warning row-record-feedback">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-up"></i> 上报');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'74_15' eq curOpertate}">
            if (status === '1' && unitId === curDeptId) {
                operations.push(' <button title="撤回" class="btn btn-minier btn-white btn-warning backFeedback">');
                operations.push('<i class="ace-icon glyphicon glyphicon-arrow-down backFeedback"></i> 撤回');
                operations.push('</button>');
            }
            </c:if>
            <c:if test="${'74_5' eq curOpertate}">
                operations.push(' <button title="反馈单" class="btn btn-minier btn-white feedbackWord">');
                operations.push('<i class="fa fa-book feedbackWord"></i> 反馈单');
                operations.push('</button>');
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
