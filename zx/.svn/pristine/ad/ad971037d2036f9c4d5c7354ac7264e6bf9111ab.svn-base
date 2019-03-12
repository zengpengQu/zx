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
                    <form class="form-horizontal" id="saveFormVehicle" role="form" method="post">
                        <input id="form-field-id" name="id" type="hidden" value="${abroadVehicle.id}">
                        <input style="display: none;"/>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-activityRoute">活动路线：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-activityRoute" name="activityRoute" class="form-control remote" placeholder="活动路线" value="${abroadVehicle.activityRoute}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-vehicleInfo">乘车安排：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <textarea class="form-control limited" id="form-field-vehicleInfo" name="roomArrange" maxlength="300" style="min-height: 180px;" >${abroadVehicle.vehicleInfo}</textarea>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    G.datepicker({
        todayHighlight: true
    });

    var $saveFormVehicle = $("#saveFormVehicle");
</script>
