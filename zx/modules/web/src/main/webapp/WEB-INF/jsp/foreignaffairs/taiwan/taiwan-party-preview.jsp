<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>

<div class="page" contenteditable="true">
    <div class="red_head" align="center" style=" padding: 10px;">
        <div class="col-xs-11" style="margin-left: 45px">
            <div class="profile-user-info profile-user-info-striped">
                <!-- 社团名称 -->
                <div class="profile-info-row">
                    <div class="profile-info-name"> 社团名称：</div>
                    <div class="profile-info-value">
                        <span class="editable" style="width: 200px">${taiWanParty.jsonObject.partyName}</span>
                    </div>
                </div>
                <!-- 社团简介 -->
                <div class="profile-info-row">
                    <div class="profile-info-name"> 社团简介：</div>
                    <div class="profile-info-value">
                        <span class="editable">${taiWanParty.jsonObject.partyDesc}</span>
                    </div>
                </div>
                <!-- 与政协交往情况 -->
                <div class="profile-info-row">
                    <div class="profile-info-name"> 与政协交往情况：</div>
                    <div class="profile-info-value">
                        <span class="editable">${taiWanParty.jsonObject.cppccInteract}</span>
                    </div>
                </div>
                <!-- 社团图片-->
                <c:if test="${list.size() ne 0}">
                    <div class="profile-info-row">
                        <div class="profile-info-name"> 社团图片：</div>
                        <div class="profile-info-value">
                            <c:forEach items="${list}" var="list">
                                <img src="${basePath}/file/download.action?id=${list.fileId}&&type=0" id="showImg"
                                     height="100px" width="100px">
                            </c:forEach>
                        </div>
                    </div>
                </c:if>
                <!--社团下人员信息-->
                <div class="profile-info-row">
                    <div class="profile-info-name"> 社团下人员信息：</div>
                    <div class="profile-info-value">
                        <table id="simple-table" class="table  table-bordered table-hover">
                            <thead>
                            <tr>
                                <th class="center" style="width:15%;">姓名</th>
                                <th class="center" style="width:15%;">性别</th>
                                <th class="center" style="width:20%;">出生日期</th>
                                <th class="center" style="width:30%;">单位</th>
                                <th class="center" style="width:30%;">职务</th>
                            </tr>
                            </thead>

                            <tbody>
                            <c:if test="${politicsList ne null}">
                                <c:forEach items="${politicsList}" var="politics">
                                    <tr class="giftsApplicationTr" data-item={"id":"${politics.id}"}>
                                        <td class="center">${politics.jsonObject.mainName}</td>
                                        <td class="center">${politics.jsonObject.gender}</td>
                                        <td class="center">${politics.jsonObject.birthday}</td>
                                        <td class="center">${politics.jsonObject.belongOrg}</td>
                                        <td class="center">${politics.jsonObject.duty}</td>
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
