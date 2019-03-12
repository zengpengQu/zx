<%--
  Created by IntelliJ IDEA.
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

<div class="tabable">
    <%--<ul class="tabbale-uls" id="table" style="margin-bottom: 15px;">
        <li class="active" style="    flex: unset;">
            <a data-toggle="tab" href="#nei" class="grid_tab">内行文</a>
        </li>
        <li style="    flex: unset;">
            <a data-toggle="tab" href="#wai" class="grid_tab">外行文</a>
        </li>
    </ul>--%>
        <!--Tab页-->
        <ul class=" tabbale-uls" id="table" style="margin-bottom: 10px;">
            <c:choose>
                <c:when test="${result eq 'wai'}">
                    <!--内行文-->
                    <li style="    flex: unset;">
                        <a data-toggle="tab" href="#nei" class="grid_tab">
                            内行文
                        </a>
                    </li>
                    <!--外行文-->
                    <li class="active" style="    flex: unset;">
                        <a data-toggle="tab" href="#wai" class="grid_tab">
                            外行文
                        </a>
                    </li>
                </c:when>
                <c:when test="${result eq 'nei'}">
                    <!--内行文-->
                    <li class="active" style="    flex: unset;">
                        <a data-toggle="tab" href="#nei" class="grid_tab">
                            内行文
                        </a>
                    </li>
                    <!--外行文-->
                    <li style="    flex: unset;">
                        <a data-toggle="tab" href="#wai" class="grid_tab">
                            外行文
                        </a>
                    </li>
                </c:when>
                <c:otherwise>
                    <!--内行文-->
                    <li class="active" style="    flex: unset;">
                        <a data-toggle="tab" href="#nei" class="grid_tab">
                            内行文
                        </a>
                    </li>
                    <!--外行文-->
                    <li style="    flex: unset;">
                        <a data-toggle="tab" href="#wai" class="grid_tab">
                            外行文
                        </a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    <div class="tab-content" style="border: 0px;">
        <div class="tab-pane fade in active" id="nei" style="background-color: white ">
            <div >
                <div>
                    <div class="widget-body">
                        <div class="widget-main">
                            <div class="row" align="center">
                                <h1 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                    流转登记内行文二维码扫描
                                </h1>
                                <div class="col-xs-12">
                                    <form class="form-horizontal" role="form" id="saveForm">
                                        <div style="margin-top:3%"></div>
                                        <div class="row">
                                            <div class="col-xs-8">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label no-padding-right"
                                                           for="id-batch-draft"> 领导批示二维码扫描： </label>
                                                    <div class="col-sm-9 ">
                                                        <input type="text" id="id-batch-draft" name="title"
                                                               class="form-control" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <button style="" class="btn btn-success btn-sm" type="button" id="searchBtn">
                                                    <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                    流转登记
                                                </button>
                                                &nbsp;&nbsp;
                                                <button style="margin-right: 10px" class="btn btn-warning btn-sm" type="button" id="resetBtn">
                                                    <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                                    重新扫描
                                                </button>
                                                <%--<button class="btn btn-sm btn-pink" type="button" id="jumpBtn">
                                                    <i class="ace-icon fa fa-plus icon-on-right bigger-110"></i>
                                                    搜索列表
                                                </button>--%>
                                            </div>
                                        </div>


                                        <div style="margin-top:10%"></div>

                                        <div class="row">
                                            <div class="col-xs-8">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label no-padding-right"
                                                           for="id-batch-draft"> 会签登记二维码扫描： </label>
                                                    <div class="col-sm-9 ">
                                                        <input type="text" id="id-batch-unit" name="title"
                                                               class="form-control" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <button style="" class="btn btn-success btn-sm" type="button" id="searchBtnUnit">
                                                    <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                    流转登记
                                                </button>
                                                &nbsp;&nbsp;
                                                <button style="margin-right: 10px" class="btn btn-warning btn-sm" type="button" id="resetBtnUnit">
                                                    <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                                    重新扫描
                                                </button>
                                                <%--<button class="btn btn-sm btn-pink" type="button" id="jumpBtnUnit">
                                                    <i class="ace-icon fa fa-plus icon-on-right bigger-110"></i>
                                                    搜索列表
                                                </button>--%>
                                            </div>
                                        </div>

                                        <div class="hr hr-18 hr-double dotted"></div>
                                    </form>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="tab-pane fade" id="wai">
                    <div class="widget-body">
                        <div class="widget-main">
                            <div class="row" align="center">
                                <h1 align="center" style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                    流转登记外行文二维码扫描
                                </h1>
                                <div class="col-xs-12">
                                    <form class="form-horizontal" role="form" id="saveFormWai">
                                        <div style="margin-top: 3%"></div>

                                        <div class="row">
                                            <div class="col-xs-8">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label "
                                                           for="id-batch-draft-wai"> 领导批示二维码扫描： </label>
                                                    <div class="col-sm-9 ">
                                                        <input type="text" id="id-batch-draft-wai" name="title"
                                                               class="form-control" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <button class="btn btn-success btn-sm" type="button"
                                                        id="searchBtnWai">
                                                    <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                    流转登记
                                                </button>
                                                &nbsp;&nbsp;
                                                <button style="margin-right: 10px"
                                                        class="btn btn-warning btn-sm" type="button"
                                                        id="resetBtnWai">
                                                    <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                                    重新扫描
                                                </button>
                                                <%--<button class="btn btn-sm btn-pink" type="button" id="jumpBtnWai">
                                                    <i class="ace-icon fa fa-plus icon-on-right bigger-110"></i>
                                                    搜索列表
                                                </button>--%>
                                            </div>
                                        </div>

                                        <div style="margin-top:10%"></div>

                                        <div class="row">
                                            <div class="col-xs-8">
                                                <div class="form-group">
                                                    <label class="col-sm-3 control-label "
                                                           for="id-batch-draft-wai"> 会签二维码扫描： </label>
                                                    <div class="col-sm-9 ">
                                                        <input type="text" id="id-batch-draft-waiunit" name="title"
                                                               class="form-control" value=""/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-4">
                                                <button class="btn btn-success btn-sm" type="button"
                                                        id="searchBtnWaiUnit">
                                                    <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                    流转登记
                                                </button>
                                                &nbsp;&nbsp;
                                                <button style="margin-right: 10px"
                                                        class="btn btn-warning btn-sm" type="button"
                                                        id="resetBtnWaiUnit">
                                                    <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                                    重新扫描
                                                </button>
                                                <%--<button class="btn btn-sm btn-pink" type="button" id="jumpBtnWaiUnit">
                                                    <i class="ace-icon fa fa-plus icon-on-right bigger-110"></i>
                                                    搜索列表
                                                </button>--%>
                                            </div>
                                        </div>

                                        <div class="hr hr-18 hr-double dotted"></div>

                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
        </div>

    </div>
