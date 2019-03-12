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
                    <span class="editable">${askReturnRecord.jsonObject.peopleName}</span>
                </div>
                <div class="profile-info-name" style="text-align: center">催还时间</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${askReturnRecord.jsonObject.askTime}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name" style="text-align: center">证件类型</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${askReturnRecord.jsonObject.permitTypeVal}</span>
                </div>
                <div class="profile-info-name" style="text-align: center">证件编号</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${askReturnRecord.jsonObject.documentCode}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name" style="text-align: center">催还人</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${askReturnRecord.jsonObject.userName}</span>
                </div>
                <div class="profile-info-name" style="text-align: center">创建时间</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${askReturnRecord.jsonObject.createTime}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name" style="text-align: center">催还内容</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${askReturnRecord.jsonObject.askContent}</span>
                </div>
                <div class="profile-info-name" style="text-align: center">备注</div>
                <div class="profile-info-value" style="text-align: center">
                    <span class="editable">${askReturnRecord.jsonObject.notes}</span>
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


