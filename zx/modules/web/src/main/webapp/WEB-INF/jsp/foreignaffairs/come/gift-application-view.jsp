<%--
  Created by IntelliJ IDEA.
  User: yingji
  Date: 2018/8/16
  Time: 16:05
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
<div class="col-xs-12">
    <div class="profile-user-info profile-user-info-striped">
        <div class="profile-info-row">
            <div class="profile-info-name"> 申请单编码：</div>
            <div class="profile-info-value">
                <span class="editable">${giftApplication.applicationCode}</span>
            </div>

            <div class="profile-info-name"> 申请状态：</div>
            <div class="profile-info-value">
                <span class="editable">${giftApplication.jsonObject.applicationState}</span>
            </div>
        </div>

        <div class="profile-info-row">
            <div class="profile-info-name"> 活动名称：</div>
            <div class="profile-info-value">
                <span class="editable">${giftApplication.activityName}</span>
            </div>

            <div class="profile-info-name"> 活动类型：</div>
            <div class="profile-info-value">
                <span class="editable">${giftApplication.activityType}</span>
            </div>
        </div>

        <div class="profile-info-row">
            <div class="profile-info-name"> 申请人：</div>
            <div class="profile-info-value">
                <span class="editable">${giftApplication.applicationPerson}</span>
            </div>

            <div class="profile-info-name"> 申请时间：</div>
            <div class="profile-info-value">
                <span class="editable">${giftApplication.jsonObject.applicationTime}</span>
            </div>
        </div>

        <div class="profile-info-row">
            <div class="profile-info-name"> 所属部门：</div>
            <div class="profile-info-value">
                <span class="editable">${giftApplication.unitName}</span>
            </div>

            <div class="profile-info-name"> 联系方式：</div>
            <div class="profile-info-value">
                <span class="editable">${giftApplication.contactWay}</span>
            </div>
        </div>

    </div>

    <div class="profile-user-info profile-user-info-striped" style="border-top: none">
        <div class="profile-info-row">
            <div class="profile-info-name"> 申请事由：</div>
            <div class="profile-info-value">
                <span class="editable" style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;
                    word-wrap: break-word;overflow: hidden">${giftApplication.applicationCause}</span>
            </div>
        </div>
    </div>

    <div class="profile-user-info profile-user-info-striped" style="border-top: none">
        <div class="profile-info-row">
            <div class="profile-info-name"> 礼品清单：</div>
            <div class="profile-info-value">
                <table id="simple-table" class="table table-bordered table-hover">
                    <thead>
                    <tr>
                        <th class="center" style="width:20%;">编码</th>
                        <th class="center" style="width:40%;">名称</th>
                        <th class="center" style="width:15%;">数量</th>
                    </tr>
                    </thead>

                    <tbody id="giftsApplicationTBody">
                    <c:if test="${giftApplication.id ne null}">
                        <c:forEach items="${giftsApplicationList}" var="giftsApplication">
                            <tr class="giftsApplicationTr">
                                <td class="center">${giftsApplication.giftCode}</td>
                                <td class="center">${giftsApplication.giftName}</td>
                                <td class="center">${giftsApplication.giftCount}</td>
                            </tr>
                        </c:forEach>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
