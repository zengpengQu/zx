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
                    <form class="form-horizontal" id="saveFormAirplane" role="form" method="post">
                        <input id="form-field-id" name="id" type="hidden" value="${abroadAirplane.id}">

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-flightNo">航班号：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-flightNo" name="flightNo" class="form-control remote"
                                       placeholder="航班号" value="${abroadAirplane.flightNo}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-fromName">启程地：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-fromName" name="fromName" class="form-control remote"
                                       placeholder="启程地" value="${abroadAirplane.fromName}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-toName">目的地：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-toName" name="toName" class="form-control remote"
                                       placeholder="目的地" value="${abroadAirplane.toName}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-airModel">机型：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-airModel" name="airModel" class="form-control remote"
                                       placeholder="机型" value="${abroadAirplane.airModel}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-shippingChoose">舱位：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <select class="form-control" id="form-field-shippingChoose" name="shippingChoose">
                                    <option value="">-----请选择-----</option>
                                    <option value="0" <c:if test="${abroadAirplane.shippingChoose eq 0}">selected</c:if> >头等舱</option>
                                    <option value="1" <c:if test="${abroadAirplane.shippingChoose eq 1}">selected</c:if> >公务舱</option>
                                    <option value="2" <c:if test="${abroadAirplane.shippingChoose eq 2}">selected</c:if> >经济舱</option>
                                    <option value="3" <c:if test="${abroadAirplane.shippingChoose eq 3}">selected</c:if> >包机</option>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-timeFlight">飞行时间：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-timeFlight" name="timeFlight" class="form-control remote"
                                       placeholder="飞行时间" value="${abroadAirplane.timeFlight}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label no-padding-right" for="form-field-noteInfo">备注信息：</label>
                            <div class="col-sm-10 ">
                                <textarea class="form-control limited" id="form-field-noteInfo" name="noteInfo" maxlength="300" style="min-height: 100px;" >${abroadAirplane.noteInfo}</textarea>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- ace scripts -->
<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>

<script type="text/javascript">
    G.datepicker({
        todayHighlight: true
    });

    var $uploadAbroadAirplane = $('#form-field-uploadAbroadAirplane');

    var $saveFormAirplane = $("#saveFormAirplane");

    $uploadAbroadAirplane.ace_file_input({
        no_file: ' ...',
        btn_choose: '选择文件',
        btn_change: '重新选择',
        droppable: false,
        onchange: null,
        thumbnail: false //| true | large
    });
</script>
