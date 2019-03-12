<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>

<script src="${basePath}/plugin/ace/assets/js/chosen.jquery.js"></script>
<%--word导出--%>
<script src="${basePath}/plugin/wordExport/js/FileSaver.js"></script>
<script src="${basePath}/plugin/wordExport/js/jquery.wordexport.js"></script>

<div class="row">
    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-12 widget-container-col ">
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
                                    <form class="form-horizontal" role="form" autocomplete="off" id="searchForm">

                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label" for="form-field-nationName">国家名称：</label>

                                                    <div class="col-sm-8">
                                                        <input class="form-control" name="nationName"
                                                               id="form-field-nationName" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4 pull-right">
                                                <div class="btn-group pull-right" style="margin-top: 7.5px;">
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
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'69_1' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn"  style="top: 6px;right:15px;">
                                <span class="fa fa-plus icon-on-right bigger-110"></span>
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
                <div class="header-table-th">国家情况信息列表</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>

                </div>


            </div>
        </div>
    </div>
</div>

<div id="preview-dialog" class="hidden" style="background-color: darkseagreen"></div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        var initParam = G.initGridParam($("#searchForm"));

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        var $nationName = $("#form-field-nationName");

        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        var $previewDialog = $("#preview-dialog");

        var loadUrl = '${basePath}/nation-condition/load-nation-condition-list.do';
        var editUrl = '#page/nation-condition/nation-condition-edit';
        var editMoreUrl = '#page/nation-condition/nation-condition-edit-more';
        var deleteUrl = '${basePath}/nation-condition/nation-condition-delete.do';
        var previewUrl = '${basePath}/nation-condition/nation-condition-preview.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'nationName', header: '国家名称', index: 'nationName', sortable: true},
            {name: 'belongArea', header: '所属地区', index: 'belongArea', sortable: true},
            /*{name: 'isOborNation', header: '是否一带一路国家', index: 'isOborNation', sortable: true},
            {name: 'isAroundNation', header: '是否周边国家', index: 'isAroundNation', sortable: true},
            {name: 'isArabNation', header: '是否阿拉伯国家', index: 'isArabNation', sortable: true},
            {name: 'isWestNation', header: '是否其他西方发达国家', index: 'isWestNation', sortable: true},
            {name: 'isOtherNation', header: '是否其他国家', index: 'isOtherNation', sortable: true},*/
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {
                name: 'work',
                header: '业务操作',
                sortable: false,
                width: 100,
                fixed: true,
                formatter: workOperationFormatter
            }
        ];

        function basicOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'69_2' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'69_3' eq curOpertate}">
            operations.push(' <button title="完善" class="btn btn-minier btn-white btn-purple row-record-complete">');
            operations.push('<i class="ace-icon fa fa-info-circle blue"></i> 完善');
            operations.push('</button>');
            </c:if>
            <c:if test="${'69_4' eq curOpertate}">
            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o"></i> 删除');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function workOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'69_5' eq curOpertate}">
            operations.push(' <button title="导出" class="btn btn-minier btn-white btn-success row-record-export">');
            operations.push('<i class="ace-icon fa fa-download blue"></i> 导出');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            initParam : initParam,
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

                if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条国家情况信息吗？',
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

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
                    var editHash = editUrl + "?id=" + id;
                    G.pjaxLoadPageContentDiv(editHash);
                } else if (className.indexOf('row-record-complete') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
                    var editMoreHash = editMoreUrl + "?id=" + id;
                    G.pjaxLoadPageContentDiv(editMoreHash);
                } else if (className.indexOf('row-record-export') !== -1) {
                    G.confirm({
                        message: '确认导出此条国家情况信息吗？',
                        callback: function (result) {
                            if (result) {
                                var loadId = G.showAjaxLoading();
                                $.get(previewUrl, {id: id}, function (data) {
                                    $previewDialog.html(data);
                                    G.doneAjaxLoading(loadId);
                                    //初始化弹出框
                                    initPreviewDialog($previewDialog);
                                });
                            }
                        }
                    });
                }
            }
        });

        function initPreviewDialog($container) {

            $container.removeClass('hidden').dialog({
                resizable: false,
                height: 700,
                width: 1200,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>国家情况预览</h4></div>",
                title_html: true,
                close: function () {
                    $container.addClass("hidden");
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
                            $container.wordExport("国家情况详细信息");
                            $(this).dialog("close");
                        }
                    }
                ]
            });
        }

        $gridTable.tjGrid("triggerResizeGrid");

        $searchBtn.click(function () {
            search();
        });

        function search() {
            var nationName = $nationName.val();
            $gridTable.tjGrid('setPostData', {
                nationName: nationName
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
            $.jgrid.gridDestroy("#grid-table");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>