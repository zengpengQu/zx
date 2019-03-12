<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2018/7/31
  Time: 17:32
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
<%--<script src="${basePath}/js/foreignaffairs/come/come-chronicle.js"></script>--%>

<div class="row">
    <div class="col-xs-12">

        <div class="hidden">
            <input type="text" id="form-field-comeInfoId" name="id" value="${comeInfoId}"/>
            <input id="comeInfo-startDate" value="${startDate}"/>
            <input id="comeInfo-endDate" value="${endDate}"/>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="addChronicleBtn">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        新增
                    </button>
                </div>
                <div class="pull-right">
                    <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <table id="grid-table-chronicle"></table>
            </div>
        </div>
    </div>
</div>

<div id="edit-chronicle-dialog" class="hide">
    <form id="chronicleForm" role="form">
        <div class="hidden">
            <input class="editable" type="text" id="id" name="id"/>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-2 control-label text-right">内容：<span
                            class="required">*</span></label>

                    <div class="col-sm-10 ">
                    <textarea  class="form-control limited editable" id="content"
                              name="content" maxlength="2000" style="min-height: 100px;" placeholder="内容"></textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-2 control-label text-right">开始时间：<span
                            class="required">*</span></label>

                    <div class="col-sm-10 ">
                        <div class="input-group date date-picker " data-date-format="yyyy-mm-dd">
                            <input class="form-control editable" name="beginTimeStr" id="beginTime"
                                   type="text" placeholder="开始时间"/>
                            <span class="input-group-addon">
                                <i class="fa fa-calendar bigger-110"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-2 control-label text-right">结束时间：<span
                            class="required">*</span></label>

                    <div class="col-sm-10">
                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                            <input class="form-control editable" name="endTimeStr" id="endTime"
                                   type="text" placeholder="结束时间"/>
                            <span class="input-group-addon">
                            <i class="fa fa-calendar bigger-110"></i>
                        </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-2 control-label text-right">备注：<span
                            class="required">&nbsp;</span></label>

                    <div class="col-sm-10 ">
                    <textarea class="form-control limited editable" id="notes"
                              name="notes" maxlength="1000" style="min-height: 100px;" placeholder="备注"></textarea>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="view-chronicle-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped" style="border-top: none">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 开始时间</div>
                    <div class="profile-info-value">
                        <span class="editable " name="beginTimeStr"></span>
                    </div>

                    <div class="profile-info-name"> 结束时间</div>
                    <div class="profile-info-value">
                        <span class="editable " name="endTimeStr"></span>
                    </div>
                </div>
            </div>

            <div class="profile-user-info profile-user-info-striped" style="border-top: none">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 内容</div>
                    <div class="profile-info-value">
                        <span class="editable " name="content"
                        style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                    </div>
                </div>
            </div>

            <div class="profile-user-info profile-user-info-striped" style="border-top: none">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 备注</div>
                    <div class="profile-info-value">
                        <span class="editable " name="notes"
                        style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript">

    G.datepicker({
        autoclose: true,
        todayHighlight: true
    });

    var comeInfoId = '${comeInfoId}';
    var loadChrUrl = '${basePath}/come/come-chronicle/load-chronicle-list.do';
    var deleteChrUrl = '${basePath}/come/come-chronicle/chronicle-delete.do';

    var $chronicleGrid = $("#grid-table-chronicle");

    var $chronicleDialog = $("#edit-chronicle-dialog");

    var $viewChronicleDialog = $("#view-chronicle-dialog");

    var $addChronicleBtn = $("#addChronicleBtn");

    var chronicleColModel = [
        {name: 'id', index: 'id', hidden: true},
        {name: 'content', header: '内容', index: 'content', sortable: true, cellattr: styleFormatter},
        {name: 'beginTimeStr', header: '开始时间', index: 'beginTimeStr', sortable: true},
        {name: 'endTimeStr', header: '结束时间', index: 'endTimeStr', sortable: true},
        {name: 'notes', header: '备注', index: 'notes', sortable: true, cellattr: styleFormatter},
        {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatter}
    ];

    function styleFormatter() {
        return 'style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"';
    }

    function basicOperationFormatter(cellvalue, options, rowData, action) {
        var operations = [];

        operations.push("<div style='margin-left:5px;font-size: 20px;'>");
        operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
        operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view"></i> 查看');
        operations.push('</button>');

        operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
        operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit"></i> 编辑');
        operations.push('</button>');

        operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
        operations.push('<i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除');
        operations.push('</button>');

        operations.push("</div>");
        cellvalue = operations.join('');
        return cellvalue;
    }

    $chronicleGrid.tjGrid({
        loadUrl: loadChrUrl,
        height: '100%',
        autowidth: true,
        colModel: chronicleColModel,
        postData: {
            comeInfoId: comeInfoId
        },
        sortname: 'beginTime',
        sortorder: 'desc',
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
            var rowData = $chronicleGrid.jqGrid('getRowData', id);

            if (className.indexOf('row-record-view') !== -1) {
                viewChronicle(rowData);
            } else if (className.indexOf('row-record-delete') !== -1) {
                G.confirm({
                    message: '确认删除此条大事记信息吗？',
                    callback: function (result) {
                        if (result) {
                            $.post(deleteChrUrl, {id: id}, function (data) {
                                if (data.result) {
                                    G.showGritterSuccess("删除成功");
                                    $chronicleGrid.tjGrid('reloadGrid');
                                }
                            });
                        }
                    }
                });
            } else if (className.indexOf('row-record-edit') !== -1) {
                editChronicleRow(rowData, $chronicleDialog);
            }
        }
    });

    $chronicleGrid.tjGrid("triggerResizeGrid");

    $addChronicleBtn.unbind('click').bind('click', function (e) {
        e.preventDefault();
        chronicleDialog($chronicleDialog);
    });

    // 编辑来访大事记
    function editChronicleRow(rowData, $dialog) {
        var $form = $dialog.find("#chronicleForm");

        $form.find('.editable').each(function () {
            $(this).val(rowData[$(this).attr('name')]);
        });

        chronicleDialog($dialog)
    }

    var enableClick = true;
    // 来访大事记弹窗
    function chronicleDialog($dialog) {

        var $form = $dialog.find("#chronicleForm");

        var saveRowUrl = '${basePath}/come/come-chronicle/add-chronicle-row.do';

        $dialog.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            maxHeight: 600,
            width: 800,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>新增/编辑大事记</h4></div>",
            title_html: true,
            close: function () {
                $form.tjValidate('resetForm');
            },
            buttons: [
                {
                    html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                    "class": "btn btn-warning",
                    click: function () {
                        $dialog.dialog("close");
                    }
                },
                {
                    html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                    "class": "btn btn-success",
                    click: function () {
                        $form.tjValidate({
                            focusInvalid: true,
                            rules: {
                                content: {required: true, maxlength: 2000},
                                beginTimeStr: {required: true},
                                endTimeStr: {required: true, compareDate: '#beginTime'},
                                content: {maxlength: 1000}
                            },
                            messages: {
                                content: {required: "内容不能为空"},
                                beginTimeStr: {required: "开始时间不能为空"},
                                endTimeStr: {required: "结束时间不能为空", compareDate: "结束时间必须大于等于开始时间"}
                            }
                        });

                        if ($form.validate().form()) {
                            if (enableClick) {
                                enableClick = false;
                                var data = $form.serializeObject();
                                data.comeInfoId = comeInfoId;

                                var startDate = moment($('#comeInfo-startDate').val(),'YYYY-MM-DD').toDate();
                                var endDate = moment($('#comeInfo-endDate').val(),'YYYY-MM-DD').toDate();
                                var beginTime = moment($('#beginTime').val(),'YYYY-MM-DD').toDate();
                                var endTime = moment($('#endTime').val(),'YYYY-MM-DD').toDate();
                                if (beginTime >= startDate && beginTime <= endDate && endTime >= startDate && endTime <= endDate) {
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
                                            $chronicleGrid.tjGrid('reloadGrid');
                                            $dialog.dialog('close');
                                        } else {
                                            G.showGritterFail("操作失败,请稍后重试！");
                                        }
                                    });
                                } else {
                                    G.alert({message: '大事记时间应在来访开始日期和结束日期之间!'});
                                }
                            }
                        }
                    }
                }
            ]
        });

    }

    // 查看来访大事记
    function viewChronicle(rowData) {
        $viewChronicleDialog.find('.editable').each(function () {
            $(this).html(rowData[$(this).attr('name')]);
        });

        initViewDialog($viewChronicleDialog);
    }

    // 查看接待计划弹窗
    function initViewDialog($container) {
        $container.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            maxHeight: 600,
            width: 800,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看来访大事记信息</h4></div>",
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
</script>