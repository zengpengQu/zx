<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/8/11
  Time: 10:39
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
                                <div class="form-group">
                                    <input id="id-come-info" name="id" type="hidden" value="${comeInfo.id}"/>

                                    <div class="profile-user-info profile-user-info-striped">
                                        <div class="profile-info-row">
                                            <div class="profile-info-name" style="text-align: center">主办单位</div>
                                            <div class="profile-info-value" style="text-align: left">
                                                <span class="editable">${comeInfo.dicDept.getDeptName()}</span>
                                            </div>

                                            <div class="profile-info-name" style="text-align: center">团长姓名</div>
                                            <div class="profile-info-value" style="text-align: left">
                                                <span class="editable">${comeInfo.cnName}</span>
                                            </div>

                                            <div class="profile-info-name" style="text-align: center">来访团国家</div>
                                            <div class="profile-info-value" style="text-align: left">
                                                <span class="editable">${comeInfo.countryId}</span>
                                            </div>
                                        </div>

                                        <div class="profile-info-row">
                                            <div class="profile-info-name" style="text-align: center">开始日期</div>
                                            <div class="profile-info-value" style="text-align: left">
                                                <span class="editable">${startDateStr}</span>
                                            </div>

                                            <div class="profile-info-name" style="text-align: center">结束日期</div>
                                            <div class="profile-info-value" style="text-align: left">
                                                <span class="editable">${endDateStr}</span>
                                            </div>

                                            <div class="profile-info-name" style="text-align: center">来访团人数</div>
                                            <div class="profile-info-value" style="text-align: left">
                                                <span class="editable">${comeInfo.peopleNum}</span>
                                            </div>
                                        </div>


                                    </div>
                                    <div class="profile-user-info profile-user-info-striped" style="border-top: none">
                                        <div class="profile-info-row">
                                            <div class="profile-info-name" style="text-align: center">任务描述</div>
                                            <div class="profile-info-value" style="word-break: break-all; display: block;white-space: pre-line;
                                                word-wrap: break-word;overflow: hidden">
                                                <div class="editable">${comeInfo.taskDscr}</div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="space-20"></div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <div id="tabs">
                    <ul class="tabbale-uls">
                        <li>
                            <a href="${basePath}/come/come-reception/load-come-reception?comeInfoId=${comeInfo.id}">接待计划</a>
                        </li>

                        <li>
                            <a href="${basePath}/come/come-schedule/load-come-schedule?comeInfoId=${comeInfo.id}">日程管理</a>
                        </li>

                        <li>
                            <a href="${basePath}/come/come-nameBook/load-come-nameBook?comeInfoId=${comeInfo.id}">人员名单</a>
                        </li>

                        <li>
                            <a href="${basePath}/come/come-gift/load-come-gift?comeInfoId=${comeInfo.id}">礼品信息</a>
                        </li>

                        <li>
                            <a href="${basePath}/come/come-report/load-come-report?comeInfoId=${comeInfo.id}">来访简报</a>
                        </li>

                        <li>
                            <a href="${basePath}/come/come-chronicle/load-come-chronicle?comeInfoId=${comeInfo.id}">大事记</a>
                        </li>
                    </ul>

                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        //jquery tabs
        $("#tabs").tabs({
            heightStyle: 'content'
        });

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        var $backBtn = $("#backBtn");

        // 返回来访管理列表
        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            G.pjaxLoadPageContentDiv("#page/come/come-info-list?SubSecPopeDomViewId=59");
        });


    });

</script>
