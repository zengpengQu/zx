<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/8/8
  Time: 16:35
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

<div class="row">
    <div class="col-xs-12">
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="hidden">
                    <input type="text" id="form-field-comeInfoId" value="${comeInfoId}"/>
                </div>
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="addGiftRecvBtn">
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
                <table id="grid-table-giftRecv"></table>
            </div>
        </div>
    </div>
</div>


<div id="edit-gift-recv" class="hide">
    <div class="row" style="margin-top: 20px">
        <div class="col-xs-12">
            <form class="form-horizontal" id="gift-recv-form" role="form">
                <input class="hide editable" type="text" name="id"/>
                <input class="hide editable" type="text" name="comeInfoId"/>

                <div class="row" style="margin-top: 15px">
                    <div class="col-xs-6">
                        <div class="form-group">

                            <label class="col-sm-4 control-label" for="form-field-giftName">礼品名称：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable" id="form-field-giftName" type="text" name="giftName"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6">
                        <div class="form-group">

                            <label class="col-sm-4 control-label" for="form-field-giftNum">礼品数量：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable" id="form-field-giftNum" type="text" name="num"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row" style="margin-top: 15px">

                    <div class="col-xs-6">
                        <div class="form-group">

                            <label class="col-sm-4 control-label" for="form-field-giver">赠礼人：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable" id="form-field-giver" type="text" name="giver"/>
                            </div>
                        </div>
                    </div>

                    <div class="col-xs-6">
                        <div class="form-group">

                            <label class="col-sm-4 control-label" for="form-field-receiver">受礼人：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable date-picker" id="form-field-receiver" type="text" name="receiver"/>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row" style="margin-top: 15px">

                    <div class="col-xs-6">
                        <div class="form-group">

                            <label class="col-sm-4 control-label" for="form-field-mainDuty">受礼人职务：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-8">
                                <input class="form-control editable" id="form-field-mainDuty" type="text" name="mainDuty"/>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="row" style="margin-top: 15px">

                    <div class="col-xs-12">
                        <div class="form-group">

                            <label class="col-sm-2 control-label" for="form-field-processOpinion">处理意见：<span
                                    class="red">*</span>
                            </label>

                            <div class="col-sm-10">
                                    <textarea class="form-control limited editable"
                                              id="form-field-processOpinion"
                                              name="processOpinion"
                                              style="min-height: 100px;"></textarea>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </div>
    </div>
</div>

