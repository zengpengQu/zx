<%--
  Created by IntelliJ IDEA.
  User: sy
  Date: 2018/7/5
  Time: 9:15
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

<title>履职支撑平台</title>

<div class="row">
    <div class="col-xs-12">
        <form class="form-horizontal" role="form" id="saveForm"
              action="${basePath}/attendance/attendance-info-save.do"
              method="post">
            <!-- #section:elements.form -->
            <div class="hidden">
                <input type="text" id="form-field-id" name="id" value="${loadAttendance.id}"/>
            </div>


            <div class="row">
                <div class="col-xs-9 col-sm-offset-1">

                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right"
                               for="form-field-meetingTitle"> 会议标题：<span class="required">*</span></label>
                        <div class="col-sm-9">
                            <input type="text" class="form-control" id="form-field-meetingTitle"
                                   name="meetingTitle" value="${loadAttendance.meetingTitle}" style="cursor: pointer;" readonly/>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right"
                               for="form-field-attendName"> 人员姓名：<span class="required">*</span></label>
                        <div class="col-sm-9 ">
                            <input type="text" id="form-field-attendName" name="attendName" readonly="readonly"
                                   class="form-control" value="${loadAttendance.attendName}"/>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right"
                               for="form-field-attendDuty"> 职务名称：<span class="required"></span></label>
                        <div class="col-sm-9 ">
                            <input type="text" id="form-field-attendDuty" name="attendDuty"
                                   class="form-control" value="${loadAttendance.attendDuty}"/>
                        </div>
                    </div>


                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right"
                               for="form-field-attendEnce"> 出勤状态：<span class="required"></span></label>

                        <div class="col-sm-9 ">
                            <select class="form-control" id="form-field-attendEnce" name="attendEnce">
                                <option value="">----请选择----</option>
                                <option value="0"
                                        <c:if test="${loadAttendance.attendEnce eq '0'}">selected</c:if>>正常</option>
                                <option value="1"
                                        <c:if test="${loadAttendance.attendEnce eq '1'}">selected</c:if>>出差</option>
                                <option value="2"
                                        <c:if test="${loadAttendance.attendEnce eq '2'}">selected</c:if>>休假</option>
                                <option value="3"
                                        <c:if test="${loadAttendance.attendEnce eq '3'}">selected</c:if>>事假</option>
                                <option value="4"
                                        <c:if test="${loadAttendance.attendEnce eq '4'}">selected</c:if>>病假</option>
                                <option value="5"
                                        <c:if test="${loadAttendance.attendEnce eq '5'}">selected</c:if>>缺席</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-3 control-label no-padding-right"
                               for="form-field-attendOther"> 备注：<span class="required"></span></label>
                        <div class="col-sm-9 ">
                            <input type="text" id="form-field-attendOther" name="attendOther"
                                   class="form-control" value="${loadAttendance.attendOther}"/>
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

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>

