<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
    pageContext.setAttribute("basePath", basePath);
%>
<title>履职支撑平台</title>
<script src="${basePath}/plugin/ace/assets/js/chosen.jquery.js"></script>
<style>
    .required_ {
        color: green;
        padding-left: 5px;
    }
</style>
<div class="row">
    <div class="col-xs-12">
        <form class="form-horizontal" role="form" id="saveForm" action="${basePath}/dept/dept-update.do"
              method="post">
            <!-- #section:elements.form -->
            <div class="hidden">
                <input type="text" id="form-field-id" name="deptCode" value="${dicDept.deptCode}"/>
            </div>
            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-9 control-label no-padding-right">
                            您要修改的部门名是： <span class="required_">
                            ${dicDept.deptName}</span>
                        </label>
                    </div>
                </div>
            </div>
            <%--部门名--%>
            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-deptName">部门名：
                            <span class="required">*</span>
                        </label>
                        <div class="col-sm-9 ">
                            <input type="text" id="form-field-deptName" name="deptName"
                                   class="form-control" value="${dicDept.deptName}"/>
                        </div>
                    </div>
                </div>
            </div>
            <%--部门描述--%>
            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-deptDscr">部门描述：
                            <span class="required">*</span>
                        </label>
                        <div class="col-sm-9 ">
                            <textarea class="form-control limited" id="form-field-deptDscr"
                                      name="deptDscr" maxlength="100" style="min-height: 80px;" placeholder="部门描述">${dicDept.deptDscr}</textarea>
                        </div>
                    </div>
                </div>
            </div>
            <%--隶属关系--%>
            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-ownership">隶属关系：
                            <span class="required">&nbsp;</span>
                        </label>
                        <div class="col-sm-9 ">
                            <input type="text" id="form-field-ownership" name="ownership"
                                   class="form-control"  value="${dicDept.ownership}"/>
                        </div>
                    </div>
                </div>
            </div>
            <%--单位性质--%>
            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-property">单位性质：
                            <span class="required">&nbsp;</span>
                        </label>
                        <div class="col-sm-9 ">
                            <select class="form-control" id="form-field-property"
                                    name="property">
                                <option value="">---------请选择---------</option>
                                <c:forEach items="${list}" var="lis">
                                    <option value="${lis.id}" <c:if test="${dicDept.property eq lis.id}">selected</c:if>>${lis.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <%--单位类别--%>
            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-category">单位类别：
                            <span class="required">&nbsp;</span>
                        </label>
                        <div class="col-sm-9 ">
                            <select class="form-control" id="form-field-category"
                                    name="category">
                                <option value="">---------请选择---------</option>
                                <c:forEach items="${paramList}" var="paramLis">
                                    <option value="${paramLis.id}" <c:if test="${dicDept.category eq paramLis.id}">selected</c:if>>${paramLis.name}</option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <%--编制类型--%>
            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-authType">编制类型：
                            <span class="required">&nbsp;</span>
                        </label>
                        <div class="col-sm-9 ">
                            <input type="text" id="form-field-authType" name="authType"
                                   class="form-control" value="${dicDept.authType}"/>
                        </div>
                    </div>
                </div>
            </div>
            <%--邮政编码--%>
            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-postalCode">邮政编码：
                            <span class="required">&nbsp;</span>
                        </label>
                        <div class="col-sm-9 ">
                            <input type="text" id="form-field-postalCode" name="postalCode"
                                   class="form-control" value="${dicDept.postalCode}"/>
                        </div>
                    </div>
                </div>
            </div>
            <%--部门电话--%>
            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-tel">部门电话：
                            <span class="required">&nbsp;</span>
                        </label>
                        <div class="col-sm-9 ">
                            <input type="text" id="form-field-tel" name="tel"
                                   class="form-control" value="${dicDept.tel}"/>
                        </div>
                    </div>
                </div>
            </div>
            <%--单位地址--%>
            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right" for="form-field-address">单位地址：
                            <span class="required">&nbsp;</span>
                        </label>
                        <div class="col-sm-9 ">
                            <input type="text" id="form-field-address" name="address"
                                   class="form-control" value="${dicDept.address}"/>
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div>
</div>
<script type="text/javascript">
    G.datepicker({
        todayHighlight : true
    });
    var $saveForm = $('#saveForm');
    $saveForm.tjValidate({
        focusInvalid: false,
        rules: {
            deptName: {
                required: true,
                maxlength: 32
            },
            deptDscr: {
                required: true,
                maxlength: 500
            },
            postalCode: {
                required: false,
                maxlength: 32
            },
            tel: {
                required: false,
                maxlength: 32
            },
            ownership: {
                required: false,
                maxlength: 32
            },
            property: {
                required: false
            },
            category: {
                required: false
            },
            address: {
                required: false,
                maxlength: 100
            },
            authType: {
                required: false,
                maxlength: 32
            },
            messages: {
                deptName: {
                    required: "部门名称不能为空"
                },
                deptDscr: {
                    required: "部门描述不能为空"
                },
                postalCode: {
                    required: "邮政编码不能为空"
                },
                tel: {
                    required: "部门电话不能为空"
                },
                ownership: {
                    required: "隶属关系不能为空"
                },
                property: {
                    required: "单位性质不能为空"
                },
                category: {
                    required: "单位类别不能为空"
                },
                address: {
                    required: "单位地址不能为空"
                },
                authType: {
                    required: "编制类型不能为空"
                }
            }
        }
    });
</script>
