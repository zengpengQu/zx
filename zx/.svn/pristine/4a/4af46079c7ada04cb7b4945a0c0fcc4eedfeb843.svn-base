<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<!-- /.page-header -->
<div class="row">
    <div class="col-xs-12">
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="addApplicationBtn">
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
                <table id="grid-table-application"></table>
            </div>
        </div>
    </div>
</div>

<div id="view-gift-application" class="hidden"></div>

<div id="edit-gift-application" class="hidden"></div>

<script type="text/javascript">

    var comeInfoId = '${comeInfoId}';

    //控件类全局变量
    var $addApplicationBtn = $("#addApplicationBtn");

    //表单类全局变量
    var $giftApplicationGrid = $("#grid-table-application");

    var $viewDialog = $("#view-gift-application");
    var $editDialog = $("#edit-gift-application");


    var loadUrl = '${basePath}/come/come-gift/load-application-list.do?comeInfoId=' + comeInfoId;
    var editUrl = '${basePath}/come/come-gift/gift-application-edit';
    var viewUrl = '${basePath}/come/come-gift/gift-application-view';
    var saveUrl = '${basePath}/come/come-gift/application-save.do';
    var deleteUrl = '${basePath}/giftApplication/load-application-delete.do';

    var colModel = [
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
            formatter: basicOperationFormatter
        }
    ];

    function styleFormatter() {
        return 'style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"';
    }

    function applicationStateFormatter(cellvalue, options, rowData, action) {

        var operations = [];
        if (cellvalue === '已接收' ) {
            operations.push("<span class='label label-success arrowed arrowed-right'>" + '已接收' + "</span>");
        }else if (cellvalue === '未接收') {
            operations.push("<span class='label label-info arrowed arrowed-right'>" + '未接收' + "</span>");
        }
        cellvalue = operations.join('');
        return cellvalue;
    }

    function basicOperationFormatter(cellvalue, options, rowData, action) {

        var operations = [];
        var status = rowData.applicationState;

        operations.push("<div style='margin-left:8px;font-size: 20px;'>");
        operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
        operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
        operations.push('</button>');
        if (status === "未接收") {
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');
        }
        if (status === "未接收") {
            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push('<i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
            operations.push('</button>');
        }
        operations.push('</div>');
        cellvalue = operations.join('');
        return cellvalue;
    }

    $giftApplicationGrid.tjGrid({
        loadUrl: loadUrl,
        height: '100%',
        maxHeight: 600,
        autowidth: true,
        colModel: colModel,
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
                viewGiftApplication(id);
            } else if (className.indexOf('row-record-delete') !== -1) {
                G.confirm({
                    message: '确认删除此条礼品申请信息吗？',
                    callback: function (result) {
                        if (result) {
                            $.post(deleteUrl, {id: id}, function (data) {
                                if (data.result) {
                                    $giftApplicationGrid.tjGrid('reloadGrid');
                                }
                            });
                        }
                    }
                });
            } else if (className.indexOf('row-record-edit') !== -1) {
                editGiftApplication(id);
            }
        },

        loadComplete: function () {
            var table = this;
            setTimeout(function () {
                updatePagerIcons(table);
                enableTooltips(table);
                hidePagerSelect(table);
            }, 0);
            $giftApplicationGrid.tjGrid("triggerResizeGrid");
        }
    });

    $giftApplicationGrid.tjGrid("triggerResizeGrid");


    $addApplicationBtn.click(function () {
       editGiftApplication();
    });


    // 查看礼品申请
    function viewGiftApplication(id) {
        var loadId = G.showAjaxLoading();
        $.ajax({
            url: viewUrl,
            type: "GET",
            data: {id: id},
            dataType: "html",
            success: function (String) {
                $viewDialog.html(String);
                G.doneAjaxLoading(loadId);
                initViewDialog($viewDialog);
            },
            error: function () {
                G.doneAjaxLoading(loadId);
                G.alert({message: "操作失败！"});
            }
        });
    }

    function initViewDialog($container) {
        $container.removeClass('hidden').dialog({
            resizable: false,
            height: 'auto',
            maxHeight: 600,
            width: 800,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看礼品申请信息</h4></div>",
            title_html: true,
            close: function () {
                $container.addClass("hidden");
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

    // 编辑礼品申请
    function editGiftApplication(id) {
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
        var $form = $container.find("#giftApplicationForm");
        var $giftsApplicationTBody = $container.find("#giftsApplicationTBody");

        $container.removeClass('hidden').dialog({
            autoOpen: true,
            resizable: false,
            height: 500,
            maxHeight: 600,
            width: 820,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 新增/编辑</h4></div>",
            title_html: true,
            close: function () {
                $container.addClass("hidden").dialog('destroy');
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
                    html: "<i class='ace-icon fa fa-check  bigger-110'></i>&nbsp; 保存",
                    "class": "btn btn-success",
                    click: function () {
                        var postData = {};
                        postData.id = $form.find('#giftApplicationId').val();
                        postData.applicationCause = $form.find('#form-field-applicationCause').val();
                        postData.comeInfoId = '${comeInfoId}';
                        postData.giftsApplicationList = getGiftList($giftsApplicationTBody);

                        postApplication(postData, $form);
                    }
                }
            ]
        });

        $form.tjValidate({
            focusInvalid: true,
            rules: {
                applicationCause: {required: true}
            },
            messages: {
                applicationCause: {required: "申请事由必须填写"}
            }
        });
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

    function postApplication(postData, $form) {

        if ($form.validate().form()) {
            if (enableClick) {
                enableClick = false;
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: saveUrl,
                    type: 'post',
                    dataType: 'json',
                    data: JSON.stringify(postData), // 表单数据
                    contentType: "application/json;charset=utf-8",
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
    }


    function reloadGrid() {
        $giftApplicationGrid.tjGrid('reloadGrid');
    }

</script>