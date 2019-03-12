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
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-nation">
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
                <table id="grid-table-nation"></table>
            </div>
        </div>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div id="edit-dialog-nation" class="hide"></div>
        <div id="view-dialog-nation" class="hide">
            <div class="row">
                <div class="col-xs-12">
                    <div class="profile-user-info profile-user-info-striped">

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 出访国家</div>
                            <div class="profile-info-value">
                                <span class="editable " id="nationName"></span>
                            </div>
                            <div class="profile-info-name"> 邀请单位</div>
                            <div class="profile-info-value">
                                <span class="editable " id="unitName"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 外方邀请人（外文）</div>
                            <div class="profile-info-value">
                                <span class="editable " id="foreignName"></span>
                            </div>
                            <div class="profile-info-name"> 外方邀请人（中文）</div>
                            <div class="profile-info-value">
                                <span class="editable " id="chineseName"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 过境国家</div>
                            <div class="profile-info-value">
                                <span class="editable " id="trsCountry"></span>
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

        var $addBtn = $("#addBtn-nation");

        var $gridTable = $("#grid-table-nation");
        var $editDialog = $("#edit-dialog-nation");
        var $viewDialog = $("#view-dialog-nation");

        var fd = new FormData();

        var loadUrl = '${basePath}/abroad-nation/load-nation-list.do';
        var editUrl = '${basePath}/abroad-nation/load-nation-edit.do';
        var saveUrl = '${basePath}/abroad-nation/abroad-nation-edit-save.do';
        var deleteUrl = '${basePath}/abroad-nation/abroad-nation-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'nationName', header: '出访国家', index: 'nationName', sortable: false},
            {name: 'unitName', header: '邀请单位', index: 'unitName', sortable: false},
            {name: 'foreignName', header: '外方邀请人（外文）', index: 'foreignName', hidden: true},
            {name: 'chineseName', header: '外方邀请人（中文）', index: 'chineseName', hidden: true},
            {name: 'trsCountry', header: '过境国家', index: 'trsCountry', sortable: false},
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
            operations.push(' <button title="下载" class="btn btn-minier fa fa-download btn-white btn-primary downloadAbroadNation">');
            operations.push('<i class="ace-icon downloadAbroadNation"></i> 下载');
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
                    viewAbroadNation(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条出访国家信息吗？',
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
                    editAbroadNation(id);
                } else if (className.indexOf('downloadAbroadNation') != -1) {
                    handleAbroadNation(id, '0');
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        $addBtn.click(function () {
            editAbroadNation();
        });

        function editAbroadNation(id) {
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
            var $form = $("#saveFormNation");
            //var $uploadAbroadNation = $form.find("#form-field-uploadAbroadNation");

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
                                    nationName: {
                                        required: true
                                    },
                                    unitName: {
                                        required: true
                                    },
                                    foreignName: {
                                        required: true
                                    },
                                    chineseName: {
                                        required: true
                                    }
                                },
                                messages: {
                                    nationName: {
                                        required: "出访国家不能为空"
                                    },
                                    unitName: {
                                        required: "邀请单位不能为空"
                                    },
                                    foreignName: {
                                        required: "外方邀请人（外文）不能为空"
                                    },
                                    chineseName: {
                                        required: "外方邀请人（中文）不能为空"
                                    }
                                }
                            });
                            var postData = getRecord($form);
                            postAbroadNation(postData, $form);
                        }
                    }
                ]
            });
            initChosen($container)
        }

        function getRecord($form) {
            var abroadInfoId = $abroadInfoId.val();
            var abroadNationId = $form.find('#form-field-id').val();
            var nationName = $form.find('#form-field-nationName').val();
            var unitName = $form.find('#form-field-unitName').val();
            var foreignName = $form.find('#form-field-foreignName').val();
            var chineseName = $form.find('#form-field-chineseName').val();
            var trsCountry = $form.find('#form-field-trsCountry').val();

            var records = {
                'id': abroadNationId,
                'abroadInfoId': abroadInfoId,
                'nationName': nationName,
                'unitName': unitName,
                'foreignName': foreignName,
                'chineseName': chineseName,
                'trsCountry': trsCountry
            };

            return records;
        }

        function postAbroadNation(postData, $form) {
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

        function initChosen($container) {
            $container.find('.chosen-select').chosen({
                allow_single_deselect: true,
            }).trigger('resize.chosen');

            //resize the chosen on window resize
            $(window)
            .off('resize.chosen')
            .on('resize.chosen', function() {
                $('.chosen-select').each(function() {
                    var $this = $(this);
                    $this.next().css({'width': $this.parent().width()});
                })
            }).trigger('resize.chosen');

            //resize chosen on sidebar collapse/expand
            $(document).on('settings.ace.chosen', function(e, event_name, event_val) {
                if(event_name != 'sidebar_collapsed') return;
                $container.find('.chosen-select').each(function() {
                    var $this = $(this);
                    $this.next().css({'width': $this.parent().width()});
                })
            });

            var $nationId = $container.find("#form-field-nationId");
            var $nationName = $container.find("#form-field-nationName");

            $nationId.change(function () {
                var nationName =  $nationId.find("option:selected").text();
                $nationName.val(nationName)
            });
        }

        function viewAbroadNation(rowData) {
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
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看出访国家信息</h4></div>",
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
            // $.jgrid.gridDestroy("#grid-table-nation");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>