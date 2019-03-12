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
                    <form class="form-horizontal" id="saveFormSchedule" role="form" method="post">
                        <input id="form-field-id" name="id" type="hidden" value="${abroadSchedule.id}">

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-dayStr">日期：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input class="form-control date-picker" name="dayStr" id="form-field-dayStr" data-date-format="yyyy-mm-dd" value="${abroadSchedule.jsonObject.dayStr}" placeholder="日期" type="text"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-period">时段：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-period" name="period" class="form-control remote" placeholder="时段" value="${abroadSchedule.period}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-content">活动安排：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <textarea class="form-control limited" id="form-field-content" name="content" maxlength="300" style="min-height: 100px;" >${abroadSchedule.content}</textarea>

                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="form-field-noteInfo">备注信息：</label>
                            <div class="col-sm-10 ">
                                <textarea class="form-control limited" id="form-field-noteInfo" name="noteInfo" maxlength="300" style="min-height: 100px;" >${abroadSchedule.noteInfo}</textarea>
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

    var $saveFormSchedule = $("#saveFormSchedule");
</script>
