<%--
  Created by IntelliJ IDEA.
  User: BT4900
  Date: 2018/8/27
  Time: 15:43
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

<div class="col-xs-12 col-sm-12 form-view-data">
    <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
        <h2 align="center" style="font-weight:bolder;letter-spacing: 2pt">
            领导活动安排反馈</h2>
    </div>

    <div class="hr hr-18 hr-double dotted"></div>

    <div class="profile-user-info">
        <div class="profile-info-row">
            <div class="profile-info-name"> 会议通知： </div>

            <div class="profile-info-value">
                <c:choose>
                    <c:when test="${model.activityPlan.content eq '' or model.activityPlan.content eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span>${model.activityPlan.content}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="hr dotted"></div>

    <div class="profile-user-info">
        <div class="profile-info-row">

            <div class="profile-info-name"> 与会领导： </div>

            <div class="profile-info-value">
                <c:choose>
                    <c:when test="${model.leaderName eq '' or model.leaderName eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span>${model.leaderName}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="hr dotted"></div>

    <div class="profile-user-info">
        <div class="profile-info-row">

            <c:choose>
                <c:when test="${model.isAttend eq '0' or model.isAttend eq null}">
                    <div class="profile-info-name"> 参会情况： </div>

                    <div class="profile-info-value">
                        <span>是</span>
                    </div>

                    <div class="profile-info-name"> 参加人员： </div>

                    <div class="profile-info-value">
                        <c:choose>
                            <c:when test="${model.leaderName eq '' or model.leaderName eq null}">
                                <span class="red empty-content">空</span>
                            </c:when>
                            <c:otherwise>
                                <span>${model.leaderName}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="profile-info-name"> 参会情况： </div>

                    <div class="profile-info-value">
                        <span>否</span>
                    </div>

                    <div class="profile-info-name"> 请假理由： </div>

                    <div class="profile-info-value">
                        <c:choose>
                            <c:when test="${model.reason eq '' or model.reason eq null}">
                                <span class="red empty-content">空</span>
                            </c:when>
                            <c:otherwise>
                                <span>${model.reason}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <div class="hr dotted"></div>

    <div class="profile-user-info">
        <div class="profile-info-row">

            <div class="profile-info-name"> 下周工作安排： </div>

            <div class="profile-info-value">
                <span>${model.jsonObject.startDateStr} 至 ${model.jsonObject.endDateStr}</span>
                <c:choose>
                    <c:when test="${model.workPlan eq '' or model.workPlan eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span>${model.workPlan}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</div><!-- /.col -->
