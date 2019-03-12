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
    <div class="col-sm-12">
        <div class="tabbable">
            <ul class="tabbale-uls" id="myTab4">
                <li class="active" style="    flex: unset;">
                    <a data-toggle="tab" href="#home4">国家情况基本信息</a>
                </li>

                <li style="    flex: unset;">
                    <a data-toggle="tab" href="#profile4">风俗礼仪禁忌</a>
                </li >

                <li style="    flex: unset;">
                    <a data-toggle="tab" href="#dropdown14">入境注意事项</a>
                </li>

                <li style="    flex: unset;">
                    <a data-toggle="tab" href="#dropdown13">国家简介</a>
                </li>
            </ul>

            <div class="tab-content" style="margin-top:15px;margin-bottom: 15px;">
                <div id="home4" class="tab-pane in active" style="height: 150px; overflow-y:auto;overflow-x:hidden;">
                    <div class="widget-body">
                        <div class="widget-main">
                            <input id="nationId" name="nationId" type="hidden" value="${nation.id}">
                            <div class="row">
                                <div class="space-20"></div>
                            </div>
                            <div class="row">
                                <div class="col-xs-3">
                                    <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                        <label class="col-sm-6 text-right bolder">国家名称:</label>
                                        <label class="col-sm-6 text-left bolder">${nation.jsonObject.nationName}</label>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                        <label class="col-sm-6 text-right bolder">所属地区:</label>
                                        <label class="col-sm-6 text-left bolder">${nation.jsonObject.belongArea}</label>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                        <label class="col-sm-6 text-right bolder">一带一路国家:</label>
                                        <label class="col-sm-6 text-left bolder">${nation.jsonObject.isOborNationVal}</label>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                        <label class="col-sm-6 text-right bolder">阿拉伯国家:</label>
                                        <label class="col-sm-6 text-left bolder">${nation.jsonObject.isArabNationVal}</label>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-3">
                                    <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                        <label class="col-sm-6 text-right bolder">周边国家:</label>
                                        <label class="col-sm-6 text-left bolder">${nation.jsonObject.isAroundNationVal}</label>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                        <label class="col-sm-6 text-right bolder">西方发达国家:</label>
                                        <label class="col-sm-6 text-left bolder">${nation.jsonObject.isWestNationVal}</label>
                                    </div>
                                </div>
                                <div class="col-xs-3">
                                    <div class="form-group" style="margin-top: 5px;margin-bottom: 5px">
                                        <label class="col-sm-6 text-right bolder">其他国家:</label>
                                        <label class="col-sm-6 text-left bolder">${nation.jsonObject.isOtherNationVal}</label>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="profile4" class="tab-pane" style="height: 150px; overflow-y:auto;overflow-x:hidden;">
                    <div>&nbsp;&nbsp;${nation.jsonObject.moresProtocolTaboo}</div>
                </div>

                <div id="dropdown14" class="tab-pane" style="height: 150px; overflow-y:auto;overflow-x:hidden;">
                    <div>&nbsp;&nbsp;${nation.jsonObject.ehtryNotices}</div>
                </div>

                <div id="dropdown13" class="tab-pane" style="height: 150px; overflow-y:auto;overflow-x:hidden;">
                    <div>${nation.jsonObject.nationIntro}</div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="space-10"></div>
