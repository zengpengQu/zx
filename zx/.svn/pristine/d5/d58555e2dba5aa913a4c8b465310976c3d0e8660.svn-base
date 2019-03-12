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
                    <form class="form-horizontal" id="saveFormHousing" role="form" method="post">
                        <input id="form-field-id" name="id" type="hidden" value="${abroadHousing.id}">

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-checkinDateStr">入住日期：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input class="form-control date-picker" name="checkinDateStr" id="form-field-checkinDateStr" data-date-format="yyyy-mm-dd" value="${abroadHousing.jsonObject.checkinDateStr}" placeholder="入住日期" type="text"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-hotelName">酒店名称：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-hotelName" name="hotelName" class="form-control remote" placeholder="酒店名称" value="${abroadHousing.hotelName}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-roomArrange">房间安排：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <textarea class="form-control limited" id="form-field-roomArrange" name="roomArrange" maxlength="300" style="min-height: 180px;" >${abroadHousing.roomArrange}</textarea>
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

    var $saveFormHousing = $("#saveFormHousing");
</script>
