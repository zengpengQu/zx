<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
<div class="row">
    <div class="col-xs-12">
        <div style="margin-top: 20px">
            <div class="widget-body">
                <div class="widget-main padding-8" style="height: 300px">
                    <form class="form-horizontal" id="saveFormGroup" role="form" method="post">
                        <input id="form-field-id" name="id" type="hidden" value="${abroadGroup.id}">

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-name">姓名：<span class="red">*</span></label>
                            <div class="col-xs-4 ">
                                <input type="text" id="form-field-name" name="name" class="form-control remote" placeholder="姓名" value="${abroadGroup.name}"/>
                            </div>
                            <label class="col-xs-2 control-label" for="form-field-sex">性别：<span class="red">*</span></label>
                            <div class="col-xs-4 ">
                                <select class="form-control" id="form-field-sex" name="sex">
                                    <option value="">-----请选择-----</option>
                                    <option value="0" <c:if test="${abroadGroup.sex eq 0}">selected</c:if> >男</option>
                                    <option value="1" <c:if test="${abroadGroup.sex eq 1}">selected</c:if> >女</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-birthdayStr">出生日期：<span class="red">*</span></label>
                            <div class="col-xs-4 ">
                                <input class="form-control date-picker" name="birthdayStr" id="form-field-birthdayStr" data-date-format="yyyy-mm-dd" value="${abroadGroup.jsonObject.birthdayStr}" placeholder="出生日期" type="text"/>
                            </div>
                            <label class="col-xs-2 control-label" for="form-field-homeplace">出生地：<span class="red">*</span></label>
                            <div class="col-xs-4 ">
                                <input type="text" id="form-field-homeplace" name="homeplace" class="form-control remote"
                                       placeholder="出生地" value="${abroadGroup.homeplace}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-org">工作单位：<span class="red">*</span></label>
                            <div class="col-xs-4 ">
                                <input type="text" id="form-field-org" name="org" class="form-control remote" placeholder="工作单位" value="${abroadGroup.org}"/>
                            </div>
                            <label class="col-xs-2 control-label" for="form-field-duty">主要职务：<span class="red">*</span></label>
                            <div class="col-xs-4 ">
                                <input type="text" id="form-field-duty" name="duty" class="form-control remote" placeholder="主要职务" value="${abroadGroup.duty}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-tel">联系方式：<span class="red">*</span></label>
                            <div class="col-xs-4 ">
                                <input type="text" id="form-field-tel" name="tel" class="form-control remote" placeholder="联系方式" value="${abroadGroup.tel}"/>
                            </div>
                            <label class="col-xs-2 control-label" for="form-field-role">角色：<span class="red">*</span></label>
                            <div class="col-xs-4 ">
                                <select class="form-control" id="form-field-role" style="background-color: #eeeeee" name="roleId">
                                    <option value="">---------请选择---------</option>
                                    <c:forEach items="${roleList}" var="role">
                                        <option value="${role.id}"
                                                <%--<c:if test="${abroadGroup.role.id eq 1201}">disabled</c:if>--%>
                                                <c:if test="${abroadGroup.role.id eq role.id}">selected</c:if>
                                        >${role.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-identity">对外身份：<span class="red"> </span></label>
                            <div class="col-xs-4 ">
                                <input type="text" id="form-field-identity" name="identity" class="form-control remote" placeholder="对外身份" value="${abroadGroup.identity}"/>
                            </div>
                            <label class="col-xs-2 control-label" for="form-field-adminLevel">行政级别：<span class="red"> </span></label>
                            <div class="col-xs-4 ">
                                <input type="text" id="form-field-adminLevel" name="adminLevel" class="form-control remote" placeholder="行政级别" value="${abroadGroup.adminLevel}"/>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ace scripts -->
<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>

<script type="text/javascript">
    G.datepicker({
        todayHighlight: true
    });

    var $uploadAbroadGroup = $('#form-field-uploadAbroadGroup');

    $uploadAbroadGroup.ace_file_input({
        no_file: ' ...',
        btn_choose: '选择文件',
        btn_change: '重新选择',
        droppable: false,
        onchange: null,
        thumbnail: false //| true | large
    });
</script>
