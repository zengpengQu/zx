<%--
  Created by IntelliJ IDEA.
  User: pengyx
  Date: 2018/7/18
  Time: 10:56
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

<script src="${basePath}/plugin/ace/assets/js/chosen.jquery.js"></script>

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
                                    <form class="form-horizontal" role="form" autocomplete="off" id="searchForm">

                                        <div class="row">
                                            <!-- 团组级别 -->
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-groupLevel">团组级别:</label>
                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-groupLevel"
                                                                name="deptId">
                                                            <option value="">-----请选择-----</option>
                                                            <c:forEach items="${dicParamList}" var="dicParam">
                                                                <option value="${dicParam.id}">${dicParam.name}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 起止日期 -->
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label">起止日期: </label>
                                                    <div class="col-sm-8">
                                                        <div class="input-daterange input-group"
                                                             data-date-format="yyyy-mm-dd">
                                                            <input type="text" class="form-control"
                                                                   name="beginTime" id="beginTime"/>
                                                            <span class="input-group-addon">
												            <i class="fa fa-exchange"></i>
											                </span>
                                                            <input type="text" class="form-control"
                                                                   name="endTime" id="endTime"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- 国家名称 -->
                                            <%--<div class="col-xs-3">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-nationName">国家名称:</label>
                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-nationName"
                                                                name="nationId">
                                                            <option value="">-----请选择-----</option>
                                                            <c:forEach items="${dicNationList}" var="dicNation">
                                                                <option value="${dicNation.nationName}">${dicNation.nationName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>--%>
                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-xs-4 control-label"
                                                           for="form-field-nationName">国家名称：</label>
                                                    <div class="col-xs-8 ">
                                                        <input class="form-control" type="text"
                                                               id="form-field-nationName" name="nationId">
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-2 pull-right "
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
                <div class="header-table-th">大事记信息浏览</div>
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
                    <div class="profile-info-name"> 团组级别</div>

                    <div class="profile-info-value">
                        <span class="editable " id="groupLevel"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 团组名称</div>

                    <div class="profile-info-value">
                        <span class="editable " id="groupName"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 开始时间</div>

                    <div class="profile-info-value">
                        <span class="editable " id="beginTimeStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 结束时间</div>

                    <div class="profile-info-value">
                        <span class="editable " id="endTimeStr"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 内容</div>

                    <div class="profile-info-value">
                        <span class="editable " id="content"></span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 备注</div>

                    <div class="profile-info-value">
                        <span class="editable " id="notes"></span>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        //时间控件
        $('.input-daterange').datepicker({autoclose: true, todayHighlight: true});
        // G.datepicker();
        //搜索条件
        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });
        //元素类全局变量
        var $groupLevel = $("#form-field-groupLevel");
        var $beginTime = $("#beginTime");
        var $endTime = $("#endTime");
        var $nationName = $("#form-field-nationName");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $searchForm = $("#searchForm");

        //表单类全局变量
        var $gridTable = $("#grid-table");
        var $viewDialog = $("#view-dialog");

        //本页面url
        var loadUrl = '${basePath}/chronicle/load-chronicle-list.do';

        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'groupLevel', header: '团组级别', index: 'dicParam.name', sortable: true},
            {name: 'groupLevelId', header: '团组级别', index: 'dicParam.id', hidden: true, sortable: true},
            {name: 'groupName', header: '团组名称', index: 'groupName', sortable: true},
            {name: 'beginTimeStr', header: '开始时间', index: 'beginTime', sortable: true},
            {name: 'endTimeStr', header: '结束时间', index: 'endTime', sortable: true},
            {name: 'nationalName', header: '国家', index: 'nationalName', sortable: true},
            {name: 'content', header: '内容', index: 'content', sortable: true, cellattr:styleFormatter},
            {name: 'notes', header: '备注', index: 'notes', hidden: true, sortable: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];
        function styleFormatter() {
            return 'style="overflow: hidden; white-space: nowrap; text-overflow: ellipsis;"';
        }
        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];
            var status = rowData.status;

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'70_1' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue"></i> 查看');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        if(!ace.vars['touch']) {
            $('.chosen-select').chosen({allow_single_deselect:true});
            //resize the chosen on window resize
            $(window)
                .off('resize.chosen')
                .on('resize.chosen', function() {
                    $('.chosen-select').each(function() {
                        var $this = $(this);
                        $this.next().css({'width': $this.parent().width()});
                    })
                }).trigger('resize.chosen');
            //resize chosen on sidebar collapse/expand
            $(document).on('settings.ace.chosen', function(e, event_name, event_val) {
                if(event_name != 'sidebar_collapsed') return;
                $('.chosen-select').each(function() {
                    var $this = $(this);
                    $this.next().css({'width': $this.parent().width()});
                })
            });
        }

        //表格展示
        $gridTable.tjGrid({
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            postData: {
                groupLevel: $groupLevel.val(),
                beginTime: $beginTime.val(),
                endTime: $endTime.val(),
                nationalName: $nationName.val()
            },
            sortname: 'updateTime',
            sortorder: 'desc',
            // caption: "大事记信息浏览",
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $gridTable.jqGrid('getRowData', id);
                //查看
                if (className.indexOf('row-record-view') !== -1) {
                    viewDutyDaily(rowData);
                }
            }
        });

        //页面自适应
        $gridTable.tjGrid("triggerResizeGrid");

        //查看大事记信息
        function viewDutyDaily(rowData) {
            //为弹出框赋值
            $viewDialog.find('.editable').each(function () {
                $(this).html(rowData[$(this).attr('id')]);
            });
            initViewDialog($viewDialog);
        }

        //初始化查看大事记弹出框
        function initViewDialog($container) {

            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>查看大事记</h4></div>",
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

        //条件查询
        $searchBtn.click(function () {
            search();
        });

        function search() {
            var groupLevel = $groupLevel.val();
            var beginTime = $beginTime.val();
            var endTime = $endTime.val();
            var nationalName = $nationName.val();
            $gridTable.tjGrid('setPostData', {
                groupLevel: groupLevel,
                beginTime: beginTime,
                endTime: endTime,
                nationalName: nationalName
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
