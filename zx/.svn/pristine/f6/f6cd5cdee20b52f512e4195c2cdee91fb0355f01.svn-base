<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/4
  Time: 17:43
  新增/编辑用户分组
--%>
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

<div class="row" style="margin-top: 15px">
    <div class="col-xs-12">
        <form class="form-horizontal" role="form" id="saveForm" action="${basePath}/contacts/contacts-edit-user-save.do"
        method="post">
            <!-- #section:elements.form -->
            <div class="hidden">
                <input type="text" id="form-field-addressTeamId" name="comListtId" value="${comListt.id}"/>
                <input type="text" id="form-field-id" name="id" value="${userComList.id}"/>
                <input type="text" id="form-field-dicDeptId" name="dicDeptId" value="${comListt.dicDept.id}"/>
                <input type="text" id="form-field-dicUserId" name="dicUserId" value="${userComList.dicUser.id}"/>

            </div>

            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label no-padding-right"
                               for="form-field-Name"> 姓名： <span class="required">*</span></label>

                        <div class="col-sm-8 ">
                            <input type="text" id="form-field-Name" name="name" maxlength="20"
                                   class="form-control" value="${userComList.name}"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label  class="col-sm-4 control-label no-padding-left"
                                for="form-field-dicDeptId">部  门：</label>
                        <div class="col-sm-8">
                            <input type="text" id="form-field-department" name="department"
                                   class="hide" value="${comListt.dicDept.id}"/>
                            <input type="text" class="form-control" id="form-field-deptName" maxlength="60"
                                   name="deptName" value="${comListt.dicDept.deptName}" style="cursor: pointer;" readonly="readonly"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label no-padding-right"
                               for="form-field-orgName"> 所属单位： <span class="required">*</span></label>

                        <div class="col-sm-8">
                            <input type="text" id="form-field-orgName" name="orgName" maxlength="100"
                                   class="form-control" value="${userComList.orgName}"/>
                        </div>
                    </div>
                </div>

                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label no-padding-right"
                               for="form-field-proTypeId"> 职务： <span class="proTypeId required">*</span></label>

                        <div class="col-sm-8">
                            <input type="text" id="form-field-proTypeId" name="proTypeId" maxlength="30"
                                   class="form-control" value="${userComList.proTypeId}"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label no-padding-right"
                               for="form-field-mobile"> 手机号码： <span class="required">*</span></label>

                        <div class="col-sm-8">
                            <input type="text" id="form-field-mobile" name="mobile"
                                   class="form-control" value="${userComList.mobile}"/>
                        </div>
                    </div>
                </div>

                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label no-padding-right"
                               for="form-field-email"> 邮箱： <span class="required">&nbsp;&nbsp;</span></label>

                        <div class="col-sm-8">
                            <input type="text" id="form-field-email" name="email"
                                   class="form-control" value="${userComList.email}"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group hide">
                        <label class="col-sm-4 control-label no-padding-right"
                               for="form-field-location"> 办公室： <span class="required">*</span></label>

                        <div class="col-sm-8">
                            <input type="text" id="form-field-location" name="location" readonly="readonly"
                                   maxlength="50" class="form-control" value="${comListt.location}"/>
                        </div>
                    </div>
                </div>

                <div class="col-xs-6">
                    <div class="form-group hide">
                        <label class="col-sm-4 control-label no-padding-right"
                               for="form-field-jobTel"> 办公电话： <span class="required">*</span></label>

                        <div class="col-sm-8">
                            <input type="text" id="form-field-jobTel" name="jobTel" readonly="readonly"
                                   class="form-control" value="${comListt.jobTel}"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label no-padding-right"
                               for="form-field-secName"> 秘书姓名：<span class="required">&nbsp;</span></label>

                        <div class="col-sm-8">
                            <input type="text" id="form-field-secName" name="secName" maxlength="20"
                                   class="form-control" value="${userComList.secName}"/>
                        </div>
                    </div>
                </div>

                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label no-padding-right"
                               for="form-field-secMobile"> 秘书电话：<span class="required">&nbsp;</span></label>

                        <div class="col-sm-8">
                            <input type="text" id="form-field-secMobile" name="secMobile"
                                   class="form-control" value="${userComList.secMobile}"/>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label no-padding-right"
                               for="form-field-driName"> 司机姓名： <span class="required">&nbsp;&nbsp;</span></label>

                        <div class="col-sm-8">
                            <input type="text" id="form-field-driName" name="driName" maxlength="20"
                                   class="form-control" value="${userComList.driName}"/>
                        </div>
                    </div>
                </div>
                <div class="col-xs-6">
                    <div class="form-group">
                        <label class="col-sm-4 control-label no-padding-right"
                               for="form-field-driMobile"> 司机电话： <span class="required">&nbsp;&nbsp;</span></label>

                        <div class="col-sm-8">
                            <input type="text" id="form-field-driMobile" name="driMobile"
                                   class="form-control" value="${userComList.driMobile}"/>
                        </div>
                    </div>
                </div>
            </div>

            <%--<div class="row">--%>
                <%--<div class="col-xs-6">--%>
                    <%--<div class="form-group">--%>
                        <%--<label class="col-sm-4 control-label no-padding-right"--%>
                               <%--for="form-field-birthDateStr"> 出生日期：<span class="required">&nbsp;&nbsp;</span></label>--%>

                        <%--<div class="col-sm-8">--%>
                            <%--<div class="input-group date date-picker" data-date-format="yyyy-mm-dd">--%>
                                <%--<input class="form-control" name="birthDateStr" id="form-field-birthDateStr"--%>
                                        <%--type="text" value="${userComList.jsonObject.birthDateStr}"/>--%>
                                <%--<span class="input-group-addon">--%>
                                        <%--<i class="fa fa-calendar bigger-110"></i>--%>
                                    <%--</span>--%>
                            <%--</div>--%>
                        <%--</div>--%>
                    <%--</div>--%>
                <%--</div>--%>
            <%--</div>--%>
        </form>
    </div>
</div>

<script type="text/javascript">

    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({
            todayHighlight : true
        });

        var $saveForm = $('#saveForm');

        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                name: {
                    required: true
                },
                department: {
                    required: true
                },
                mobile: {
                    required: true,
                    isMobile:true
                },
                jobTel:{
                    isPhone:true
                },
                secMobile:{
                    isMobile:true
                },
                driMobile:{
                    isMobile:true
                },
                proTypeId:{
                    required: true,
                },
                orgName:{
                    required: true,
                }
            },
            messages: {
                name: {
                    required: "姓名不能为空"
                },
                department: {
                    required: "部门不能为空"
                },
                mobile: {
                    required: "手机号码不能为空"
                },
                proTypeId: {
                    required: "职务不能为空"
                },
                orgName:{
                    required: "所属单位不能为空"
                }
            }
        });
    });
</script>

