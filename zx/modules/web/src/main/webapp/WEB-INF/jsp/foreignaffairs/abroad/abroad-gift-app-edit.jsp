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
        <div style="margin-top: 20px">
            <div class="widget-body">
                <div class="widget-main padding-8" style="height: 300px">
                    <form class="form-horizontal" id="giftApplicationForm" role="form" method="post">
                        <input id="giftApplicationId" name="id" type="hidden" value="${giftApplication.id}">

                        <div class="row">
                            <div class="space-10"></div>
                        </div>


                        <div class="row">
                            <div class="col-xs-12 ">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label" for="form-field-applicationCause">申请事由：
                                        <span class="required">*</span></label>

                                    <div class="col-sm-10 ">
                        <textarea class="form-control limited" id="form-field-applicationCause"
                                  name="applicationCause" maxlength="500" style="min-height: 100px;"
                                  placeholder="申请事由">${giftApplication.applicationCause}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12 ">
                                <label class="col-xs-2 control-label">礼品清单：</label>
                                <div class="row">
                                    <div class="col-xs-10 pull-right">
                                        <table id="gift-list-table" class="table table-bordered table-hover">
                                            <thead>
                                            <tr>
                                                <th class="center" style="width:20%;">编码</th>
                                                <th class="center" style="width:40%;">名称</th>
                                                <th class="center" style="width:10%;">数量</th>
                                                <th class="center" style="width:15%;">操作</th>
                                            </tr>
                                            </thead>
                                            <tbody id="giftsApplicationTBody">
                                            <c:if test="${giftApplication.id ne null}">
                                                <c:forEach items="${giftsApplicationList}" var="giftsApplication">
                                                    <tr class="giftsApplicationTr"
                                                        data-item={"id":"${giftsApplication.id}"}>
                                                        <td class="hidden"><input name="id" value="${giftsApplication.id}"/></td>
                                                        <td class="hidden"><input type="text" name="giftInfoId" title="礼品Id" value="${giftsApplication.giftInfoId}" readonly/></td>
                                                        <td class="center"><input type="text" name="giftCode" title="编码" value="${giftsApplication.giftCode}" readonly/></td>
                                                        <td class="center"><input type="text" name="giftName" title="名称" value="${giftsApplication.giftName}" readonly/></td>
                                                        <td class="center"><input type="number" name="giftCount" min="0" title="数量" value="${giftsApplication.giftCount}"/></td>
                                                        <td class="center"><i
                                                                class="ace-icon red fa fa-trash-o row-record-delete"
                                                                style="cursor: pointer;" title="删除">删除</i></td>
                                                    </tr>
                                                </c:forEach>
                                            </c:if>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="pull-right">
                                    <button class="btn btn-sm btn-primary" type="button" id="addGiftsApplicationBtn">
                                        增行
                                    </button>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<div id="giftChooseDialog" class="hidden">
    <div class="row">
        <div class="col-xs-12 jqgrid_box">
            <div class="row">
                <div class="col-xs-12">
                    <table id="gift-choose-grid-table"></table>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-12">
                    <form id="giftsApplicationForm" class="form-horizontal" role="form">
                        <div class="row">
                            <div class="hidden">
                                <input type="text" id="id" name="id"/>
                                <input type="text" id="giftInfoId" name="giftInfoId"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="space-10"></div>
                        </div>

                        <div class="row">
                            <div class="col-xs-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label text-right">编码：<span class="required">*</span></label>
                                    <div class="col-sm-8 ">
                                        <input type="text" id="form-field-giftCode" name="giftCode" readonly
                                               class="form-control " placeholder="编码"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="space-10"></div>
                        </div>

                        <div class="row">
                            <div class="col-xs-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label text-right">名称：<span class="required">*</span></label>
                                    <div class="col-sm-8 ">
                                        <input type="text" id="form-field-giftName" name="giftName" readonly
                                               class="form-control " placeholder="名称"/>
                                    </div>
                                </div>
                            </div>
                            <div class="col-xs-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label text-right">数量：<span class="required">*</span></label>
                                    <div class="col-sm-8 ">
                                        <input type="number" id="form-field-giftCount" name="giftCount" min="0"
                                               class="form-control " placeholder="数量"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    var $giftsApplicationTable = $("#gift-list-table");
    var $giftsApplicationTBody = $("#giftsApplicationTBody");
    var $addGiftsApplicationBtn = $("#addGiftsApplicationBtn");

    var $giftChooseDialog = $("#giftChooseDialog");
    var $giftChooseGridTable = $("#gift-choose-grid-table");

    $addGiftsApplicationBtn.on('click', function (e) {
        e.preventDefault();

        initChooseDialog($giftChooseDialog);
    });

    function initChooseDialog($container) {

        var $form = $container.find("#giftsApplicationForm");
        initChooseGiftGridTable($giftChooseGridTable);

        $container.removeClass('hidden').dialog({
            autoOpen: true,
            resizable: false,
            maxHeight: 650,
            width: 820,
            modal: true,
            title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-book green'></i>礼品清单</div>",
            title_html: true,
            position: { my: "top-100%", at: "center", of: window },
            close: function () {
                $container.addClass('hidden').dialog('destroy');
                if ($.fn.jqGrid["GridUnload"] === undefined) {
                    $.fn.jqGrid["GridUnload"] = $.jgrid.gridUnload;
                }
                $giftChooseGridTable.jqGrid('GridUnload');
            },
            buttons: [
                {
                    html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                    "class": "btn",
                    click: function () {
                        $(this).dialog("close");
                    }
                },
                {
                    html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 添加",
                    "class": "btn btn-success",
                    click: function () {
                        if ($form.validate().form()) {
                            appendGift($form, $giftsApplicationTBody);

                            $(this).dialog("close");
                        }
                    }
                }
            ]
        });


        $giftChooseGridTable.setGridWidth($container.find('.jqgrid_box').width());
        $giftChooseGridTable.tjGrid('triggerResizeGrid');

        $form.tjValidate({
            focusInvalid: true,
            rules: {
                giftName: {required: true},
                giftCount: {required: true}
            },
            messages: {
                giftName: {required: "礼品名称不能为空"},
                giftCount: {required: "礼品数量不能为空"}
            }
        });
    }

    // 在礼品清单中添加选择的礼品
    function appendGift($form, $dest) {
        var html = [];

        html.push('<tr class="giftsApplicationTr" data-item ="{{json}}">');
        html.push('<td class="hidden"><input name="id"/></td>');
        html.push('<td class="hidden"><input type="text" name="giftInfoId" title="礼品id" value="{{giftInfoId}}" readonly/></td>');
        html.push('<td class="center"><input type="text" name="giftCode" title="编码" value="{{giftCode}}" readonly/></td>');
        html.push('<td class="center"><input type="text" name="giftName" title="名称" value="{{giftName}}" readonly/></td>');
        html.push('<td class="center"><input type="number" name="giftCount" min="0" value="{{giftCount}}"/></td>');
        html.push('<td class="center"><i class="ace-icon red fa fa-trash-o row-record-delete" style="cursor: pointer;" title="删除">删除</i></td>');
        html.push('</tr>');

        var data = $form.serializeObject();
        data.json = JSON.stringify(data);
        var temp = Handlebars.compile(html.join(''));
        var view = temp(data);
        $dest.append(view);
    }

    // 删除一行礼品
    $giftsApplicationTable.on('click', '.row-record-delete', function (e) {
        e.preventDefault();

        deleteGiftsApplicationData(e);
    });

    function deleteGiftsApplicationData(e) {
        var id = $(e.target).closest('tr').data('item').id;
        var deleteUrl = '';

        if (!_.isEmpty(id)) {

            deleteUrl = '${basePath}/abroad-gift-app/gifts-application-delete.do';
            deleteByUrl(e, deleteUrl, id);
        } else {
            $(e.target).closest('tr').remove();
        }
    }


    /************ 选择礼品弹窗 ************/
    var loadGiftChoiceListUrl = '${basePath}/giftStore/load-giftStoreInfo-list.do';

    var colModel = [
        {name: 'id', index: 'id', hidden: true},
        {name: 'giftCode', header: '礼品编码', index: 'giftCode', hidden: false, sortable: true},
        {name: 'giftName', header: '礼品名称', index: 'giftName', width: 100, sortable: true},
        {name: 'giftType', header: '礼品类型', index: 'giftType', sortable: true},
        // {name: 'giftState', header: '库存状态', index: 'giftState', sortable: true},
        {name: 'giftCount', header: '数量', index: 'giftCount', sortable: true},
        {
            name: 'basic',
            header: '基本操作',
            sortable: false,
            width: 100,
            fixed: true,
            formatter: basicOperationFormatter
        }
    ];

    function basicOperationFormatter(cellvalue, options, rowData, action) {
        var operations = [];
        operations.push("<div style='margin-left:8px;font-size: 20px;'>");
        operations.push(' <button title="选择" class="btn btn-minier btn-white btn-purple row-record-edit">');
        operations.push('<i class="ace-icon fa fa-check blue row-record-edit"></i> 选择');
        operations.push('</button>');
        operations.push("</div>");
        cellvalue = operations.join('');
        return cellvalue;
    }

    function initChooseGiftGridTable($gridTable) {
        $gridTable.tjGrid({
            loadUrl: loadGiftChoiceListUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            onSelectRow: function (id, stat, e) {
                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                if (className.indexOf('row-record-edit') !== -1) {
                    chooseGift(id);
                }
            },
            loadComplete: function () {
                var table = this;
                setTimeout(function () {
                    updatePagerIcons(table);
                    enableTooltips(table);
                    hidePagerSelect(table);
                }, 0);

                $gridTable.tjGrid('triggerResizeGrid');
            }
        });
    }

    $giftChooseGridTable.tjGrid('triggerResizeGrid');

    function chooseGift(id) {
        var $giftsApplicationForm = $("#giftsApplicationForm");

        var rowData = $giftChooseGridTable.jqGrid('getRowData', id);

        var giftInfoId = rowData.id;
        var giftCode = rowData.giftCode;
        var giftName = rowData.giftName;
        var giftCount = 1;

        $giftsApplicationForm.find('#giftInfoId').val(giftInfoId);
        $giftsApplicationForm.find('#form-field-giftCode').val(giftCode);
        $giftsApplicationForm.find('#form-field-giftName').val(giftName);
        $giftsApplicationForm.find('#form-field-giftCount').val(giftCount);
    }

    //删除方法
    function deleteByUrl(e, url, id) {

        G.confirm({
            message: '确认删除此条礼品吗？',
            callback: function (result) {
                if (result) {
                    $.post(
                        url,
                        {id: id},
                        function (data) {
                            if (data.result) {
                                G.showGritterSuccess("删除成功！");
                                $(e.target).closest('tr').remove();
                            } else {
                                G.showGritterFail("删除失败！")
                            }
                        });
                }
            }
        });
    }

</script>