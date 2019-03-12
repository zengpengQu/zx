<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/4
  Time: 17:43
  新增/编辑通讯录
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
<script src="${basePath}/plugin/ace/assets/js/chosen.jquery.js"></script>

<div class="row">
    <div class="col-xs-12">
        <form class="form-horizontal" role="form" id="saveForm"
              action="${basePath}/contacts-address/addressTeam-edit-save.do"
              method="post">
            <!-- #section:elements.form -->
            <div class="hidden">
                <input type="text" id="form-field-parentId" name="parentId" value="${parentAddressTeamParentId}"/>
                <input type="text" id="form-field-id" name="id" value="${thisAddressTeam.id}"/>
                <input type="text" id="form-field-delFlag" name="delFlag" value="${thisAddressTeam.delFlag}"/>
            </div>
            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-9 control-label no-padding-right">
                            您要添加的通讯录组属于： <span class="required">
                            ${thisAddressTeam.teamName}
                        </span>
                        </label>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right"
                               for="form-field-teamName">通讯录组名： <span class="required">*</span></label>

                        <div class="col-sm-9 ">
                            <input type="text" id="form-field-teamName" name="teamName" maxlength="32"
                                   class="form-control"/>
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
        var $saveForm = $('#saveForm');
        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                teamName: {
                    required: true
                },
                messages: {
                    teamName: {
                        required: "分组名称不能为空"
                    }
                }
            }
        });
    });
</script>

