<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<div class="row">
    <div class="col-xs-12">

        <div class="hidden">
            <input type="text" id="form-field-abroadInfoId" name="abroadInfoId" value="${abroadInfoId}"/>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-schedule">
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
                <table id="grid-table-schedule"></table>
            </div>
        </div>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div id="edit-dialog-schedule" class="hide"></div>
        <div id="view-dialog-schedule" class="hide">
            <div class="row">
                <div class="col-xs-12">
                    <div class="profile-user-info profile-user-info-striped">

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 日期</div>
                            <div class="profile-info-value">
                                <span class="editable " id="dayStr"></span>
                            </div>
                            <div class="profile-info-name"> 时段</div>
                            <div class="profile-info-value">
                                <span class="editable " id="period"></span>
                            </div>
                        </div>
                    </div>

                    <div class="profile-user-info profile-user-info-striped" style="border-top: none">

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 活动安排</div>
                            <div class="profile-info-value">
                                <span class="editable " id="content"
                                      style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                            </div>
                        </div>
                    </div>
                    <div class="profile-user-info profile-user-info-striped" style="border-top: none">

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 备注信息</div>
                            <div class="profile-info-value">
                                <span class="editable " id="noteInfo"
                                      style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="hidden">
    <input type="text" id="abroadInfoStartDate" value="${abroadInfo.startDate}"/>
    <input type="text" id="abroadInfoEndDate" value="${abroadInfo.endDate}"/>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker();

        var $abroadInfoId = $("#form-field-abroadInfoId");

        var $addBtn = $("#addBtn-schedule");

        var $gridTable = $("#grid-table-schedule");
        var $editDialog = $("#edit-dialog-schedule");
        var $viewDialog = $("#view-dialog-schedule");

        var fd = new FormData();

        var loadUrl = '${basePath}/abroad-schedule/load-schedule-list.do';
        var editUrl = '${basePath}/abroad-schedule/load-schedule-edit.do';
        var saveUrl = '${basePath}/abroad-schedule/abroad-schedule-edit-save.do';
        var deleteUrl = '${basePath}/abroad-schedule/abroad-schedule-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'dayStr', header: '日期', index: 'day', sortable: true},
            {name: 'period', header: '时段', index: 'period', sortable: false},
            {name: 'content', header: '活动安排', index: 'content', sortable: false},
            {name: 'noteInfo', header: '备注信息', index: 'noteInfo', hidden: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 200,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

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

        $gridTable.tjGrid({
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            postData: {
                abroadInfoId: $abroadInfoId.val()
            },
            sortname: 'day',
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
                    var rowData = $gridTable.jqGrid('getRowData', id);
                    viewAbroadSchedule(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条日程信息吗？',
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
                    editAbroadSchedule(id);
                } else if (className.indexOf('downloadAbroadSchedule') != -1) {
                    handleAbroadSchedule(id, '0');
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        $addBtn.click(function () {
            editAbroadSchedule();
        });

        function editAbroadSchedule(id) {
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: editUrl,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $editDialog.html(String);
                    G.doneAjaxLoading(loadId);
                    initEditDialog($editDialog);
                },
                error: function () {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }

        var enableClick = true;
        function initEditDialog($container) {
            var $form = $("#saveFormSchedule");

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 新增/编辑</h4></div>",
                title_html: true,
                close: function () {
                    $form.resetForm();
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
                        html: "<i class='ace-icon fa fa-check  bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            $form.tjValidate({
                                focusInvalid: false,
                                rules: {
                                    dayStr: {
                                        required: true
                                    },
                                    period: {
                                        required: true
                                    },
                                    content: {
                                        required: true
                                    }
                                },
                                messages: {
                                    dayStr: {
                                        required: "日期不能为空"
                                    },
                                    period: {
                                        required: "时段不能为空"
                                    },
                                    content: {
                                        required: "活动安排不能为空"
                                    }
                                }
                            });
                            var postData = getRecord($form);
                            postAbroadSchedule(postData, $form);
                        }
                    }
                ]
            });
        }

        function getRecord($form) {
            var abroadInfoId = $abroadInfoId.val();
            var abroadScheduleId = $form.find('#form-field-id').val();
            var dayStr = $form.find('#form-field-dayStr').val();
            var period = $form.find('#form-field-period').val();
            var content = $form.find('#form-field-content').val();
            var noteInfo = $form.find('#form-field-noteInfo').val();

            var records = {
                'id': abroadScheduleId,
                'abroadInfoId': abroadInfoId,
                'dayStr': dayStr,
                'period': period,
                'content': content,
                'noteInfo': noteInfo
            };

            return records;
        }

        function postAbroadSchedule(postData, $form) {
            if ($form.validate().form()) {
                var statDate = moment($('#abroadInfoStartDate').val(), 'YYYY-MM-DD').toDate();
                var endDate = moment($('#abroadInfoEndDate').val(), 'YYYY-MM-DD').toDate();
                var day = moment($('#form-field-dayStr').val(), 'YYYY-MM-DD').toDate();
                if (day >= statDate && day <= endDate) {
                    postRecord(postData);
                } else {
                    G.alert({message: '日期应在出访开始日期和结束日期之间!'});
                }
            }
        }

        function postRecord(postData) {
            if (enableClick) {
                enableClick = false;
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: saveUrl,
                    type: 'post',
                    dataType: 'json',
                    data: postData, // 表单数据
                    async: true
                }).done(function (map) {
                    G.doneAjaxLoading(loadId);
                    enableClick = true;
                    if (map.result) {
                        G.showGritterSuccess("保存成功！");
                        $editDialog.dialog('close');
                    } else {
                        G.showGritterFail("保存失败,请稍后重试！");
                    }
                    //更新表格数据
                    reloadGrid();
                });
            }
        }

        function viewAbroadSchedule(rowData) {
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
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看日程信息</h4></div>",
                title_html: true,
                close: function () {
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
            $gridTable.tjGrid('reloadGrid');
        }


        $(document).one('ajaxloadstart.page', function (e) {
            // $.jgrid.gridDestroy("#grid-table-schedule");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });


    });
</script>
