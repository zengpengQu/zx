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

<div class="row">
    <div class="col-xs-12">

        <div class="hidden">
            <input type="text" id="form-field-abroadInfoId" name="abroadInfoId" value="${abroadInfoId}"/>
        </div>

        <h4 class="smaller header lighter blue"
            style="margin-top: 0px;margin-bottom:10px ">
            <i class="ace-icon fa fa-list"></i>
            内部人员
        </h4>

        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-left">
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-group-in">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        选择
                    </button>
                </div>

                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="exportBtn-namebook-in">
                        <span class="ace-icon fa fa-cloud-download icon-on-right bigger-110"></span>
                        人员名单
                    </button>
                </div>

                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="exportBtn-group-in">
                        <span class="ace-icon fa fa-cloud-download icon-on-right bigger-110"></span>
                        任务批件
                    </button>
                </div>

                <div class="pull-right">
                    <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <table id="grid-table-group-in"></table>
            </div>
        </div>

        <div class="row">
            <div class="space-10"></div>
        </div>

        <h4 class="smaller header lighter blue"
            style="margin-top: 0px;margin-bottom:10px ">
            <i class="ace-icon fa fa-list"></i>
            外部人员
        </h4>

        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-left">
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-group-out">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        新增
                    </button>
                </div>
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="exportBtn-group-out">
                        <span class="ace-icon fa fa-cloud-download icon-on-right bigger-110"></span>
                        任务通知书、确认件
                    </button>
                </div>

                <div class="pull-right">
                    <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <table id="grid-table-group-out"></table>
            </div>
        </div>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">

        <div id="import-dialog-group" class="hide"></div>

        <div id="preview-dialog-group" class="hide" style="background-color: darkseagreen"></div>

        <div id="edit-dialog-group" class="hide"></div>

        <div id="view-dialog-group" class="hide">
            <div class="row">
                <div class="col-xs-12">
                    <div class="profile-user-info profile-user-info-striped">

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 姓名</div>
                            <div class="profile-info-value">
                                <span class="editable " id="name"></span>
                            </div>
                            <div class="profile-info-name"> 性别</div>
                            <div class="profile-info-value">
                                <span class="editable " id="sexName"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 出生日期</div>
                            <div class="profile-info-value">
                                <span class="editable " id="birthdayStr"></span>
                            </div>
                            <div class="profile-info-name"> 出生地</div>
                            <div class="profile-info-value">
                                <span class="editable " id="homeplace"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 工作单位</div>
                            <div class="profile-info-value">
                                <span class="editable " id="org"></span>
                            </div>
                            <div class="profile-info-name"> 主要职务</div>
                            <div class="profile-info-value">
                                <span class="editable " id="duty"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 角色</div>
                            <div class="profile-info-value">
                                <span class="editable " id="roleName"></span>
                            </div>
                            <div class="profile-info-name"> 对外身份</div>
                            <div class="profile-info-value">
                                <span class="editable " id="identity"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 联系方式</div>
                            <div class="profile-info-value">
                                <span class="editable " id="tel"></span>
                            </div>
                            <div class="profile-info-name"> 人员类别</div>
                            <div class="profile-info-value">
                                <span class="editable " id="personFlagName"></span>
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

        var $addBtnIn = $("#addBtn-group-in");
        var $gridTableIn = $("#grid-table-group-in");
        var $exportBtnIn = $("#exportBtn-group-in");
        var $addBtnOut = $("#addBtn-group-out");
        var $gridTableOut = $("#grid-table-group-out");
        var $exportBtnOut = $("#exportBtn-group-out");

        var $importDialog = $("#import-dialog-group");
        var $previewDialog = $("#preview-dialog-group");
        var $editDialog = $("#edit-dialog-group");
        var $viewDialog = $("#view-dialog-group");

        var loadUrlIn = '${basePath}/abroad-group/load-group-list-in.do';
        var importUrl = '${basePath}/abroad-group-user/abroad-user-list.do';
        var saveImportUrl = '${basePath}/abroad-group/abroad-group-user-save.do';
        var editUrl = '${basePath}/abroad-group/load-group-edit.do';
        var saveUrl = '${basePath}/abroad-group/abroad-group-edit-save.do';
        var deleteUrl = '${basePath}/abroad-group/abroad-group-delete.do';
        var loadUrlOut = '${basePath}/abroad-group/load-group-list-out.do';

        var totalNum = 0;
        var innerNum = 0;
        var outerNum = 0;

        var colModelIn = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'name', header: '姓名', index: 'name', sortable: true, width: 90},
            {name: 'sexName', header: '性别', index: 'sexName', sortable: false, width: 50},
            {name: 'birthdayStr', header: '出生日期', index: 'birthdayStr', hidden: true},
            {name: 'homeplace', header: '出生地', index: 'homeplace', hidden: true},
            {name: 'org', header: '工作单位', index: 'org', sortable: true},
            {name: 'duty', header: '主要职务', index: 'duty', sortable: false},
            {name: 'roleName', header: '角色', index: 'role.id', sortable: false},
            {name: 'identity', header: '对外身份', index: 'identity', sortable: false},
            {name: 'tel', header: '联系方式', index: 'tel', hidden: true},
            {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatterIn}
        ];

        function basicOperationFormatterIn(cellvalue, options, rowData, action) {
            var operations = [];

            operations.push("<div style='margin-left:5px;font-size: 20px;'>");
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view-in">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view-in"></i> 查看');
            operations.push('</button>');

            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit-in">');
            operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit-in"></i> 编辑');
            operations.push('</button>');

            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete-in">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete-in"></i> 删除');
            operations.push('</button>');

            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTableIn.tjGrid({
            loadUrl: loadUrlIn,
            height: '100%',
            autowidth: true,
            colModel: colModelIn,
            postData: {
                abroadInfoId: $abroadInfoId.val()
            },
            sortname: 'role',
            sortorder: 'asc',
            rowNum: -1,
            pgbuttons: false,
            pginput: false,
            gridComplete: function () {

                // 内部人员人数
                innerNum = $(this).jqGrid('getGridParam', 'records');
                totalNum = innerNum + outerNum;
                setTotalNum(totalNum);
                //调整表格宽度
                var parent_column = $gridTableIn.closest('[class*="col-"]');
                $gridTableIn.tjGrid("triggerResizeGrid");
                $gridTableIn.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
            },
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }

                if (className.indexOf('row-record-view-in') !== -1) {
                    var rowData = $gridTableIn.jqGrid('getRowData', id);
                    viewAbroadGroup(rowData);
                } else if (className.indexOf('row-record-delete-in') !== -1) {
                    G.confirm({
                        message: '确认删除此条成员信息吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        if (data.delLeader) {
                                            $("#groupLeader").html("");
                                        }

                                        G.showGritterSuccess("删除成功");
                                        $gridTableIn.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-edit-in') !== -1) {
                    editAbroadGroup(id);
                }
            }
        });

        // 内部人员拖拽换行
        $gridTableIn.sortableRows({
            update : function(event, ui){
                var id = $(ui.item).attr("id");
                var rowIndex = ui.item.context.rowIndex;
                updateRowIndex(id, rowIndex, "in");
            }
        });

        // 拖拽换行，更新相关记录的排序号
        function updateRowIndex(id, rowIndex, flag) {
            var updateUrl = '${basePath}/abroad-group/update-row-index.do';

            $.ajax({
                url: updateUrl,
                type: "POST",
                data: {id: id, rowIndex: rowIndex, flag: flag},
                dataType: "json",
                success: function () {

                },
                error: function () {
                    G.alert({message: "换行失败！"});
                }
            });
        }

        $gridTableIn.tjGrid("triggerResizeGrid");

        $addBtnIn.click(function () {
            $.ajax({
                url: importUrl,
                type: "GET",
                data: {abroadInfoId: $abroadInfoId.val()},
                dataType: "html",
                success: function (String) {
                    $importDialog.html(String);
                    initImportDialog($importDialog);
                },
                error: function () {
                    G.alert({message: "操作失败！"});
                }
            });
        });

        var enableImportClick = true;
        function initImportDialog($container) {
            var $form = $("#saveFormImport");

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 850,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 导入</h4></div>",
                title_html: true,
                close: function () {
                    $container.empty();
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
                            if (item_selected.length > 0) {
                                var abroadInfoId = $abroadInfoId.val();
                                var postData = {
                                    'abroadInfoId': abroadInfoId,
                                    'userIds': JSON.stringify(item_selected)
                                };
                                if (enableImportClick) {
                                    enableImportClick = false;
                                    var loadId = G.showAjaxLoading();
                                    $.ajax({
                                        url: saveImportUrl,
                                        type: 'post',
                                        dataType: 'json',
                                        data: postData,
                                        async: true
                                    }).done(function (map) {
                                        G.doneAjaxLoading(loadId);
                                        enableImportClick = true;

                                        if (map.result) {
                                            G.showGritterSuccess("导入成功！");
                                        } else {
                                            G.showGritterFail("导入失败,请稍后重试！");
                                        }
                                        $importDialog.dialog('close');
                                        $gridTableIn.tjGrid('reloadGrid');
                                    });
                                }
                            } else {
                                G.alert({message: "请先选择要导入的人员"});
                            }
                        }
                    }
                ]
            });
        }

        $addBtnOut.click(function () {
            var flag = 'out';

            editAbroadGroup(null, flag);
        });

        function editAbroadGroup(id, flag) {
            $.ajax({
                url: editUrl,
                type: "GET",
                data: {id: id, flag: flag},
                dataType: "html",
                success: function (String) {
                    $editDialog.html(String);
                    initEditDialog($editDialog, flag);
                },
                error: function () {
                    G.alert({message: "操作失败！"});
                }
            });
        }

        var enableClick = true;
        function initEditDialog($container, flag) {
            var $form = $("#saveFormGroup");

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                width: 700,
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

                            var postData = getRecord($form);
                            if (flag === 'out') {
                                postData['peopleNum'] = outerNum;
                            }
                            postAbroadGroup(postData, $form);
                        }
                    }
                ]
            });

            $form.tjValidate({
                focusInvalid: false,
                rules: {
                    name: {
                        required: true
                    },
                    sex: {
                        required: true
                    },
                    birthdayStr: {
                        required: true
                    },
                    homeplace: {
                        required: true
                    },
                    org: {
                        required: true
                    },
                    duty: {
                        required: true
                    },
                    tel: {
                        required: true
                    },
                    roleId: {
                        required: true
                    },
                },
                messages: {
                    name: {
                        required: "姓名不能为空"
                    },
                    sex: {
                        required: "性别不能为空"
                    },
                    birthdayStr: {
                        required: "出生日期不能为空"
                    },
                    homeplace: {
                        required: "出生地不能为空"
                    },
                    org: {
                        required: "工作单位不能为空"
                    },
                    duty: {
                        required: "主要职务不能为空"
                    },
                    tel: {
                        required: "联系方式不能为空"
                    },
                    roleId: {
                        required: "角色不能为空"
                    },
                }
            });
        }

        function getRecord($form) {
            var abroadInfoId = $abroadInfoId.val();
            var abroadGroupId = $form.find('#form-field-id').val();
            var name = $form.find('#form-field-name').val();
            var sex = $form.find('#form-field-sex').val();
            var birthdayStr = $form.find('#form-field-birthdayStr').val();
            var homeplace = $form.find('#form-field-homeplace').val();
            var org = $form.find('#form-field-org').val();
            var duty = $form.find('#form-field-duty').val();
            var tel = $form.find('#form-field-tel').val();
            var roleId = $form.find('#form-field-role').val();
            var identity = $form.find('#form-field-identity').val();
            var adminLevel = $form.find('#form-field-adminLevel').val();

            var records = {
                'id': abroadGroupId,
                'abroadInfoId': abroadInfoId,
                'name': name,
                'sex': sex,
                'birthdayStr': birthdayStr,
                'homeplace': homeplace,
                'org': org,
                'duty': duty,
                'tel': tel,
                'roleId': roleId,
                'identity': identity,
                'adminLevel': adminLevel
            };

            return records;
        }

        function postAbroadGroup(postData, $form) {
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
                    G.doneAjaxLoading(loadId);
                    enableClick = true;
                    if (map.result) {
                        if (map.change) {
                            $("#groupLeader").html(map.leaderName);
                        }

                        G.showGritterSuccess("保存成功！");
                        $editDialog.dialog('close');
                    } else {
                        G.showGritterFail("保存失败,请稍后重试！");
                    }
                    $gridTableIn.tjGrid('reloadGrid');
                    $gridTableOut.tjGrid('reloadGrid');
                });
            }
        }

        function viewAbroadGroup(rowData) {
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
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看成员信息</h4></div>",
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

        $exportBtnIn.unbind('click').on('click', function (e) {
            e.preventDefault();
            G.confirm({
                message: '确认导出任务批件吗？',
                callback: function (result) {
                    if (result) {
                        var data = {
                            abroadInfoId: $abroadInfoId.val()
                        };
                        exportGroupIn(data, 'all');
                    }
                }
            });
        });

        function exportGroupIn(data, type) {
            var postData = JSON.stringify(data);
            var url = '${basePath}/abroad-group/group-preview-in.do';
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: url,
                type: "GET",
                data: {data: postData, type: type},
                dataType: "html",
                success: function (String) {
                    $previewDialog.html(String);
                    G.doneAjaxLoading(loadId);
                    initPreviewDialog($previewDialog, '任务批件');
                },
                error: function (e) {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }

        function initPreviewDialog($container, fileName) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 700,
                width: 1200,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>任务批件预览</h4></div>",
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

                            $container.wordExport(fileName + '${sysDate}');
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }

        var $exportNamebookIn = $("#exportBtn-namebook-in");

        $exportNamebookIn.on('click', function (e) {
            e.preventDefault();
            var url = '${basePath}/abroad-group/group-namebook-in.do';

            G.confirm({
                message: '确认导出人员名单吗？',
                callback: function (result) {
                    if (result) {
                        var data = {
                            abroadInfoId: $abroadInfoId.val()
                        };
                        var loadId = G.showAjaxLoading();
                        $.ajax({
                            url: url,
                            type: "GET",
                            data: {data: JSON.stringify(data), type: 'all'},
                            dataType: "html",
                            success: function (String) {
                                $previewDialog.html(String);
                                G.doneAjaxLoading(loadId);
                                initPreviewDialog($previewDialog, '出国人员名单');
                            },
                            error: function (e) {
                                G.doneAjaxLoading(loadId);
                                G.alert({message: "操作失败！"});
                            }
                        });
                    }
                }
            });
        });

        var item_selected_out = [];
        var colModelOut = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'name', header: '姓名', index: 'name', sortable: true, width: 90},
            {name: 'sexName', header: '性别', index: 'sexName', sortable: false, width: 50},
            {name: 'birthdayStr', header: '出生日期', index: 'birthdayStr', hidden: true},
            {name: 'homeplace', header: '出生地', index: 'homeplace', hidden: true},
            {name: 'org', header: '工作单位', index: 'org', sortable: true},
            {name: 'duty', header: '主要职务', index: 'duty', sortable: false},
            {name: 'roleName', header: '角色', index: 'roleName', sortable: false},
            {name: 'identity', header: '对外身份', index: 'identity', sortable: false},
            {name: 'tel', header: '联系方式', index: 'tel', hidden: true},
            {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatterOut}
        ];

        function basicOperationFormatterOut(cellvalue, options, rowData, action) {
            var operations = [];

            operations.push("<div style='margin-left:5px;font-size: 20px;'>");
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view-out">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view-out"></i> 查看');
            operations.push('</button>');

            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit-out">');
            operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit-out"></i> 编辑');
            operations.push('</button>');

            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete-out">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete-out"></i> 删除');
            operations.push('</button>');

            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTableOut.tjGrid({
            loadUrl: loadUrlOut,
            height: '100%',
            autowidth: true,
            colModel: colModelOut,
            postData: {
                abroadInfoId: $abroadInfoId.val()
            },
            sortname: 'role',
            sortorder: 'asc',
            rowNum: -1,
            pgbuttons: false,
            pginput: false,
            multiselect: true,
            gridComplete: function () {
                var _this = this;
                if (item_selected_out.length > 0) {
                    for (var i = 0; i < item_selected_out.length; i++) {
                        $(_this).tjGrid('setSelection', item_selected_out[i]);
                    }
                }

                // 外部人员人数
                outerNum = $(this).jqGrid('getGridParam', 'records');
                totalNum = innerNum + outerNum;
                setTotalNum(totalNum);

                //调整表格宽度
                var parent_column = $gridTableOut.closest('[class*="col-"]');
                $gridTableOut.tjGrid("triggerResizeGrid");
                $gridTableOut.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
            },
            onSelectAll: function (aRowIds, status) {
                if (status) {
                    item_selected_out = _.union(item_selected_out, aRowIds);
                } else {
                    item_selected_out = _.difference(item_selected_out, aRowIds);
                }
            },
            beforeSelectRow: function (rowId) {
                var index = _.indexOf(item_selected_out, rowId);
                if (index == -1) {
                    item_selected_out.push(rowId);
                } else {
                    item_selected_out = _.pull(item_selected_out, rowId);
                }
            },
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }

                if (className.indexOf('row-record-view-out') !== -1) {
                    var rowData = $gridTableOut.jqGrid('getRowData', id);
                    viewAbroadGroup(rowData);
                } else if (className.indexOf('row-record-delete-out') !== -1) {
                    G.confirm({
                        message: '确认删除此条成员信息吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        G.showGritterSuccess("删除成功");
                                        $gridTableOut.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-edit-out') !== -1) {
                    var flag = 'out';
                    editAbroadGroup(id, flag);
                }
            }
        });

        // 外部人员拖拽换行
        $gridTableOut.sortableRows({
            update : function(event, ui){
                var id = $(ui.item).attr("id");
                var rowIndex = ui.item.context.rowIndex;
                updateRowIndex(id, rowIndex, "out");
            }
        });
        $gridTableOut.tjGrid("triggerResizeGrid");

        $exportBtnOut.unbind('click').on('click', function (e) {
            e.preventDefault();

            if (item_selected_out.length > 0) {
                G.confirm({
                    message: '确认导出任务通知书吗？',
                    callback: function (result) {
                        if (result) {
                            exportGroupOut(item_selected_out, 'part');
                        }
                    }
                });
            } else {
                G.alert({message: "请选择要导出任务通知书和确认件的人员"});
            }
        });

        function exportGroupOut(data, type) {
            var postData = JSON.stringify(data);
            var url = '${basePath}/abroad-group/group-preview-out.do';
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: url,
                type: "GET",
                data: {data: postData, type: type},
                dataType: "html",
                success: function (String) {
                    $previewDialog.html(String);
                    G.doneAjaxLoading(loadId);
                    initPreviewDialog($previewDialog, '通知书及确认件');
                },
                error: function (e) {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });
        }

        // 设置团组总人数
        function setTotalNum(totalNum) {
            var url = '${basePath}/abroad-info/set-totalNum.do';
            $.post(url, {totalNum: totalNum, abroadInfoId: $abroadInfoId.val()}, function (response) {
                if (response.result) {

                } else {

                }
            });
        }

        $(document).one('ajaxloadstart.page', function (e) {
            // $.jgrid.gridDestroy("#grid-table-group-in");
            // $.jgrid.gridDestroy("#grid-table-group-out");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
