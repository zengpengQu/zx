<%--
  Created by IntelliJ IDEA.
  User: BT4900
  Date: 2018/8/1
  Time: 15:15
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
            一周工作情况反馈</h2>
    </div>

    <div class="hr hr-18 hr-double dotted"></div>

    <div class="profile-user-info">
        <div class="profile-info-row">
            <div class="profile-info-name"> 单位： </div>

            <div class="profile-info-value">
                <c:choose>
                    <c:when test="${workFeedbackVo.dicDept.deptName eq '' or workFeedbackVo.dicDept.deptName eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span>${workFeedbackVo.dicDept.deptName}</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="profile-info-name"> 填报人： </div>

            <div class="profile-info-value">
                <c:choose>
                    <c:when test="${workFeedbackVo.createName eq '' or workFeedbackVo.createName eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span>${workFeedbackVo.createName}</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="profile-info-name"> 联系电话： </div>

            <div class="profile-info-value">
                <c:choose>
                    <c:when test="${workFeedbackVo.phone eq '' or workFeedbackVo.phone eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span>${workFeedbackVo.phone}</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="profile-info-name"> 签发领导： </div>

            <div class="profile-info-value">
                <c:choose>
                    <c:when test="${workFeedbackVo.signLeader eq '' or workFeedbackVo.signLeader eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span>${workFeedbackVo.signLeader}</span>
                    </c:otherwise>
                </c:choose>
            </div>

            <div class="profile-info-name"> 报送日期： </div>

            <div class="profile-info-value">
                <c:choose>
                    <c:when test="${workFeedbackVo.feedbackDateStr eq '' or workFeedbackVo.feedbackDateStr eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span>${workFeedbackVo.feedbackDateStr}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="hr dotted"></div>

    <div class="profile-user-info">
        <div class="profile-info-row">
            <div class="profile-info-name"> 综合处长会议： </div>

            <div class="profile-info-value">
                <c:choose>
                    <c:when test="${workFeedbackVo.weekWork.meeting eq '' or workFeedbackVo.weekWork.meeting eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span>${workFeedbackVo.weekWork.meeting}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="hr dotted"></div>

    <div class="profile-user-info">
        <div class="profile-info-row">

            <c:choose>
                <c:when test="${workFeedbackVo.isAttend eq '0' or workFeedbackVo.isAttend eq null}">
                    <div class="profile-info-name"> 是否参加： </div>

                    <div class="profile-info-value">
                        <span>是</span>
                    </div>

                    <div class="profile-info-name"> 参加人员： </div>

                    <div class="profile-info-value">
                        <c:choose>
                            <c:when test="${workFeedbackVo.participants.empName eq '' or workFeedbackVo.participants.empName eq null}">
                                <span class="red empty-content">空</span>
                            </c:when>
                            <c:otherwise>
                                <span>${workFeedbackVo.participants.empName}</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="profile-info-name"> 是否参加： </div>

                    <div class="profile-info-value">
                        <span>否</span>
                    </div>

                    <div class="profile-info-name"> 请假理由： </div>

                    <div class="profile-info-value">
                        <c:choose>
                            <c:when test="${workFeedbackVo.reason eq '' or workFeedbackVo.reason eq null}">
                                <span class="red empty-content">空</span>
                            </c:when>
                            <c:otherwise>
                                <span>${workFeedbackVo.reason}</span>
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

            <div class="profile-info-name"> 本周工作情况： </div>

            <div class="profile-info-value" >
                <c:choose>
                    <c:when test="${workFeedbackVo.workContent eq '' or workFeedbackVo.workContent eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span style="word-break: normal;display: block;white-space: pre-wrap;
                        word-wrap: break-word;">${workFeedbackVo.workContent}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="hr dotted"></div>

    <div class="profile-user-info">
        <div class="profile-info-row">

            <div class="profile-info-name"> 下周工作安排： </div>

            <div class="profile-info-value">
                <c:choose>
                    <c:when test="${workFeedbackVo.workSchedule eq '' or workFeedbackVo.workSchedule eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span style="word-break: normal;display: block;white-space: pre-wrap;
                        word-wrap: break-word;">${workFeedbackVo.workSchedule}</span>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <div class="hr dotted"></div>

    <div class="profile-user-info">
        <div class="profile-info-row">

            <div class="profile-info-name"> 近期重点工作： </div>

            <div class="profile-info-value">
                <c:choose>
                    <c:when test="${workFeedbackVo.majorWork eq '' or workFeedbackVo.majorWork eq null}">
                        <span class="red empty-content">空</span>
                    </c:when>
                    <c:otherwise>
                        <span style="word-break: normal;display: block;white-space: pre-wrap;
                        word-wrap: break-word;">${workFeedbackVo.majorWork}</span>
                    </c:otherwise>
                </c:choose>

            </div>
        </div>
    </div>

    <div class="hr dotted"></div>

    <div class="form-group" style="margin-top: 5px;margin-bottom: 15px">
        <h4 align="center" style="font-weight:bolder;letter-spacing: 2pt">
            局级领导离京和脱产学习情况</h4>
    </div>

    <div class="col-sm-12">
        <table class="table table-striped table-bordered" id="workStudy"
               data-feedback="${workFeedbackVo.id}"
               name="workStudyList">
            <thead>
            <tr>
                <th class="center hide">id</th>
                <th class="center hide">是否删除</th>
                <th class="center" style="width: 15%">姓名</th>
                <th class="center" style="width: 18%">开始日期</th>
                <th class="center" style="width: 18%">截止日期</th>
                <th class="center" style="width: 17%">手机号</th>
                <th class="center" style="width: 25%">离京事由或脱产学习情况</th>
            </tr>
            </thead>

            <tbody>
            <c:if test="${!empty workFeedbackVo.workStudyList}">
                <c:forEach items="${workFeedbackVo.workStudyList}" var="workStudy"
                           varStatus="status">
                    <tr class="workStudy" data-id="${workStudy.id}">
                        <td class="center hide">${workStudy.id}</td>
                        <td class="center hide">${workStudy.delFlag}</td>
                        <td class="center">${workStudy.name}</td>
                        <td class="center">${workStudy.jsonObject.startDateStr}</td>
                        <td class="center">${workStudy.jsonObject.endDateStr}</td>
                        <td class="center">${workStudy.phone}</td>
                        <td class="center">${workStudy.reason}</td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${fn:length(workFeedbackVo.workStudyList) == 0}">
                <tr class="empty-row">
                    <th style="width: 100%" colspan="6" class="center">无内容！</th>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>

    <div class="form-group" style="margin-top: 5px;margin-bottom: 15px">
        <h4 align="center" style="font-weight:bolder;letter-spacing: 2pt">
            局级领导带班情况</h4>
    </div>

    <div class="col-sm-12">
        <table class="table table-striped table-bordered" id="workGuide"
               data-feedback="${workFeedbackVo.id}">
            <thead>
            <tr>
                <th class="center hide">id</th>
                <th class="center hide">是否删除</th>
                <th class="center">姓名</th>
                <th class="center">开始日期</th>
                <th class="center">截止日期</th>
                <th class="center">手机号</th>
            </tr>
            </thead>

            <tbody>
            <c:if test="${!empty workFeedbackVo.workGuideList}">
                <c:forEach items="${workFeedbackVo.workGuideList}" var="workGuide"
                           varStatus="status">
                    <tr class="workGuide" data-id="${workGuide.id}">
                        <td class="center hide">${workGuide.id}</td>
                        <td class="center hide">${workGuide.delFlag}</td>
                        <td class="center">${workGuide.name}</td>
                        <td class="center">${workGuide.jsonObject.startDateStr}</td>
                        <td class="center">${workGuide.jsonObject.endDateStr}</td>
                        <td class="center">${workGuide.phone}</td>
                    </tr>
                </c:forEach>
            </c:if>
            <c:if test="${fn:length(workFeedbackVo.workGuideList) == 0}">
                <tr class="empty-row">
                    <th style="width: 100%" colspan="5" class="center">无内容！</th>
                </tr>
            </c:if>
            </tbody>
        </table>
    </div>
</div><!-- /.col -->



