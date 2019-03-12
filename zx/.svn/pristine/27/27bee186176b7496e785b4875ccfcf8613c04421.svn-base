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
                <div class="btn-group pull-left">
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-group-in">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        导入（内部人员）
                    </button>
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-group-out">
                        <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                        新增（外部人员）
                    </button>
                </div>
                <%--<div class="btn-group pull-right">--%>
                    <%--<button class="btn btn-info btn-sm" type="button" id="addBtn-group-in">--%>
                        <%--<span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>--%>
                        <%--任务批件--%>
                    <%--</button>--%>
                    <%--<button class="btn btn-info btn-sm" type="button" id="addBtn-group-out">--%>
                        <%--<span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>--%>
                        <%--任务通知书--%>
                    <%--</button>--%>
                <%--</div>--%>
            </div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <table id="grid-table-group"></table>
            </div>
        </div>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div id="import-dialog-group" class="hide"></div>
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
        var $addBtnOut = $("#addBtn-group-out");
        var $gridTable = $("#grid-table-group");

        var $importDialog = $("#import-dialog-group");
        var $editDialog = $("#edit-dialog-group");
        var $viewDialog = $("#view-dialog-group");

        var loadUrl = '${basePath}/abroad-group/load-group-list.do';
        var importUrl = '${basePath}/abroad-group-user/abroad-user-list.do';
        var saveImportUrl = '${basePath}/abroad-group/abroad-group-user-save.do';
        var editUrl = '${basePath}/abroad-group/load-group-edit.do';
        var saveUrl = '${basePath}/abroad-group/abroad-group-edit-save.do';
        var deleteUrl = '${basePath}/abroad-group/abroad-group-delete.do';

        var colModel = [
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
            {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatter}
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
            sortname: 'sorting',
            sortorder: 'asc',
            rowNum: -1,
            pgbuttons: false,
            pginput: false,
            multiselect: true,
            multiboxonly: true,
            gridComplete: function () {
                var _this = this;
                if (item_selected.length > 0) {
                    for (var i = 0; i < item_selected.length; i++) {
                        $(_this).tjGrid('setSelection', item_selected[i]);
                    }
                }
            },
            onSelectAll: function (aRowIds, status) {
                if (status) {
                    item_selected = _.union(item_selected, aRowIds);
                } else {
                    item_selected = _.difference(item_selected, aRowIds);
                }
            },
            beforeSelectRow: function (rowId) {
                var index = _.indexOf(item_selected, rowId);
                if (index == -1) {
                    item_selected.push(rowId);
                } else {
                    item_selected = _.pull(item_selected, rowId);
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

                if (className.indexOf('row-record-view') !== -1) {
                    var rowData = $gridTable.jqGrid('getRowData', id);
                    viewAbroadGroup(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条成员信息吗？',
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
                    editAbroadGroup(id);
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

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

        function initImportDialog($container) {
            var $form = $("#saveFormImport");

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                width: 700,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 导入</h4></div>",
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
                            if (item_selected.length > 0) {
                                G.confirm({
                                    message: '确定导入操作？',
                                    callback: function (result) {
                                        if (result) {
                                            var loadId = G.showAjaxLoading();
                                            G.doneAjaxLoading(loadId);
                                            var abroadInfoId = $abroadInfoId.val();
                                            var postData = {
                                                'abroadInfoId': abroadInfoId,
                                                'userIds': JSON.stringify(item_selected)
                                            };
                                            $.ajax({
                                                url: saveImportUrl,
                                                type: 'post',
                                                dataType: 'json',
                                                data: postData,
                                                async: true
                                            }).done(function (map) {
                                                if (map.result) {
                                                    G.showGritterSuccess("导入成功！");
                                                    $importDialog.dialog('close');
                                                } else {
                                                    G.showGritterFail("导入失败,请稍后重试！");
                                                }
                                                reloadGrid();
                                            });
                                        }
                                    }
                                });
                            }
                        }
                    }
                ]
            });
        }

        $addBtnOut.click(function () {
            editAbroadGroup();
        });

        function editAbroadGroup(id) {
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

        function initEditDialog($container) {
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
                                    identity: {
                                        required: true
                                    },
                                    sorting: {
                                        required: true
                                    }
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
                                    identity: {
                                        required: "对外身份不能为空"
                                    },
                                    sorting: {
                                        required: "排序号不能为空"
                                    }
                                }
                            });
                            var postData = getRecord($form);
                            postAbroadGroup(postData, $form);
                        }
                    }
                ]
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
            var sorting = $form.find('#form-field-sorting').val();

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
                'sorting': sorting
            };

            return records;
        }

        function postAbroadGroup(postData, $form) {
            if ($form.validate().form()) {
                G.confirm({
                    message: '确定保存操作？',
                    callback: function (result) {
                        if (result) {
                            var loadId = G.showAjaxLoading();
                            G.doneAjaxLoading(loadId);
                            postRecord(postData);
                        }
                    }
                });
            }
        }

        function postRecord(postData) {
            $.ajax({
                url: saveUrl,
                type: 'post',
                dataType: 'json',
                data: postData, // 表单数据
                async: true
            }).done(function (map) {
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
                width: 700,
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

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }


        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy("#grid-table-group");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });



    });
</script>
