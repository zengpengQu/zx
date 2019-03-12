<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/4
  Time: 17:43
  新增/编辑部门分组
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

<div class="row">
    <div class="col-xs-12">
        <form class="form-horizontal" role="form" id="saveForm"
              action="${basePath}/contacts-dep/contacts-edit-dept-save.do"
              method="post">
            <!-- #section:elements.form -->
            <div class="hidden">
                <input type="text" id="form-field-id" name="id" value="${deptComList.id}"/>
                <input type="text" id="form-field-addressTeamId" name="addressTeamId" value="${addressTeam.id}"/>

            </div>


            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <c:choose>
                        <c:when test="${deptComList eq null}">
                            <div class="form-group">
                                <label  class="col-xs-3 control-label no-padding-left"
                                        for="form-field-dicDeptId">部  门：</label>
                                <div class="col-sm-9 deptDiv">
                                    <input type="text" id="form-field-dicDeptId" name="dicDeptId"
                                           class="hide" value="${curDept.id}"/>
                                    <input type="text" class="form-control" id="form-field-deptName"
                                           name="deptName" value="${curDept.absName}" style="cursor: pointer;" readonly="readonly"/>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                        <div class="form-group">
                            <label  class="col-xs-3 control-label no-padding-left"
                                    for="form-field-dicDeptId">部  门：</label>
                            <div class="col-sm-9 deptDiv">
                                <input type="text" name="dicDeptId"
                                       class="hide" value="${deptComList.dicDept.id}"/>
                                <input type="text" id="dicDept-dept" class="form-control"
                                       name="deptName" value="${deptComList.dicDept.deptName}" style="cursor: pointer;" readonly="readonly"/>
                            </div>
                        </div>
                        </c:otherwise>
                    </c:choose>



                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right"
                               for="form-field-location"> 办公室： <span class="required">*</span></label>

                        <div class="col-sm-9">
                            <input type="text" id="form-field-location" name="location"
                                   class="form-control" value="${deptComList.location}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right"
                               for="form-field-jobTel"> 办公室电话： <span class="required">*</span></label>

                        <div class="col-sm-9 ">
                            <input type="text" id="form-field-jobTel" name="jobTel"
                                   class="form-control" value="${deptComList.jobTel}"/>
                        </div>
                    </div>

                </div>
            </div>
        </form>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        var curOperateAuth = '${curOperateAuth}';

        <c:choose>
            <c:when test="${deptComList eq null}">
                if (curOperateAuth.indexOf('48_12') !== -1) {
                    G.initDept('deptDiv',true,['{}','{}'],TREE_NODE);
                } else {
                    G.initDept('deptDiv',false,['${curDept}','${curDept}'],TREE_NODE);
                }
            </c:when>
            <c:otherwise>
                $("#dicDept-dept").click(function () {
                    if (curOperateAuth.indexOf('48_12') !== -1) {
                        G.initDept('deptDiv',true,['{}','{}'],TREE_NODE);
                    } else {
                        G.initDept('deptDiv',false,['${curDept}','${curDept}'],TREE_NODE);
                    }
                });
            </c:otherwise>
        </c:choose>

        var $saveForm = $('#saveForm');

        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                dicDeptId: {
                    required: true
                },
                location: {
                    required: true,
                    maxlength: 50
                },
                jobTel: {
                    maxlength: 50
                }
            },
            messages: {
                dicDeptId: {
                    required: "部门名称不能为空"
                },
                location: {
                    required: "办公室不能为空"
                }
            }
        });

    });
</script>

