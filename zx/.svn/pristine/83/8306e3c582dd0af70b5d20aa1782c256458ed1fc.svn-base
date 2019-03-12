<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/5
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
                                                           for="form-field-groupName">会议标题:</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-groupName"
                                                               name="groupName">
                                                        </input>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-startDate">会议时间：</label>

                                                    <div class="col-sm-8 ">
                                                        <div class="input-group">
                                                            <input class="form-control date-picker"
                                                                   name="startDate"
                                                                   id="form-field-startDate"
                                                                   data-date-format="yyyy-mm-dd"
                                                                   value="" type="text"/>
                                                            <span class="input-group-addon"><i
                                                                    class="fa fa-calendar bigger-110"></i></span>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-leaderName">会议地点:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-leaderName"
                                                               name="leaderName">
                                                        </input>
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
            </div>
        </div>

        <div class="row">
            <div class="space-10"></div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'63_3' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn"
                                    style="top: 6px;right:15px;">
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
                <div class="header-table-th">外事局局务会议管理列表</div>
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
        <div class="col-xs-12">
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name"> 会议标题</div>

                    <div class="profile-info-value">
                        <span class="editable " id="title"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 会议内容</div>

                    <div class="profile-info-value">
                        <span class="editable " id="content"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 会议时间</div>

                    <div class="profile-info-value">
                        <span class="editable " id="time"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 会议地点</div>

                    <div class="profile-info-value">
                        <span class="editable " id="meetingSite"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 会议人员</div>

                    <div class="profile-info-value">
                        <span class="editable " id="attendence"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 其他</div>

                    <div class="profile-info-value">
                        <span class="editable " id="other"></span>
                    </div>
                </div>


            </div>
        </div>
    </div>
</div>

<div id="edit-dialog" class="hide"></div>
<div id="preview-dialog" class="hide" style="background-color: darkseagreen"></div>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        var initParam = G.initGridParam($("#searchForm"));

        G.datepicker({autoclose: true, todayHighlight: true});

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        // 元素类全局变量
        var $groupName = $("#form-field-groupName");//会议标题
        var $leaderName = $("#form-field-leaderName");//会议地点
        var $startDate = $("#form-field-startDate");//会议日期
        var $endDate = $("#form-field-endDate");

        // 控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        // 表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");
        var $viewDialog = $("#view-dialog");

        var loadUrl = '${basePath}/council/load-congress-list.do';
        var editUrl = '#page/council/congress-info-edit';
        var deleteUrl = '${basePath}/council/congress-info-delete.do';

        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'title', header: '会议标题', index: 'title', sortable: true},
            {name: 'content', header: '会议内容', index: 'content', sortable: true},
            {name: 'time', header: '会议时间',width:80, index: 'time', sortable: true},
            {name: 'meetingSite', header: '会议地点', index: 'meetingSite', sortable: true},
            {name: 'attendence', header: '参会人员', index: 'attendence', sortable: true},
            {name: 'other', header: '其他', index: 'other', hidden: true, sortable: true},
            {name: 'catTime', header: '创建时间', index: 'catTime', hidden: true, sortable: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 200,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];


            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'63_1' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-viewCon">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'63_2' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'63_4' eq curOpertate}">
            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue"></i> 删除');
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

        $gridTable.tjGrid({
            initParam : initParam,
            loadUrl: loadUrl,
            height: '100%',
            width:'100%',
            autowidth: true,
            colModel: colModel,
            postData: {
                groupName: $groupName.val(),
                leaderName: $leaderName.val(),
                startDate: $startDate.val(),
                endDate: $endDate.val()
            },
            sortname: 'catTime',
            sortorder: 'desc',
            // caption: "会议管理列表",
            onSelectRow: function (id, stat, e) {

                if (e == undefined) {
                    return false;
                }

                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $gridTable.jqGrid('getRowData', id);

                // 查看
                if (className.indexOf('row-record-view') !== -1) {

                    viewComeInfo(rowData);

                } else if (className.indexOf('row-record-edit') !== -1) {

                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm,$gridTable);
                    }
                    var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(editHash);

                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确定删除此条局务会议记录吗？',
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
                }
            }
        });
        $gridTable.tjGrid("triggerResizeGrid");

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
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'>" +
                "<i class='ace-icon fa  fa-globe green'></i>查看</h4></div>",
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

            $gridTable.tjGrid('setPostData', {
                groupName: groupName,
                leaderName: leaderName,
                startDate: startDate,
                endDate: endDate
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
        $(document).one('ajaxloadstart.page', function (e) {

            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>