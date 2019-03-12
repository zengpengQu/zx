<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/8/1
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>

<div class="row">
    <div class="col-xs-12">
        <div class="row" style="margin-top: 20px;">
            <div class="row">
                <div class="col-xs-12">
                    <!-- PAGE CONTENT BEGINS -->
                    <div class="tabbable">
                        <div class="row">
                            <div class="col-xs-8">
                                <%--<ul class="nav nav-tabs">
                                    <li class="active schedule">
                                        <a data-toggle="tab" id="censusInFo1">
                                            <i class="green ace-icon fa fa-eye bigger-120"></i>
                                            同一地点时间冲突
                                        </a>
                                    </li>

                                    <li class="edit">
                                        <a data-toggle="tab" id="censusInFo2">
                                            <i class="green ace-icon fa fa-eye bigger-120"></i>
                                            同一省份每月出现三次以上的
                                        </a>
                                    </li>
                                    <li class="edit">
                                        <a data-toggle="tab" id="censusInFo3">
                                            <i class="green ace-icon fa fa-eye bigger-120"></i>
                                            同一省份一年内出现六次以上的
                                        </a>
                                    </li>
                                </ul>--%>
                                <ul class="tabbale-uls" style="margin-bottom: 15px;">
                                    <li class="active">
                                        <a data-toggle="tab" id="censusInFo1">同一地点时间冲突</a>
                                    </li>
                                    <li class="edit">
                                        <a data-toggle="tab" id="censusInFo2">同一省份每月三次以上</a>
                                    </li>
                                    <li class="edit">
                                        <a data-toggle="tab" id="censusInFo3">同一省份一年内六次以上</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="header-table-th">视察考察调研活动统计</div>
                                <div class="table-content col-md-12">
                                    <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                                        <table id="grid-dateType-table" class="table_list"></table>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                    <!-- /section:elements.tab -->
                </div>

                <!-- PAGE CONTENT ENDS -->
            </div><!-- /.col -->
        </div>
    </div>
</div>
<script type="text/javascript">
    var scripts = [null, null];

    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        G.datepicker();
        $(".accordion").accordion({
            collapsible: true,
            active: true,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        var $gridDateTypeTable = $("#grid-dateType-table");

        var loadCensusUrl = '${basePath}/dateType/load-clash-list.do';

        var colModel2 = [{name: 'id', index: 'id', hidden: true},
            {name: 'placeId', index: 'placeId', hidden: true},
            {
                name: 'actTypeName', header: '类别', index: 'actTypeName', width: 50, sortable: false, cellattr: function
                    (rowId, tv, rawObject, cm, rdata) {
                    return 'id=\'actTypeName' + rowId + "\'";
                }
            },
            {
                name: 'dicDeptName',
                header: '承办单位',
                index: 'dicDeptName',
                width: 60,
                sortable: false,
                cellattr: function
                    (rowId, tv, rawObject, cm, rdata) {
                    return 'id=\'dicDeptName' + rowId + "\'";
                }
            },
            {
                name: 'title', header: '标题', index: 'title', width: 65, sortable: false, cellattr: function
                    (rowId, tv, rawObject, cm, rdata) {
                    return 'id=\'title' + rowId + "\'";
                }
            },


            {name: 'place', header: '地点', index: 'place', sortable: false, width: 70, title: false},
            {name: 'dataTime', header: '活动时间', index: 'dataTime', sortable: false, width: 138, title: false},
            {name: 'nowTime', header: '年度', index: 'nowTime', hidden: true, sortable: true},
            {name: 'feedbackId', header: '反馈ID', index: 'feedbackId', hidden: true, sortable: true},
            {name: 'createTime', header: '创建时间', index: 'createTime', hidden: true, sortable: true}
        ];

        $gridDateTypeTable.tjGrid({
            loadUrl: loadCensusUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel2,
            //sortname: 'placeTime',
            sortorder: 'desc',
            /*caption: '视察考察调研活动统计',*/
            gridComplete: function () {
                // MergerStatistics($gridDateTypeTable,'actTypeName');
                MergerStatistics($gridDateTypeTable, 'title');
                // MergerStatistics($gridDateTypeTable,'dicDeptName');

                //调整表格宽度
                var parent_column = $gridDateTypeTable.closest('[class*="col-"]');
                $gridDateTypeTable.tjGrid("triggerResizeGrid");
                $gridDateTypeTable.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
            }
        });

        //表格合并
        function MergerStatistics(gridName, CellName) {
            var mya = gridName.getDataIDs();
            var length1 = mya.length;
            for (var i = 0; i < length1; i++) {
                var before = gridName.jqGrid('getRowData', mya[i]);
                var rowSpanTaxCount = 1;
                for (var j = i + 1; j <= length1; j++) {
                    var end = gridName.jqGrid('getRowData', mya[j]);
                    //var cellNames = CellName.split(",");
                    //for(var n = 0; n<cellNames.length;n++){
                    if (before[CellName] == end[CellName]) {
                        rowSpanTaxCount++;
                        gridName.setCell(mya[j], CellName, '', {display: 'none'});
                        gridName.setCell(mya[j], 'actTypeName', '', {display: 'none'});
                        gridName.setCell(mya[j], 'dicDeptName', '', {display: 'none'});
                    } else {
                        rowSpanTaxCount = 1;
                        break;
                    }
                    $("#" + CellName + "" + mya[i] + "").attr("rowspan", rowSpanTaxCount);
                    $("#actTypeName" + mya[i] + "").attr("rowspan", rowSpanTaxCount);
                    $("#dicDeptName" + mya[i] + "").attr("rowspan", rowSpanTaxCount);


                    // }
                }
            }
        }

        var $censusInFo1 = $("#censusInFo1");
        var $censusInFo2 = $("#censusInFo2");
        var $censusInFo3 = $("#censusInFo3");
        //数据统计，不包括未上报的
        //时间分表 根据上报时间
        $censusInFo1.click(function () {
            opentable("placeTime");
        });
        //
        $censusInFo2.click(function () {
            //排序方式，类别，活动ID，活动标题，地点
            opentable("monthTime");
        });
        $censusInFo3.click(function () {
            //排序方式，类别，地点
            opentable("yearTime");
        });

        function opentable(sortName) {
            $gridDateTypeTable.tjGrid('setPostData', {
                sortName: sortName
            });
            $gridDateTypeTable.tjGrid('reloadGrid');
        }

    });


</script>
<script src="/plugin/xlsx.full.min.js" type="text/javascript"></script>
