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
    <div class="form-group">
        <div class="profile-user-info profile-user-info-striped">
            <div class="profile-info-row">
                <div class="profile-info-name" style="text-align: center">姓名</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${privateAbroad.jsonObject.empName}</span>
                </div>
                <div class="profile-info-name" style="text-align: center">工作部门</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${privateAbroad.jsonObject.department}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name" style="text-align: center">出国开始时间</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${privateAbroad.jsonObject.startTime}</span>
                </div>
                <div class="profile-info-name" style="text-align: center">出国结束时间</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${privateAbroad.jsonObject.endTime}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name" style="text-align: center">团组名称</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${privateAbroad.groupName}</span>
                </div>
                <div class="profile-info-name" style="text-align: center">组团单位</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${privateAbroad.jsonObject.groupDepartment}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name" style="text-align: center">创建时间</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${privateAbroad.jsonObject.createTime}</span>
                </div>
                <div class="profile-info-name" style="text-align: center">备注</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${privateAbroad.notes}</span>
                </div>
            </div>
        </div>&nbsp;
        <div class="clearfix">
            <div class="col-xs-12 center">
                <button class="btn btn-primary btn-sm" type="button" id="backBtn">
                    <i class="ace-icon fa fa-undo bigger-110"></i>
                    返回
                </button>
            </div>
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


