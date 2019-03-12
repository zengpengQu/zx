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
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-airplane">
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
                <table id="grid-table-airplane"></table>
            </div>
        </div>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div id="edit-dialog-airplane" class="hide"></div>
        <div id="view-dialog-airplane" class="hide">
            <div class="row">
                <div class="col-xs-12">
                    <div class="profile-user-info profile-user-info-striped">

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 航班号</div>
                            <div class="profile-info-value">
                                <span class="editable " id="flightNo"></span>
                            </div>
                            <div class="profile-info-name"> 机型</div>
                            <div class="profile-info-value">
                                <span class="editable " id="airModel"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 启程地</div>
                            <div class="profile-info-value">
                                <span class="editable " id="fromName"></span>
                            </div>
                            <div class="profile-info-name"> 目的地</div>
                            <div class="profile-info-value">
                                <span class="editable " id="toName"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 舱位</div>
                            <div class="profile-info-value">
                                <span class="editable " id="shippingChooseName"></span>
                            </div>
                            <div class="profile-info-name"> 飞行时间</div>
                            <div class="profile-info-value">
                                <span class="editable " id="timeFlight"></span>
                            </div>
                        </div>
                    </div>

                    <div class="profile-user-info profile-user-info-striped" style="border-top: none">
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 备注信息</div>
                            <div class="profile-info-value">
                                <span class="editable " id="noteInfo" style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
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

        var $addBtn = $("#addBtn-airplane");

        var $gridTable = $("#grid-table-airplane");
        var $editDialog = $("#edit-dialog-airplane");
        var $viewDialog = $("#view-dialog-airplane");

        var fd = new FormData();

        var loadUrl = '${basePath}/abroad-airplane/load-airplane-list.do';
        var editUrl = '${basePath}/abroad-airplane/load-airplane-edit.do';
        var saveUrl = '${basePath}/abroad-airplane/abroad-airplane-edit-save.do';
        var deleteUrl = '${basePath}/abroad-airplane/abroad-airplane-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'flightNo', header: '航班号', index: 'flightNo', sortable: false},
            {name: 'fromName', header: '启程地', index: 'fromName', sortable: false},
            {name: 'toName', header: '目的地', index: 'toName', sortable: false},
            {name: 'airModel', header: '机型', index: 'airModel', sortable: false},
            {name: 'shippingChooseName', header: '舱位', index: 'shippingChooseName', sortable: false},
            {name: 'timeFlight', header: '飞行时间', index: 'timeFlight'},
            {name: 'noteInfo', header: '备注信息', index: 'noteInfo', hidden: true},
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

        function workOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];

            operations.push("<div style='margin-left:5px;font-size: 20px;'>");
            operations.push(' <button title="下载" class="btn btn-minier fa fa-download btn-white btn-primary downloadAbroadAirplane">');
            operations.push('<i class="ace-icon downloadAbroadAirplane"></i> 下载');
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
                    viewAbroadAirplane(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条乘机信息吗？',
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
                    editAbroadAirplane(id);
                } else if (className.indexOf('downloadAbroadAirplane') != -1) {
                    handleAbroadAirplane(id, '0');
                }
            },

            loadComplete: function () {
                var table = this;
                setTimeout(function () {
                    updatePagerIcons(table);
                    enableTooltips(table);
                    hidePagerSelect(table);
                }, 0);
                $gridTable.tjGrid("triggerResizeGrid");
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        $addBtn.click(function () {
            editAbroadAirplane();
        });

        function editAbroadAirplane(id) {
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
            var $form = $("#saveFormAirplane");
            //var $uploadAbroadAirplane = $form.find("#form-field-uploadAbroadAirplane");

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
                                    flightNo: {
                                        required: true
                                    },
                                    fromName: {
                                        required: true
                                    },
                                    toName: {
                                        required: true
                                    },
                                    airModel: {
                                        required: true
                                    },
                                    shippingChoose: {
                                        required: true
                                    },
                                    timeFlight: {
                                        required: true
                                    }
                                },
                                messages: {
                                    flightNo: {
                                        required: "航班号不能为空"
                                    },
                                    fromName: {
                                        required: "启程地不能为空"
                                    },
                                    toName: {
                                        required: "目的地不能为空"
                                    },
                                    airModel: {
                                        required: "机型不能为空"
                                    },
                                    shippingChoose: {
                                        required: "舱位不能为空"
                                    },
                                    timeFlight: {
                                        required: "飞行时间不能为空"
                                    }
                                }
                            });
                            var postData = getRecord($form);
                            postAbroadAirplane(postData, $form);
                        }
                    }
                ]
            });

/*            $uploadAbroadAirplane.bind('change', function () {
                $uploadAbroadAirplane.each(function () {
                    var fieldName = $(this).attr('name');
                    //for fields with "multiple" file support
                    //field name should be something like `myfile[]`

                    var files = $(this).data('ace_input_files');
                    if (files && files.length > 0) {
                        for (var i = 0; i < files.length; i++) {
                            fd.append(fieldName, files[i]);
                        }
                    }
                });
            });*/
        }

        function getRecord($form) {
            var abroadInfoId = $abroadInfoId.val();
            var abroadAirplaneId = $form.find('#form-field-id').val();
            var flightNo = $form.find('#form-field-flightNo').val();
            var fromName = $form.find('#form-field-fromName').val();
            var toName = $form.find('#form-field-toName').val();
            var airModel = $form.find('#form-field-airModel').val();
            var shippingChoose = $form.find('#form-field-shippingChoose').val();
            var timeFlight = $form.find('#form-field-timeFlight').val();
            var noteInfo = $form.find('#form-field-noteInfo').val();

            var records = {
                'id': abroadAirplaneId,
                'abroadInfoId': abroadInfoId,
                'flightNo': flightNo,
                'fromName': fromName,
                'toName': toName,
                'airModel': airModel,
                'shippingChoose': shippingChoose,
                'timeFlight': timeFlight,
                'noteInfo': noteInfo
            };

            return records;
        }

        function postAbroadAirplane(postData, $form) {
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

        function viewAbroadAirplane(rowData) {
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
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看乘机信息</h4></div>",
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

        function handleAbroadAirplane(id, type) {
            var rowData = $gridTable.jqGrid('getRowData', id);
            var operName = "";
            var downloadUrl = '${basePath}/abroad-airplane/abroad-airplane-download.do';
            if (type == '0') {
                operName = '下载';
                var realName = rowData.realName;
                var uuidName = rowData.uuidName;
                var filePath = downloadUrl + '?uuidName=' + uuidName + '&realName=' + realName;

                var $downloadForm = $("<form method='post'></form>");
                $downloadForm.attr("action", filePath);
                $(document.body).append($downloadForm);
                $downloadForm.submit();
            }
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        $(document).one('ajaxloadstart.page', function (e) {
            // $.jgrid.gridDestroy("#grid-table-airplane");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
