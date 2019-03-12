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
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-peopleName">姓名：</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="peopleName" id="form-field-peopleName" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-documentCode">证件号码：</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="documentCode"
                                                               id="form-field-documentCode" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label">催还时间: </label>
                                                    <div class="col-sm-8">
                                                        <div class="input-daterange input-group"
                                                             data-date-format="yyyy-mm-dd">
                                                            <input type="text" class="form-control"
                                                                   name="startTime" id="form-field-startTime"/>
                                                            <span class="input-group-addon">
												            <i class="fa fa-exchange"></i>
											                </span>
                                                            <input type="text" class="form-control"
                                                                   name="endTime" id="form-field-endTime"/>
                                                        </div>
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
                <div class="header-table-th">催还记录列表</div>
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
        <div class="form-group">
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name" style="text-align: center">姓名</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="peopleName"></span>
                    </div>
                    <div class="profile-info-name" style="text-align: center">催还时间</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="askTime"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name" style="text-align: center">证件类型</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="permitTypeVal"></span>
                    </div>
                    <div class="profile-info-name" style="text-align: center">证件编号</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="documentCode"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name" style="text-align: center">催还人</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="userName"></span>
                    </div>
                    <div class="profile-info-name" style="text-align: center">创建时间</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="createTime"></span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name" style="text-align: center">催还内容</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="askContent"></span>
                    </div>
                    <div class="profile-info-name" style="text-align: center">备注</div>
                    <div class="profile-info-value" style="text-align: center">
                        <span class="editable" id="notes"></span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        $('.input-daterange').datepicker({autoclose: true, todayHighlight: true});

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //元素类全局变量
        var $peopleName = $("#form-field-peopleName");
        var $documentCode = $("#form-field-documentCode");
        var $startTime = $("#form-field-startTime");
        var $endTime = $("#form-field-endTime");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");

        //弹窗类全局变量
        var $viewDialog = $("#view-dialog");

        var loadUrl = '${basePath}/ask-return/load-ask-return-list.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'peopleName', header: '姓名', index: 'peopleName', sortable: true, width: 50},
            {name: 'documentCode', header: '证件号码', index: 'documentCode', sortable: true, width: 100},
            {name: 'askContent', header: '催还内容', index: 'askContent', sortable: true},
            {name: 'askTime', header: '催还时间', index: 'askTime', sortable: true,},
            {name: 'permitTypeVal', header: '证件类型', index: 'askTime', sortable: true,},
            {name: 'userName', header: '催还人', index: 'askTime', sortable: true,},
            {name: 'createTime', header: '创建时间', index: 'askTime', sortable: true,},
            {name: 'notes', header: '备注', index: 'askTime', sortable: true,},

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
            <c:if test="${'86_1' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
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
            // caption: "催还记录列表",
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
                    viewAskReturn(rowData);
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        function viewAskReturn(rowData) {
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
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看催还记录</h4></div>",
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
            var peopleName = $peopleName.val();
            var documentCode = $documentCode.val();
            var startTime = $startTime.val();
            var endTime = $endTime.val();
            $gridTable.tjGrid('setPostData', {
                peopleName: peopleName,
                documentCode: documentCode,
                startTime: startTime,
                endTime: endTime
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
            $.jgrid.gridDestroy("#grid-table");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>