<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2018/7/31
  Time: 17:24
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
<%--<script src="${basePath}/js/foreignaffairs/come/come-schedule.js"></script>--%>

<div class="row">
    <div class="col-xs-12">
        <div class="hidden">
            <input type="text" id="form-field-comeInfoId" name="id" value="${comeInfoId}"/>
        </div>

        <div class="btn-group pull-right">
            <button class="btn btn-info btn-sm" type="button" id="addScheduleBtn">
                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                新增
            </button>
            <button class="btn btn-info btn-sm" type="button" id="exportScheduleBtn">
                <span class="ace-icon fa fa-cloud-download icon-on-right bigger-110"></span>
                导出
            </button>
        </div>
        <div class="pull-right">
            <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <table id="grid-table-schedule" class="table_list"></table>
            </div>
        </div>
    </div>
</div>


<div id="edit-schedule-dialog" class="hide">
</div>

<div id="view-schedule-dialog" class="hide">

    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">

                </div>
            </div>

            <div class="profile-user-info profile-user-info-striped" style="border-top: none">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 活动日期</div>
                    <div class="profile-info-value">
                        <span class="editable " id="activityDateStr"></span>
                    </div>
                    <div class="profile-info-row">
                        <div class="profile-info-name"> 活动时间</div>
                        <div class="profile-info-value">
                            <span class="editable " id="activityTimeStr"></span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="profile-user-info profile-user-info-striped" style="border-top: none">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 活动内容</div>
                    <div class="profile-info-value">
                        <span class="editable " id="activity"
                        style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/bootstrap-timepicker.css"/>
<link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/bootstrap-datetimepicker.css"/>

<script src="${basePath}/plugin/ace/assets/js/date-time/bootstrap-timepicker.js"></script>
<script src="${basePath}/plugin/ace/assets/js/date-time/bootstrap-datetimepicker.js"></script>


