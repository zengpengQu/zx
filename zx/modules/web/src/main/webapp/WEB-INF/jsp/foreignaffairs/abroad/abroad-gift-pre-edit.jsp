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
                    <form class="form-horizontal" id="saveFormPre" role="form" method="post">
                        <input id="form-field-pre-id" name="id" type="hidden" value="${abroadGiftPre.id}">

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-nation">出访国家：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-nation" name="nation" class="form-control remote" placeholder="出访国家" value="${abroadGiftPre.nation}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-giver">赠礼方：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-giver" name="giver" class="form-control remote" placeholder="赠礼方" value="${abroadGiftPre.giver}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-donee">受赠方：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <input type="text" id="form-field-donee" name="donee" class="form-control remote" placeholder="受赠方" value="${abroadGiftPre.donee}"/>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-gifts">赠送礼品：<span class="red">*</span></label>
                            <div class="col-xs-10 ">
                                <textarea class="form-control limited" id="form-field-gifts" name="gifts" maxlength="300" style="min-height: 60px;" >${abroadGiftPre.gifts}</textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-giftsReturn">对方回赠：</label>
                            <div class="col-xs-10 ">
                                <textarea class="form-control limited" id="form-field-giftsReturn" name="giftsReturn" maxlength="300" style="min-height: 60px;" >${abroadGiftPre.giftsReturn}</textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-xs-2 control-label" for="form-field-giftsRemain">剩余礼品：</label>
                            <div class="col-xs-10 ">
                                <textarea class="form-control limited" id="form-field-giftsRemain" name="giftsRemain" maxlength="300" style="min-height: 60px;" >${abroadGiftPre.giftsRemain}</textarea>
                            </div>
                        </div>

                        <div class="form-group">
                            <label class="col-sm-2 control-label" for="form-field-notes">备注信息：</label>
                            <div class="col-sm-10 ">
                                <textarea class="form-control limited" id="form-field-notes" name="notes" maxlength="300" style="min-height: 100px;" >${abroadGiftPre.notes}</textarea>
                            </div>
                        </div>

                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    var $saveFormPre = $("#saveFormPre");

</script>