</div>

    <script type="text/javascript">
        var scripts = [null, null];
        $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

            //切换tab页
            var flagTab = '${result}';
            if (flagTab == "wai") {
                $("#nei").removeClass().attr("class", "tab-pane fade ");
                $("#wai").removeClass().attr("class", "tab-pane fade in active");
            }
            if (flagTab == "nei") {
                $("#nei").removeClass().attr("class", "tab-pane fade in active");
                $("#wai").removeClass().attr("class", "tab-pane fade ");
            }

            var $saveForm = $('#saveForm');
            var $saveFormWai = $('#saveFormWai');
            var $searchBtn = $("#searchBtn");
            var $searchBtnUnit = $("#searchBtnUnit");
            var $searchBtnWai = $("#searchBtnWai");
            var $searchBtnWaiUnit = $("#searchBtnWaiUnit");
            var $resetBtn = $("#resetBtn");
            var $resetBtnUnit = $("#resetBtnUnit");
            var $resetBtnWai = $("#resetBtnWai");
            var $resetBtnWaiUnit = $("#resetBtnWaiUnit");
            var $jumpBtn = $("#jumpBtn");
            var $jumpBtnWai = $("#jumpBtnWai");

            var searchUrl = '#page/register-batch-nei/batch-transfer-code';
            var searchUnitUrl = '#page/register-batch-nei/batch-transfer-codeunit';
            var searchUrlWai = '#page/register-batch-out/batch-transfer-wai-code';
            var searchUrlWaiUnit = '#page/register-batch-out/batch-transfer-wai-codeunit';

            $resetBtn.click(function () {
                $saveForm.resetForm();
            });
            $resetBtnUnit.click(function () {
                $saveForm.resetForm();
            });
            $resetBtnWai.click(function () {
                $saveFormWai.resetForm();
            });
            $resetBtnWaiUnit.click(function () {
                $saveFormWai.resetForm();
            });

            $jumpBtn.click(function () {
                G.pjaxLoadPageContentDiv("#page/register-batch/batch-load-list");
            });
            $jumpBtnWai.click(function () {
                G.pjaxLoadPageContentDiv("#page/register-batch/batch-load-list");
            });

            //点击流转登记提交Id过去
            $searchBtn.unbind('click').bind('click', function (e) {
                e.preventDefault();
                var batchDraftId = $saveForm.find("#id-batch-draft").val();
                if (batchDraftId != ""){
                    var data = $saveForm.serializeObject();
                    data["batchDraftId"] = batchDraftId;

                    var Url = searchUrl + "?batchDraftId=" + batchDraftId + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(Url);
                }
            });

            //点击流转登记时把Id提交过去
            $searchBtnUnit.unbind('click').bind('click', function (e) {
                e.preventDefault();
                var batchDraftId = $saveForm.find("#id-batch-unit").val();

                if (batchDraftId != ""){
                    var data = $saveForm.serializeObject();
                    data["batchDraftId"] = batchDraftId;

                    var Url = searchUnitUrl + "?batchDraftId=" + batchDraftId + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(Url);
                }

            });

            //点击流转登记提交Id过去
            $searchBtnWai.unbind('click').bind('click', function (e) {
                e.preventDefault();
                var batchDraftIdWai = $saveFormWai.find("#id-batch-draft-wai").val();
                if (batchDraftIdWai != ""){
                    var data = $saveFormWai.serializeObject();
                    data["batchDraftIdWai"] = batchDraftIdWai;
                    var urlWai = searchUrlWai + "?batchDraftIdWai=" + batchDraftIdWai + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(urlWai);
                }
            });
            //点击流转登记提交Id过去
            $searchBtnWaiUnit.unbind('click').bind('click', function (e) {
                e.preventDefault();
                var batchDraftIdWai = $saveFormWai.find("#id-batch-draft-waiunit").val();
                if (batchDraftIdWai != ""){
                    var data = $saveFormWai.serializeObject();
                    data["batchDraftIdWai"] = batchDraftIdWai;
                    var urlWai = searchUrlWaiUnit + "?batchDraftIdWai=" + batchDraftIdWai + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(urlWai);
                }
            });
        });
    </script>