<script type="text/javascript">

    var $comeInfoId = $("#form-field-comeInfoId");

    var $addScheduleBtn = $("#addScheduleBtn");
    var $exportScheduleBtn = $("#exportScheduleBtn");
    var $scheduleGrid = $("#grid-table-schedule");

    var $editScheduleDialog = $("#edit-schedule-dialog");
    var $viewScheduleDialog = $("#view-schedule-dialog");


    var loadUrl = '${basePath}/come/come-schedule/load-schedule-list.do';
    var editUrl = '${basePath}/come/come-schedule/load-schedule-edit';
    var deleteUrl = '${basePath}/come/come-schedule/schedule-delete.do';

    var colModel = [
        {name: 'id', index: 'id', hidden: true},
        {name: 'activityDateStr', header: '日期', index: 'activityDate', sortable: true},
        {name: 'activityTimeStr', header: '时间', index: 'activityTime', sortable: true},
        {name: 'activity', header: '活动内容', index: 'activity', sortable: true, cellattr: styleFormatter},
        {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatter}
    ];

    function styleFormatter() {
        return 'style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"';
    }

    function basicOperationFormatter(cellvalue, options, rowData, action) {
        var operations = [];

        operations.push("<div style='margin-left:5px;font-size: 20px;'>");
        operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
        operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
        operations.push('</button>');

        operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
        operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
        operations.push('</button>');

        operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
        operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
        operations.push('</button>');

        operations.push("</div>");
        cellvalue = operations.join('');
        return cellvalue;
    }

    $scheduleGrid.tjGrid({
        loadUrl: loadUrl,
        height: '100%',
        autowidth: true,
        colModel: colModel,
        postData: {
            comeInfoId: $comeInfoId.val()
        },
        sortname: 'activityDate',
        sortorder: 'asc',
        rowNum: -1,
        pgbuttons: false,
        pginput: false,
        onSelectRow: function (id, stat, e) {

            if (e === undefined) {
                return false;
            }
            var className = $(e.target).attr('class');
            if (!className) {
                return false;
            }

            if (className.indexOf('row-record-view') !== -1) {
                var rowData = $scheduleGrid.jqGrid('getRowData', id);
                viewSchedule(rowData);
            } else if (className.indexOf('row-record-delete') !== -1) {
                G.confirm({
                    message: '确认删除此条日程信息吗？',
                    callback: function (result) {
                        if (result) {
                            $.post(deleteUrl, {id: id}, function (data) {
                                if (data.result) {
                                    G.showGritterSuccess("删除成功");
                                    $scheduleGrid.tjGrid('reloadGrid');
                                }
                            });
                        }
                    }
                });
            } else if (className.indexOf('row-record-edit') !== -1) {
                editSchedule(id);
            }
        }
    });

    $scheduleGrid.tjGrid("triggerResizeGrid");

    $exportScheduleBtn.unbind('click').bind('click', function (e) {
        e.preventDefault();
        var exportUrl = '${basePath}/come/come-schedule/come-schedule-export.do?comeInfoId=' + $comeInfoId.val();

        var $downloadForm = $("<form method='post'></form>");
        $downloadForm.attr("action", exportUrl);
        $(document.body).append($downloadForm);
        $downloadForm.submit();
    });
        // 新增接待计划
    $addScheduleBtn.unbind('click').bind('click', function (e) {
        e.preventDefault();

        editSchedule();
    });

    // 编辑接待计划
    function editSchedule(id) {
        var loadId = G.showAjaxLoading();
        $.ajax({
            url: editUrl,
            type: "GET",
            data: {id: id, comeInfoId: $comeInfoId.val()},
            dataType: "html",
            success: function (String) {
                $editScheduleDialog.html(String);
                G.doneAjaxLoading(loadId);
                initEditDialog($editScheduleDialog);
            },
            error: function () {
                G.doneAjaxLoading(loadId);
                G.alert({message: "操作失败！"});
            }
        });

    }
    var enableClick = true;
    // 编辑接待计划弹窗
    function initEditDialog($container) {

        G.timepicker({
            minuteStep: 5,
            showMeridian: false,
            disableFocus: true
        });

        var $form = $container.find("#scheduleDetailForm");
        var saveRowUrl = '${basePath}/come/come-schedule/add-schedule-row.do';

        $container.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            width: 850,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 新增/编辑日程信息</h4></div>",
            title_html: true,
            close: function () {
                $form.tjValidate('resetForm');
            },

            buttons: [
                {
                    html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                    "class": "btn btn-warning commitBtn",
                    click: function () {
                        $container.dialog("close");
                    }
                },
                {
                    html: "<i class='ace-icon fa fa-check  bigger-110'></i>&nbsp; 确定",
                    "class": "btn btn-success",
                    click: function () {
                        if ($form.validate().form()) {
                            if(enableClick) {
                                enableClick = false;
                                var data = $form.serializeObject();
                                data["comeInfoId"] = $comeInfoId.val();

                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: saveRowUrl,
                                    type: 'post',
                                    dataType: 'json',
                                    data: data,
                                    async: true
                                }).done(function (map) {
                                    enableClick = true;
                                    G.doneAjaxLoading(loadId);
                                    if (map.result) {
                                        G.showGritterSuccess("操作成功！");
                                        reloadGrid();
                                        $container.dialog('close');
                                    } else {
                                        G.showGritterFail("操作失败,请稍后重试！");
                                    }
                                });
                            }
                        }
                    }
                }
            ]
        });

        $form.tjValidate({
            focusInvalid: true,
            rules: {
                receptionSite: {required: true},
                accompanyNum: {required: true},
                startDateStr: {required: true},
                endDateStr: {required: true},
                activityPlan: {required: true}
            },
            messages: {
                receptionSite: {required: "接待地点不能为空"},
                accompanyNum: {required: "陪同人员不能为空"},
                startDateStr: {required: "开始日期不能为空"},
                endDateStr: {required: "结束日期不能为空"},
                activityPlan: {required: "活动安排不能为空"}
            }
        });
    }

    // 查看接待计划
    function viewSchedule(rowData) {
        $viewScheduleDialog.find('.editable').each(function () {
            $(this).html(rowData[$(this).attr('id')]);
        });

        initViewDialog($viewScheduleDialog);
    }

    // 查看接待计划弹窗
    function initViewDialog($container) {
        $container.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            maxHeight: 600,
            width: 800,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看日程信息</h4></div>",
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

    function reloadGrid() {
        $scheduleGrid.tjGrid('reloadGrid');
    }

</script>