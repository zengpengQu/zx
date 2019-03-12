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
            <div class="col-xs-12">
                <div class="btn-group pull-right">
                    <button class="btn btn-info btn-sm" type="button" id="backBtn">
                        <span class="ace-icon fa fa-arrow-left  bigger-120"></span>
                        返回
                    </button>
                </div>
                <div class="pull-right">
                    <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10 mar_t_5"></i>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12 widget-container-col " style="padding-left: 33px;">
                <!-- #section:custom/widget-box -->
                <div class="accordion-style2 accordion">
                    <h5 class="accordion-header">出访信息</h5>
                    <div class="widget-body">
                        <div class="widget-main">
                            <div class="col-xs-12">
                                <form class="form-horizontal" role="form" id="searchForm">
                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                <label class="col-sm-5 text-right">团组活动编号:</label>
                                                <label class="col-sm-7 text-left">${abroadInfo.groupNumber}</label>
                                            </div>
                                        </div>
                                        <div class="col-xs-8">
                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                <label class="col-sm-5 text-right">团组活动名称:</label>
                                                <label class="col-sm-7 text-left">${abroadInfo.groupName}</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                <label class="col-sm-5 text-right">团长:</label>
                                                <label class="col-sm-7 text-left" id="groupLeader">${abroadInfo.groupLeader.empName }</label>
                                            </div>
                                        </div>
                                        <div class="col-xs-8">
                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                <label class="col-sm-5 text-right">主办单位:</label>
                                                <label class="col-sm-7 text-left">${abroadInfo.org.deptName}</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                <label class="col-sm-5 text-right">开始日期:</label>
                                                <label class="col-sm-7 text-left">${abroadInfo.jsonObject.startDateStr}</label>
                                            </div>
                                        </div>
                                        <div class="col-xs-8">
                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                <label class="col-sm-5 text-right">结束日期:</label>
                                                <label class="col-sm-7 text-left">${abroadInfo.jsonObject.endDateStr}</label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="row">
                                        <div class="col-xs-4">
                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                <label class="col-sm-5 text-right">任务批件号:</label>
                                                <label class="col-sm-7 text-left">${abroadInfo.batchNumber}</label>
                                            </div>
                                        </div>
                                        <div class="col-xs-8">
                                            <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                                <label class="col-sm-5 text-right">任务描述:</label>
                                                <label class="col-sm-7 text-left">${abroadInfo.taskDesc}</label>
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
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div id="tabs">
                    <ul class="tabbale-uls" style="padding-left: 17px;">
                        <li>
                            <a href="${basePath}/abroad-group/abroad-group-list?abroadInfoId=${abroadInfo.id}">团组信息</a>
                        </li>

                        <li>
                            <a href="${basePath}/abroad-nation/abroad-nation-list?abroadInfoId=${abroadInfo.id}">出访国家</a>
                        </li>

                        <li>
                            <a href="${basePath}/abroad-schedule/abroad-schedule-list?abroadInfoId=${abroadInfo.id}">日程信息</a>
                        </li>

                        <li>
                            <a href="${basePath}/abroad-gift/abroad-gift-list?abroadInfoId=${abroadInfo.id}">礼品方案</a>
                        </li>

                        <li>
                            <a href="${basePath}/abroad-vehicle/abroad-vehicle-list?abroadInfoId=${abroadInfo.id}">乘车信息</a>
                        </li>

                        <li>
                            <a href="${basePath}/abroad-housing/abroad-housing-list?abroadInfoId=${abroadInfo.id}">住房信息</a>
                        </li>

                        <li>
                            <a href="${basePath}/abroad-airplane/abroad-airplane-list?abroadInfoId=${abroadInfo.id}">乘机信息</a>
                        </li>

                        <li>
                            <a href="${basePath}/abroad-preparment/abroad-preparment-list?abroadInfoId=${abroadInfo.id}">筹备会议</a>
                        </li>

                        <li>
                            <a href="${basePath}/abroad-passport/abroad-passport-list?abroadInfoId=${abroadInfo.id}">护照签证</a>
                        </li>

                        <li>
                            <a href="${basePath}/abroad-chronicle/abroad-chronicle-list?abroadInfoId=${abroadInfo.id}">大事记</a>
                        </li>
                    </ul>

                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    //jquery tabs
    $( "#tabs" ).tabs();

    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        var $backBtn = $("#backBtn");
        $backBtn.click(function () {
            G.pjaxLoadPageContentDiv('#page/abroad-info/abroad-info-list?SubSecPopeDomViewId=58');
        });
    });
</script>
