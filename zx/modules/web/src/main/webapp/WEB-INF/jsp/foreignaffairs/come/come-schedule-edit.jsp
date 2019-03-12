<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/8/13
  Time: 17:24
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
<%--<script src="${basePath}/js/foreignaffairs/come/come-reception.js"></script>--%>
<div class="row" style="margin-top: 30px;">
    <div class="col-xs-12">
        <form id="scheduleDetailForm" role="form">
        <div class="row" style="margin-top: 20px">
            <div class="col-xs-12 form-horizontal">
                <div class="col-sm-6">
                    <label class="col-sm-4 control-label" for="form-field-activityDate">活动日期：<span
                            class="red">*</span></label>
                    <div class="col-sm-8">
                        <select class="form-control editable"
                                id="form-field-activityDate"
                                name="activityDateStr">
                            <option value="">----------请选择----------
                            </option>
                            <c:forEach items="${dateList}" var="date" varStatus="status">
                                <option value="${date}" <c:if test="${comeSchedule.jsonObject.activityDateStr eq date}">selected</c:if>>${date}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="col-sm-6">
                    <label class="col-sm-4 control-label" for="form-field-activityTime">活动时间：<span
                            class="red">*</span></label>
                    <div class="col-sm-8">
                        <div class="input-group">
                            <input id="form-field-activityTime" type="text"
                                   class="timepicker form-control editable"
                                   value="${comeSchedule.jsonObject.activityTimeStr}"
                                   name="activityTimeStr"/>
                            <span class="input-group-addon">
                                    <i class="fa fa-clock-o bigger-110"></i>
                                </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" style="margin-top: 10px">
            <div class="col-xs-12 form-horizontal">
                <label class="col-sm-2 control-label" for="form-field-activity">活动内容：<span
                        class="red">*</span></label>
                <div class="col-sm-10">
                    <textarea class="form-control limited editable"
                              id="form-field-activity"
                              name="activity"
                              style="min-height: 100px;">${comeSchedule.activity}</textarea>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="space-10"></div>
        </div>

    </form>
    </div>
</div>

