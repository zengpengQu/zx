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
                        <h5 class="group-header accordion-header" style="width: 160px;">
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
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-groupName">团组名称：</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="groupName"
                                                               id="form-field-groupName" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-contacts">联系人：</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="contacts"
                                                               id="form-field-contacts" type="text"/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-groupLevel">团组级别:</label>

                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-groupLevel"
                                                                name="groupLevel">
                                                            <option value="">-----请选择-----</option>
                                                            <c:forEach items="${dicParamList}" var="dicParam">
                                                                <option value="${dicParam.id}">${dicParam.name}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-sponsor">主办单位:</label>

                                                    <div class="col-sm-8 deptDiv">
                                                        <input type="text" id="form-field-sponsor" name="sponsor"
                                                               class="hide" value=""/>
                                                        <input type="text" class="form-control" id="form-field-deptName"
                                                               name="deptName" value="" style="cursor: pointer;" readonly/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-contactsTel">联系人电话：</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="contactsTel"
                                                               id="form-field-contactsTel" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4" style="margin-top: 5px;margin-bottom: 5px">
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
                        <c:if test="${'60_1' eq curOpertate}">
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
                <div class="header-table-th">临时外事活动列表</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
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

        G.datepicker();

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        G.initDept('deptDiv', true, null, TREE_NODE);

        //元素类全局变量
        var $groupName = $("#form-field-groupName");
        var $contacts = $("#form-field-contacts");
        var $contactsTel = $("#form-field-contactsTel");
        var $sponsor = $("#form-field-sponsor");
        var $groupLevel = $("#form-field-groupLevel");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        var loadUrl = '${basePath}/temp-affairs/load-temp-affairs-list.do';
        var editUrl = '#page/temp-affairs/temp-affairs-edit';
        var viewUrl = '#page/temp-affairs/temp-affairs-view';
        var deleteUrl = '${basePath}/temp-affairs/temp-affairs-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'groupNumber', header: '团组编号', index: 'groupNumber', sortable: true, hidden: true},
            {name: 'groupName', header: '团组名称', index: 'groupName', sortable: true},
            {name: 'groupLevelName', header: '团组级别', index: 'groupLevelName', sortable: true},
            {name: 'deptName', header: '主办单位', index: 'deptName', sortable: true},
            {name: 'activityType', header: '活动类型', index: 'activityType', sortable: true},
            {name: 'activityTime', header: '活动时间', index: 'activityTime', sortable: true, width: 200},
            {name: 'activitySite', header: '活动地点', index: 'activitySite', sortable: true, hidden: true},
            {name: 'activityContent', header: '活动内容', index: 'activityContent', sortable: true, hidden: true},
            {name: 'feteSite', header: '宴请地点', index: 'feteSite', sortable: true, hidden: true},
            {name: 'attendLeader', header: '出席领导', index: 'attendLeader', sortable: true, hidden: true},
            {name: 'accompany', header: '陪同人员', index: 'accompany', sortable: true, hidden: true},
            {name: 'chinese', header: '我方出席人员', index: 'chinese', sortable: true, hidden: true},
            {name: 'foreigner', header: '外方出席人员', index: 'foreigner', sortable: true, hidden: true},
            {name: 'contacts', header: '联系人', index: 'contacts', sortable: true, width: 100},
            {name: 'contactsTel', header: '联系人电话', index: 'contactsTel', sortable: true},
            {name: 'newsOrg', header: '新闻单位', index: 'newsOrg', sortable: true, hidden: true},
            {name: 'notes', header: '备注', index: 'notes', sortable: true, hidden: true},
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
            <c:if test="${'60_2' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'60_3' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'60_4' eq curOpertate}">
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

                if (className.indexOf('row-record-view') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
                    var viewHash = viewUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(viewHash);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条临时外事活动信息吗？',
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
                    var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(editHash);
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        $searchBtn.click(function () {
            search();
        });

        function search() {
            var groupName = $groupName.val();
            var contacts = $contacts.val();
            var contactsTel = $contactsTel.val();
            var sponsor = $sponsor.val();
            var groupLevel = $groupLevel.val();
            $gridTable.tjGrid('setPostData', {
                groupName: groupName,
                contacts: contacts,
                contactsTel: contactsTel,
                sponsor: sponsor,
                groupLevel: groupLevel
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