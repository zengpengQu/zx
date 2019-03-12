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
                    <form class="form-horizontal" id="saveFormChronicle" role="form" method="post">
                        <input id="form-field-id" name="id" type="hidden" value="${chronicle.id}">

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-beginTimeStr">开始时间：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input class="form-control date-picker" name="beginTimeStr" id="form-field-beginTimeStr" data-date-format="yyyy-mm-dd" value="${chronicle.jsonObject.beginTimeStr}" placeholder="开始时间" type="text"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-endTimeStr">结束时间：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input class="form-control date-picker" name="endTimeStr" id="form-field-endTimeStr" data-date-format="yyyy-mm-dd" value="${chronicle.jsonObject.endTimeStr}" placeholder="结束时间" type="text"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-content">内容：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <textarea class="form-control limited" id="form-field-content" name="content" maxlength="2000" style="min-height: 150px;" >${chronicle.content}</textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right" for="form-field-notes">备注：</label>
                            <div class="col-sm-10 ">
                                <textarea class="form-control limited" id="form-field-notes" name="notes" maxlength="1000" style="min-height: 100px;" >${chronicle.notes}</textarea>
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

    var $saveFormChronicle = $("#saveFormChronicle");
</script>
