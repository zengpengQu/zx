<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/4
  Time: 17:43
  新增/编辑用户分组
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

<div class="row">
    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-9 col-sm-offset-1">
                <div class="form-group">
                    <label class="col-sm-3 control-label no-padding-right"> &nbsp;&nbsp;&nbsp;活动&nbsp;&nbsp;&nbsp;标题：</label>
                        <div class="col-sm-9 ">
                            <label class="control-label no-padding-right">${correctList[0].placeList.title}</label>
                        </div>
                    </div>
                    <c:forEach var="correct" items="${correctList}" varStatus="start">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right"> 需调整内容&nbsp;${start.index+1}：</label>
                            <div class="col-sm-9 ">
                                <label class="control-label no-padding-right"> ${correct.text}<span class="required">&nbsp;&nbsp;</span></label>
                                <c:if test="${correct.state == '2'}"><span style="color: #3C6E31">(已调整)</span></c:if>
                                <c:if test="${correct.state != '2'}"><span style="color: red ">(未调整)</span></c:if>
                            </div>
                    </div>
                    </c:forEach>
                </div>
            </div>
    </div>
</div>