<%--
  Created by IntelliJ IDEA.
  User: pengyx
  Date: 2018/6/14
  Time: 17:11
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

    <div>
        <c:if test="${!empty taiWanInfo}">
            <div class="black_head" style=" padding: 10px;">
                <div>
                        <c:forEach items="${taiWanInfo}" var="chronicle">
                            <c:forEach items="${chronicle.value}" var="chronicleValue">
                                <input type="radio" name="taiWanInfoUserName" value="${chronicle.key}">
                                <span style="font-size:15px;">部门：${chronicleValue.key}&nbsp;&nbsp;
                                <span style="font-size:15px">人员：&nbsp;${chronicleValue.value}</span>
                            </span>
                                </input>
                                <br>
                            </c:forEach>
                        </c:forEach>
                </div>
            </div>
        </c:if>
    </div>