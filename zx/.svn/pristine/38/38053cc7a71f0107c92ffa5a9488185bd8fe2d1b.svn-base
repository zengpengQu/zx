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
                礼品库存信息查看
            </h4>
        </div>
        <div class="profile-user-info profile-user-info-striped">
            <div class="profile-info-row">
                <div class="profile-info-name"> 礼品名称：</div>
                <div class="profile-info-value">
                    <span class="editable">${giftInfo.giftName}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 礼品编码：</div>
                <div class="profile-info-value">
                    <span class="editable">${giftInfo.giftCode}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 礼品类型：</div>
                <div class="profile-info-value">
                    <span class="editable">${giftInfo.jsonObject.giftType}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 库存状态：</div>
                <div class="profile-info-value">
                    <span class="editable">${giftInfo.jsonObject.giftState}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 数量：</div>
                <div class="profile-info-value">
                    <span class="editable">${giftInfo.giftCount}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 单价：</div>
                <div class="profile-info-value">
                    <span class="editable">${giftInfo.giftPrice}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 所属货架：</div>
                <div class="profile-info-value">
                    <span class="editable">${giftInfo.giftShelves.frameCode}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 录入人：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftInfo.createName}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 录入时间：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftInfo.jsonObject.createTime}</span>
                </div>
            </div>
            <div class="profile-info-row">
                <div class="profile-info-name"> 说明：</div>

                <div class="profile-info-value">
                    <span class="editable">${giftInfo.giftInstruction}</span>
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
