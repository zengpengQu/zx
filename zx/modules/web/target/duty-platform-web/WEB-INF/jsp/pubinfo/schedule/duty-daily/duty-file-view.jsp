<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/7/4
  Time: 9:52
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>


<div class="row">

    <div class="col-xs-12">

        <div class="profile-user-info profile-user-info-striped">
            <div class="profile-info-row">
                <div class="profile-info-name"> 期数：</div>

                <div class="profile-info-value">
                    <span class="editable">${model.dutyNum}</span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 日期：</div>

                <div class="profile-info-value">
                    <span class="editable">${model.dutyTime}</span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 上传者：</div>

                <div class="profile-info-value">
                    <span class="editable">${model.uploader}</span>
                </div>
            </div>

            <div class="profile-info-row">
                <div class="profile-info-name"> 附件：</div>

                <div class="profile-info-value">
                    <span class="editable">${model.realName}</span>
                </div>
            </div>
        </div>
    </div>
</div>
