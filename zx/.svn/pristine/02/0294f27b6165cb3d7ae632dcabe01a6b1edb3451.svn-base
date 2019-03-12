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
                                                           for="form-field-groupName">人员姓名:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-groupName" type="text"
                                                               name="groupName">
                                                        </input>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-4">
                                                <label class="col-sm-4 control-label" for="form-field-leaderName" style="margin-top: 5px;margin-bottom: 5px">出勤状态：
                                                </label>
                                                <div class="col-sm-8 ">
                                                    <select class="form-control" id="form-field-leaderName" name="leaderName"style="margin-top: 5px;margin-bottom: 5px">
                                                        <option value="">---请选择---</option>
                                                        <option value="0">正常</option>
                                                        <option value="1">出差</option>
                                                        <option value="2">休假</option>
                                                        <option value="3">事假</option>
                                                        <option value="4">病假</option>
                                                        <option value="5">缺席</option>
                                                    </select>
                                                </div>
                                            </div>

                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-meetingTitle">会议标题:</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" id="form-field-meetingTitle" type="text"
                                                               name="meetingTitle">
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

        <div id="view-dialog" class="hide">
            <div class="row">
                <div class="col-xs-12">
                    <div class="profile-user-info profile-user-info-striped">
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 会议标题 </div>

                            <div class="profile-info-value">
                                <span class="editable " id="meetingTitle"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 参会人员姓名 </div>

                            <div class="profile-info-value">
                                <span class="editable " id="attendName"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 人员职务 </div>

                            <div class="profile-info-value">
                                <span class="editable " id="attendDuty"></span>
                            </div>
                        </div>

                        <div class="profile-info-row">
                            <div class="profile-info-name"> 出勤状态 </div>

                            <div class="profile-info-value">
                                <span class="editable " id="attendEnce"></span>
                            </div>
                        </div>
                        <div class="profile-info-row">
                            <div class="profile-info-name"> 备注 </div>

                            <div class="profile-info-value">
                                <span class="editable " id="attendOther"></span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">出勤情况管理列表</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<div id="attend-edit-dialog" class="hide"></div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

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
        var $groupName = $("#form-field-groupName");//人员姓名姓名
        var $leaderName = $("#form-field-leaderName");//出勤状态
        var $meetingTitle = $("#form-field-meetingTitle");//会议标题

        // 控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        // 表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");
        var $viewDialog = $("#view-dialog");
        var $attendEditDialog = $("#attend-edit-dialog");

        var loadUrl = '${basePath}/attendance/load-attendance-list.do';
        var editUrl = '${basePath}/attendance/attendance-info-edit.do';
        var deleteUrl = '${basePath}/attendance/attendance-info-delete.do';

        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'attendTime', header: '参会日期', index: 'attendTime', hidden: true, sortable: true},
            {name: 'meetingTitle', header: '会议标题', index: 'meetingTitle', sortable: true},
            {name: 'attendName', header: '姓名', index: 'attendName', sortable: true},
            //{name: 'attendDuty', header: '职位', index: 'attendDuty', sortable: true},
            {name: 'attendEnce', header: '出勤状态', index: 'attendEnce', sortable: true},
            {name: 'attendOther', header: '备注', index: 'attendOther', sortable: true},

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
            <c:if test="${'64_3' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'64_3' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-primary row-record-edit">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 编辑');
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
            loadUrl: loadUrl,
            height: '100%',
            width:'100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'meetingTitle',
            sortorder: 'desc',
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
                    attendanceEdit(id);
                   // var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                   // G.pjaxLoadPageContentDiv(editHash);

                } else if (className.indexOf('row-record-delete') !== -1) {

                    G.confirm({
                        message: '确认删除出勤情况记录！',
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

        function  initViewDialog($container) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看</h4></div>",
                title_html: true,
                close: function () {
                    // $container.addClass("hide");
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


        //新增  编辑
        function attendanceEdit(id) {
            $.ajax({
                url: editUrl,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $attendEditDialog.html(String);
                    //初始化弹出框
                    initAttendanceDialog($attendEditDialog);
                },
                error: function () {
                    G.alert({message: "操作失败！"});
                }
            });
        }

        function initAttendanceDialog($container) {
            var $form = $("#saveForm");
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'>" +
                "</i>修改 局务会议出勤情况</h4></div>",
                title_html: true,
                close: function () {
                    $container.empty();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            if ($form.validate().form()) {
                                $form.ajaxSubmit({
                                    success: function (map) {
                                        if (map.result) {
                                            G.showGritterSuccess("保存成功!");
                                            $container.dialog("close");
                                        } else {
                                            G.showGritterFail("保存失败,请稍后重试!");
                                        }
                                        //更新表格数据
                                        G.search($searchForm, $gridTable);
                                    }
                                });
                            }
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
            var meetingTitle = $meetingTitle.val();

            $gridTable.tjGrid('setPostData', {
                groupName: groupName,
                leaderName: leaderName,
                meetingTitle: meetingTitle,
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