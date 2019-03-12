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

<div class="row">
    <div class="col-xs-12">
        <form class="form-horizontal" role="form" id="saveForm" action="${basePath}/correct/correct-edit-save.do"
        method="post">
            <!-- #section:elements.form -->
            <div class="hidden">
                <input type="text" id="form-field-id" name="id" value="${place.id}"/>

            </div>

            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right"> 活动&nbsp;&nbsp;标题： <span class="required">&nbsp;&nbsp;</span></label>

                        <div class="col-sm-9 ">
                            <label class="control-label no-padding-right"> ${place.title}</label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right"
                               for="form-field-text"> 需调整内容： <span class="required">*</span></label>
                            <div class="col-sm-9 ">
                                <textarea class="form-control limited" id="form-field-text"
                                          name="text" maxlength="100"
                                          style="min-height: 100px;"></textarea>
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
            text: {
                required: true,
                maxlength:1000
            }
        },
        messages: {
            text: {
                required: "需调整内容不能为空"
            }
        }
    });
</script>