<div id="view-gift-recv" class="hide">
    <div class="row">
        <div class="col-xs-12">

            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 礼品名称</div>
                    <div class="profile-info-value">
                        <span class="editable " name="giftName"></span>
                    </div>

                    <div class="profile-info-name"> 礼品数量</div>
                    <div class="profile-info-value">
                        <span class="editable " name="num"></span>
                    </div>
                </div>


                <div class="profile-info-row">
                    <div class="profile-info-name"> 赠礼人</div>
                    <div class="profile-info-value">
                        <span class="editable " name="giver"></span>
                    </div>

                    <div class="profile-info-name"> 受礼人</div>
                    <div class="profile-info-value">
                        <span class="editable " name="receiver"></span>
                    </div>
                </div>


                <div class="profile-info-row">
                    <div class="profile-info-name"> 受礼人主要职务</div>
                    <div class="profile-info-value">
                        <span class="editable " name="mainDuty"></span>
                    </div>
                </div>
            </div>

            <div class="profile-user-info profile-user-info-striped" style="border-top: none">

                <div class="profile-info-row">
                    <div class="profile-info-name"> 处理意见</div>
                    <div class="profile-info-value">
                        <span class="editable " name="processOpinion"
                        style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    var $comeInfoId = $("#form-field-comeInfoId");

    //控件类全局变量
    var $addGiftRecvBtn = $("#addGiftRecvBtn");

    //表单类全局变量
    var $giftgiftRecvGrid = $("#grid-table-giftRecv");

    var $viewGiftRecvDialog = $("#view-gift-recv");
    var $editGiftRecvDialog = $("#edit-gift-recv");


    var loadRecvUrl = '${basePath}/come/come-gift-recv/load-giftRecv-list.do';
    var editRecvUrl = '${basePath}/come/come-gift/gift-giftRecv-edit';
    var viewRecvUrl = '${basePath}/come/come-gift/gift-giftRecv-view';
    var saveRecvUrl = '${basePath}/come/come-gift/giftRecv-save.do';
    var deleteRecvUrl = '${basePath}/come/come-gift-recv/giftRecv-delete.do';

    var colModel = [
        {name: 'id', index: 'id', hidden: true},
        {name: 'updateTime', index: 'updateTime', hidden: true},
        {name: 'giftName', header: '礼品名称', index: 'giftName', sortable: false},
        {name: 'num', header: '礼品数量', index: 'num', sortable: false},
        {name: 'giver', header: '赠礼人', index: 'giver', sortable: false},
        {name: 'receiver', header: '受礼人', index: 'receiver', sortable: false},
        {name: 'mainDuty', header: '受礼人主要职务', index: 'mainDuty', sortable: false},
        {name: 'processOpinion', header: '处理意见', index: 'processOpinion', sortable: false, cellattr: styleFormatter},
        {
            name: 'basic',
            header: '基本操作',
            sortable: false,
            width: 220,
            fixed: true,
            formatter: basicOperationFormatter
        }];

    function styleFormatter() {
        return 'style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"';
    }

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
        operations.push('<i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
        operations.push('</button>');

        operations.push("</div>");
        cellvalue = operations.join('');
        return cellvalue;
    }


    $giftgiftRecvGrid.tjGrid({
        loadUrl: loadRecvUrl,
        height: '100%',
        autowidth: true,
        colModel: colModel,
        postData: {
            comeInfoId: $comeInfoId.val()
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
            var rowData = $giftgiftRecvGrid.jqGrid('getRowData', id);

            if (className.indexOf('row-record-view') !== -1) {
                viewReceive(rowData);
            } else if (className.indexOf('row-record-delete') !== -1) {
                G.confirm({
                    message: '确认删除此条礼品信息吗？',
                    callback: function (result) {
                        if (result) {
                            $.post(deleteRecvUrl, {id: id}, function (data) {
                                if (data.result) {
                                    G.showGritterSuccess("删除成功");
                                    $giftgiftRecvGrid.tjGrid('reloadGrid');
                                }
                            });
                        }
                    }
                });
            } else if (className.indexOf('row-record-edit') !== -1) {
                editReceiveRow(rowData, $editGiftRecvDialog);
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

    $giftgiftRecvGrid.tjGrid("triggerResizeGrid");

    // 新增礼品受赠信息
    $addGiftRecvBtn.unbind('click').bind('click', function (e) {
        e.preventDefault();
        giftRecvDialog($editGiftRecvDialog);
    });

    // 编辑礼品受赠信息
    function editReceiveRow(rowData, $dialog) {
        var $form = $dialog.find('#gift-recv-form');
        $form.find('.editable').each(function () {
            $(this).val(rowData[$(this).attr('name')]);
        });

        giftRecvDialog($dialog)
    }

    var enableClick = true;
    // 礼品受赠信息弹窗
    function giftRecvDialog($dialog) {

        var $form = $dialog.find('#gift-recv-form');
        var saveRowUrl = '${basePath}/come/come-gift-recv/add-gift-recv-row.do';

        $dialog.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            width: 800,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller' style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>新增/编辑礼品受赠信息</h4></div>",
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
                        if ($form.validate().form()) {
                            var data = $form.serializeObject();
                            data['comeInfo.id'] = $comeInfoId.val();

                            if (enableClick) {
                                enableClick = false;
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
                                        $giftgiftRecvGrid.tjGrid('reloadGrid');
                                        $dialog.dialog('close');
                                    } else {
                                        G.showGritterFail("操作失败,请稍后重试！");
                                    }
                                });
                            }

                        }
                    }
                }
            ]
        });

        $form.tjValidate({
            focusInvalid: true,
            rules: {
                content: {required: true},
                beginTimeStr: {required: true},
                endTimeStr: {required: true}
            },
            messages: {
                content: {required: "内容不能为空"},
                beginTimeStr: {required: "开始时间不能为空"},
                endTimeStr: {required: "结束时间不能为空"}
            }
        });
    }

    // 查看礼品受赠信息
    function viewReceive(rowData) {
        $viewGiftRecvDialog.find('.editable').each(function () {
            $(this).html(rowData[$(this).attr('name')]);
        });

        initViewDialog($viewGiftRecvDialog);
    }

    // 查看礼品受赠弹窗
    function initViewDialog($container) {
        $container.removeClass('hide').dialog({
            resizable: false,
            height: 'auto',
            maxHeight: 600,
            width: 800,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看礼品受赠信息</h4></div>",
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