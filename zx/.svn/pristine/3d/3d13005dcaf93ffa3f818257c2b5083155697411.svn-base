<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>

<script src="${basePath}/plugin/ace/assets/js/chosen.jquery.js"></script>

<div class="row">
    <div class="col-xs-12">
        <div style="margin-top: 20px">
            <div class="widget-body">
                <div class="widget-main padding-8" style="height: 300px">
                    <form class="form-horizontal" id="saveFormNation" role="form" method="post">
                        <input id="form-field-id" name="id" type="hidden" value="${abroadNation.id}">

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label class="col-xs-3 control-label" for="form-field-nationName">出访国家：<span class="red">*</span></label>
                                    <div class="col-xs-9 ">
                                        <input type="hidden" id="form-field-nationName" name="nationName" class="form-control remote" placeholder="多个出访国家请用逗号隔开（如：国家1, 国家2）" value="${abroadNation.nationName}"/>
                                        <%--<select class="form-control" id="form-field-nationName" style="background-color: #eeeeee" name="nationId">--%>
                                        <%--<option value="">---------请选择---------</option>--%>
                                        <%--<c:forEach items="${nationList}" var="nation">--%>
                                        <%--<option value="${nation.id}" <c:if test="${abroadNation.nationId eq nation.id}">selected</c:if> >${nation.nationName}</option>--%>
                                        <%--</c:forEach>--%>
                                        <%--</select>--%>
                                        <select class="chosen-select form-control" id="form-field-nationId"
                                                name="nationId" data-placeholder="请选择...">
                                            <option value=""> </option>
                                            <c:forEach items="${dicNationList}" var="dicNation">
                                                <option value="${dicNation.id}" <c:if test="${nation.dicNation.id eq dicNation.id}">selected</c:if> >${dicNation.nationName}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>


                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label class="col-xs-3 control-label" for="form-field-unitName">邀请单位：<span class="red">*</span></label>
                                    <div class="col-xs-9 ">
                                        <input type="text" id="form-field-unitName" name="unitName" class="form-control remote" placeholder="邀请单位" value="${abroadNation.unitName}"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label class="col-xs-3 control-label" for="form-field-chineseName">外方邀请人（中文）：<span class="red">*</span></label>
                                    <div class="col-xs-9 ">
                                        <input type="text" id="form-field-chineseName" name="chineseName" class="form-control remote" placeholder="外方邀请人（中文）" value="${abroadNation.chineseName}"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label class="col-xs-3 control-label" for="form-field-foreignName">外方邀请人（外文）：<span class="red">*</span></label>
                                    <div class="col-xs-9 ">
                                        <input type="text" id="form-field-foreignName" name="foreignName" class="form-control remote" placeholder="外方邀请人（外文）" value="${abroadNation.foreignName}"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-12">
                                <div class="form-group">
                                    <label class="col-xs-3 control-label" for="form-field-trsCountry">过境国家：&nbsp;</label>
                                    <div class="col-xs-9 ">
                                        <input type="text" id="form-field-trsCountry" name="trsCountry" class="form-control remote" placeholder="多个过境国家请用逗号隔开（如：国家1, 国家2）" value="${abroadNation.trsCountry}"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    var $saveFormNation = $("#saveFormNation");

</script>
