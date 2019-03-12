<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>

<div style="background-color: white;">

    <%--内容部分--%>
    <button class="btn btn-sm btn-success pull-right"
            onclick="javascript:history.go(-1);">
        <i class="ace-icon fa fa-arrow-left  bigger-120"></i>
        返回
    </button>

    <div class="user-profile row" id="user-profile-1">
        <div class="col-xs-12 col-sm-3 center">
            <div>
                <div class="space-4"></div>

                <div class="width-80 label label-info label-xlg arrowed-in arrowed-in-right">
                    <div class="inline position-relative">
                        <a class="user-title-label dropdown-toggle" href="#" data-toggle="dropdown">
                            <span class="white">${user.empName}</span>
                        </a>
                    </div>
                </div>
            </div>

            <div class="space-6"></div>

            <!-- #section:pages/profile.contact -->
            <div class="profile-contact-info">
                <div class="profile-contact-links align-left">
                    <li class="btn btn-link">
                        <i class="ace-icon fa fa-globe bigger-125 blue"></i>
                        <c:if test="${user.isContact == '1'}">是</c:if>
                        <c:if test="${user.isContact != '1'}">非</c:if>
                        联络人
                    </li>
                    <c:if test="${user.isContact == '1'}">
                        <li class="btn btn-link">
                            <i class="ace-icon fa fa-envelope bigger-120 orange"></i>
                            <c:if test="${user.isFirstContact == '1'}">是</c:if>
                            <c:if test="${user.isFirstContact != '1'}">非</c:if>
                            第一联络人
                        </li>
                    </c:if>
                    <li class="btn btn-link">
                        <i class="ace-icon fa fa-plus-circle bigger-120 green"></i>
                        <c:if test="${user.isEmContact == '1'}">是</c:if>
                        <c:if test="${user.isEmContact != '1'}">非</c:if>
                        紧急联系人
                    </li>
                </div>

                <div class="space-6"></div>

                <div class="profile-social-links align-left">
                    <li title="" class="tooltip-info">
                        <span class="blue">&nbsp;系统登录名：</span>
                        <i class="ace-icon fa fa-user orange"></i><strong class="blue">&nbsp;${user.userId}</strong>

                    </li>
                    <li title="" class="tooltip-info align-left">
                        <span class="blue">&nbsp;激活状态：</span>
                        <c:if test="${user.isactive =='1'}"><i class="ace-icon fa fa-circle green"></i><span
                                class="green">&nbsp;已激活</span></c:if>
                        <c:if test="${user.isactive !='1'}"><i class="ace-icon fa fa-circle red"></i><span class="red">&nbsp;未激活</span></c:if>
                    </li>

                    <li title="" class="tooltip-info align-left">
                        <span class="blue">&nbsp;视频同步：</span>
                        <c:if test="${user.accordFlag =='1'}"><i class="ace-icon fa fa-circle green"></i><span
                                class="green">&nbsp;已同步</span></c:if>
                        <c:if test="${user.isactive =='1'}"><i class="ace-icon fa fa-circle red"></i><span class="red">&nbsp;未同步</span></c:if>

                    </li>

                </div>
            </div>

            <!-- /section:pages/profile.contact -->
            <div class="hr hr12 dotted"></div>

            <!-- #section:custom/extra.grid -->
            <div class="clearfix">
                <div class="grid2">
                    <span class="bigger-150 blue">机构</span>

                    <br>
                    ${user.dicDept.dicOrganization.orgName}
                </div>
                <div class="grid2">
                    <span class="bigger-150 blue">部门</span>

                    <br>
                    ${user.dicDept.deptName}
                </div>
            </div>
            <!-- /section:custom/extra.grid -->
            <div class="hr hr16 dotted"></div>
            <div class="pricing-span-body">
                <div class="widget-box pricing-box-small widget-color-blue">
                    <div class="widget-header">
                        <h5 class="widget-title bigger lighter">角色列表</h5>
                    </div>

                    <div class="widget-body">
                        <div class="widget-main no-padding">
                            <ul class="list-unstyled list-striped pricing-table">
                                <c:forEach items="${user.roleList}" var="role">
                                    <li> ${role.roleName} </li>
                                </c:forEach>
                            </ul>
                        </div>

                    </div>
                </div>
            </div>

        </div>

        <div class="col-xs-12 col-sm-9">

            <div class="space-12"></div>

            <!-- #section:pages/profile.info -->
            <div class="profile-user-info profile-user-info-striped">
                <div class="profile-info-row">
                    <div class="profile-info-name" > 用户名</div>

                    <div class="profile-info-value"style="width: 250px;">
                        <span class="editable" id="username">${user.empName}</span>
                    </div>
                    <div class="profile-info-name"> 性别</div>

                    <div class="profile-info-value">
                            <span class="editable">
                            <c:if test="${user.sex == '0'}">男</c:if>
                            <c:if test="${user.sex == '1'}">女</c:if>
                            </span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 账户创建时间</div>

                    <div class="profile-info-value">
                        <span class="editable"><fmt:formatDate value="${user.createDate}"
                                                               pattern="yyyy-MM-dd HH:mm"/></span>
                    </div>
                    <div class="profile-info-name"> 单位职务</div>

                    <div class="profile-info-value">
                        <i class="fa fa-map-marker light-orange bigger-110"></i>
                        <span class="editable" id="city">${user.position}</span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 邮箱</div>

                    <div class="profile-info-value">
                        <span class="editable" id="age">${user.email}</span>
                    </div>
                    <div class="profile-info-name"> 传真</div>

                    <div class="profile-info-value">
                        <span class="editable" id="signup">${user.fax}</span>
                    </div>
                </div>

                <div class="profile-info-row">
                    <div class="profile-info-name"> 手机号</div>

                    <div class="profile-info-value">
                        <span class="editable" id="login">${user.mobile}</span>
                    </div>
                    <div class="profile-info-name"> 办公电话</div>

                    <div class="profile-info-value">
                        <span class="editable">${user.phone}</span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> NOTES地址</div>

                    <div class="profile-info-value">
                        <span class="editable">${user.notes}</span>
                    </div>
                    <div class="profile-info-name"> 专业</div>

                    <div class="profile-info-value">
                        <span class="editable">${user.position}</span>
                    </div>
                </div>
                <div class="profile-info-row">
                    <div class="profile-info-name"> 人员职责</div>

                    <div class="profile-info-value">
                        <span class="editable">${user.dutynames}</span>
                    </div>
                    <div class="profile-info-name"> </div>

                    <div class="profile-info-value">
                        <span class="editable"></span>
                    </div>
                </div>
            </div>

            <!-- /section:pages/profile.info -->
            <div class="space-20"></div>

            <div class="widget-box transparent">
                <div class="widget-header widget-header-small">
                    <h4 class="widget-title blue smaller">
                        <i class="ace-icon fa fa-rss orange"></i>
                        操作记录
                    </h4>

                    <div class="widget-toolbar action-buttons">
                        <a href="#" data-action="collapse">
                            <i class="ace-icon fa fa-chevron-up"></i>
                        </a>
                    </div>
                </div>

                <div class="widget-body">
                    <div class="widget-main padding-8">

                        <div class="col-xs-12" style="z-index: 0;">
                            <table id="grid-table"></table>
                        </div>

                        <!-- /section:pages/profile.feed -->
                    </div>
                </div>
            </div>

            <div class="hr hr2 hr-double"></div>

            <div class="space-6"></div>

            <%--<div class="center">--%>
            <%--<button class="btn btn-sm btn-primary btn-white btn-round" type="button">--%>
            <%--<i class="ace-icon fa fa-rss bigger-150 middle orange2"></i>--%>
            <%--<span class="bigger-110">View more activities</span>--%>

            <%--<i class="icon-on-right ace-icon fa fa-arrow-right"></i>--%>
            <%--</button>--%>
            <%--</div>--%>
        </div>
    </div>
</div>


<script type="text/javascript">
    var scripts = [null, null]
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        var $gridTable = $('#grid-table');
        var colModel = [
            {name: 'id', header: 'id', hidden: true},
            {name: 'dscr', header: 'dscr', hidden: true},
            {name: 'updEmpName', header: '操作用户', width: 80},
            {name: 'fromIp', header: '用户IP', width: 100},
            {name: 'updDate', header: '操作时间', width: 70},
            {name: 'urlDscr', header: '操作概述', sortable: false, width: 80}
        ];

        $gridTable.tjGrid({
            loadUrl: '${basePath}/syslog/load.do?userId=' +${user.id},
            height: '100%',
            width: 700,
            colModel: colModel,
            sortname: 'updDate',
            sortorder: 'desc',
            caption: " ${user.empName}操作日志浏览"
        });

        $gridTable.tjGrid('bindResizeGrid');
    });
</script>

