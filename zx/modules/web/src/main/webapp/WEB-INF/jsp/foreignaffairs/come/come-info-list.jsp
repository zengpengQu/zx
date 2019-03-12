<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/6/27
  Time: 13:55
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
                                                           for="form-field-groupName">团组名称:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-groupName"
                                                               name="groupName" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-leaderName">来访团团长:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-leaderName"
                                                               name="leaderName" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px; margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label">来访时间：</label>
                                                    <div class="col-sm-8 ">
                                                        <div class="input-daterange input-group">
                                                            <input id="form-field-startDate" type="text"
                                                                   class="form-control" name="startDate"/>
                                                            <span class="input-group-addon"><i
                                                                    class="fa fa-exchange"></i></span>
                                                            <input id="form-field-endDate" type="text"
                                                                   class="form-control" name="endDate"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <%--<div class="col-xs-3">--%>
                                        <%--<div class="form-group" style="margin-top: 5px; margin-bottom: 5px">--%>
                                        <%--<label class="col-sm-4 control-label"--%>
                                        <%--for="form-field-startDate">开始日期:</label>--%>
                                        <%--<div class="col-sm-8 ">--%>
                                        <%--<div class="input-group" style="width: 100%;">--%>
                                        <%--<input class="form-control date-picker"--%>
                                        <%--name="startDate"--%>
                                        <%--id="form-field-startDate"--%>
                                        <%--data-date-format="yyyy-mm-dd"--%>
                                        <%--placeholder="开始日期" type="text"/>--%>
                                        <%--<span class="input-group-addon"><i--%>
                                        <%--class="fa fa-calendar bigger-110"></i></span>--%>
                                        <%--</div>--%>
                                        <%--</div>--%>
                                        <%--</div>--%>
                                        <%--</div>--%>
                                        <%--<div class="col-xs-3">--%>
                                        <%--<div class="form-group" style="margin-top: 5px; margin-bottom: 5px">--%>
                                        <%--<label class="col-sm-4 control-label" for="form-field-endDate">结束日期:</label>--%>
                                        <%--<div class="col-sm-8 ">--%>
                                        <%--<div class="input-group" style="width: 100%;">--%>
                                        <%--<input class="form-control date-picker"--%>
                                        <%--name="endDate"--%>
                                        <%--id="form-field-endDate"--%>
                                        <%--data-date-format="yyyy-mm-dd"--%>
                                        <%--placeholder="结束日期"--%>
                                        <%--type="text"/>--%>
                                        <%--<span class="input-group-addon"><i--%>
                                        <%--class="fa fa-calendar bigger-110"></i></span>--%>
                                        <%--</div>--%>
                                        <%--</div>--%>
                                        <%--</div>--%>
                                        <%--</div>--%>

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
            </div>
        </div>

        <div class="row">
            <div class="space-10"></div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'59_1' eq curOpertate}">
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
                <div class="header-table-th">来访管理列表</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table-comeInfo"></table>
                    </div>

                </div>

            </div>
        </div>

        <div id="view-dialog" class="hide">
            <div class="row">
                <div class="col-xs-12">
                    <div class="profile-user-info profile-user-info-striped">
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 邀请名义</div>

                            <div class="profile-info-value">
                                <span class="editable " id="invitationName"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 主办单位</div>

                            <div class="profile-info-value">
                                <span class="editable " id="sponsorName"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 团组编号</div>

                            <div class="profile-info-value">
                                <span class="editable " id="groupNumber"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 团组级别</div>

                            <div class="profile-info-value">
                                <span class="editable " id="groupLevel"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 来访国家</div>

                            <div class="profile-info-value">
                                <span class="editable " id="countryId"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 来访团人数</div>

                            <div class="profile-info-value">
                                <span class="editable " id="peopleNum"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 团长中文名</div>

                            <div class="profile-info-value">
                                <span class="editable " id="cnName"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 团长外文名</div>

                            <div class="profile-info-value">
                                <span class="editable " id="foreignName"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 开始日期</div>

                            <div class="profile-info-value">
                                <span class="editable " id="startDateStr"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 结束日期</div>

                            <div class="profile-info-value">
                                <span class="editable " id="endDateStr"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 任务描述</div>

                            <div class="profile-info-value">
                                <span class="editable " id="taskDscr" style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                        word-wrap: break-word;overflow: hidden"></span>
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

        var initParam = G.initGridParam($("#searchForm"));

        $('.input-daterange').datepicker({
                format: 'yyyy-mm-dd',
                autoclose: true,
                todayHighlight: true
            }
        );

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        // 元素类全局变量
        var $groupName = $("#form-field-groupName");
        var $leaderName = $("#form-field-leaderName");
        var $startDate = $("#form-field-startDate");
        var $endDate = $("#form-field-endDate");

        // 控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        // 表单类全局变量
        var $searchForm = $("#searchForm");
        var $comeInfoGrid = $("#grid-table-comeInfo");
        var $viewDialog = $("#view-dialog");

        var loadUrl = '${basePath}/come/load-come-info-list.do';
        var editUrl = '#page/come/load-come-info-edit';
        var deleteUrl = '${basePath}/come/come-info-delete.do';
        var moreUrl = '#page/come/load-come-info-edit-more';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'groupNumber', header: '团组编号', index: 'groupNumber', sortable: true},
            {name: 'groupName', header: '团组名称', index: 'groupName', sortable: false},
            {name: 'groupLevel', header: '团组级别', index: 'groupLevel.seq', sortable: true},
            {name: 'invitationName', header: '邀请名义', index: 'invitation.id', hidden: true},
            {name: 'sponsorName', header: '主办单位', index: 'dicDept.id', sortable: true},
            {name: 'countryId', header: '来访国家', index: 'countryId', sortable: false},
            {name: 'peopleNum', header: '来访团人数', index: 'peopleNum', hidden: true, sortable: false},
            {name: 'cnName', header: '团长中文名', index: 'cnName', hidden: true, sortable: false},
            {name: 'foreignName', header: '团长外文名', index: 'foreignName', hidden: true, sortable: false},
            {name: 'startDateStr', header: '开始日期', index: 'startDate', sorttype: 'date', hidden: false, sortable: true},
            {name: 'endDateStr', header: '结束日期', index: 'endDate', sorttype: 'date', hidden: false, sortable: true},
            {name: 'taskDscr', header: '任务描述', index: 'taskDscr', sortable: false, cellattr: styleFormatter},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {name: 'work', header: '业务操作', sortable: false, width: 150, fixed: true, formatter: workOperationFormatter}
        ];

        function styleFormatter() {
            return 'style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"';
        }

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'59_2' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out bigger-120"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'59_3' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil bigger-120"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'59_4' eq curOpertate}">
            operations.push(' <button title="删除" class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
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
            <c:if test="${'59_5' eq curOpertate}">
            operations.push(' <button title="更多" class="btn btn-minier btn-white btn-primary editMore">');
            operations.push('<i class="ace-icon glyphicon glyphicon-book"></i> 更多');
            operations.push('</button>');
            </c:if>

            <c:if test="${'59_6' eq curOpertate}">
            operations.push(' <button title="导出" class="btn btn-minier btn-white btn-primary export">');
            operations.push('<i class="ace-icon fa fa-cloud-download"></i> 导出');
            operations.push('</button>');
            </c:if>
            </c:forEach>

            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $addBtn.unbind('click').bind('click', function (e) {
            G.pjaxLoadPageContentDiv(editUrl);
        });

        $comeInfoGrid.tjGrid({
            initParam: initParam,
            loadUrl: loadUrl,
            // editUrl: editUrl,
            // deleteUrl: deleteUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            postData: {
                groupName: $groupName.val(),
                leaderName: $leaderName.val(),
                startDate: $startDate.val(),
                endDate: $endDate.val()
            },
            sortname: 'startDate',
            sortorder: 'desc',
            // caption: "来访管理列表",
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }

                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $comeInfoGrid.jqGrid('getRowData', id);

                // 查看
                if (className.indexOf('row-record-view') !== -1) {

                    viewComeInfo(rowData);

                } else if (className.indexOf('row-record-edit') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm, $comeInfoGrid);
                    }

                    var editHash = editUrl + "?id=" + id;
                    G.pjaxLoadPageContentDiv(editHash);

                } else if (className.indexOf('row-record-delete') !== -1) {

                    G.confirm({
                        message: '确认删除记录！',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        $comeInfoGrid.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                }
                // 更多编辑
                else if (className.indexOf('editMore') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm, $comeInfoGrid);
                    }

                    var moreHash = moreUrl + "?id=" + id;
                    G.pjaxLoadPageContentDiv(moreHash);
                } else if (className.indexOf('export') !== -1) {
                    var exportUrl = '${basePath}/come/come-reception-export.do?comeInfoId=' + id;

                    var $downloadForm = $("<form method='post'></form>");
                    $downloadForm.attr("action", exportUrl);
                    $(document.body).append($downloadForm);
                    $downloadForm.submit();
                }
            }
        });

        $comeInfoGrid.tjGrid("triggerResizeGrid");

        /**
         * 查看来访信息
         */
        function viewComeInfo(rowData) {

            //为弹出框赋值
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
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看来访管理信息</h4></div>",
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
            var groupName = $groupName.val();
            var leaderName = $leaderName.val();
            var startDate = $startDate.val();
            var endDate = $endDate.val();

            $comeInfoGrid.tjGrid('setPostData', {
                groupName: groupName,
                leaderName: leaderName,
                startDate: startDate,
                endDate: endDate
            });
            reloadGrid();
        }

        function reloadGrid() {
            $comeInfoGrid.tjGrid('reloadGrid');
        }

        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });

        $(document).one('ajaxloadstart.page', function (e) {

            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>