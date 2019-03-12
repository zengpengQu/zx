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
        <div class="row">
            <!-- 主办单位 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">主办单位：</label>
                    <div class="col-sm-8 ">
                        <input type="text" readonly="readonly"
                               class="form-control " value="${supervisionMatter.jsonObject.hostUnitName}"
                               placeholder="主办单位"/>
                    </div>
                </div>
            </div>
            <!-- 协作单位 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">协作单位：</label>
                    <div class="col-sm-8 ">
                        <input type="text" readonly="readonly"
                               class="form-control " value="${supervisionMatter.jsonObject.cooperativeName}"
                               placeholder="协作单位"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <!-- 督查事项编号 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label" >督查事项编号：</label>
                    <div class="col-sm-8 ">
                        <input type="text" readonly="readonly"
                               class="form-control " value="${supervisionMatter.jsonObject.serialNumber}"
                               placeholder="督查事项编号"/>
                    </div>
                </div>
            </div>
            <!-- 下发日期 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">下发日期：</label>
                    <div class="col-sm-8 ">
                        <input class="form-control" readonly="readonly" placeholder="下发日期"
                               value="${supervisionMatter.jsonObject.issuedDate}" type="text"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <!-- 督查事项 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-2 control-label">督查事项：</label>
                    <div class="col-sm-10 ">
                    <textarea readonly="readonly"
                              class="form-control " maxlength="200" style="min-height: 60px;"
                              placeholder="督查事项">${supervisionMatter.jsonObject.supMatter}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <!-- 办理要求 -->
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-2 control-label">办理要求：</label>
                    <div class="col-sm-10 ">
                    <textarea class="form-control limited"
                              readonly="readonly" maxlength="200" style="min-height: 60px;"
                              placeholder="办理要求">${supervisionMatter.jsonObject.requirements}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
    </div>
    <div class="col-xs-12">
        <div style="margin-top: 5%"></div>
        <div class="row">
            <!-- 承办单位 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">承办单位：</label>
                    <div class="col-sm-8 ">
                        <input type="text" readonly="readonly" style="width: 100%"
                               name="cooperativeName" value="${supervisionMatter.jsonObject.hostUnitName}"/>
                    </div>
                </div>
            </div>
            <!-- 审批人 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">审批人：
                        <span class="red"></span></label>
                    <div class="col-sm-8 ">
                        <input type="text" readonly="readonly"
                               class="form-control " value="${supervisionFeedBack.jsonObject.createName}"
                               placeholder="审批人"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <!-- 是否办结 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">是否办结：
                        <span class="red"></span></label>
                    <div class="col-sm-8 ">
                        <input type="text"readonly="readonly"
                               class="form-control " value="${supervisionFeedBack.jsonObject.isTransfer}"
                               placeholder="是否办结"/>
                    </div>
                </div>
            </div>
            <!-- 反馈日期 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label">反馈日期：
                        <span class="red"></span></label>
                    <div class="col-sm-8 ">
                        <div class="input-group">
                            <input class="form-control"readonly="readonly"
                                   value="${supervisionFeedBack.jsonObject.feedBackDate}" type="text"/>
                            <span class="input-group-addon">
                            <i class="fa fa-calendar bigger-110"></i>
                        </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <!-- 办理情况概要 -->
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-2 control-label">办理情况概要：
                        <span class="red"></span></label>
                    <div class="col-sm-10 ">
                    <textarea readonly="readonly" class="form-control " maxlength="200" style="min-height: 80px;"
                              placeholder="办理情况概要">${supervisionFeedBack.jsonObject.summary}</textarea>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <!-- 已上传的附件 -->
            <c:if test="${supervisionFeedBack.id ne null}">
                <div class="col-xs-12">
                    <div class="form-group" id="uploadedDiv">
                        <label class="col-sm-2 control-label" style="font-weight: bold;color: deepskyblue;">
                            已上传的附件：
                        </label>
                        <div class="col-sm-10 no-padding-left">
                            <span id="download-file"></span>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        var $downLoadFile = $("#download-file");
        //获取已上传的附件
        function appendAttach($div,jsonFileObject) {
            $div.empty();
            var html = [];
            if (jsonFileObject == null) {
                html.push('<ul class="list-unstyled list-striped pricing-table-header"><li style="margin-top:5px">');
                html.push('暂无上传附件！');
                html.push('</li></ul>');
            } else {
                html.push('<ul class="list-unstyled list-striped pricing-table-header">');
                html.push('<li class="blue"  style="cursor:pointer;margin-top:5px;background-color: white;">');
                html.push('<a class="filePreview" fileId="' + jsonFileObject.id + '" style="color:#478FCA;font-family:仿宋, Arial, Helvetica, sans-serif;font-size: 18px;">');
                html.push(jsonFileObject.fileName);
                html.push('</a>&nbsp&nbsp&nbsp');
                html.push('<a style="color:grey" href="${basePath}/bulletin-board/download.action?id=' + jsonFileObject.id + '&type=0">');
                html.push('<i class="ace-icon fa fa-download grey bigger-130"></i>下载</a>&nbsp;');
                html.push('</li>');
                html.push('</ul>');
            }
            $div.append(html.join(""));
        }
        //获取已上传的附件
        appendAttach($downLoadFile,${jsonFileObject});

    });
</script>