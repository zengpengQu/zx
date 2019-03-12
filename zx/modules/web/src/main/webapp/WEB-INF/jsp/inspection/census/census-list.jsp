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
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px;">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-place">省份:</label>
                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-place" name="place">
                                                            <option value="">请选择省份</option>
                                                            <c:forEach items="${districtList}" var="depts">
                                                                <option value="${depts.id}">${depts.districtName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-4">
                                                <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-nodeTime">年度:</label>

                                                    <div class="col-sm-8">
                                                        <div class="input-group">
                                                            <input class="form-control yearpicker"
                                                                   name="nodeTime"
                                                                   id="form-field-nodeTime"
                                                                   data-date-format="yyyy"
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
                                                           for="form-field-createTime">活动日期:</label>

                                                    <div class="col-sm-8 ">
                                                        <div class="input-group">
                                                            <input class="form-control datepickermouth"
                                                                   name="createTime"
                                                                   id="form-field-createTime"
                                                                   data-date-format="yyyy-mm-dd" value="" type="text"/>
                                                            <span class="input-group-addon"><i
                                                                    class="fa fa-calendar bigger-110"></i></span>
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
                                                        统计
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
            <div class="col-xs-12" style="margin-left: -8px;margin-bottom: 8px">
                <div class="btn-group pull-right">
                    <div class="btn-group pull-right">
                        <button style="margin-right: 10px"
                                class="btn btn-primary btn-sm" type="button"
                                id="exportBtn">
                            <span class="ace-icon glyphicon glyphicon-export icon-on-right bigger-110"></span>
                            导出Excel表格
                        </button>
                    </div>
                    <div class="pull-right">
                        <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
                <div class="col-xs-12">
                    <!-- PAGE CONTENT BEGINS -->
                    <div class="tabbable">

                        <div class="row">
                            <div class="col-xs-12">
                                <ul class="tabbale-uls">
                                    <li class="active" style="">
                                        <a data-toggle="tab" id="censusInFo1">
                                            <%--<i class="green ace-icon fa fa-eye bigger-120"></i>--%>
                                            视察考察调研安排表
                                        </a>
                                    </li>

                                    <li class="" style="">
                                        <a data-toggle="tab" id="censusInFo2">
                                            <%--<i class="green ace-icon fa fa-eye bigger-120"></i>--%>
                                            视察考察调研活动时间分表
                                        </a>
                                    </li>
                                    <li class="" style="">
                                        <a data-toggle="tab" id="censusInFo3">
                                            <%--<i class="green ace-icon fa fa-eye bigger-120"></i>--%>
                                            视察考察调研活动地区分表
                                        </a>
                                    </li>
                                    <li class="" style="">
                                        <a data-toggle="tab" id="censusInFo4">
                                            <%--<i class="green ace-icon fa fa-eye bigger-120"></i>--%>
                                            活动时间,地点分布表
                                        </a>
                                    </li>
                                    <li class="" style="">
                                        <a data-toggle="tab" id="censusInFo5">
                                            <%--<i class="green ace-icon fa fa-eye bigger-120"></i>--%>
                                            时间地点相对集中的活动
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="row" id="dept-hide">
                            <div class="col-xs-12" id="grid-table-Div">
                                <div class="header-table-th">视察考察调研活动数据浏览</div>
                                <div class="table-content col-xs-12">
                                    <table id="grid-table"></table>
                                </div>
                            </div>
                            <div class="col-xs-12" id="grid-dateType-Div">
                                <div class="header-table-th">视察考察调研活动数据浏览</div>
                                <div class="table-content col-xs-12">
                                    <div class="col-xs-12" id="place-table-Div"></div>
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
        $('.yearpicker').datepicker({
            starView: 'decade',
            minView: 'decade',
            format: 'yyyy',
            maxViewMode: 2,
            minViewMode: 2,
            autoclose: true
        });
        $('.datepickermouth').datetimepicker({
            format: 'yyyy-mm',
            autoclose: true,
            todayBtn: true,
            startView: 'year',
            minView: 'year',
            maxViewMode: 1,
            minViewMode: 1,
            language: 'zh-CN'
        });
        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        var excelDateOn = 1;

        //查询重置按钮
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $exportBtn = $("#exportBtn");


        var $searchForm = $("#searchForm");
        //查询条件全局变量
        var $place = $("#form-field-place");
        var $nodeTime = $("#form-field-nodeTime");
        var $createTime = $("#form-field-createTime");

        var $gridTable = $("#grid-table");
        var $placeTable = $("#place-table-Div");
        var $gridDateType = $("#grid-dateType-Div");

        var $gridTableDiv = $("#grid-table-Div");

        var loadCensusUrl = '${basePath}/census/load-census-List.do';

        var colModel = [{name: 'id', index: 'id', hidden: true},
            {name: 'placeId', index: 'placeId', hidden: true},
            {name: 'actTypeName', header: '类别', index: 'actTypeName', width: 50, sortable: false},
            {name: 'title', header: '标题', index: 'title', width: 65, sortable: true},
            {name: 'dicDeptName', header: '承办单位', index: 'dicDeptName', width: 60, sortable: false},
            {
                name: 'place',
                header: '地点',
                index: 'place',
                sortable: false,
                width: 70,
                title: false,
                formatter: placeFormatter
            },
            {
                name: 'dataTime',
                header: '活动时间',
                index: 'dataTime',
                sortable: false,
                width: 138,
                title: false,
                formatter: DateTimeFormatter
            },
            {name: 'nowTime', header: '年度', index: 'nowTime', hidden: true, sortable: true},
            {name: 'feedbackId', header: '反馈ID', index: 'feedbackId', hidden: true, sortable: true},
            {name: 'createTime', header: '创建时间', index: 'createTime', hidden: true, sortable: true}
        ];

        //地点
        function placeFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            var dateTypes = rowData.dateType;
            if (dateTypes != "") {
                if (dateTypes.length === 1) {
                    operations.push('<span style="color:#0f0f0f">&nbsp;&nbsp;&nbsp;&nbsp;');
                    operations.push(dateTypes[0]);
                    operations.push('</span>');
                } else {
                    operations.push('<table width="115%"  style="margin-left: -5px;margin-top: -14px;margin-bottom: -8px;">');
                    for (var i = 0; i < dateTypes.length; i++) {
                        operations.push('<tr width="100%">');
                        if (i === 0) {
                            operations.push('<td style="height: 44px;"><span style=" display: block;margin-bottom: -12px;');
                        } else {
                            operations.push('<td style="height: 38px;"><span style="');
                        }
                        operations.push('">&nbsp;&nbsp;&nbsp;&nbsp;');
                        operations.push(dateTypes[i]);
                        operations.push('</span></td></tr>');
                    }
                    operations.push('</table>');
                }
            }
            cellvalue = operations.join('');
            return cellvalue;
        }

        //时间 dataTimes
        function DateTimeFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            var dataTimes = rowData.dataTimes;
            if (dataTimes != "") {
                if (dataTimes.length === 1) {
                    operations.push('<span style="color:#0f0f0f">&nbsp;&nbsp;&nbsp;&nbsp;');
                    operations.push(dataTimes[0]);
                    operations.push('</span>');
                } else {
                    operations.push('<table width="115%"  style="margin-left: -5px;margin-top: -14px;margin-bottom: -8px;">');
                    for (var i = 0; i < dataTimes.length; i++) {
                        operations.push('<tr width="100%">');
                        if (i === 0) {
                            operations.push('<td style="height: 44px;"><span style=" display: block;margin-bottom: -12px;');
                        } else {
                            operations.push('<td style="height: 38px"><span style="');
                        }
                        operations.push('">&nbsp;&nbsp;&nbsp;&nbsp;');
                        operations.push(dataTimes[i]);
                        operations.push('</span></td></tr>');
                    }
                    operations.push('</table>');
                }
            }
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            loadUrl: loadCensusUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'createTime',
            sortorder: 'desc',
            gridComplete: function () {
                //调整表格宽度
                var parent_column = $gridTable.closest('[class*="col-"]');
                $gridTable.tjGrid("triggerResizeGrid");
                $gridTable.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});


            },
        });
        $gridDateType.hide()
        $gridTable.tjGrid("triggerResizeGrid");

        var $censusInFo1 = $("#censusInFo1");
        var $censusInFo2 = $("#censusInFo2");
        var $censusInFo3 = $("#censusInFo3");
        var $censusInFo4 = $("#censusInFo4");
        var $censusInFo5 = $("#censusInFo5");
        //数据统计，不包括未上报的
        //时间分表 根据上报时间
        $censusInFo1.click(censusInFo1);

        function censusInFo1() {
            var dateYear = $nodeTime.val();
            var createTime = $createTime.val();
            var place = $place.val();
            excelDateOn = 1;
            if (place === "" && dateYear === "" && createTime === "") {
                search();
                $gridDateType.hide()
                $gridTableDiv.show();
            } else {
                var str = "<div class='row'><div class='space-10'></div></div>";
                str += "<span style='font-size: 30px ;display:block;text-align: center;color:black;'>暂不支持查询</span>";
                $placeTable.show();
                $placeTable.html(str);
                $gridTableDiv.hide();
            }

        }

        //时间分表，每月的活动安排进行展示
        //查询条件，年度 和 会议日期月份 可以使用
        $censusInFo2.click(censusInFo2);

        function censusInFo2() {
            var dateYear = $nodeTime.val();
            var createTime = $createTime.val();
            var place = $place.val();
            excelDateOn = 2;
            $gridDateType.show();
            $placeTable.show();
            if (place === "") {
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: "${basePath}/dateType/load-timeTable-list.do",
                    type: "post",
                    dataType: 'json',
                    data: {'dateYear': dateYear, 'createTime': createTime},
                    success: function (date) {
                        G.doneAjaxLoading(loadId);
                        var str = "";
                        if (date.length == 0) {
                            str += "<div class='row'><div class='space-10'></div></div>";
                            str += "<span style='font-size: 30px ;display:block;text-align: center;color:black;'>暂无数据</span>"
                        } else {
                            str += "<table class='table  table-bordered table-hover' style='text-align: center;' id='timePlaceTable'>" +
                                "   <thead><tr>" +
                                "       <th></th>" +
                                "       <th>承办单位</th>" +
                                "       <th>标题</th>" +
                                "       <th>时间</th>" +
                                "       <th>地点</th>" +
                                "       <th>备注</th>" +
                                "   </tr></thead>" +
                                "   <tbody>";
                            var j = "0000";
                            for (var i = 0; i < date.length; i++) {
                                for (var p = 0; p <= 12; p++) {
                                    if (date[i].createTime === p.toString()) {
                                        if (j != p.toString()) {
                                            str += "<tr><td colspan='6' align='center'bgcolor='#C7FDFF'>" +
                                                date[i].dateYear + "年&nbsp;&nbsp;&nbsp;&nbsp;视察考察调研活动安排时间表（ " +
                                                date[i].createTime + " ）月</td></tr>";
                                            j = p.toString();
                                        }
                                        str += "<tr><td>" + (i + 1) + "</td>";
                                        str += "<td>" + date[i].deptName + "</td>";
                                        str += "<td>" + date[i].title + "</td>";
                                        str += "            <td>" + date[i].beginTimeStr + " 至 " + date[i].endTimeStr + "</td>";
                                        str += "            <td>" + date[i].place + "</td>";
                                        str += "            <td>" + date[i].notes + "</td></tr>";
                                    }
                                }
                            }
                            str += "      </tbody>" +
                                "</table>";
                        }
                        $placeTable.html(str);
                        $gridTableDiv.hide();
                        var s = $("#timePlaceTable")[0];
                        tableRowspan(s);
                    },
                    error: function () {
                        G.alert({message: "操作失败！"});
                    }
                });
            } else {
                var str = "<div class='row'><div class='space-10'></div></div>";
                str += "<span style='font-size: 30px ;display:block;text-align: center;color:black;'>暂不支持地区查询</span>";
                $placeTable.html(str);
                $gridTableDiv.hide();
            }
        }

        //地区分表
        $censusInFo3.click(censusInFo3);

        function censusInFo3() {
            var dateYear = $nodeTime.val();
            var place = $place.val();
            var createTime = $createTime.val();
            excelDateOn = 3;
            $gridDateType.show();
            $placeTable.show();
            if (createTime === "") {
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: "${basePath}/dateType/load-placeTable-list.do",
                    type: "post",
                    dataType: 'json',
                    data: {'dateYear': dateYear, 'place': place},
                    success: function (date) {
                        G.doneAjaxLoading(loadId);
                        var str = "";
                        if (date.length == 0) {
                            str += "<div class='row'><div class='space-10'></div></div>";
                            str += "<span style='font-size: 30px ;display:block;text-align: center;color:black;'>暂无数据</span>"
                        } else {
                            str += "<table class='table  table-bordered table-hover' id='timePlaceTable'>" +
                                "   <thead><tr>" +
                                "       <th></th>" +
                                "       <th>承办单位</th>" +
                                "       <th>标题</th>" +
                                "       <th>时间</th>" +
                                "       <th>地点</th>" +
                                "       <th>备注</th>" +
                                "   </tr></thead>" +
                                "   <tbody>";
                            var j = -1;
                            for (var i = 0; i < date.length; i++) {
                                for (var k = 0; k < 34; k++) {
                                    if (date[i].i === k.toString()) {
                                        if (j != date[i].i) {
                                            str += "<tr><td colspan='6' align='center'bgcolor='#C7FDFF'>" +
                                                date[i].dateYear + "年&nbsp;&nbsp;&nbsp;&nbsp;视察考察调研活动安排地区表（" + date[i].place + "）</td></tr>";
                                            j = date[i].i;
                                        }
                                        str += "<tr><td>" + (i + 1) + "</td>";
                                        str += "<td>" + date[i].deptName + "</td>";
                                        str += "<td>" + date[i].title + "</td>";
                                        str += "            <td>" + date[i].beginTimeStr + " 至 " + date[i].endTimeStr + "</td>";
                                        str += "            <td>" + date[i].place + "</td>";
                                        str += "            <td>" + date[i].notes + "</td></tr>";
                                    }
                                }
                            }
                            str += "      </tbody>" +
                                "</table>";
                        }
                        $placeTable.html(str);
                        $gridTableDiv.hide();
                        var s = $("#timePlaceTable")[0];
                        tableRowspan(s);
                    }, error: function () {
                        G.alert({message: "操作失败！"});
                    }
                });
            } else {
                var str = "<div class='row'><div class='space-10'></div></div>";
                str += "<span style='font-size: 30px ;display:block;text-align: center;color:black;'>暂不支持日期查询</span>";
                $placeTable.html(str);
                $gridTableDiv.hide();
            }
        }

        //时间地点分布列表
        //查询条件，年度和省份可以使用
        $censusInFo4.click(censusInFo4);

        function censusInFo4() {
            var dateYear = $nodeTime.val();
            var place = $place.val();
            var createTime = $createTime.val();
            excelDateOn = 4;
            if (createTime === "") {
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: "${basePath}/dateType/load-placeDateTable-list.do",
                    type: "post",
                    dataType: 'json',
                    data: {'dateYear': dateYear, 'place': place},
                    success: function (date) {
                        G.doneAjaxLoading(loadId);
                        $gridDateType.show();
                        $placeTable.show();
                        var str = "" +
                            "<table class='table  table-bordered table-hover'>" +
                            "   <thead><tr>" +
                            "       <th></th>" +
                            "       <th>地区</th>" +
                            "       <th>全年总数</th>" +
                            "       <th>1月</th>" +
                            "       <th>2月</th>" +
                            "       <th>3月</th>" +
                            "       <th>4月</th>" +
                            "       <th>5月</th>" +
                            "       <th>6月</th>" +
                            "       <th>7月</th>" +
                            "       <th>8月</th>" +
                            "       <th>9月</th>" +
                            "       <th>10月</th>" +
                            "       <th>11月</th>" +
                            "       <th>12月</th>" +
                            "       <th>待定</th>" +
                            "   </tr></thead>" +
                            "   <tbody>";
                        str += "<tr><td colspan='16' align='center'bgcolor='#C7FDFF'>（ " +
                            date[0].dateYear + " ） 时间地点分布列表</td></tr>";
                        for (var i = 0; i < date.length; i++) {

                            str += "        <tr>" +
                                "            <td>" + (i + 1) + "</td>" +
                                "<td>" + date[i].place + "</td>" +
                                "<td>" + date[i].count + "</td>";
                            if (date[i].yi == null) {
                                date[i].yi = 0;
                            }
                            str += "            <td>" + date[i].yi + "</td>";
                            if (date[i].er == null) {
                                date[i].er = 0;
                            }
                            str += "            <td>" + date[i].er + "</td>";
                            if (date[i].san == null) {
                                date[i].san = 0;
                            }
                            str += "            <td>" + date[i].san + "</td>";
                            if (date[i].si == null) {
                                date[i].si = 0;
                            }
                            str += "            <td>" + date[i].si + "</td>";
                            if (date[i].wu == null) {
                                date[i].wu = 0;
                            }
                            str += "            <td>" + date[i].wu + "</td>";
                            if (date[i].liu == null) {
                                date[i].liu = 0;
                            }
                            str += "            <td>" + date[i].liu + "</td>";
                            if (date[i].qi == null) {
                                date[i].qi = 0;
                            }
                            str += "            <td>" + date[i].qi + "</td>";
                            if (date[i].ba == null) {
                                date[i].ba = 0;
                            }
                            str += "            <td>" + date[i].ba + "</td>";
                            if (date[i].jiu == null) {
                                date[i].jiu = 0;
                            }
                            str += "            <td>" + date[i].jiu + "</td>";
                            if (date[i].shi == null) {
                                date[i].shi = 0;
                            }
                            str += "            <td>" + date[i].shi + "</td>";
                            if (date[i].yy == null) {
                                date[i].yy = 0;
                            }
                            str += "            <td>" + date[i].yy + "</td>";
                            if (date[i].ye == null) {
                                date[i].ye = 0;
                            }
                            str += "            <td>" + date[i].ye + "</td>";
                            if (date[i].ding == null) {
                                date[i].ding = 0;
                            }
                            str += "            <td>" + date[i].ding + "</td>" +
                                "        </tr>";
                        }
                        str += "      </tbody>" +
                            "</table>";

                        $placeTable.html(str);
                        $gridTableDiv.hide();
                    },
                    error: function () {
                        G.alert({message: "操作失败！"});
                    }
                });
            } else {
                var str = "<div class='row'><div class='space-10'></div></div>";
                str += "<span style='font-size: 30px ;display:block;text-align: center;color:black;'>暂不支持日期查询</span>";
                $placeTable.html(str);
                $gridTableDiv.hide();
            }

        }

        //时间地点相对集中
        $censusInFo5.click(censusInFo5);

        function censusInFo5() {
            //排序方式，类别，上报时间，地点
            var dateYear = $nodeTime.val();
            var place = $place.val();
            var createTime = $createTime.val();
            excelDateOn = 5;
            $gridDateType.show();
            $placeTable.show();
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: "${basePath}/dateType/load-placeTimeTable-list.do",
                type: "post",
                dataType: 'json',
                data: {'dateYear': dateYear, 'place': place, 'createTime': createTime},
                success: function (date) {
                    G.doneAjaxLoading(loadId);
                    var str = "";
                    if (date.length == 0) {
                        str += "<span style='font-size: 30px ;display:block;text-align: center;color:black;'>暂无数据</span>"
                    } else {
                        str += "<table class='table  table-bordered table-hover' id='timePlaceTable'>" +
                            "   <thead><tr>" +
                            "       <th></th>" +
                            "       <th>承办单位</th>" +
                            "       <th>标题</th>" +
                            "       <th>时间</th>" +
                            "       <th>地点</th>" +
                            "       <th>备注</th>" +
                            "   </tr></thead>" +
                            "   <tbody>";
                        var j = -1;
                        var jj = "-1";
                        for (var i = 0; i < date.length; i++) {
                            for (var k = 0; k < 34; k++) {
                                if (date[i].i === k.toString()) {
                                    if (j != date[i].i) {
                                        str += "<tr><td colspan='6' align='center'bgcolor='#2FDAFF' style='font-size: 18px'>" +
                                            date[i].dateYear + "  年度  " + date[i].place + "</td></tr>";
                                        j = date[i].i;
                                    }
                                    for (var p = 0; p <= 12; p++) {
                                        if (date[i].createTime === p.toString()) {
                                            if (jj != p.toString()) {
                                                str += "<tr><td colspan='6' align='center'bgcolor='#C7FDFF'>视察考察调研活动安排（ " +
                                                    date[i].createTime + " ）月</td></tr>";
                                                jj = p.toString();
                                            }
                                            str += "<tr><td>" + (i + 1) + "</td>";
                                            str += "<td>" + date[i].deptName + "</td>";
                                            str += "<td>" + date[i].title + "</td>";
                                            str += "            <td>" + date[i].beginTimeStr + " 至 " + date[i].endTimeStr + "</td>";
                                            str += "            <td>" + date[i].place + "</td>";
                                            str += "            <td>" + date[i].notes + "</td></tr>";
                                        }
                                    }
                                }
                            }
                        }
                        str += "      </tbody>" +
                            "</table>";
                    }
                    $placeTable.html(str);
                    $gridTableDiv.hide();
                    var s = $("#timePlaceTable")[0];
                    tableRowspan(s);
                }, error: function () {
                    G.alert({message: "操作失败！"});
                }
            });
        }

        //合并行
        function tableRowspan(table) {
            var val = "", count = 1, start, col = 5;
            if (table != undefined) {
                for (var i = 0; i < table.rows.length; i++) {
                    var le = table.rows[i].cells.length;
                    if (le != 1) {
                        if (val == table.rows[i].cells[col - 3].innerHTML) {
                            count++;
                        } else {
                            if (count > 1) {
                                start = i - count;
                                for (var j = start + 1; j < i; j++) {
                                    //删除多余行单元格
                                    table.rows[j].removeChild(table.rows[j].cells[col]);
                                    table.rows[j].removeChild(table.rows[j].cells[col - 3]);
                                    table.rows[j].removeChild(table.rows[j].cells[col - 4]);
                                }
                                //合并行
                                table.rows[start].cells[col].rowSpan = count;
                                table.rows[start].cells[col - 3].rowSpan = count;
                                table.rows[start].cells[col - 4].rowSpan = count;
                                //设置字体居中
                                table.rows[start].cells[col].style.cssText = "height:" + count * 35 + "px;line-height:" + count * 35 + "px;";
                                table.rows[start].cells[col - 3].style.cssText = "height:" + count * 35 + "px;line-height:" + count * 35 + "px;";
                                table.rows[start].cells[col - 4].style.cssText = "height:" + count * 35 + "px;line-height:" + count * 35 + "px;";
                                count = 1;
                            }
                            val = table.rows[i].cells[col - 3].innerHTML;
                        }
                    } else {
                        if (count > 1) {
                            start = i - count;
                            for (var j = start + 1; j < i; j++) {
                                //删除多余行单元格
                                table.rows[j].removeChild(table.rows[j].cells[col]);
                                table.rows[j].removeChild(table.rows[j].cells[col - 3]);
                                table.rows[j].removeChild(table.rows[j].cells[col - 4]);
                            }
                            //合并行
                            table.rows[start].cells[col].rowSpan = count;
                            table.rows[start].cells[col - 3].rowSpan = count;
                            table.rows[start].cells[col - 4].rowSpan = count;
                            //设置字体居中
                            table.rows[start].cells[col].style.cssText = "height:" + count * 35 + "px;line-height:" + count * 35 + "px;";
                            table.rows[start].cells[col - 3].style.cssText = "height:" + count * 35 + "px;line-height:" + count * 35 + "px;";
                            table.rows[start].cells[col - 4].style.cssText = "height:" + count * 35 + "px;line-height:" + count * 35 + "px;";
                            count = 1;
                        }
                        val = "";
                    }
                }
                if (count > 1) {
                    start = i - count;
                    //合并行
                    table.rows[start].cells[col].rowSpan = count;
                    table.rows[start].cells[col - 3].rowSpan = count;
                    table.rows[start].cells[col - 4].rowSpan = count;
                    //设置字体居中
                    table.rows[start].cells[col].style.cssText = "height:" + count * 35 + "px;line-height:" + count * 35 + "px;";
                    table.rows[start].cells[col - 3].style.cssText = "height:" + count * 35 + "px;line-height:" + count * 35 + "px;";
                    table.rows[start].cells[col - 4].style.cssText = "height:" + count * 35 + "px;line-height:" + count * 35 + "px;";
                    for (var j = start + 1; j < i; j++) {
                        //删除多余行单元格
                        table.rows[j].removeChild(table.rows[j].cells[col]);
                        table.rows[j].removeChild(table.rows[j].cells[col - 3]);
                        table.rows[j].removeChild(table.rows[j].cells[col - 4]);
                    }
                }
            }
        }


        //导出表格
        $exportBtn.click(function () {
            var excelDateOns = excelDateOn;
            var dateYear = $nodeTime.val();
            var place = $place.val();
            var createTime = $createTime.val();
            var bool = false;
            if (excelDateOns === 2) {
                if (place === "") {
                    bool = true;
                } else {
                    bool = false
                }
            }
            if (excelDateOns === 3) {
                if (createTime === "") {
                    bool = true;
                } else {
                    bool = false
                }
            }
            if (excelDateOns === 4) {
                if (createTime === "") {
                    bool = true;
                } else {
                    bool = false
                }
            }
            if (excelDateOns === 1) {
                if (place === "" && dateYear === "" && createTime === "") {
                    bool = true;
                } else {
                    bool = false
                }
            }
            if (excelDateOns === 5) {
                bool = true;
            }
            if (bool) {
                G.confirm({
                    message: '确认导出活动安排信息吗?',
                    callback: function (result) {
                        if (result) {
                            location.href = '${basePath}/dateType/export-excel.do?dateYear=' + dateYear + '&place=' + place +
                                '&createTime=' + createTime + '&excelDateOns=' + excelDateOns;
                        }
                    }
                });
            } else {
                G.showGritterSuccess("导出活动安排信息数据不存在！！！！");
            }
        });
        //统计按钮
        $searchBtn.click(function () {
            if (excelDateOn == 1) {
                censusInFo1();
            } else if (excelDateOn == 2) {
                censusInFo2();
            } else if (excelDateOn == 3) {
                censusInFo3();
            } else if (excelDateOn == 4) {
                censusInFo4();
            } else if (excelDateOn == 5) {
                censusInFo5();
            }
        });

        function search() {
            $gridTable.tjGrid('setPostData', {});
            $gridTable.tjGrid('reloadGrid');
        }

        $resetBtn.click(function () {
            $searchForm.resetForm();
            if (excelDateOn == 1) {
                censusInFo1();
            } else if (excelDateOn == 2) {
                censusInFo2();
            } else if (excelDateOn == 3) {
                censusInFo3();
            } else if (excelDateOn == 4) {
                censusInFo4();
            } else if (excelDateOn == 5) {
                censusInFo5();
            }
        });
        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });


</script>
<script src="/plugin/xlsx.full.min.js" type="text/javascript"></script>