</div>
<div class="row">
    <div class="col-xs-12">
        <div class="tabbable">
            <ul id="inbox-tabs" class="tabbale-uls">
                <li class="active" style="flex: unset">
                    <a data-toggle="tab" href="#vipPerson">
                        <%--<i class="blue ace-icon fa fa-users bigger-130"></i>--%>
                        <span class="">主要人物简介</span>
                    </a>
                </li>

                <li style="flex: unset">
                    <a data-toggle="tab" href="#parliament">
                        <%--<i class="orange2 ace-icon fa fa-gavel bigger-130"></i>--%>
                        <span class="">重要议会简介</span>
                    </a>
                </li>

                <li style="flex: unset">
                    <a data-toggle="tab" href="#contact">
                        <%--<i class="purple ace-icon fa fa-comments bigger-130"></i>--%>
                        <span class="">交往情况记录</span>
                    </a>
                </li>

                <li style="flex: unset">
                    <a data-toggle="tab" href="#cityScenery">
                        <%--<i class="green ace-icon fa fa-tree bigger-130"></i>--%>
                        <span class="">城市/景点简介</span>
                    </a>
                </li>
            </ul>

            <div class="tab-content no-border no-padding" style="margin-top: 15px;">
                <div id="vipPerson" class="tab-pane in active">

                    <div class="message-container">
                        <div id="id-message-list-navbar1" class="clearfix">
                            <div class="message-bar">
                                <div class="message-infobar" id="id-message-infobar1">
                                    <%--<span class="blue bigger-150">主要人物</span>--%>
                                    <%--<span class="green bigger-110">简介</span>--%>
                                </div>
                            </div>
                            <div class="header-table-th">主要人物简介</div>
                            <div>
                                <div class="messagebar-item-right contacts-exportBtn">
                                    <div class="inline position-relative">
                                        <button class="btn btn-info btn-sm" type="button" id="addVipPersonBtn">
                                            <span class="ace-icon fa fa-user icon-on-right bigger-110"></span>
                                            添加
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="message-list-container">
                            <div class="message-list" id="vip-person-message-list">
                                <div class="table-content col-md-12">
                                    <div class="col-md-12 new-message" style="padding: 0px; background: #fff;">
                                        <c:if test="${nation.id ne null}">
                                            <c:forEach items="${vipPersonIntroList}" var="vipPersonIntro">
                                                <div class="message-item message-unread vipPersonDiv"
                                                     data-item={"vipPersonId":"${vipPersonIntro.id}"}>

                                                    <span class="sender"
                                                          title="${vipPersonIntro.jsonObject.foreignName}">${vipPersonIntro.jsonObject.chineseName}</span>

                                                    <span class="summary" data-rel="popover" style="word-break: break-all; display: block;white-space: pre-wrap;word-wrap: break-word;">${vipPersonIntro.jsonObject.personIntro}</span>

                                                    <span class="time">${vipPersonIntro.jsonObject.createTime}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<i
                                                            class="ace-icon green fa fa-pencil row-record-edit bigger-125"
                                                            style="cursor: pointer;" title="修改"></i>&nbsp;&nbsp;<i
                                                            class="ace-icon red fa fa-trash-o row-record-delete bigger-125"
                                                            style="cursor: pointer;" title="删除"></i>
                                                    </span>
                                                </div>
                                            </c:forEach>
                                        </c:if>
                                    </div>

                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div id="parliament" class="tab-pane fade">
                    <div class="message-container">
                        <div id="id-message-list-navbar2" class=" clearfix">
                            <div class="message-bar">
                                <div class="message-infobar" id="id-message-infobar2">
                                    <%--<span class="blue bigger-150">重要议会</span>--%>
                                    <%--<span class="green bigger-110">简介</span>--%>
                                </div>
                            </div>
                            <div class="header-table-th">重要议会简介</div>
                            <div>
                                <div class="messagebar-item-right contacts-exportBtn">
                                    <div class="inline position-relative" >
                                        <button class="btn btn-warning btn-sm" type="button" id="addParliamentBtn">
                                            <span class="ace-icon fa fa-gavel icon-on-right bigger-110"></span>
                                            添加
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="message-list-container">
                            <div class="message-list" id="parliament-message-list">
                            <div class="table-content col-md-12">
                                <div class="col-md-12 new-message" style="padding: 0px;background: #fff;">
                                    <c:if test="${nation.id ne null}">
                                    <c:forEach items="${parliamentIntroList}" var="parliamentIntro">
                                        <div class="message-item message-unread parliamentDiv" data-item={"parliamentId":"${parliamentIntro.id}"}>
                                            <%--<i class="message-star ace-icon fa fa-gavel orange2"></i>--%>
                                            <span class="sender" title="${parliamentIntro.jsonObject.parliamentName}">${parliamentIntro.jsonObject.parliamentName}</span>


                                            <span class="summary" data-rel="popover" style="word-break: break-all; display: block;white-space: pre-wrap;word-wrap: break-word;">${parliamentIntro.jsonObject.parliamentIntro}</span>
                                            <span class="time" style="width: 180px">${parliamentIntro.jsonObject.createTime}&nbsp;&nbsp;<i class="ace-icon green fa fa-pencil row-record-edit bigger-125" style="cursor: pointer;" title="修改"></i>&nbsp;&nbsp;<i class="ace-icon red fa fa-trash-o row-record-delete bigger-125" style="cursor: pointer;" title="删除"></i>
                                            </span>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                </div>

                            </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="contact" class="tab-pane fade">
                    <div class="message-container">
                        <div id="id-message-list-navbar3" class=" clearfix">
                            <div class="message-bar">
                                <div class="message-infobar" id="id-message-infobar3">
                                    <%--<span class="blue bigger-150">交往情况</span>--%>
                                    <%--<span class="green bigger-110">记录</span>--%>
                                </div>
                            </div>
                            <div class="header-table-th">交往情况记录</div>
                            <div>
                                <div class="messagebar-item-right contacts-exportBtn">
                                    <div class="inline position-relative" >
                                        <button class="btn btn-purple btn-sm" type="button" id="addContactBtn">
                                            <span class="ace-icon fa fa-comments icon-on-right bigger-110"></span>
                                            添加
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="message-list-container">
                            <div class="message-list" id="contact-message-list">
                            <div class="table-content col-md-12">
                                <div class="col-md-12 new-message" style="padding: 0px;background: #fff;">
                                    <c:if test="${nation.id ne null}">
                                        <c:forEach items="${contactConditionList}" var="contactCondition">
                                            <div class="message-item message-unread contactDiv" data-item={"contactId":"${contactCondition.id}"}>
                                                <c:if test="${contactCondition.jsonObject.contactType eq '0'}">
                                                    <%--<i class="message-star ace-icon fa fa-comment purple"></i>--%>
                                                </c:if>
                                                <c:if test="${contactCondition.jsonObject.contactType eq '1'}">
                                                    <%--<i class="message-star ace-icon fa fa-comment-o purple"></i>--%>
                                                </c:if>
                                                <span class="sender" title="${contactCondition.jsonObject.contactTypeVal}-${contactCondition.jsonObject.contactDate}">${contactCondition.jsonObject.contactTypeVal}-${contactCondition.jsonObject.contactDate}</span>


                                                <span class="summary" data-rel="popover"style="word-break: break-all; display: block;white-space: pre-wrap;word-wrap: break-word;">${contactCondition.jsonObject.contactCondition}</span>
                                                <span class="time" style="width: 180px">${contactCondition.jsonObject.createTime}&nbsp;&nbsp;<i class="ace-icon green fa fa-pencil row-record-edit bigger-125" style="cursor: pointer;" title="修改"></i>&nbsp;&nbsp;<i class="ace-icon red fa fa-trash-o row-record-delete bigger-125" style="cursor: pointer;" title="删除"></i>
                                                </span>
                                            </div>
                                        </c:forEach>
                                    </c:if>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div id="cityScenery" class="tab-pane fade">
                    <div class="message-container">
                        <div id="id-message-list-navbar4" class=" clearfix">
                            <div class="message-bar">
                                <div class="message-infobar" id="id-message-infobar4">
                                    <%--<span class="blue bigger-150">城市/景点</span>--%>
                                    <%--<span class="green bigger-110">简介</span>--%>
                                </div>
                            </div>
                            <div class="header-table-th">城市/景点简介</div>
                            <div>
                                <div class="messagebar-item-right contacts-exportBtn">
                                    <div class="inline position-relative" >
                                        <button class="btn btn-success btn-sm" type="button" id="addCitySceneryBtn">
                                            <span class="ace-icon fa fa-tree icon-on-right bigger-110"></span>
                                            添加
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="message-list-container">
                            <div class="message-list" id="city-scenery-message-list">
                            <div class="table-content col-md-12">
                                <div class="col-md-12 new-message" style="padding: 0px;background: #fff;">
                                     <c:if test="${nation.id ne null}">
                                    <c:forEach items="${citySceneryIntroList}" var="citySceneryIntro">
                                        <div class="message-item message-unread citySceneryDiv" data-item={"citySceneryId":"${citySceneryIntro.id}"}>
                                            <%--<i class="message-star ace-icon fa fa-tree green"></i>--%>
                                            <span class="sender" title="${citySceneryIntro.jsonObject.citySceneryName}">${citySceneryIntro.jsonObject.citySceneryName}</span>
                                            <span class="summary" data-rel="popover" style="word-break: break-all; display: block;white-space: pre-wrap;word-wrap: break-word;">${citySceneryIntro.jsonObject.citySceneryIntro}</span>
                                            <span class="time" style="width: 180px">${citySceneryIntro.jsonObject.createTime}&nbsp;&nbsp;<i class="ace-icon green fa fa-pencil row-record-edit bigger-125" style="cursor: pointer;" title="修改"></i>&nbsp;&nbsp;<i class="ace-icon red fa fa-trash-o row-record-delete bigger-125" style="cursor: pointer;" title="删除"></i>
                                            </span>
                                        </div>
                                    </c:forEach>
                                </c:if>
                                </div>
                            </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="row">
    <div class="space-10"></div>
