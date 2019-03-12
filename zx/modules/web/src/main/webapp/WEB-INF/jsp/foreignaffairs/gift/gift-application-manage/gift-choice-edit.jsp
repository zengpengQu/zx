<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<div id="giftsApplicationDialog">
    <form id="giftsApplicationForm" role="form">
        <div class="row">
            <div class="hidden">
                <input type="text" id="id" name="id"/>
            </div>
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" style="font-weight: bold;">编码：</label>

                    <div class="col-sm-8 ">
                        <input type="text" id="form-field-giftCode" name="giftCode" disabled="true"
                               class="form-control "  value="${giftApplicationVO.giftCode}"
                               placeholder="编码"/>
                        <div class="hidden">
                            <input type="text" id="form-field-giftCode" name="giftCode"
                                   value="${giftApplicationVO.giftCode}" />
                        </div>
                    </div>
                </div>
            </div>
<%--
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" style="font-weight: bold;">类型：<span
                            class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <input type="text" id="form-field-giftApplicationType" name="giftApplicationType"
                               class="form-control " value="${giftApplicationVO.giftType}"
                               placeholder="类型"/>
                    </div>
                </div>
            </div>
--%>
        </div>
        <div class="space-10"></div>
        <div class="row">
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" style="font-weight: bold;">名称：<span
                            class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <input type="text" id="form-field-giftName" name="giftName" disabled="true"
                               class="form-control " value="${giftApplicationVO.giftName}"
                               placeholder="名称"/>
                        <div class="hidden">
                            <input type="text" id="form-field-giftName" name="giftName" value="${giftApplicationVO.giftName}" />
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" style="font-weight: bold;">数量：<span
                            class="required">*</span></label>
                    <div class="col-sm-8 ">
                        <input type="text" id="form-field-giftCount" name="giftCount"
                               class="form-control "  value="${giftApplicationVO.giftCount}"
                               placeholder="数量"/>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>