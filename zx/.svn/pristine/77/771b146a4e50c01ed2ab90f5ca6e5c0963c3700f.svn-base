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
    <div class="col-sm-10 col-sm-offset-1">
        <div style="border-bottom: 0px;margin-top: 20px;margin-bottom: 20px;padding-left: 10px;">
            <h4 class="widget-title" style="font-weight: bold; color: #00b3ee">
                <i class="ace-icon fa fa-leaf green"></i>
                礼品申请信息查看
            </h4>
        </div>
        <div class="profile-user-info profile-user-info-striped">
            <div class="profile-info-row">
                <div class="profile-info-name"> 申请单编码：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftApplication.applicationCode}</span>
                </div>
            </div>

            <div class="profile-info-row">
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
            </div>
            <div class="profile-info-row">
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
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 申请时间：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftApplication.jsonObject.applicationTime}</span>
                </div>
            </div>


            <div class="profile-info-row">
                <div class="profile-info-name"> 联系方式：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftApplication.contactWay}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 所属部门：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftApplication.unitName}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 申请事由：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftApplication.applicationCause}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 礼品清单：</div>
                <div class="profile-info-value">
                        <table id="simple-table" class="table  table-bordered table-hover">
                            <thead>
                            <tr>
                                <th class="center" style="width:20%;">编码</th>
                                <th class="center" style="width:40%;">名称</th>
                                <%--<th class="center" style="width:20%;">类型</th>--%>
                                <th class="center" style="width:15%;">数量</th>
                            </tr>
                            </thead>

                            <tbody id="giftsApplicationTBody">
                            <c:if test="${giftApplication.id ne null}">
                                <c:forEach items="${giftsApplicationList}" var="giftsApplication">
                                    <tr class="giftsApplicationTr" data-item = {"id":"${giftsApplication.id}"}>
                                        <td class="center">${giftsApplication.giftCode}</td>
                                        <td class="center">${giftsApplication.giftName}</td>
                                        <%--<td class="center">${giftsApplication.jsonObject.giftType}</td>--%>
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
    </div>
</div>

<div class="row">
    <div class="space-10"></div>
</div>
<div class="row">
    <div class="clearfix">
        <div class="col-xs-12 center">
            <button class="btn btn-primary btn-sm" type="button" id="backBtn">
                <i class="ace-icon fa fa-undo bigger-110"></i>
                返回
            </button>
        </div>
    </div>
</div>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        var $backBtn = $('#backBtn');
        $backBtn.click(function () {
            G.back();
        })
    });
</script>
