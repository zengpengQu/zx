<%--
  Created by IntelliJ IDEA.
  User: yx
  Date: 2018/7/31
  Time: 17:31
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

<div class="row" style="margin-top: 30px;">
    <div id="giftTab">
        <ul >
            <li >
                <a href="${basePath}/come/come-gift/gift-application-list?comeInfoId=${comeInfoId}" >
                    <i class="green ace-icon fa fa-pencil-square bigger-120"></i>
                    礼品申请
                </a>
            </li>

            <li >
                <a href="${basePath}/come/come-gift-recv/gift-receive?comeInfoId=${comeInfoId}" >
                    <i class="green ace-icon fa fa-pencil-square bigger-120"></i>
                    礼品受赠
                </a>
            </li>
        </ul>
    </div>
</div>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        $("#giftTab").tabs();

    });
</script>