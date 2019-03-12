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
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-chronicle">
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

<div class="row">
    <div class="col-xs-12">
        <div id="edit-dialog-chronicle" class="hide"></div>
        <div id="view-dialog-chronicle" class="hide">
            <div class="row">
                <div class="col-xs-12">
                    <div class="profile-user-info profile-user-info-striped">

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 开始时间</div>
                            <div class="profile-info-value">
                                <span class="editable " id="beginTimeStr"></span>
                            </div>
                            <div class="profile-info-name"> 结束时间</div>
                            <div class="profile-info-value">
                                <span class="editable " id="endTimeStr"></span>
                            </div>
                        </div>
                    </div>

                    <div class="profile-user-info profile-user-info-striped" style="border-top: none">
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 内容</div>
                            <div class="profile-info-value">
                                <span class="editable " id="content"
                                      style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                            </div>
                        </div>
                    </div>

                    <div class="profile-user-info profile-user-info-striped" style="border-top: none;">
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 备注</div>
                            <div class="profile-info-value">
                                <span class="editable " id="notes"
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

        var $addBtn = $("#addBtn-chronicle");

        var $gridTable = $("#grid-table-chronicle");
        var $editDialog = $("#edit-dialog-chronicle");
        var $viewDialog = $("#view-dialog-chronicle");

        var fd = new FormData();

        var loadUrl = '${basePath}/abroad-chronicle/load-chronicle-list.do';
        var editUrl = '${basePath}/abroad-chronicle/load-chronicle-edit.do';
        var saveUrl = '${basePath}/abroad-chronicle/abroad-chronicle-edit-save.do';
        var deleteUrl = '${basePath}/abroad-chronicle/abroad-chronicle-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'beginTimeStr', header: '开始时间', index: 'beginTimeStr', sortable: false},
            {name: 'endTimeStr', header: '结束时间', index: 'endTimeStr', sortable: false},
            {name: 'content', header: '内容', index: 'content', sortable: false, cellattr: styleFormatter},
            {name: 'notes', header: '备注', index: 'notes', hidden: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 200,
                fixed: true,
                formatter: basicOperationFormatter
            }
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
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除');
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
            sortname: 'beginTime',
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
                    viewAbroadChronicle(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条大事记吗？',
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
                    editAbroadChronicle(id);
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        $addBtn.click(function () {
            editAbroadChronicle();
        });

        function editAbroadChronicle(id) {
            $.ajax({
                url: editUrl,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $editDialog.html(String);
                    initEditDialog($editDialog);
                },
                error: function () {
                    G.alert({message: "操作失败！"});
                }
            });
        }

        var enableClick = true;
        function initEditDialog($container) {
            var $form = $("#saveFormChronicle");

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                // maxHeight: 650,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 新增/编辑</h4></div>",
                title_html: true,
                close: function () {
                    $form.resetForm();
                    $('.ace-file-name').attr('data-title', ' ... ');
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
                                    beginTimeStr: {
                                        required: true
                                    },
                                    endTimeStr: {
                                        required: true,
                                        compareDate: '#form-field-beginTimeStr'
                                    },
                                    content: {
                                        required: true,
                                        maxlength: 2000
                                    },
                                    notes: {
                                        maxlength: 1000
                                    }
                                },
                                messages: {
                                    beginTimeStr: {
                                        required: "开始时间不能为空"
                                    },
                                    endTimeStr: {
                                        required: "结束时间不能为空"
                                    },
                                    content: {
                                        required: "内容不能为空"
                                    }
                                }
                            });
                            var postData = getRecord($form);
                            postAbroadChronicle(postData, $form);
                        }
                    }
                ]
            });
        }

        function getRecord($form) {
            var abroadInfoId = $abroadInfoId.val();
            var abroadChronicleId = $form.find('#form-field-id').val();
            var beginTimeStr = $form.find('#form-field-beginTimeStr').val();
            var endTimeStr = $form.find('#form-field-endTimeStr').val();
            var content = $form.find('#form-field-content').val();
            var notes = $form.find('#form-field-notes').val();

            var records = {
                'id': abroadChronicleId,
                'abroadInfoId': abroadInfoId,
                'beginTimeStr': beginTimeStr,
                'endTimeStr': endTimeStr,
                'content': content,
                'notes': notes
            };

            return records;
        }

        function postAbroadChronicle(postData, $form) {
            if ($form.validate().form()) {
                var statDate = moment($('#abroadInfoStartDate').val(), 'YYYY-MM-DD').toDate();
                var endDate = moment($('#abroadInfoEndDate').val(), 'YYYY-MM-DD').toDate();
                var beginTime = moment($('#form-field-beginTimeStr').val(), 'YYYY-MM-DD').toDate();
                var endTime = moment($('#form-field-endTimeStr').val(), 'YYYY-MM-DD').toDate();
                if (beginTime >= statDate && beginTime <= endDate && endTime >= statDate && endTime <= endDate) {

                    postRecord(postData);
                } else {
                    G.alert({message: '开始结束时间应在出访开始日期和结束日期之间!'});
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
                    enableClick = true;
                    G.doneAjaxLoading(loadId);
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

        function viewAbroadChronicle(rowData) {
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
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看大事记</h4></div>",
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
            // $.jgrid.gridDestroy("#grid-table-chronicle");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
