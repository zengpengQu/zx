<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/7/4
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>

<div class="row">
    <div class="col-sm-10 col-sm-offset-1">
        <div class="hidden">
            <input type="text" id="giftOutOrInId" name="giftOutOrInId" value="${giftOutOrIn.id}"/>
        </div>
        <div style="border-bottom: 0px;margin-top: 20px;margin-bottom: 20px;padding-left: 10px;">
            <h4 class="widget-title" style="font-weight: bold; color: #00b3ee">
                <i class="ace-icon fa fa-leaf green"></i>
                礼品入库单信息查看
            </h4>
        </div>
        <div class="profile-user-info profile-user-info-striped">
            <div class="profile-info-row">
                <div class="profile-info-name"> 活动类型：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftOutOrIn.activityType}</span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 活动名称：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftOutOrIn.activityName}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 申请人：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftOutOrIn.applicationPerson}</span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 库存状态：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftOutOrIn.jsonObject.isOutbound}</span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 入库编码：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftOutOrIn.outboundCode}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 经办人：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftOutOrIn.transactor}</span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 入库时间：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftOutOrIn.jsonObject.outboundTime}</span>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="space-10"></div>
</div>
<div class="row">
    <div class="col-sm-10 col-sm-offset-1" style="padding-left: 25px;padding-right: 22px;">
        <div class="header-table-th">礼品入库明细</div>
        <div class="table-content col-md-12">
            <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                <table id="grid-table-purchase" class="table_list"></table>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="space-10"></div>
</div>
<div class="clearfix">
        <div class="col-xs-12 center">
            <button class="btn btn-primary btn-sm" type="button" id="backBtn">
                <i class="ace-icon fa fa-undo bigger-110"></i>
                返回
            </button>
        </div>
    </div>
</div>


<div id="view-dialog" class="hide">
    <div class="row">
        <div class="col-xs-12">

            <div class="profile-user-info profile-user-info-striped">

                <div class="profile-info-row">
                    <div class="profile-info-name"> 礼品编码：</div>
                    <div class="profile-info-value">
                        <span class="editable " id="giftCode"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 礼品名称：</div>
                    <div class="profile-info-value">
                        <span class="editable " id="giftName"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 礼品类型：</div>
                    <div class="profile-info-value">
                        <span class="editable " id="giftType"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 数量：</div>
                    <div class="profile-info-value">
                        <span class="editable " id="giftCount"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 单价：</div>
                    <div class="profile-info-value">
                        <span class="editable " id="giftPrice"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 所属货架：</div>
                    <div class="profile-info-value">
                        <span class="editable " id="giftFrame"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({
            todayHighlight : true
        });

        //表单类全局变量
        var $viewDialog = $("#view-dialog");

        //入库礼品明细
        var $gridTable = $("#grid-table-purchase");
        var giftOutOrInId = $("#giftOutOrInId").val();

        var loadUrl = '${basePath}/giftOutOrInRecords/load-giftOutOrInRecords-list.do?giftOutOrInId='+ giftOutOrInId;

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'giftCode', header: '礼品编码', index: 'giftCode', sortable: true},
            {name: 'giftName', header: '礼品名称', index: 'giftName', sortable: true, width: 400},
            {name: 'giftType', header: '礼品类型', index: 'giftType', sortable: true},
            // {name: 'giftState', header: '库存状态', index: 'giftState', sortable: true},
            {name: 'giftCount', header: '数量', index: 'giftCount', sortable: true},
            {name: 'giftPrice', header: '单价', index: 'giftPrice', sortable: true},
            {name: 'giftFrame', header: '所属货架', index: 'giftFrame', sortable: true},
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
            <c:if test="${true}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'updateTime',
            sortorder: 'desc',

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
                    viewAbroadInfo(rowData);
                }
            }
        });
        $gridTable.tjGrid("triggerResizeGrid");


        //礼品入库单基本信息
        var $giftPurchaseForm = $('#giftPurchaseForm');

        var $backBtn = $("#backBtn");


        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var listUrl = '#page/giftPurchase/gift-purchase-manage';

            var postData = $giftPurchaseForm.serializeObject();

            var flag = 0;
            $.each(postData, function (index, item) {

                if (item !== "") {
                    flag = 1;
                }
            });

            if (flag === 0) {
                G.pjaxLoadPageContentDiv(listUrl)
            }
        });


        //礼品明细查看
        function viewAbroadInfo(rowData) {
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
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看礼品入库明细信息</h4></div>",
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

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table-purchase');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });

</script>
