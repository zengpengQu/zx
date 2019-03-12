<%--
  Created by IntelliJ IDEA.
  User: admin
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

<div class="tabable">
    <ul class="tabbale-uls" id="table" style="margin-bottom: 15px;">
        <li class="active" style="flex: unset;">
            <a data-toggle="tab" href="#nei" class="grid_tab">内行文</a>
        </li>
        <li style="    flex: unset;">
            <a data-toggle="tab" href="#wai" class="grid_tab">外行文</a>
        </li>
    </ul>
    <div class="tab-content" style="border: 0px;">
        <div class="tab-pane fade in active" id="nei">
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
                                                <form class="form-horizontal" role="form" id="searchForm">
                                                    <div class="row">
                                                        <div class="col-xs-4">
                                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-xs-4 control-label no-padding-left"
                                                                       for="form-title-title">标题：</label>
                                                                <div class="col-xs-8 ">
                                                                    <input class="form-control" type="text" id="form-title-title" name="title">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-4">
                                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-xs-4 control-label no-padding-left"
                                                                       for="form-field-orgName">报送部门：</label>
                                                                <div class="col-xs-8 ">
                                                                    <input class="form-control" type="text" id="form-field-orgName" name="orgName">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-4">
                                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-sm-4 control-label" style="padding-right: 20px;">报送日期:  </label>
                                                                <div class="col-sm-8">
                                                                    <div class="input-daterange input-group"
                                                                         data-date-format="yyyy-mm-dd">
                                                                        <input type="text" class="form-control"
                                                                               name="sendTimeStr" id="sendTimeStr"/>
                                                                        <span class="input-group-addon">
                                                                            <i class="fa fa-exchange"></i>
											                            </span>
                                                                        <input type="text" class="form-control"
                                                                               name="endTime" id="endTime"/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-4">
                                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-xs-4 control-label no-padding-left"
                                                                       for="form-field-reporter">签报人：</label>
                                                                <div class="col-xs-8 ">
                                                                    <input class="form-control" type="text" id="form-field-reporter" name="reporter">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-4">
                                                            <div class="col-xs-6 pull-right"
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
                                <button class="btn btn-info btn-sm" type="button" id="jumpBtn"
                                        style="top: 6px;right: 15px;">
                                    <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                    扫描
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="header-table-th">呈批件流转登记</div>
                            <div class="table-content col-md-12">
                                <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                                    <table id="grid-table" class="table_list"></table>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="wai">
            <div class="row" id="inWai">
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
                                                <form class="form-horizontal" role="form" id="searchFormWai">
                                                    <div class="row">
                                                        <div class="col-xs-4">
                                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-xs-4 control-label no-padding-left"
                                                                       for="form-field-titleWai">标题：</label>
                                                                <div class="col-xs-8 ">
                                                                    <input class="form-control" type="text" id="form-field-titleWai">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-4">
                                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-xs-4 control-label no-padding-left"
                                                                       for="form-field-deptName">承办单位：</label>
                                                                <div class="col-xs-8 ">
                                                                    <input class="form-control" type="text" id="form-field-deptName">
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="row">
                                                        <div class="col-xs-4">
                                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-sm-4 control-label" style="padding-right: 20px;">报送日期:  </label>
                                                                <div class="col-sm-8">
                                                                    <div class="input-daterange input-group"
                                                                         data-date-format="yyyy-mm-dd">
                                                                        <input type="text" class="form-control"
                                                                               name="sendTimeWai" id="sendTimeWai"/>
                                                                        <span class="input-group-addon">
												                                <i class="fa fa-exchange"></i>
											                            </span>
                                                                        <input type="text" class="form-control"
                                                                               name="endTimeWai" id="endTimeWai"/>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-4">
                                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                                <label class="col-xs-4 control-label no-padding-left"
                                                                       for="form-field-contractor">承办人：</label>
                                                                <div class="col-xs-8 ">
                                                                    <input class="form-control" type="text" id="form-field-contractor">
                                                                </div>
                                                            </div>
                                                        </div>
                                                        <div class="col-xs-4">
                                                            <div class="col-xs-6 pull-right"
                                                                 style="margin-top: 5px;margin-bottom: 5px">
                                                                <div class="btn-group pull-right">
                                                                    <button class="btn btn-success btn-sm" type="button"
                                                                            id="searchBtnWai">
                                                                        <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                                        查询
                                                                    </button>
                                                                    <button style="margin-right: 10px"
                                                                            class="btn btn-warning btn-sm" type="button"
                                                                            id="resetBtnWai">
                                                                        <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                                                        重置
                                                                    </button>
                                                                </div>
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
                                <button class="btn btn-info btn-sm" type="button" id="jumpBtnWai"
                                        style="top: 6px;right: 15px;">
                                    <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                    扫描
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="header-table-th">呈批件报送</div>
                            <div class="table-content col-md-12">
                                <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                                    <table id="grid-table-wai" class="table_list"></table>
                                </div>
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
    //当通过标签切换显示的时候,第二个jqgrid的宽度不能自适应。
    //解决:当标签切换完成的时候,重新设置jqgrid的宽度值等于其父元素的宽度值即可。
    $('.grid_tab').on('shown.bs.tab',function(){
        $($(this).attr('href')).find('.table_list').jqGrid(
            'setGridWidth',$($(this).attr('href')).find('.jqgrid_box').width());
    });

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
        var $startDate = $("#sendTimeStr");
        var $endDate = $("#endTime");
        var $title = $("#form-title-title");
        var $orgName = $("#form-field-orgName");
        var $reporter = $("#form-field-reporter");
        var $startDateWai = $("#sendTimeWai");
        var $endDateWai = $("#endTimeWai");
        var $titleWai = $("#form-field-titleWai");
        var $deptName = $("#form-field-deptName");
        var $contractor = $("#form-field-contractor");



        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $searchBtnWai = $("#searchBtnWai");
        var $resetBtnWai = $("#resetBtnWai");
        var $jumpBtn = $("#jumpBtn");
        var $jumpBtnWai = $("#jumpBtnWai");

        //表单类全局变量
        var $searchForm = $("#searchForm");
        var $searchFormWai = $("#searchFormWai");
        var $gridTable = $("#grid-table");
        var $gridTableWai = $("#grid-table-wai");

        //本页面url
        var loadUrl = '${basePath}/register-batch-nei/load-batch-register-list.do';
        var loadUrlWai = '${basePath}/register-batch-out/load-batch-register-wai-list.do';
        var transterUrl = '#page/register-batch-nei/batch-transfer-reg';
        var transterUrlWai = '#page/register-batch-out/batch-transfer-reg';

        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'title', header: '标题', index: 'title', sortable: true},
            {name: 'orgName', header: '报送部门', index: 'orgName', sortable: true},
            {name: 'sendTime', header: '上报时间', index: 'sendTime', sortable: false},
            {name: 'reporter', header: '签报人', index: 'reporter', sortable: false},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 150,
                fixed: true,
                formatter: basicOperationFormatter
            },
        ];
        var colModelWai = [{name: 'id', index: 'id', hidden: true},
            {name: 'title', header: '标题', index: 'title', sortable: true},
            {name: 'orgName', header: '来文单位', index: 'orgName', sortable: true},
            {name: 'deptName', header: '承办单位', index: 'deptName', sortable: true},
            {name: 'sendTime', header: '上报时间', index: 'sendTime', sortable: false},
            {name: 'contractor', header: '承办人', index: 'contractor', sortable: false},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            },
        ];
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
                var rowData = $gridTable.jqGrid('getRowData', id);

                if (className.indexOf('row-record-view') !== -1) {
                    G.pjaxLoadPageContentDiv(transterUrl + "?id=" + id + '&date=' + new Date().getTime());
                }
            }

    });

        $gridTableWai.tjGrid({
            loadUrl: loadUrlWai,
            height: '100%',
            autowidth: true,
            colModel: colModelWai,
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

                var rowData = $gridTableWai.jqGrid('getRowData', id);

                if (className.indexOf('row-record-view') !== -1) {
                    G.pjaxLoadPageContentDiv(transterUrlWai + "?id=" + id + '&date=' + new Date().getTime());
                }
            }

    });

        $gridTable.tjGrid("triggerResizeGrid");
        $gridTableWai.tjGrid("triggerResizeGrid");

        //扫描的页面跳转
        $jumpBtn.click(function () {
            G.pjaxLoadPageContentDiv("#page/register-batch-nei/batch-register-qcode");
        });
        $jumpBtnWai.click(function () {
            G.pjaxLoadPageContentDiv("#page/register-batch-out/batch-register-wai-qcode");
        });

        $searchBtn.click(function () {
            search();
        });
        $searchBtnWai.click(function () {
            searchWai();
        });
        function search() {

            var startDate = $startDate.val();
            var endDate = $endDate.val();
            var title = $title.val();
            var orgName = $orgName.val();
            var reporter = $reporter.val();

            $gridTable.tjGrid('setPostData', {
                sendTimeStr: startDate,
                endTime: endDate,
                title: title,
                orgName: orgName,
                reporter: reporter
            });
            reloadGrid();
        }
        function searchWai() {

            var startDateWai = $startDateWai.val();
            var endDateWai = $endDateWai.val();
            var titleWai = $titleWai.val();
            var deptName = $deptName.val();
            var contractor = $contractor.val();

            $gridTableWai.tjGrid('setPostData', {
                startDateWai: startDateWai,
                endDateStr: endDateWai,
                title: titleWai,
                deptName: deptName,
                contractor: contractor
            });
            reloadGridWai();
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }
        function reloadGridWai() {
            $gridTableWai.tjGrid('reloadGrid');
        }
        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });
        $resetBtnWai.click(function () {
            $searchFormWai.resetForm();
            searchWai();
        });


        function basicOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            var status = rowData.status;

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 登记');
            operations.push('</button>');
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

    });
</script>