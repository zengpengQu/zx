<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
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
                                    <form class="form-horizontal" id="saveFormImport" role="form" method="post">
                                        <div class="hidden">
                                            <input type="text" id="abroadInfoId" name="abroadInfoId" value="${abroadInfoId}"/>
                                            <input type="text" id="comeInfoId" name="comeInfoId" value="${comeInfoId}"/>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-12">
                                                <div class="row">
                                                    <div class="col-xs-4">
                                                        <div class="form-group">
                                                            <label class="col-sm-4 control-label" for="search-userName">姓名:</label>
                                                            <div class="col-sm-8 ">
                                                                <input class="form-control" type="text" id="search-userName">
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-4">
                                                        <div class="form-group">
                                                            <label class="col-sm-3 control-label" for="search-deptId">单位:</label>

                                                            <div class="col-sm-9 deptDiv">
                                                                <input type="text" id="search-deptId" name="deptId"
                                                                       class="hide" value=""/>
                                                                <input type="text" id="form-field-deptName"
                                                                       readonly="readonly"<%-- style="width: 100%"--%>
                                                                       name="deptName" value="" style="cursor: pointer;"/>
                                                            </div>
                                                        </div>
                                                    </div>
                                                    <div class="col-xs-4 pull-right" style="margin-top: 5px;margin-bottom: 5px">
                                                        <div class="btn-group pull-right">
                                                            <button class="btn btn-success btn-sm" type="button" id="searchBtn">
                                                                <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>查询
                                                            </button>
                                                            <button class="btn btn-warning btn-sm" type="button" id="resetBtn">
                                                                <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                                                重置
                                                            </button>
                                                        </div>
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
                <!-- /section:custom/widget-box -->
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="header-table-th"></div>
                <div class="table-content  col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table-import"></table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(".accordion").accordion({
        collapsible: false,
        active: false,
        heightStyle: "content",
        animate: 250,
        header: ".accordion-header"
    });

    G.initDept('deptDiv',true,null,TREE_NODE);

    var $abroadInfoId = $("#abroadInfoId");
    var $comeInfoId = $("#comeInfoId");
    var $gridTableImport = $("#grid-table-import");
    var userUrl = '${basePath}/abroad-group-user/load-user-list.do';

    var $userName = $("#search-userName");
    var $deptId = $("#search-deptId");
    var $searchBtn = $("#searchBtn");
    var $resetBtn = $("#resetBtn");
    var $searchForm = $("#saveFormImport");

    var item_selected = [];

    var colModelImport = [
        {name: 'id', index: 'id', hidden: true},
        {name: 'empName', header: '姓名', index: 'empName', sortable: false},
        {name: 'sexStr', header: '性别', index: 'sexStr', sortable: false},
        {name: 'birthday', header: '出生日期', index: 'birthday', sortable: false},
        {name: 'deptName', header: '工作单位', index: 'deptName', sortable: false},
        {name: 'mainDuty', header: '主要职务', index: 'mainDuty', sortable: false}
    ];

    $gridTableImport.tjGrid({
        loadUrl: userUrl,
        height: '100%',
        width: '100%',
        autowidth: true,
        colModel: colModelImport,
        postData: {
            abroadInfoId: $abroadInfoId.val(),
            comeInfoId: $comeInfoId.val()
        },
        sortname: 'createDate',
        sortorder: 'desc',
        multiselect: true,
        onSelectRow: function (id, stat, e) {

            if (e === undefined) {
                return false;
            }
            var className = $(e.target).attr('class');
            if (!className) {
                return false;
            }
        },
        gridComplete: function () {
            var _this = this;
            if (item_selected.length > 0) {
                for (var i = 0; i < item_selected.length; i++) {
                    $(_this).tjGrid('setSelection', item_selected[i]);
                }
            }

            //调整表格宽度
            var parent_column = $gridTableImport.closest('[class*="col-"]');
            $gridTableImport.tjGrid("triggerResizeGrid");
            $gridTableImport.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
        },
        onSelectAll: function (aRowIds, status) {
            if (status) {
                item_selected = _.union(item_selected, aRowIds);
            } else {
                item_selected = _.difference(item_selected, aRowIds);
            }
        },
        beforeSelectRow: function (rowId) {
            var index = _.indexOf(item_selected, rowId);
            if (index == -1) {
                item_selected.push(rowId);
            } else {
                item_selected = _.pull(item_selected, rowId);
            }
        }
    });
    $gridTableImport.tjGrid('triggerResizeGrid');

    $searchBtn.click(function () {
        search();
    });

    $resetBtn.click(function () {
        $searchForm.resetForm();
        search();
    });

    function search() {
        var userName = $userName.val();
        var deptId = $deptId.val();
        $gridTableImport.tjGrid('setPostData', {
            userName: userName,
            deptId: deptId
        });
        $gridTableImport.tjGrid('reloadGrid');
    }
</script>
