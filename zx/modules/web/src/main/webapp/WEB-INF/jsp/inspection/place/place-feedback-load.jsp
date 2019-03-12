<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/26
  Time: 14:15
  To change this template use File | Settings | File Templates.
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>


<title>履职支撑平台</title>

<div class="row" style="background-color: lightgrey">
    <div class="col-sm-10 col-sm-offset-1">
        <!-- #section:pages/invoice -->
        <div class="widget-box">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <h2 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-size: 22px">
                                                活动安排&nbsp;&nbsp;&nbsp;基本信息</h2>
                                            <div class="hr hr-18 hr-double dotted"></div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label">活动名称：</label>
                                            <div class="col-sm-8 ">
                                                <label class=" control-label"><span class="required">${placeList.title}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label">
                                                活动类别：</label>

                                            <div class="col-sm-8 ">
                                                <label class=" control-label"><span class="required">${placeList.actTypeId}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label">
                                                承办单位：</label>

                                            <div class="col-sm-8 ">
                                                <label class=" control-label"><span class="required">${placeList.dicDept.deptName}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label">
                                                创建时间：</label>

                                            <div class="col-sm-8 ">
                                                <label class=" control-label"><span class="required">${placeList.jsonObject.createTime}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-12">
                                        <div class="hr hr-18 hr-double dotted"></div>
                                    </div>
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <h2 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-size: 22px">
                                                活动安排&nbsp;&nbsp;&nbsp;反馈信息</h2>
                                        </div>

                                    </div>

                                <c:forEach items="${feedbackList}" var="feedback" varStatus="feed">
                                   <%-- <div class="col-xs-12">
                                        <div class="hr hr-18 hr-double dotted"></div>
                                        <label class="col-sm-4 control-label" style="font-size: 16px;color: #2b7dbc">
                                            第&nbsp;${feed.index+1}&nbsp;条反馈信息 ：</label>
                                    </div>--%>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   > 反&nbsp;&nbsp;馈&nbsp;&nbsp;人：<span class="required"></span></label>
                                            <div class="col-sm-8">
                                                        <label class="control-label"><span class="required"> ${feedback.feedbackMan}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"> 反馈时间：<span class="required"></span></label>
                                            <div class="col-sm-8">
                                                <label class="control-label"><span class="required"> ${feedback.jsonObject.feedbackTime}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"> 率队领导：<span class="required"></span></label>
                                            <div class="col-sm-8">
                                                <label class="control-label"><span class="required"> ${feedback.teamLeader}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"> 团队规模：<span class="required"></span></label>
                                            <div class="col-sm-8">
                                                <label class="control-label"><span class="required"> ${feedback.groupScale}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"> 组织形式：<span class="required"></span></label>
                                            <div class="col-sm-8">
                                                <label class="control-label"><span class="required"> ${feedback.orgType}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"> 实际时间：<span class="required"></span></label>

                                            <div class="col-sm-8 ">
                                                <label class="control-label"><span class="required"> ${feedback.jsonObject.times}</span></label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"> 实际地点：<span class="required"></span></label>
                                            <div class="col-sm-8">
                                                <label class="control-label"><span class="required"> ${feedback.actualPlace}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<div class="col-xs-6">--%>
                                        <%--<div class="form-group">--%>
                                            <%--<label class="col-sm-4 control-label"> 备注信息：<span class="required"></span></label>--%>
                                            <%--<div class="col-sm-8">--%>
                                                <%--<label class="control-label"><span class="required"> ${feedback.notes}</span></label>--%>
                                            <%--</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"> 经&nbsp;&nbsp;办&nbsp;&nbsp;人：<span class="required"></span></label>

                                            <div class="col-sm-8">
                                                <label class="control-label"><span class="required"> ${feedback.agentName}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"> 联系方式：<span class="required"></span></label>
                                            <div class="col-sm-8 ">
                                                <label class="control-label"><span class="required"> ${feedback.agentMobile}</span></label>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"> 计划调整原因：<span class="required"></span></label>
                                            <div class="col-sm-8">
                                                <label class="control-label"><span class="required"> ${feedback.adjustmentReason}</span></label>
                                            </div>
                                        </div>
                                    </div>
                                </c:forEach>
                                </div>
                        </div><!-- /.col -->
                    </div><!-- /.row -->
                </div><!-- /.widget-main -->
            </div><!-- /.widget-body -->
        </div>

    </div>
</div>

