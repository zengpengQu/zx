<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath =  path;
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
                            <div class="widget-main" >
                                <div class="col-xs-12" >
                                    <form class="form-horizontal" id="searchForm">
                                        <div class="row">
                                            <div class="col-xs-4">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="search-name">用户名称:</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" type="text" id="search-name">
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-5">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label">操作时间：</label>

                                                    <div class="col-sm-8 ">
                                                        <div class="input-group">
                                                            <input id="startTime" type="text"
                                                                   class="form-control" name="start"/>
                                                            <span class="input-group-addon">
																		<i class="fa fa-exchange"></i>
																	</span>

                                                            <input id="endTime" type="text"
                                                                   class="form-control" name="end"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-3">
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
                <c:forEach items="${curOperateAuth}" var="curOpertate">
                    <c:if test="${'43_1' eq  curOpertate}">
                        <div class="btn-group pull-right contacts-exportBtn">
                            <button class="btn btn-sm btn-success" id="add-new-role" style="top:6px;right:15px;">
                                <i class="ace-icon glyphicon glyphicon-user bigger-120"></i>
                                新增角色
                            </button>
                        </div>

                    </c:if>
                </c:forEach>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th">系统日志浏览</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="col-xs-12">
    <div id="data-dialog" class="hide" >
        <h4 class="header smaller lighter blue" style="margin-top: 0px; "><i
                class="ace-icon fa fa-pencil-square-o "></i>
            操作数据
        </h4>

        <div id="data-content">

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

        //查询
        var $startTime = $('#startTime');
        var $endTime = $('#endTime');
        var $searchName = $("#search-name");
        var $searchBtn = $("#searchBtn");
        var $dataContent = $("#data-content");
        var $dataDialog = $("#data-dialog");
        $startTime.datepicker({
            autoclose: true,
            format: 'yyyy-mm-dd',
            todayHighlight: true,
            todayBtn: 'linked'
        }).on('change', function () {
            var endDate = $endTime.val();

            if (endDate != '') {
                var startDate = $startTime.val();
                if (compareDate(startDate, endDate)) {
                    $endTime.val(startDate)
                }
            }
        });
        $endTime.datepicker({
            autoclose: true,
            format: 'yyyy-mm-dd',
            todayHighlight: true,
            todayBtn: 'linked'
        }).on('change', function () {
            var startDate = $startTime.val();
            if (startDate != '') {
                var endDate = $endTime.val();
                if (compareDate(startDate, endDate)) {
                    $startTime.val(endDate)
                }
            }
        });

        //grid
        var $gridTable = $('#grid-table');

        var colModel = [
            {name: 'id', header: 'id', hidden: true},
            {name: 'dscr', header: 'dscr', hidden: true},
            {name: 'updEmpName', header: '操作用户'},
            {name: 'fromIp', header: '用户IP'},
            {name: 'updDate', header: '操作时间'},
            {name: 'urlDscr', header: '操作概述', sortable: false},
            {name: '', header: '操作数据', sortable: false, formatter: operationFormatter}

        ];

        function operationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary viewData">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            loadUrl: '${basePath}/syslog/load.do',
            height: '100%',
            autowidth : true,
            colModel: colModel,
            sortname: 'updDate',
            sortorder: 'desc',
            // caption: " 系统日志浏览",
            onSelectRow: function (id, stat, e) {
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                //查看

                if (className.indexOf('viewData') != -1) {
                    var rowData = $gridTable.jqGrid('getRowData', id);
                    var dscr = rowData.dscr;
                    viewData(dscr);
                }
            }
        });
        $gridTable.tjGrid("triggerResizeGrid");
        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        $searchBtn.click(function () {
            search();
        })

        var $searchForm = $("#searchForm");
        var $resetBtn = $("#resetBtn");
        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        })

        function search() {
            var searchName = $searchName.val();
            var startTime = $startTime.val();
            var endTime = $endTime.val();
            $gridTable.tjGrid('setPostData', {
                startTime: startTime,
                endTime: endTime,
                searchName: searchName
            });
            reloadGrid();
        }

        function compareDate(date1, date2) {
            return (new Date(date1.replace(/-/g, "//"))) >= (new Date(date2.replace(/-/g, "//")));
        }


        function viewData(dscr) {
            var array = dscr.split(";");
            var html = [];
            for (var i = 0; i < array.length - 1; i++) {
                var obj = array[i];
                obj = obj.split(":");
                var value = obj[1];
                if (obj[1].length > 45) {
                    value = value.substring(0, 41) + "...]";
                }
                html.push('<div class="alert alert-block alert-success">');
                html.push('<button class="close" type="button" data-dismiss="alert"><i class="ace-icon fa fa-times"></i></button>');
                html.push('<i class="ace-icon fa 	fa-comment-o green"></i>&nbsp;');
                html.push('<strong class="blue border">' + obj[0] + ':</strong><strong class="red border">' + value + '</strong>');
                html.push('</div>');
            }
            $dataContent.append(html.join(''));
            $dataDialog.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i> 操作数据</h4></div>",
                title_html: true,
                close: function () {
                    $dataContent.empty();
                    $dataDialog.remove();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 关闭",
                        "class": "btn btn-success",
                        click: function () {
                            $(this).dialog("close");

                        }
                    }
                ]
            });
        }

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>