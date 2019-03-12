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
    <div class="col-xs-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" id="giftApplicationForm" role="form" method="post">
                                <input id="giftApplicationId" name="id" type="hidden" value="${giftApplication.id}">
                                <input id="abroadinfoId" type="hidden" name="abroadinfoId" value="${abroadinfoId}"/>
                                <input id="comeInfoId" type="hidden" name="comeInfoId" value="${comeInfoId}"/>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${giftApplication.id eq null}"> 礼品申请信息新增</c:when>
                                                    <c:otherwise> 礼品申请信息编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-applicationCode">申请单编码：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-applicationCode"
                                                       name="applicationCode"
                                                       class="form-control " value="${giftApplication.applicationCode}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-applicationState">申请状态：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-applicationState" name="applicationState">
                                                    <c:choose>
                                                        <c:when test="${giftApplication.id eq null}">
                                                            <c:forEach items="${dicParamList}" var="dicParam">
                                                                <option value="${dicParam.id}"
                                                                        <c:if test="${dicParam.id eq notAccept.id}">selected</c:if>>${dicParam.name}</option>
                                                            </c:forEach>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <c:forEach items="${dicParamList}" var="dicParam">
                                                                <option value="${dicParam.id}"
                                                                        <c:if test="${giftApplication.dicParam.id eq dicParam.id}">selected</c:if> >${dicParam.name}</option>
                                                            </c:forEach>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-activityName">活动名称：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-activityName" name="activityName"
                                                       class="form-control " value="${giftApplication.activityName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-activityType">活动类型：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-activityType" name="activityType"
                                                       class="form-control " value="${giftApplication.activityType}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-applicationPerson">申请人：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-applicationPerson"
                                                       name="applicationPerson"
                                                       class="form-control "
                                                       value="${giftApplication.applicationPerson}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-applicationTime">申请时间：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="applicationTime"
                                                           id="form-field-applicationTime"
                                                           value="${giftApplication.jsonObject.applicationTime}"
                                                           type="text"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-contactWay">联系方式：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-contactWay" name="contactWay"
                                                       class="form-control " value="${giftApplication.contactWay}"/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-unitName">所属部门：<span
                                                    class="required">&nbsp;</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" class="form-control" name="unitName"
                                                       id="form-field-unitName"
                                                       value="${giftApplication.unitName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-applicationCause"
                                                   style="width: 11%">申请事由：
                                                <span class="required">*</span></label>

                                            <div class="col-sm-10 " style="width: 89%;">
                                            <textarea class="form-control limited" id="form-field-applicationCause"
                                                      name="applicationCause" maxlength="500" style="min-height: 100px;">${giftApplication.applicationCause}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <label class="col-sm-2 control-label" style="width: 11%">礼品清单：<span
                                                class="required">*</span></label>

                                        <div class="col-sm-10" style="width: 89%;padding-left: 0px;padding-right: 0px;">
                                            <table id="simple-table" class="table table-bordered table-hover">
                                                <thead>
                                                <tr>
                                                    <th class="center" style="width:20%;">编码</th>
                                                    <th class="center" style="width:50%;">名称</th>
                                                    <th class="center" style="width:15%;">数量</th>
                                                    <th class="center" style="width:15%;">操作</th>
                                                </tr>
                                                </thead>

                                                <tbody id="giftsApplicationTBody">
                                                <c:if test="${giftApplication.id ne null}">
                                                    <c:forEach items="${giftsApplicationList}" var="giftsApplication">
                                                        <tr class="giftsApplicationTr"
                                                            data-item={"id":"${giftsApplication.id}"}>
                                                            <td class="hidden"><input name="id" value="${giftsApplication.id}"/></td>
                                                            <td class="hidden"><input type="text" name="giftInfoId" title="礼品Id" value="${giftsApplication.giftInfoId}" readonly/></td>
                                                            <td class="center"><input type="text" name="giftCode" title="编码" value="${giftsApplication.giftCode}" readonly/></td>
                                                            <td class="center"><input type="text" name="giftName" title="名称" value="${giftsApplication.giftName}" readonly/></td>
                                                            <td class="center"><input type="number" name="giftCount" min="0" title="数量" value="${giftsApplication.giftCount}"/></td>
                                                            <td class="center"><i
                                                                    class="ace-icon red fa fa-trash-o row-record-delete"
                                                                    style="cursor: pointer;" title="删除">删除</i></td>
                                                        </tr>
                                                    </c:forEach>
                                                </c:if>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="btn-group pull-right" style="margin-right: 5px;">
                                            <button class="btn btn-sm btn-primary" type="button"
                                                    id="addGiftsApplicationBtn">增行
                                            </button>
                                        </div>
                                    </div>
                                </div>

                                <div class="clearfix form-actions center">
                                    <div class="col-xs-12">
                                        <button class="btn btn-info btn-sm" type="button" id="saveBtn">
                                            <i class="ace-icon fa fa-check bigger-110"></i>
                                            保存
                                        </button>
                                        &nbsp;&nbsp;&nbsp;
                                        <button class="btn btn-primary btn-sm" type="button" id="backBtn">
                                            <i class="ace-icon fa fa-undo bigger-110"></i>
                                            返回
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div id="giftsApplicationDialog" class="hidden">
    <div class="row">
        <div class="col-xs-12 jqgrid_box">
            <div class="row">
                <div class="col-xs-12">
                    <table id="gift-choose-grid-table"></table>
                </div>
            </div>

            <div class="row">
                <div class="space-10"></div>
            </div>

            <div class="row">
                <div class="col-xs-12">
                    <form id="giftsApplicationForm" class="form-horizontal" role="form">
                        <div class="row">
                            <div class="hidden">
                                <input type="text" id="id" name="id"/>
                                <input type="text" id="giftInfoId" name="giftInfoId"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="space-10"></div>
                        </div>

                        <div class="row">
                            <div class="col-xs-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label text-right">编码：<span class="required">*</span></label>
                                    <div class="col-sm-8 ">
                                        <input type="text" id="form-field-giftCode" name="giftCode" readonly
                                               class="form-control " placeholder="编码"/>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-xs-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label text-right">名称：<span
                                            class="required">*</span></label>

                                    <div class="col-sm-8 ">
                                        <input type="text" id="form-field-giftName" name="giftName" readonly
                                               class="form-control "
                                               placeholder="名称"/>
                                    </div>
                                </div>
                            </div>

                            <div class="col-xs-6">
                                <div class="form-group">
                                    <label class="col-sm-4 control-label text-right">数量：<span
                                            class="required">*</span></label>
                                    <div class="col-sm-8 ">
                                        <input type="number" min="0" id="form-field-giftCount" name="giftCount"
                                               class="form-control "
                                               placeholder="数量"/>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({
            todayHighlight: true
        });
        //请求url
        var loadGiftChooseListUrl = '${basePath}/giftStore/load-giftStoreInfo-list.do';

        var $giftChooseGridTable = $("#gift-choose-grid-table");

        var $giftsApplicationTBody = $('#giftsApplicationTBody');
        var $addGiftsApplicationBtn = $('#addGiftsApplicationBtn');
        var $giftsApplicationDialog = $('#giftsApplicationDialog');
        var $giftsApplicationForm = $('#giftsApplicationForm');

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'giftCode', header: '礼品编码', index: 'giftCode', hidden: false, sortable: true},
            {name: 'giftName', header: '礼品名称', index: 'giftName', width: 100, sortable: true},
            {name: 'giftType', header: '礼品类型', index: 'giftType', sortable: true},
            {name: 'giftState', header: '库存状态', index: 'giftState', sortable: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 100,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:if test="${true}">
            operations.push(' <button title="选择" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-check blue"></i> 选择');
            operations.push('</button>');
            </c:if>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function chooseGift(id) {
            var $giftsApplicationForm = $("#giftsApplicationForm");

            var rowData = $giftChooseGridTable.jqGrid('getRowData', id);

            var giftInfoId = rowData.id;
            var giftCode = rowData.giftCode;
            var giftName = rowData.giftName;
            var giftCount = 1;

            $giftsApplicationForm.find('#giftInfoId').val(giftInfoId);
            $giftsApplicationForm.find('#form-field-giftCode').val(giftCode);
            $giftsApplicationForm.find('#form-field-giftName').val(giftName);
            $giftsApplicationForm.find('#form-field-giftCount').val(giftCount);
        }


        function initGiftChooseGridTable($gridTable) {
            $gridTable.tjGrid({
                loadUrl: loadGiftChooseListUrl,
                height: '100%',
                autowidth: true,
                colModel: colModel,
                // sortname: 'updateTime',
                // sortorder: 'desc',
                // caption: "礼品查询列表",
                onSelectRow: function (id, stat, e) {

                    if (e === undefined) {
                        return false;
                    }
                    var className = $(e.target).attr('class');
                    if (!className) {
                        return false;
                    }

                    if (className.indexOf('row-record-edit') !== -1) {
                        chooseGift(id);
                    }
                }
            });
        }
        $giftChooseGridTable.tjGrid('triggerResizeGrid');


        $addGiftsApplicationBtn.click(function (e) {
            e.preventDefault();

            initChooseDialog($giftsApplicationDialog);

        });

        function initChooseDialog($container) {
            var $form = $container.find("#giftsApplicationForm");

            initGiftChooseGridTable($giftChooseGridTable);

            $container.removeClass('hidden').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 650,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-book green'></i>礼品清单新增</div>",
                title_html: true,
                position: { my: "top-100%", at: "center", of: window },
                close: function () {
                    $container.addClass('hidden').dialog('destroy');
                    if ($.fn.jqGrid["GridUnload"] === undefined) {
                        $.fn.jqGrid["GridUnload"] = $.jgrid.gridUnload;
                    }
                    $giftChooseGridTable.jqGrid('GridUnload');
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
                            if ($form.validate().form()) {
                                appendGift($form, $giftsApplicationTBody);

                                $this.dialog('close');
                            }
                        }
                    }
                ]
            });

            $container.dialog('open');
            $giftChooseGridTable.setGridWidth($giftsApplicationDialog.find('.jqgrid_box').width());
            $giftChooseGridTable.tjGrid('triggerResizeGrid');

            $form.tjValidate({
                focusInvalid: true,
                rules: {
                    giftName: {required: true},
                    giftCount: {required: true, maxlength: 10}
                },
                messages: {
                    giftName: {required: "礼品名称必须填写"},
                    giftCount: {required: "礼品数量必须填写"}
                }
            });
        }

        // 在礼品清单中添加选择的礼品
        function appendGift($form, $dest) {
            var html = [];

            html.push('<tr class="giftsApplicationTr" data-item ="{{json}}">');
            html.push('<td class="hidden"><input name="id"/></td>');
            html.push('<td class="hidden"><input type="text" name="giftInfoId" title="礼品id" value="{{giftInfoId}}" readonly/></td>');
            html.push('<td class="center"><input type="text" name="giftCode" title="编码" value="{{giftCode}}" readonly/></td>');
            html.push('<td class="center"><input type="text" name="giftName" title="名称" value="{{giftName}}" readonly/></td>');
            html.push('<td class="center"><input type="number" name="giftCount" min="0" value="{{giftCount}}"/></td>');
            html.push('<td class="center"><i class="ace-icon red fa fa-trash-o row-record-delete" style="cursor: pointer;" title="删除">删除</i></td>');
            html.push('</tr>');

            var data = $form.serializeObject();
            data.json = JSON.stringify(data);
            var temp = Handlebars.compile(html.join(''));
            var view = temp(data);
            $dest.append(view);
        }

        // 删除一行礼品
        $("#simple-table").on('click', '.row-record-delete', function (e) {
            e.preventDefault();

            deleteGiftsApplicationData(e);
        });

        function deleteGiftsApplicationData(e) {
            var id = $(e.target).closest('tr').data('item').id;
            var deleteUrl = '';

            if (!_.isEmpty(id)) {

                deleteUrl = '${basePath}/giftApplication/gifts-application-delete.do';
                deleteByUrl(e, deleteUrl, id);
            } else {
                $(e.target).closest('tr').remove();
            }
        }

        var $giftApplicationForm = $('#giftApplicationForm');
        var $giftApplicationId = $('#giftApplicationId');
        var $applicationCode = $('#form-field-applicationCode');
        var $activityName = $('#form-field-activityName');
        var $activityType = $('#form-field-activityType');
        var $applicationPerson = $('#form-field-applicationPerson');
        var $applicationTime = $('#form-field-applicationTime');
        var $applicationCause = $('#form-field-applicationCause');
        var $contactWay = $('#form-field-contactWay');
        var $unitName = $('#form-field-unitName');
        var $applicationState = $('#form-field-applicationState');
        var $abroadInfoId = $('#abroadInfoId');
        var $comeInfoId = $('#comeInfoId');


        function getAllGiftApplicationData() {
            var giftApplicationData = {};
            var dicParam = {};

            giftApplicationData.id = $giftApplicationId.val();
            giftApplicationData.abroadInfoId = $abroadInfoId.val();
            giftApplicationData.comeInfoId = $comeInfoId.val();
            giftApplicationData.applicationCode = $applicationCode.val();
            giftApplicationData.activityName = $activityName.val();
            giftApplicationData.activityType = $activityType.val();
            giftApplicationData.applicationPerson = $applicationPerson.val();

            giftApplicationData.applicationTime = $applicationTime.val();
            giftApplicationData.applicationCause = $applicationCause.val();
            giftApplicationData.contactWay = $contactWay.val();
            giftApplicationData.unitName = $unitName.val();
            dicParam.id = $applicationState.val()
            giftApplicationData.dicParam = dicParam;

            giftApplicationData.giftsApplicationList = getGiftList($giftsApplicationTBody);
            return giftApplicationData;
        }

        function getGiftList($tbody) {
            var giftList = [];

            var $tr = $tbody.find("tr[class='giftsApplicationTr']");
            $.each( $tr, function(_, row) {
                var data = {};
                $.each($(row).find(':input'), function () {
                    data[this.name] = $(this).val();
                });

                giftList.push(data);
            });

            return giftList;
        }

        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        var saveUrl = '${basePath}/giftApplication/load-application-save.do';

        $saveBtn.unbind('click').bind('click', function (e) {
            if ($giftApplicationForm.validate().form()) {
                var data = getAllGiftApplicationData();
                G.confirm({
                    message: '确认保存此条礼品申请单信息吗？',
                    callback: function (result) {
                        if (result) {
                            var loadId = G.showAjaxLoading();
                            $saveBtn.prop("disabled", true);
                            $backBtn.prop("disabled", true);
                            $.ajax({
                                url: saveUrl,
                                type: 'POST',
                                dataType: 'json',
                                data: JSON.stringify(data),
                                contentType: "application/json;charset=utf-8",
                                async: true
                            }).done(function (map) {
                                if (map.result == true) {
                                    G.doneAjaxLoading(loadId);
                                    G.showGritterSuccess("保存成功!");
                                    G.pjaxLoadPageContentDiv('#page/giftApplication/gift-application-manage');
                                } else if (map.result == 'empty') {
                                    G.doneAjaxLoading(loadId);
                                    G.showGritterFail("请添加礼品!");
                                    $saveBtn.prop("disabled", false);
                                    $backBtn.prop("disabled", false);
                                } else {
                                    G.doneAjaxLoading(loadId);
                                    G.showGritterFail("保存失败!");
                                    $saveBtn.prop("disabled", false);
                                    $backBtn.prop("disabled", false);
                                }
                            });
                        }
                    }
                });
            }
        });

        $giftApplicationForm.tjValidate({
            focusInvalid: true,
            rules: {
                applicationCode: {required: true, maxlength: 32},
                activityName: {required: true, maxlength: 100},
                activityType: {required: true, maxlength: 32},
                applicationPerson: {required: true, maxlength: 32},
                applicationTime: {required: true},
                applicationCause: {required: true},
                contactWay: {required: true, maxlength: 32},
                applicationState: {required: true}
            },
            messages: {
                applicationCode: {required: "申请单编码必须填写"},
                activityName: {required: "活动名称必须填写"},
                activityType: {required: "活动类型必须选择"},
                applicationPerson: {required: "申请人必须填写"},
                applicationTime: {required: "申请时间必须选择"},
                applicationCause: {required: "申请事由必须填写"},
                applicationState: {required: "申请状态必须选择"},
                contactWay: {required: "联系方式必须填写"}
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var listUrl = '#page/giftApplication/gift-application-manage';

            var postData = $giftApplicationForm.serializeObject();

            var flag = 0;
            $.each(postData, function (index, item) {

                if (item !== "") {
                    flag = 1;
                }
            });

            if (flag === 0) {
                G.pjaxLoadPageContentDiv(listUrl)
            } else {
                G.confirm({
                    message: "您有礼品申请单信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(listUrl);
                        }
                    }
                });
            }

        });

        //删除方法
        function deleteByUrl(e, url, id) {

            G.confirm({
                message: '确认删除此条礼品吗？',
                callback: function (result) {
                    if (result) {
                        $.post(
                            url,
                            {id: id},
                            function (data) {
                                if (data.result) {
                                    G.showGritterSuccess("删除成功！");
                                    $(e.target).closest('tr').remove();
                                } else {
                                    G.showGritterFail("删除失败！")
                                }
                            });
                    }
                }
            });
        }

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>