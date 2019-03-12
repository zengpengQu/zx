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
                                                           for="form-field-frameCode">货架编号:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-frameCode"
                                                               name="frameCode" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-frameType">货架类型:</label>

                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-frameType"
                                                                name="frameType">
                                                            <option value="">-----请选择-----</option>
                                                            <c:forEach items="${dicGiftTypeList}" var="dicGiftType">
                                                                <option value="${dicGiftType.id}">${dicGiftType.typeName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-3 pull-right"
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
                        <c:if test="${'61_3' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right:15px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                新增
                            </button>
                        </c:if>
                    </c:forEach>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">礼品架管理列表</div>
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
                    <div class="profile-info-name"> 货架编码：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="frameCode"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 使用状态：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="frameState"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 货架名称：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="frameName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 规格：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="frameFormat"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 购置日期：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="purchaseTime"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 经办人：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="frameAgent"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 承重（公斤）：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="frameBearing"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 货架类型：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="frameType"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 说明：</div>

                    <div class="profile-info-value">
                        <span class="editable" id="frameInstruction"></span>
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
        var $frameCode = $("#form-field-frameCode");
        var $frameType = $("#form-field-frameType");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        //弹窗类全局变量
        var $viewDialog = $("#view-dialog");

        var loadUrl = '${basePath}/gift/load-gift-shelves-list.do';
        var editUrl = '#page/gift/load-gift-shelves-edit';
        var deleteUrl = '${basePath}/gift/load-gift-shelves-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'frameCode', header: '货架号码', index: 'frameCode', sortable: true},
            {name: 'frameName', header: '货架名称', index: 'frameName', sortable: true},
            {name: 'frameType', header: '货架类型', index: 'frameType', sortable: true},
            {name: 'purchaseTime', header: '购置日期', index: 'purchaseTime', sortable: true},
            {name: 'frameFormat', header: '规格（米）', index: 'frameFormat', sortable: true},
            {name: 'frameBearing', header: '承重量（kg）', index: 'frameBearing', sortable: true},
            {name: 'frameAgent', header: '经办人', index: 'frameAgent', sortable: true},
            {name: 'frameInstruction', header: '说明', hidden: true},
            {name: 'frameState', header: '使用状态', index: 'frameState', sortable: true},
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
            <c:if test="${'61_1' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'61_2' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'61_4' eq curOpertate}">
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
            // caption: "礼品架管理列表",
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
                    viewShelf(rowData);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条礼品架信息吗？',
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

        function viewShelf(rowData) {
            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });

            initViewDialog($viewDialog);
        }

        //初始化查看礼品架弹出框
        function initViewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看礼品架信息</h4></div>",
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
            var frameCode = $frameCode.val();
            var frameType = $frameType.val();

            $gridTable.tjGrid('setPostData', {
                frameCode: frameCode,
                frameType: frameType,
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