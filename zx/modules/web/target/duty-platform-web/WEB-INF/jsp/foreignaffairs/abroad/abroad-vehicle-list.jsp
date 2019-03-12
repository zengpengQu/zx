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
                    <button class="btn btn-info btn-sm" type="button" id="export-vehicle">
                        <span class="ace-icon fa fa-cloud-download icon-on-right bigger-110"></span>
                        导出
                    </button>
                </div>

                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-vehicle">
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
                <table id="grid-table-vehicle"></table>
            </div>
        </div>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div id="edit-dialog-vehicle" class="hide"></div>
        <div id="view-dialog-vehicle" class="hide">
            <div class="row">
                <div class="col-xs-12">
                    <div class="profile-user-info profile-user-info-striped">

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 活动路线</div>
                            <div class="profile-info-value">
                                <span class="editable " id="activityRoute"
                                      style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 乘车安排</div>
                            <div class="profile-info-value">
                                <span class="editable " id="vehicleInfo"
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

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker();

        var $abroadInfoId = $("#form-field-abroadInfoId");

        var $addBtn = $("#addBtn-vehicle");
        var $exportBtn = $("#export-vehicle");

        var $gridTable = $("#grid-table-vehicle");
        var $editDialog = $("#edit-dialog-vehicle");
        var $viewDialog = $("#view-dialog-vehicle");

        var loadUrl = '${basePath}/abroad-vehicle/load-vehicle-list.do';
        var editUrl = '${basePath}/abroad-vehicle/load-vehicle-edit.do';
        var saveUrl = '${basePath}/abroad-vehicle/abroad-vehicle-edit-save.do';
        var deleteUrl = '${basePath}/abroad-vehicle/abroad-vehicle-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'activityRoute', header: '活动路线', index: 'activityRoute', sortable: false},
            {name: 'vehicleInfo', header: '乘车安排', index: 'vehicleInfo', hidden: true},
            {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatter}
        ];

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
            sortname: 'updateTime',
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

                if (className.indexOf('row-record-view') !== -1) {
                    var rowData = $gridTable.jqGrid('getRowData', id);
                    viewAbroadVehicle(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条乘车信息吗？',
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
                    editAbroadVehicle(id);
                } else if (className.indexOf('downloadAbroadVehicle') != -1) {
                    handleAbroadVehicle(id, '0');
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        $addBtn.click(function () {
            editAbroadVehicle();
        });

        function editAbroadVehicle(id) {
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
            var $form = $("#saveFormVehicle");

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
                                    activityRoute: {
                                        required: true
                                    },
                                    roomArrange: {
                                        required: true
                                    }
                                },
                                messages: {
                                    activityRoute: {
                                        required: "活动路线不能为空"
                                    },
                                    roomArrange: {
                                        required: "乘车安排不能为空"
                                    }
                                }
                            });
                            var postData = getRecord($form);
                            postAbroadVehicle(postData, $form);
                        }
                    }
                ]
            });
        }

        function getRecord($form) {
            var abroadInfoId = $abroadInfoId.val();
            var abroadVehicleId = $form.find('#form-field-id').val();
            var activityRoute = $form.find('#form-field-activityRoute').val();
            var vehicleInfo = $form.find('#form-field-vehicleInfo').val();

            var records = {
                'id': abroadVehicleId,
                'abroadInfoId': abroadInfoId,
                'activityRoute': activityRoute,
                'vehicleInfo': vehicleInfo
            };

            return records;
        }

        function postAbroadVehicle(postData, $form) {
            if ($form.validate().form()) {
                postRecord(postData);
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

        function viewAbroadVehicle(rowData) {
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
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看乘车信息</h4></div>",
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

        // 导出文件
        $exportBtn.click(function (e) {
            e.preventDefault();

            location.href = '${basePath}/abroad-vehicle/export-vehicle.do?abroadInfoId=' + $abroadInfoId.val();

        });


        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }


        $(document).one('ajaxloadstart.page', function (e) {
            // $.jgrid.gridDestroy("#grid-table-vehicle");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