</div>
<div class="row">
    <div class="col-xs-12">
        <div class="clearfix">
            <div class="col-xs-12 center">
                <button class="btn btn-primary" type="button" id="backBtn">
                    <i class="ace-icon fa fa-undo bigger-110"></i>
                    返回
                </button>
            </div>
        </div>
    </div>
</div>

<div id="vip-person-dialog" class="hidden">
    <form id="vipPersonForm" autocomplete="off" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right">重要人物姓名(中文)：
                        <span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <input type="text" id="chineseName" name="chineseName"
                               class="form-control" placeholder="重要人物姓名(中文)"/>
                    </div>
                </div>
            </div>
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right" >重要人物姓名（英文)：
                        <span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <input type="text" id="foreignName" name="foreignName"
                               class="form-control" placeholder="重要人物姓名（英文)"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-10"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <h3 align="center">重要人物简介<span
                            class="required">*</span></h3>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                        <div id="personIntro" name="personIntro" type="text/plain"
                             style="min-height: 200px"></div>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="parliament-dialog" class="hidden">
    <form id="parliamentForm" autocomplete="off" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right">议会名称：
                        <span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <input type="text" id="parliamentName" name="parliamentName"
                               class="form-control" placeholder="议会名称"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-10"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <h3 align="center">议会简介<span
                            class="required">*</span></h3>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                        <div id="parliamentIntro" name="parliamentIntro" type="text/plain"
                             style="min-height: 200px"></div>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="contact-dialog" class="hidden">
    <form id="contactForm" autocomplete="off" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right">交往对象：
                        <span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <div class="input-group">
                            <select class="form-control" id="contactType"
                                    name="contactType" style="width: 240px">
                                <option value="">-----请选择-----</option>
                                <option value="0">政协</option>
                                <option value="1">其他</option>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right">交往日期：
                        <span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                            <input class="form-control" name="contactDate" id="contactDate"
                                   type="text" placeholder="交往日期"/>
                            <span class="input-group-addon">
                                <i class="fa fa-calendar bigger-110"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-10"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <h3 align="center">交往情况<span
                            class="required">*</span></h3>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <div id="contactCondition" name="contactCondition" type="text/plain"
                         style="min-height: 200px"></div>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="city-scenery-dialog" class="hidden">
    <form id="citySceneryForm" autocomplete="off" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right">城市/景点名称：
                        <span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <input type="text" id="citySceneryName" name="citySceneryName"
                               class="form-control" placeholder="城市/景点名称"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-10"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <h3 align="center">城市/景点简介<span
                            class="required">*</span></h3>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <div id="citySceneryIntro" name="citySceneryIntro" type="text/plain"
                         style="min-height: 200px"></div>
                </div>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({
            autoclose: true,
            todayHighlight : true
        });

        var $nationId = $('#nationId');

        var $vipPersonMessageList = $('#vip-person-message-list');
        var $addVipPersonBtn = $('#addVipPersonBtn');
        var $vipPersonDialog = $('#vip-person-dialog');
        var $vipPersonForm = $('#vipPersonForm');

        var $parliamentMessageList = $('#parliament-message-list');
        var $addParliamentBtn = $('#addParliamentBtn');
        var $parliamentDialog = $('#parliament-dialog');
        var $parliamentForm = $('#parliamentForm');

        var $contactMessageList = $('#contact-message-list');
        var $addContactBtn = $('#addContactBtn');
        var $contactDialog = $('#contact-dialog');
        var $contactForm = $('#contactForm');

        var $citySceneryMessageList = $('#city-scenery-message-list');
        var $addCitySceneryBtn = $('#addCitySceneryBtn');
        var $citySceneryDialog = $('#city-scenery-dialog');
        var $citySceneryForm = $('#citySceneryForm');

        clickPopover($vipPersonMessageList, '主要人物简介');
        clickPopover($parliamentMessageList, '重要议会简介');
        clickPopover($contactMessageList, '交往情况记录');
        clickPopover($citySceneryMessageList, '城市/景点简介');

        $addVipPersonBtn.click(function () {
            openVipPersonDialog(null, null);
        });

        $addParliamentBtn.click(function () {
            openParliamentDialog(null, null);
        });

        $addContactBtn.click(function () {
            openContactDialog(null, null);
        });

        $addCitySceneryBtn.click(function () {
            openCitySceneryDialog(null, null);
        });

        function openVipPersonDialog(intro, editDiv) {
            $vipPersonDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 530,
                width: 1000,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border' style='margin-top: 12px'><i class='ace-icon fa fa-user blue'></i>&nbsp;添加重要人物</div>",
                title_html: true,
                close: function () {
                    $vipPersonForm.resetForm();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 添加",
                        "class": "btn btn-success",
                        click: function () {
                            var $this = $(this);
                            if($vipPersonForm.validate().form()) {
                                var data = $vipPersonForm.serializeObject();
                                data.nationId = $nationId.val();
                                if (intro != null) {//编辑时id赋值
                                    data.id = intro.id;
                                }
                                var url = '${basePath}/nation-condition/vip-person-save.do';
                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: url,
                                    type: 'POST',
                                    dataType: 'json',
                                    data: JSON.stringify(data),
                                    contentType: "application/json;charset=utf-8",
                                    async: true
                                }).done(function (map) {
                                    G.doneAjaxLoading(loadId);
                                    if (map.result == true) {
                                        var createTime = map.createTime;
                                        var vipPersonId = map.vipPersonId;
                                        if (editDiv != null) {//编辑时删除之前的div
                                            editDiv.remove();
                                        }
                                        addMessage('vipPerson', $vipPersonMessageList, data, createTime, vipPersonId);
                                        G.showGritterSuccess("操作成功!");
                                        $this.dialog("close");
                                    } else {
                                        G.showGritterFail("操作失败!");
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            UE.delEditor('personIntro');
            var ue = UE.getEditor('personIntro');
            ue.addListener("ready", function () {
                if (intro == null) {//新增
                    ue.setContent('');
                } else {//编辑
                    ue.setContent(intro.personIntro);
                }
            });
            $vipPersonDialog.dialog('open');
        }

        function openParliamentDialog(intro, editDiv) {
            $parliamentDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 530,
                width: 1000,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border' style='margin-top: 12px'><i class='ace-icon fa fa-gavel orange'></i>&nbsp;添加重要议会</div>",
                title_html: true,
                close: function () {
                    $parliamentForm.resetForm();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 添加",
                        "class": "btn btn-success",
                        click: function () {
                            var $this = $(this);
                            if($parliamentForm.validate().form()) {
                                var data = $parliamentForm.serializeObject();
                                data.nationId = $nationId.val();
                                if (intro != null) {//编辑时id赋值
                                    data.id = intro.id;
                                }
                                var url = '${basePath}/nation-condition/parliament-save.do';
                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: url,
                                    type: 'POST',
                                    dataType: 'json',
                                    data: JSON.stringify(data),
                                    contentType: "application/json;charset=utf-8",
                                    async: true
                                }).done(function (map) {
                                    G.doneAjaxLoading(loadId);
                                    if (map.result == true) {
                                        var createTime = map.createTime;
                                        var parliamentId = map.parliamentId;
                                        if (editDiv != null) {//编辑时删除之前的div
                                            editDiv.remove();
                                        }
                                        addMessage('parliament', $parliamentMessageList, data, createTime, parliamentId);
                                        G.showGritterSuccess("操作成功!");
                                        $this.dialog("close");
                                    } else {
                                        G.showGritterFail("操作失败!");
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            UE.delEditor('parliamentIntro');
            var ue = UE.getEditor('parliamentIntro');
            ue.addListener("ready", function () {
                if (intro == null) {//新增
                    ue.setContent('');
                } else {//编辑
                    ue.setContent(intro.parliamentIntro);
                }
            });
            $parliamentDialog.dialog('open');
        }

        function openContactDialog(intro, editDiv) {
            $contactDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 530,
                width: 1000,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border' style='margin-top: 12px'><i class='ace-icon fa fa-comments purple'></i>&nbsp;添加交往情况</div>",
                title_html: true,
                close: function () {
                    $contactForm.resetForm();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 添加",
                        "class": "btn btn-success",
                        click: function () {
                            var $this = $(this);
                            if($contactForm.validate().form()) {
                                var data = $contactForm.serializeObject();
                                data.nationId = $nationId.val();
                                if (intro != null) {//编辑时id赋值
                                    data.id = intro.id;
                                }
                                var url = '${basePath}/nation-condition/contact-save.do';
                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: url,
                                    type: 'POST',
                                    dataType: 'json',
                                    data: JSON.stringify(data),
                                    contentType: "application/json;charset=utf-8",
                                    async: true
                                }).done(function (map) {
                                    G.doneAjaxLoading(loadId);
                                    if (map.result == true) {
                                        var createTime = map.createTime;
                                        var contactId = map.contactId;
                                        if (editDiv != null) {//编辑时删除之前的div
                                            editDiv.remove();
                                        }
                                        addMessage('contact', $contactMessageList, data, createTime, contactId);
                                        G.showGritterSuccess("操作成功!");
                                        $this.dialog("close");
                                    } else {
                                        G.showGritterFail("操作失败!");
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            UE.delEditor('contactCondition');
            var ue = UE.getEditor('contactCondition');
            ue.addListener("ready", function () {
                if (intro == null) {//新增
                    ue.setContent('');
                } else {//编辑
                    ue.setContent(intro.contactCondition);
                }
            });
            $contactDialog.dialog('open');
        }

        function openCitySceneryDialog(intro, editDiv) {
            $citySceneryDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 530,
                width: 1000,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border' style='margin-top: 12px'><i class='ace-icon fa fa-tree green'></i>&nbsp;添加交往情况</div>",
                title_html: true,
                close: function () {
                    $citySceneryForm.resetForm();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn",
                        click: function () {
                            $(this).dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 添加",
                        "class": "btn btn-success",
                        click: function () {
                            var $this = $(this);
                            if($citySceneryForm.validate().form()) {
                                var data = $citySceneryForm.serializeObject();
                                data.nationId = $nationId.val();
                                if (intro != null) {//编辑时id赋值
                                    data.id = intro.id;
                                }
                                var url = '${basePath}/nation-condition/city-scenery-save.do';
                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: url,
                                    type: 'POST',
                                    dataType: 'json',
                                    data: JSON.stringify(data),
                                    contentType: "application/json;charset=utf-8",
                                    async: true
                                }).done(function (map) {
                                    G.doneAjaxLoading(loadId);
                                    if (map.result == true) {
                                        var createTime = map.createTime;
                                        var citySceneryId = map.citySceneryId;
                                        if (editDiv != null) {//编辑时删除之前的div
                                            editDiv.remove();
                                        }
                                        addMessage('cityScenery', $citySceneryMessageList, data, createTime, citySceneryId);
                                        G.showGritterSuccess("操作成功!");
                                        $this.dialog("close");
                                    } else {
                                        G.showGritterFail("操作失败!");
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            UE.delEditor('citySceneryIntro');
            var ue = UE.getEditor('citySceneryIntro');
            ue.addListener("ready", function () {
                if (intro == null) {//新增
                    ue.setContent('');
                } else {//编辑
                    ue.setContent(intro.citySceneryIntro);
                }
            });
            $citySceneryDialog.dialog('open');
        }

        $vipPersonForm.tjValidate({
            focusInvalid: true,
            rules: {
                chineseName: {required: true},
                foreignName: {required: true}
            },
            messages: {
                chineseName: {required: "中文姓名必须填写"},
                foreignName: {required: "英文姓名必须填写"}
            }
        });

        $parliamentForm.tjValidate({
            focusInvalid: true,
            rules: {
                parliamentName: {required: true}
            },
            messages: {
                parliamentName: {required: "议会名称必须填写"}
            }
        });

        $contactForm.tjValidate({
            focusInvalid: true,
            rules: {
                contactType: {required: true},
                contactDate: {required: true}
            },
            messages: {
                contactType: {required: "交往对象必须选择"},
                contactDate: {required: "交往日期必须填写"}
            }
        });

        $citySceneryForm.tjValidate({
            focusInvalid: true,
            rules: {
                citySceneryName: {required: true}
            },
            messages: {
                citySceneryName: {required: "城市/景点名称必须填写"}
            }
        });

        //inbox中追加一条数据
        function addMessage(type, $messageListDiv, data, createTime, id) {
            var messageArr = [];
            if (type === 'vipPerson') {
                messageArr.push('<div class="message-item message-unread ' + type + 'Div" data-item={"vipPersonId":"'+ id +'"}>');
                messageArr.push('    <span class="sender" title="'+ data.foreignName +'">'+ data.chineseName +'</span> ');
                messageArr.push('    <span class="summary" data-rel="popover" style="word-break: break-all; display: block;white-space: pre-wrap;word-wrap: break-word;">'+ data.personIntro +'</span>');
                messageArr.push('    <span class="time" style="width: 180px">'+ createTime +'&nbsp;&nbsp;');
                messageArr.push('      <i class="ace-icon green fa fa-pencil row-record-edit bigger-125" style="cursor: pointer;" title="修改">');
                messageArr.push('      </i>&nbsp;&nbsp;<i class="ace-icon red fa fa-trash-o row-record-delete bigger-125" style="cursor: pointer;" title="删除"></i></span>');
                messageArr.push('</div>');
            } else if (type === 'parliament') {
                messageArr.push(' <div class="message-item message-unread ' + type + 'Div" data-item={"parliamentId":"'+ id +'"}>');
                messageArr.push('     <span class="sender" title="'+ data.parliamentName +'">'+ data.parliamentName +'</span> ');
                messageArr.push('     <span class="summary" data-rel="popover" style="word-break: break-all; display: block;white-space: pre-wrap;word-wrap: break-word;">'+ data.parliamentIntro +'</span>');
                messageArr.push('     <span class="time" style="width: 180px;">'+ createTime +'&nbsp;&nbsp;');
                messageArr.push('       <i class="ace-icon green fa fa-pencil row-record-edit bigger-125" style="cursor: pointer;" title="修改">');
                messageArr.push('       </i>&nbsp;&nbsp;<i class="ace-icon red fa fa-trash-o row-record-delete bigger-125" style="cursor: pointer;" title="删除"></i></span>');
                messageArr.push(' </div>');
            } else if (type === 'contact') {
                messageArr.push(' <div class="message-item message-unread ' + type + 'Div" data-item={"contactId":"'+ id +'"}>');
                if (data.contactType === '0') {
                    messageArr.push('     <span class="sender" title="'+'政协-'+ data.contactDate +'">'+'政协-'+ data.contactDate +'</span> ');
                } else if (data.contactType === '1') {
                    messageArr.push('     <span class="sender" title="'+'其他-'+ data.contactDate +'">'+'其他-'+ data.contactDate +'</span> ');
                }
                messageArr.push('     <span class="summary" data-rel="popover" style="word-break: break-all; display: block;white-space: pre-wrap;word-wrap: break-word;">'+ data.contactCondition +'</span>');
                messageArr.push('     <span class="time" style="width: 180px">'+ createTime +'&nbsp;&nbsp;<i class="ace-icon green fa fa-pencil row-record-edit bigger-125" style="cursor: pointer;" title="修改"></i>&nbsp;&nbsp;<i class="ace-icon red fa fa-trash-o row-record-delete bigger-125" style="cursor: pointer;" title="删除"></i></span> ');
                messageArr.push(' </div>');
            } else if (type === 'cityScenery') {
                messageArr.push(' <div class="message-item message-unread ' + type + 'Div" data-item={"citySceneryId":"'+ id +'"}>');
                messageArr.push('     <span class="sender" title="'+ data.citySceneryName +'">'+ data.citySceneryName +'</span> ');
                messageArr.push('     <span class="summary" data-rel="popover" style="word-break: break-all; word-wrap: break-word">'+ data.citySceneryIntro +'</span>');
                messageArr.push('     <span class="time" style="width: 180px">'+ createTime +'&nbsp;&nbsp;');
                messageArr.push('<i class="ace-icon green fa fa-pencil row-record-edit bigger-125" style="cursor: pointer;" title="修改">');
                messageArr.push('</i>&nbsp;&nbsp;<i class="ace-icon red fa fa-trash-o row-record-delete bigger-125" style="cursor: pointer;" title="删除"></i></span>                                ');
                messageArr.push(' </div>');
            }
            $messageListDiv.find(".new-message").prepend(messageArr.join(''));
            if (type == 'vipPerson') {
                clickPopover($vipPersonMessageList, '主要人物简介');
            }  else if (type == 'parliament') {
                clickPopover($parliamentMessageList, '重要议会简介');
            } else if (type == 'contact') {
                clickPopover($contactMessageList, '交往情况记录');
            } else if (type == 'cityScenery') {
                clickPopover($citySceneryMessageList, '城市/景点简介');
            }
        }

        function clickPopover($messageListDiv, title) {
            $messageListDiv.find('span[data-rel=popover]').each(function () {
                var $element = $(this);
                var text = $element.html();
                $element.popover({
                    trigger: 'hover',//hover
                    placement: 'auto',//可以指定弹框位置 例如'auto right'
                    title: title,
                    html: 'true',
                    container:'body',
                    content: getStyledContent(text)
                });
            });
        }

        function getStyledContent(text) {
            var html = [];

            html.push('<div style="word-break: normal;max-width: 500px;display: block;white-space: pre-wrap;word-wrap: break-word;overflow: hidden">');
            html.push(text);
            html.push('</div>');

            return html.join('');
        }

        $vipPersonMessageList.on('click', '.row-record-delete', function (e) {
            e.preventDefault();
            var $this = $(this);
            var $div = $this.parents('div.vipPersonDiv');
            var item = $this.parents('div.vipPersonDiv').data('item');
            var vipPersonId = item.vipPersonId;
            var url = "${basePath}/nation-condition/vip-person-delete.do";
            deleteMessage(url, vipPersonId, $div)
        });

        $vipPersonMessageList.on('click', '.row-record-edit', function (e) {
            e.preventDefault();
            var $this = $(this);
            var $div = $this.parents('div.vipPersonDiv');
            var item = $this.parents('div.vipPersonDiv').data('item');
            var vipPersonId = item.vipPersonId;
            var url = "${basePath}/nation-condition/vip-person-edit.do";
            var intro = getOneMessage(url, vipPersonId);
            $('#chineseName').val(intro.chineseName);
            $('#foreignName').val(intro.foreignName);
            openVipPersonDialog(intro, $div);
        });

        $parliamentMessageList.on('click', '.row-record-delete', function (e) {
            e.preventDefault();
            var $this = $(this);
            var $div = $this.parents('div.parliamentDiv');
            var item = $this.parents('div.parliamentDiv').data('item');
            var parliamentId = item.parliamentId;
            var url = "${basePath}/nation-condition/parliament-delete.do";
            deleteMessage(url, parliamentId, $div)
        });

        $parliamentMessageList.on('click', '.row-record-edit', function (e) {
            e.preventDefault();
            var $this = $(this);
            var $div = $this.parents('div.parliamentDiv');
            var item = $this.parents('div.parliamentDiv').data('item');
            var parliamentId = item.parliamentId;
            var url = "${basePath}/nation-condition/parliament-edit.do";
            var intro = getOneMessage(url, parliamentId);
            $('#parliamentName').val(intro.parliamentName);
            openParliamentDialog(intro, $div);
        });

        $contactMessageList.on('click', '.row-record-delete', function (e) {
            e.preventDefault();
            var $this = $(this);
            var $div = $this.parents('div.contactDiv');
            var item = $this.parents('div.contactDiv').data('item');
            var contactId = item.contactId;
            var url = "${basePath}/nation-condition/contact-delete.do";
            deleteMessage(url, contactId, $div)
        });

        $contactMessageList.on('click', '.row-record-edit', function (e) {
            e.preventDefault();
            var $this = $(this);
            var $div = $this.parents('div.contactDiv');
            var item = $this.parents('div.contactDiv').data('item');
            var contactId = item.contactId;
            var url = "${basePath}/nation-condition/contact-edit.do";
            var intro = getOneMessage(url, contactId);
            $('#contactDate').val(intro.contactDate);
            $('#contactType').val(intro.contactType);
            openContactDialog(intro, $div);
        });

        $citySceneryMessageList.on('click', '.row-record-delete', function (e) {
            e.preventDefault();
            var $this = $(this);
            var $div = $this.parents('div.citySceneryDiv');
            var item = $this.parents('div.citySceneryDiv').data('item');
            var citySceneryId = item.citySceneryId;
            var url = "${basePath}/nation-condition/city-scenery-delete.do";
            deleteMessage(url, citySceneryId, $div)
        });

        $citySceneryMessageList.on('click', '.row-record-edit', function (e) {
            e.preventDefault();
            var $this = $(this);
            var $div = $this.parents('div.citySceneryDiv');
            var item = $this.parents('div.citySceneryDiv').data('item');
            var citySceneryId = item.citySceneryId;
            var url = "${basePath}/nation-condition/city-scenery-edit.do";
            var intro = getOneMessage(url, citySceneryId);
            $('#citySceneryName').val(intro.citySceneryName);
            openCitySceneryDialog(intro, $div);
        });

        function deleteMessage(url, id, deleteDiv) {
            G.confirm({
                message: '确认删除此条信息吗？',
                callback: function (result) {
                    if (result) {
                        $.post(url, {id: id}, function (data) {
                            if (data.result) {
                                G.showGritterSuccess("删除成功！");
                                deleteDiv.remove();
                            } else {
                                G.showGritterFail("删除失败！")
                            }
                        });
                    }
                }
            });
        }

        function getOneMessage(url, id) {
            var data = null;
            if (id) {
                var loadId = G.showAjaxLoading();
                $.ajax({
                    type: 'POST',
                    url: url,
                    dataType: 'json',
                    async: false,
                    data: {id: id},
                    success: function(response){
                        if (response.result) {
                            G.doneAjaxLoading(loadId);
                            data = response.intro;
                        }
                    }
                });
            }
            return data;
        }

        var $backBtn = $('#backBtn');
        $backBtn.click(function () {
            G.pjaxLoadPageContentDiv('#page/nation-condition/nation-condition-list');
        })

        //初始化页面时移除dialog模态框
        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>