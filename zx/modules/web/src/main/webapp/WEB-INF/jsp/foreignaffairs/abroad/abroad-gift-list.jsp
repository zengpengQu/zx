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

        <h4 class="smaller header lighter blue"
            style="margin-top: 0px;margin-bottom:10px ">
            <i class="ace-icon fa fa-list"></i>
            礼品申请
        </h4>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-gift-app">
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
                <table id="grid-table-gift-app"></table>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div id="edit-dialog-gift-app" class="hide"></div>
                <div id="view-dialog-gift-app" class="hide"></div>
            </div>
        </div>

        <div class="row">
            <div class="space-20"></div>
        </div>

        <h4 class="smaller header lighter blue"
            style="margin-top: 0px;margin-bottom:10px ">
            <i class="ace-icon fa fa-list"></i>
            礼品赠送
        </h4>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="addBtn-gift-pre">
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
                <table id="grid-table-gift-pre"></table>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div id="edit-dialog-gift-pre" class="hide"></div>
                <div id="view-dialog-gift-pre" class="hide">
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="profile-user-info profile-user-info-striped">

                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 出访国家</div>
                                    <div class="profile-info-value">
                                        <span class="editable " id="nation"></span>
                                    </div>
                                    <div class="profile-info-name"> 赠礼方</div>
                                    <div class="profile-info-value">
                                        <span class="editable " id="giver"></span>
                                    </div>
                                </div>

                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 受赠方</div>
                                    <div class="profile-info-value">
                                        <span class="editable " id="donee"></span>
                                    </div>
                                    <div class="profile-info-name"> 赠送礼品</div>
                                    <div class="profile-info-value">
                                        <span class="editable " id="gifts"></span>
                                    </div>
                                </div>

                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 对方回赠</div>
                                    <div class="profile-info-value">
                                        <span class="editable " id="giftsReturn"></span>
                                    </div>
                                    <div class="profile-info-name"> 剩余礼品</div>
                                    <div class="profile-info-value">
                                        <span class="editable " id="giftsRemain"></span>
                                    </div>
                                </div>

                                <div class="profile-info-row">
                                    <div class="profile-info-name"> 备注信息</div>
                                    <div class="profile-info-value">
                                        <span class="editable " id="notes"></span>
                                    </div>
                                </div>

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

        var $addBtnPre = $("#addBtn-gift-pre");

        var $gridTablePre = $("#grid-table-gift-pre");
        var $editDialogPre = $("#edit-dialog-gift-pre");
        var $viewDialogPre = $("#view-dialog-gift-pre");

        var loadUrlPre = '${basePath}/abroad-gift-pre/load-gift-pre-list.do';
        var editUrlPre = '${basePath}/abroad-gift-pre/load-gift-pre-edit.do';
        var saveUrlPre = '${basePath}/abroad-gift-pre/gift-pre-edit-save.do';
        var deleteUrlPre = '${basePath}/abroad-gift-pre/gift-pre-delete.do';

        var colModelPre = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'nation', header: '出访国家', index: 'nation', sortable: false},
            {name: 'giver', header: '赠礼方', index: 'giver', sortable: false},
            {name: 'donee', header: '受赠方', index: 'donee', sortable: false},
            {name: 'gifts', header: '赠送礼品', index: 'gifts', sortable: false},
            {name: 'giftsReturn', header: '对方回赠', index: 'giftsReturn', hidden: true},
            {name: 'giftsRemain', header: '剩余礼品', index: 'giftsRemain', hidden: true},
            {name: 'notes', header: '备注信息', index: 'notes', hidden: true},
            {name: 'basic', header: '基本操作', sortable: false, width: 200, fixed: true, formatter: basicOperationFormatterPre}
        ];

        function basicOperationFormatterPre(cellvalue, options, rowData, action) {
            var operations = [];

            operations.push("<div style='margin-left:5px;font-size: 20px;'>");
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view-pre">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view-pre"></i> 查看');
            operations.push('</button>');

            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit-pre">');
            operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit-pre"></i> 编辑');
            operations.push('</button>');

            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete-pre">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete-pre"></i> 删除');
            operations.push('</button>');

            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTablePre.tjGrid({
            loadUrl: loadUrlPre,
            height: '100%',
            autowidth: true,
            colModel: colModelPre,
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

                if (className.indexOf('row-record-view-pre') !== -1) {
                    var rowData = $gridTablePre.jqGrid('getRowData', id);
                    viewGiftPre(rowData);
                } else if (className.indexOf('row-record-delete-pre') !== -1) {
                    G.confirm({
                        message: '确认删除此条赠送记录吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrlPre, {id: id}, function (data) {
                                    if (data.result) {
                                        G.showGritterSuccess("删除成功");
                                        $gridTablePre.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-edit-pre') !== -1) {
                    editGiftPre(id);
                }
            },

            loadComplete: function () {
                var table = this;
                setTimeout(function () {
                    updatePagerIcons(table);
                    enableTooltips(table);
                    hidePagerSelect(table);
                }, 0);
                $gridTablePre.tjGrid("triggerResizeGrid");
            }
        });

        $gridTablePre.tjGrid("triggerResizeGrid");

        $addBtnPre.click(function () {
            editGiftPre();
        });

        function editGiftPre(id) {
            $.ajax({
                url: editUrlPre,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $editDialogPre.html(String);
                    initEditDialogPre($editDialogPre);
                },
                error: function () {
                    G.alert({message: "操作失败！"});
                }
            });
        }

        var enableClick = true;
        function initEditDialogPre($container) {
            var $form = $("#saveFormPre");

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 新增/编辑</h4></div>",
                title_html: true,
                close: function () {
                    $form.tjValidate('resetForm');
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

                            var postData = getRecordPre($form);
                            postGiftPre(postData, $form);
                        }
                    }
                ]
            });

            $form.tjValidate({
                focusInvalid: false,
                rules: {
                    nation: {
                        required: true
                    },
                    giver: {
                        required: true
                    },
                    donee: {
                        required: true
                    },
                    gifts: {
                        required: true
                    }
                },
                messages: {
                    nation: {
                        required: "出访国家不能为空"
                    },
                    giver: {
                        required: "赠礼方不能为空"
                    },
                    donee: {
                        required: "受赠方不能为空"
                    },
                    gifts: {
                        required: "赠送礼品不能为空"
                    }
                }
            });
        }

        function getRecordPre($form) {
            var abroadInfoId = $abroadInfoId.val();
            var id = $form.find('#form-field-pre-id').val();
            var nation = $form.find('#form-field-nation').val();
            var giver = $form.find('#form-field-giver').val();
            var donee = $form.find('#form-field-donee').val();
            var gifts = $form.find('#form-field-gifts').val();
            var giftsReturn = $form.find('#form-field-giftsReturn').val();
            var giftsRemain = $form.find('#form-field-giftsRemain').val();
            var notes = $form.find('#form-field-notes').val();

            var records = {
                'id': id,
                'abroadInfoId': abroadInfoId,
                'nation': nation,
                'giver': giver,
                'donee': donee,
                'gifts': gifts,
                'giftsReturn': giftsReturn,
                'giftsRemain': giftsRemain,
                'notes': notes
            };

            return records;
        }

        function postGiftPre(postData, $form) {
            if ($form.validate().form()) {
                postRecordPre(postData);
            }
        }

        function postRecordPre(postData) {
            if (enableClick) {
                enableClick = false;
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: saveUrlPre,
                    type: 'post',
                    dataType: 'json',
                    data: postData,
                    async: true
                }).done(function (map) {
                    G.doneAjaxLoading(loadId);
                    if (map.result) {
                        G.showGritterSuccess("保存成功！");
                        enableClick = true;
                        $editDialogPre.dialog("close");
                    } else {
                        G.showGritterFail("保存失败,请稍后重试！");
                        enableClick = true;
                    }
                    $gridTablePre.tjGrid('reloadGrid');
                });
            }
        }

        function viewGiftPre(rowData) {
            $viewDialogPre.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });
            initViewDialogPre($viewDialogPre);
        }

        function initViewDialogPre($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看礼品赠送</h4></div>",
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



        var $addBtnApp = $("#addBtn-gift-app");

        var $gridTableApp = $("#grid-table-gift-app");
        var $editDialogApp = $("#edit-dialog-gift-app");
        var $viewDialogApp = $("#view-dialog-gift-app");

        var loadUrlApp = '${basePath}/abroad-gift-app/load-gift-app-list.do';
        var editUrlApp = '${basePath}/abroad-gift-app/load-gift-app-edit.do';
        var saveUrlApp = '${basePath}/abroad-gift-app/gift-app-edit-save.do';
        var deleteUrlApp = '${basePath}/abroad-gift-app/gift-app-delete.do';
        var viewUrlApp = '${basePath}/abroad-gift-app/gift-app-view.do';

        var colModelApp = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'applicationCode', header: '申请单编码', index: 'applicationCode', sortable: false},
            {name: 'activityName', header: '活动名称', index: 'activityName', sortable: false},
            {name: 'applicationState', header: '申请状态', index: 'applicationState', sortable: false,
                align: 'center', formatter: applicationStateFormatter},
            {name: 'applicationPerson', header: '申请人', index: 'applicationPerson', sortable: false},
            {name: 'applicationTime', header: '申请时间', index: 'applicationTime', sortable: false},
            {name: 'applicationCause', header: '申请事由', index: 'applicationCause', sortable: false, cellattr: styleFormatter},
            {name: 'applicationType', header: '活动类型',hidden: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatterApp
            }
        ];
        function styleFormatter() {
            return 'style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"';
        }

        function applicationStateFormatter(cellvalue, options, rowData, action) {
            var applicationState = rowData.applicationState;
            var operations = [];
            if (applicationState === '已接收' ) {
                operations.push("<span class='label label-success arrowed arrowed-right'>" + '已接收' + "</span>");
            }else if (applicationState === '未接收') {
                operations.push("<span class='label label-info arrowed arrowed-right'>" + '未接收' + "</span>");
            }
            cellvalue = operations.join('');
            return cellvalue;
        }

        function basicOperationFormatterApp(cellvalue, options, rowData, action) {
            var applicationState = rowData.applicationState;
            var operations = [];

            operations.push("<div style='margin-left:5px;font-size: 20px;'>");
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view-app">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view-app"></i> 查看');
            operations.push('</button>');

            if (applicationState === '未接收'){
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit-app">');
                operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit-app"></i> 编辑');
                operations.push('</button>');
            }

            if (applicationState === '未接收') {
                operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete-app">');
                operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete-app"></i> 删除');
                operations.push('</button>');
            }

            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTableApp.tjGrid({
            loadUrl: loadUrlApp,
            height: '100%',
            maxHeight: 600,
            autowidth: true,
            colModel: colModelApp,
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

                if (className.indexOf('row-record-view-app') !== -1) {
                    viewGiftApp(id);
                } else if (className.indexOf('row-record-delete-app') !== -1) {
                    G.confirm({
                        message: '确认删除此条申请记录吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrlApp, {id: id}, function (data) {
                                    if (data.result) {
                                        G.showGritterSuccess("删除成功");
                                        $gridTableApp.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-edit-app') !== -1) {
                    editGiftApp(id);
                }
            }
        });

        $gridTableApp.tjGrid("triggerResizeGrid");

        $addBtnApp.click(function () {
            editGiftApp();
        });

        function editGiftApp(id) {
            $.ajax({
                url: editUrlApp,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $editDialogApp.html(String);
                    initEditDialogApp($editDialogApp);
                },
                error: function () {
                    G.alert({message: "操作失败！"});
                }
            });
        }

        var enableAppClick = true;
        function initEditDialogApp($container) {
            var $form = $container.find("#giftApplicationForm");
            var $giftsApplicationTBody = $container.find("#giftsApplicationTBody");

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 500,
                maxHeight: 600,
                width: 820,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 礼品申请新增/编辑</h4></div>",
                title_html: true,
                close: function () {
                    $container.addClass("hide").dialog('destroy');
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning commitBtn",
                        click: function () {
                            console.log($container.height());
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check  bigger-110'></i>&nbsp; 保存",
                        "class": "btn btn-success",
                        click: function () {
                            var postData = {};
                            postData.id = $form.find('#giftApplicationId').val();
                            postData.applicationCause = $form.find('#form-field-applicationCause').val();
                            postData.abroadInfoId = $abroadInfoId.val();
                            postData.giftsApplicationList = getGiftList($giftsApplicationTBody);
                            postGiftApp(postData, $form);
                        }
                    }
                ]
            });

            $form.tjValidate({
                focusInvalid: false,
                rules: {
                    applicationCause: {
                        required: true
                    }
                },
                messages: {
                    applicationCause: {
                        required: "申请事由不能为空"
                    }
                }
            });
        }

        function postGiftApp(postData, $form) {
            if ($form.validate().form()) {
                postRecordApp(postData);
            }
        }

        function getGiftList($tbody) {
            var giftList = [];

            var $tr = $tbody.find("tr[class='giftsApplicationTr']");
            $.each( $tr, function(_, row) {
                var data = {};
                $.each($(row).find(':input'), function () {
                    data[this.name] = $(this).val();
                });

                giftList.push(data);
            });

            return giftList;
        }

        function postRecordApp(postData) {
            if (enableAppClick) {
                enableAppClick = false;
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: saveUrlApp,
                    type: 'post',
                    dataType: 'json',
                    data: JSON.stringify(postData),
                    contentType: "application/json;charset=utf-8",
                    async: true
                }).done(function (map) {
                    G.doneAjaxLoading(loadId);
                    enableAppClick = true;

                    if (map.result == true) {
                        G.showGritterSuccess("保存成功!");
                        $editDialogApp.dialog('close');
                    } else if (map.result == 'empty') {
                        G.showGritterFail("请添加礼品!");
                    } else {
                        G.showGritterFail("保存失败!");
                    }
                    $gridTableApp.tjGrid('reloadGrid');
                });
            }
        }

        function viewGiftApp(id) {
            $.ajax({
                url: viewUrlApp,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $viewDialogApp.html(String);
                    initViewDialogApp($viewDialogApp);
                },
                error: function () {
                    G.alert({message: "操作失败！"});
                }
            });
        }

        function initViewDialogApp($container) {
            var $form = $("#viewFormApp");
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 查看</h4></div>",
                title_html: true,
                close: function () {
                    $form.resetForm();
                    $('.ace-file-name').attr('data-title', ' ... ');
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

        $(document).one('ajaxloadstart.page', function (e) {
            // $.jgrid.gridDestroy('#grid-table-gift-pre');
            // $.jgrid.gridDestroy('#grid-table-gift-app');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
