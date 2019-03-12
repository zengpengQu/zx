<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>

<div class="row">
    <div class="header-table-th">台湾社团信息详情</div>
    <div class="table-content col-md-12">
        <div class="col-xs-12" style="padding: 0px;">
            <div class="profile-user-info profile-user-info-striped" style="width: 100%">
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
                            <img src="${basePath}/file/download.action?id=${list.fileId}&&type=0" class="showImg" id="showImg" height="120px" width="120px">
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
                                        <tr class="giftsApplicationTr" data-item = {"id":"${politics.id}"}>
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
</div>
<!-- 返回 -->
<div class="clearfix">
    <div class="col-xs-12 center" style="margin-top: 15px;">
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
