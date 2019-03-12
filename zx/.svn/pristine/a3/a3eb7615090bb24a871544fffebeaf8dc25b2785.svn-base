<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>

<div class="row">
    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-12 widget-container-col ">
                <!-- #section:custom/widget-box -->
                <div class="accordion-style2 accordion">
                    <div class="group group-bottom">
                        <h5 class="group-header accordion-header">
                           <span class="searchTj">
                                查询条件
                            </span>
                        </h5>
                        <div class="widget-body" style="border-top-width: 1px;background: #fff;">
                            <div class="widget-main">
                                <div class="col-xs-12">
                                    <form class="form-horizontal" role="form" id="searchForm">
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-giftName">礼品名称:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-giftName"
                                                               name="giftName" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-giftCode">礼品编码:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-giftCode"
                                                               name="giftCode" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-giftType">礼品类型:</label>

                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-giftType"
                                                                name="giftType">
                                                            <option value="">-----请选择-----</option>
                                                            <c:forEach items="${dicGiftTypeList}" var="dicGiftType">
                                                                <option value="${dicGiftType.id}">${dicGiftType.typeName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12 pull-right"
                                                 style="margin-top: 5px;margin-bottom: 5px">
                                                <div class="btn-group pull-right">
                                                    <button class="btn btn-success btn-sm" type="button"
                                                            id="searchBtn">
                                                        <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                        查询
                                                    </button>
                                                    <button class="btn btn-warning btn-sm" type="button" id="resetBtn">
                                                        <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                                        重置
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
                <!-- /section:custom/widget-box -->
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'62_3' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right:15px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
                            </button>
                        </c:if>
                    </c:forEach>
                </div>
                <%--<div class="pull-right">--%>
                    <%--<i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>--%>
                <%--</div>--%>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">礼品库存管理列表</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>

                </div>
            </div>
        </div>
    </div>
</div>

<div id="view-dialog" class="hide">
    <div class="row">
        <div class="col-sm-10 col-sm-offset-1">
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 礼品名称：</div>
                    <div class="profile-info-value">
                        <span class="editable" id="giftName"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 礼品编码：</div>
                    <div class="profile-info-value">
                        <span class="editable" id="giftCode"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 礼品类型：</div>
                    <div class="profile-info-value">
                        <span class="editable" id="giftType"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 库存状态：</div>
                    <div class="profile-info-value">
                        <span class="editable" id="giftState"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 数量：</div>
                    <div class="profile-info-value">
                        <span class="editable" id="giftCount"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 单价：</div>
                    <div class="profile-info-value">
                        <span class="editable" id="giftPrice"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 所属货架：</div>
                    <div class="profile-info-value">
                        <span class="editable" id="giftFrame"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 录入人：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="createName"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 录入时间：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="createTime"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 说明：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="giftInstruction"></span>
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

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //元素类全局变量
        var $giftName = $("#form-field-giftName");
        var $giftCode = $("#form-field-giftCode");
        var $giftType = $("#form-field-giftType");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        //弹窗类全局变量
        var $viewDialog = $("#view-dialog");


        var loadUrl = '${basePath}/giftStore/load-giftStoreInfo-list.do';
        var editUrl = '#page/giftStore/load-giftStoreInfo-edit';
        var deleteUrl = '${basePath}/giftStore/load-giftStoreInfo-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'giftCode', header: '礼品编码', index: 'giftCode', sortable: true},
            {name: 'giftName', header: '礼品名称', index: 'giftName', sortable: true},
            {name: 'giftType', header: '礼品类型', index: 'giftType', sortable: true},
            {name: 'giftState', header: '库存状态', index: 'giftState', sortable: true},
            {name: 'giftCount', header: '数量', index: 'giftCount', sortable: true},
            {name: 'giftPrice', header: '单价', index: 'giftPrice', sortable: true},
            {name: 'giftFrame', header: '所属货架', index: 'giftFrame', sortable: true},
            {name: 'createName', header: '录入人', hidden: true},
            {name: 'createTime', header: '录入时间', hidden: true},
            {name: 'giftInstruction', header: '说明', hidden: true},

            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'62_1' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'62_2' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'62_4' eq curOpertate}">
            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
            operations.push('</button>');
            </c:if>
            </c:forEach>
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
            // caption: "礼品库存管理列表",
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $gridTable.jqGrid('getRowData', id);

                if (className.indexOf('row-record-view') !== -1) {
                   viewStorage(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条礼品库存信息吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        $gridTable.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-edit') !== -1) {
                    var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(editHash);
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        function viewStorage(rowData) {
            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });

            initViewDialog($viewDialog);
        }

        //初始化查看礼品库存弹出框
        function initViewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看礼品库存信息</h4></div>",
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

        $searchBtn.click(function () {
            search();
        });

        function search() {
            var giftName = $giftName.val();
            var giftType = $giftType.val();
            var giftCode = $giftCode.val();

            $gridTable.tjGrid('setPostData', {
                giftName: giftName,
                giftCode: giftCode,
                giftType: giftType,
            });
            reloadGrid();
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });

        $addBtn.click(function () {
            G.pjaxLoadPageContentDiv(editUrl);
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>