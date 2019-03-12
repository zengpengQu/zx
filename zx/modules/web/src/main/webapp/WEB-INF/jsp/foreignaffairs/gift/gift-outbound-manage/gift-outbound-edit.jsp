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
                            <form class="form-horizontal" id="giftOutboundForm" role="form" method="post">
                                <input id="giftOutOrInId" name="id" type="hidden" value="${giftOutOrIn.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${giftOutOrIn.id eq null}"> 礼品出库单信息新增</c:when>
                                                    <c:otherwise> 礼品出库单信息编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-activityType">活动类型：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-activityType" name="activityType"
                                                       class="form-control " value="${giftOutOrIn.activityType}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-activityName" >活动名称：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-activityName"
                                                        name="activityName">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${activityList}" var="activity">
                                                        <option value="${activity}"
                                                                <c:if test="${giftOutOrIn.activityName eq activity}">selected</c:if> >${activity}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-applicationPerson"
                                            >申请人：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input class="form-control" name="applicationPerson"
                                                       id="form-field-applicationPerson"
                                                       value="${giftOutOrIn.applicationPerson}" type="text"/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-applicationTime"
                                            >申请时间：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input type="text" id="form-field-applicationTime"
                                                           name="applicationTime"
                                                           class="form-control "
                                                           value="${giftOutOrIn.jsonObject.applicationTime}"/>
                                                    <span class="input-group-addon">
                                                        <i class="fa fa-calendar bigger-110"></i></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-transactor"
                                            >经办人：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input class="form-control" name="transactor" id="form-field-transactor"
                                                       value="${giftOutOrIn.transactor}" type="text"/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-outboundTime"
                                            >出库时间：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="outboundTime"
                                                           id="form-field-outboundTime"
                                                           value="${giftOutOrIn.jsonObject.outboundTime}" type="text"/>
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
                                            <label class="col-sm-4 control-label" for="form-field-isOutbound"
                                            >出库状态：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-isOutbound" name="isOutbound">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${dicParamList}" var="dicParam">
                                                        <option value="${dicParam.id}"
                                                                <c:if test="${giftOutOrIn.dicParam.id eq dicParam.id}">selected</c:if> >${dicParam.name}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-outboundCode"
                                            >出库编码：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-outboundCode" name="outboundCode"
                                                       class="form-control " value="${giftOutOrIn.outboundCode}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12">
                            <div class="btn-group pull-right contacts-exportBtn">
                                <button class="btn btn-info btn-sm" type="button" id="addGiftOutOrinRecordsBtn"
                                        style="top: 6px;right: 5px;">
                                    <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>新增
                                </button>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-12" style="margin-left: 15px;">
                            <div class="header-table-th">礼品出库明细</div>
                            <div class="table-content col-md-12">
                                <div class="col-md-12 jqgrid_box" style="padding: 0px;background: #fff;">
                                    <table id="grid-table-outbound" class="table_list"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="space-10"></div>
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
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 出库明细编辑对话框 -->
<div id="edit-dialog-gift-outorin-record-dialog"></div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({
            todayHighlight: true
        });

        G.updateBreadcrumb([
            '外事信息管理',
            '外事活动',
            '礼品出库单管理']);

        //表单类全局变量
        var $editGiftOutOrInRecordDialog = $("#edit-dialog-gift-outorin-record-dialog");
        var $addGiftOutOrinRecordsBtn = $("#addGiftOutOrinRecordsBtn");

        //出库礼品明细
        var $gridTable = $("#grid-table-outbound");
        var giftOutOrInId = $("#giftOutOrInId").val();

        var listUrl = '#page/giftOutbound/gift-outbound-manage?SubSecPopeDomViewId=94';

        var loadUrl = '${basePath}/giftOutOrInRecords/load-giftOutOrInRecords-list.do?giftOutOrInId=' + giftOutOrInId;
        var editUrl = '${basePath}/giftOutOrInRecords/load-giftOutOrInRecords-edit.do';
        var deleteUrl = '${basePath}/giftOutOrInRecords/load-giftOutOrInRecords-delete.do';
        var saveGiftOutOrInRecordsUrl = '${basePath}/giftOutOrInRecords/load-giftOutOrInRecords-save.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'giftCode', header: '礼品编码', index: 'giftCode', sortable: true, width: 300},
            {name: 'giftName', header: '礼品名称', index: 'giftName', sortable: true, width: 400},
            {name: 'giftType', header: '礼品类型', index: 'giftType', sortable: true},
            // {name: 'giftState', header: '库存状态', index: 'giftState', sortable: true},
            {name: 'giftCount', header: '数量', index: 'giftCount', sortable: true},
            {name: 'giftPrice', header: '单价', index: 'giftPrice', sortable: true},
            {name: 'giftFrame', header: '所属货架', index: 'giftFrame', sortable: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 150,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:if test="${true}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${true}">
            operations.push(' <button title="删除" class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除');
            operations.push('</button>');
            </c:if>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'updateTime',
            sortorder: 'desc',
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }

                if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条礼品出库信息吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        G.showGritterSuccess("删除成功");
                                        $gridTable.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-edit') !== -1) {
                    editGiftOutOrInRecord(id);
                }
            }
        });
        $gridTable.tjGrid("triggerResizeGrid");


        //礼品出库基本信息

        var $giftOutboundForm = $('#giftOutboundForm');
        var $giftOutOrInId = $('#giftOutOrInId');
        var $activityType = $('#form-field-activityType');
        var $activityName = $('#form-field-activityName');
        var $transactor = $('#form-field-transactor');
        var $applicationPerson = $('#form-field-applicationPerson');
        var $outboundTime = $('#form-field-outboundTime');
        var $outboundCode = $('#form-field-outboundCode');
        var $applicationTime = $('#form-field-applicationTime');
        var $isOutbound = $('#form-field-isOutbound');

        function getAllgiftOutOrInData() {
            var giftOutOrInData = {};
            var dicParam = {};

            giftOutOrInData.id = $giftOutOrInId.val();
            dicParam.id = $isOutbound.val();
            giftOutOrInData.dicParam = dicParam;

            giftOutOrInData.activityName = $activityName.val();
            giftOutOrInData.activityType = $activityType.val();
            giftOutOrInData.applicationPerson = $applicationPerson.val();
            giftOutOrInData.applicationTime = $applicationTime.val();
            giftOutOrInData.transactor = $transactor.val();
            giftOutOrInData.outboundTime = $outboundTime.val();
            giftOutOrInData.outboundCode = $outboundCode.val();


            return giftOutOrInData;
        }

        var $saveBtn = $("#saveBtn");
        var $saveGiftOutboundBtn = $("#saveGiftOutboundBtn");
        var $backBtn = $("#backBtn");

        var saveUrl = '${basePath}/giftOutbound/load-outbound-save.do';

        $saveBtn.unbind('click').bind('click', function (e) {
            if ($giftOutboundForm.validate().form()) {
                var data = getAllgiftOutOrInData();
                G.confirm({
                    message: '确认保存此条礼品出库信息吗？',
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
                                if (map.result === true) {
                                    G.doneAjaxLoading(loadId);
                                    if (map.synchronousFlag) {
                                        G.showGritterSuccess("出库成功!");
                                        G.pjaxLoadPageContentDiv(listUrl)
                                    } else {
                                        G.showGritterSuccess("保存成功!");
                                        G.back();

                                        // var giftOutOrInId = map.giftOutOrInId;
                                        // var editHash = '#page/giftOutbound/load-outbound-edit' + '?id=' + giftOutOrInId;
                                        // G.pjaxLoadPageContentDiv(editHash);
                                    }
                                    $saveBtn.prop("disabled", true);
                                    $backBtn.prop("disabled", true);
                                } else if (map.result === 'empty') {
                                    G.doneAjaxLoading(loadId);
                                    $("#giftOutOrInId").val(map.giftOutOrInId);
                                    $isOutbound.val('21')
                                    G.showGritterFail("礼品出库明细为空，不可出库!");
                                    $saveBtn.prop("disabled", false);
                                    $backBtn.prop("disabled", false);
                                } else {
                                    if (!map.synchronousFlag) {

                                        var msg = map.msg.replace('\n', '<br/>');

                                        G.showMessage(msg);
                                        G.doneAjaxLoading(loadId);
                                        $saveBtn.prop("disabled", false);
                                        $backBtn.prop("disabled", false);
                                        $saveGiftOutboundBtn.prop("disabled", false);
                                    }
                                }
                            });
                        }
                    }
                });
            }
        });

        $giftOutboundForm.tjValidate({
            focusInvalid: true,
            rules: {
                activityName: {required: true, maxlength: 32},
                activityType: {required: true, maxlength: 32},
                applicationTime: {required: true},
                applicationPerson: {required: true, maxlength: 32},
                transactor: {required: true, maxlength: 32},
                outboundTime: {required: true},
                isOutbound: {required: true},
                outboundCode: {required: true, maxlength: 32}
            },
            messages: {
                activityName: {required: "活动名称必须填写"},
                activityType: {required: "活动类型必须填写"},
                applicationTime: {required: "申请时间必须选择"},
                applicationPerson: {required: "申请人必须填写"},
                transactor: {required: "经办人必须填写"},
                outboundTime: {required: "出库时间必须选择"},
                isOutbound: {required: "出库状态必须选择"},
                outboundCode: {required: "出库编码必须填写"}
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();

            var postData = $giftOutboundForm.serializeObject();

            var flag = 0;
            $.each(postData, function (index, item) {

                if (item !== "") {
                    flag = 1;
                }
            });

            if (flag === 0) {
                G.pjaxLoadPageContentDiv(listUrl);
            } else {
                G.confirm({
                    message: "您有礼品出库信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(listUrl);
                        }
                    }
                });
            }

        });


        $addGiftOutOrinRecordsBtn.click(function (e) {
            e.preventDefault();

            var giftOutOrInId = '${giftOutOrIn.getId()}';

            if (giftOutOrInId === '') {
                $addGiftOutOrinRecordsBtn.prop('disabled', true);
                G.alert({message :'请先填写并保存出库单基本信息'});
            } else {
                $addGiftOutOrinRecordsBtn.prop('disabled', false);
                editGiftOutOrInRecord();
            }
        });

        function editGiftOutOrInRecord(id) {
            $.ajax({
                url: editUrl,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $editGiftOutOrInRecordDialog.html(String);
                    initEditDialogGiftOutOrInRecordDialog($editGiftOutOrInRecordDialog);
                },
                error: function () {
                    G.alert({message: "操作失败！"});
                }
            })
        }

        function initEditDialogGiftOutOrInRecordDialog($container) {
            var $form = $("#saveGiftOutOrInRecordsForm");
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 新增/编辑</h4></div>",
                title_html: true,
                position: { my: "top-120%", at: "center", of: window },
                close: function () {
                    $form.resetForm();
                },

                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning commitBtn",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check  bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            var postData = getRecord($form);
                            postGift0utOrInRecord(postData, $form);
                        }
                    }
                ]
            });

            $form.tjValidate({
                focusInvalid: false,
                rules: {
                    giftName: {
                        required: true,
                        maxlength: 32
                    },
                    giftCode: {
                        required: true,
                        maxlength: 32
                    },
                    giftType: {
                        required: true
                    },
                    giftPrice: {
                        required: true,
                        maxlength: 32
                    },
                    giftCount: {
                        required: true,
                        maxlength: 32
                    },
                    giftFrame: {
                        required: true
                    }
                },
                messages: {
                    giftName: {
                        required: "礼品名称不能为空"
                    },
                    giftCode: {
                        required: "礼品编码不能为空"
                    },
                    giftType: {
                        required: "礼品类型不能为空"
                    },
                    giftPrice: {
                        required: "礼品价格不能为空"
                    },
                    giftCount: {
                        required: "礼品数量不能为空"
                    },
                    giftFrame: {
                        required: "礼品货架不能为空"
                    }
                }
            });
        }

        function getRecord($form) {
            var giftInfoId = $('#giftOutOrInRecordId').val();
            var giftName = $('#form-field-giftName').val();
            var giftCode = $('#form-field-giftCode').val();
            var giftType = $('#form-field-giftType').val();
            var giftPrice = $('#form-field-giftPrice').val();
            var giftCount = $('#form-field-giftCount').val();
            var giftFrame = $('#form-field-giftFrame').val();

            var records = {
                'id': giftInfoId,
                'giftName': giftName,
                'giftCode': giftCode,
                'giftType': giftType,
                'giftPrice': giftPrice,
                'giftCount': giftCount,
                'giftFrame': giftFrame,
                'giftOutOrInId': giftOutOrInId
            };
            return records;
        }

        function postGift0utOrInRecord(postData, $form) {
            if ($form.validate().form()) {
                G.confirm({
                    message: '确定保存操作？',
                    callback: function (result) {
                        if (result) {
                            var loadId = G.showAjaxLoading();
                            G.doneAjaxLoading(loadId);
                            postRecord(postData);
                        }
                    }
                });
            }
        }

        function postRecord(postData) {
            $.ajax({
                url: saveGiftOutOrInRecordsUrl,
                type: 'post',
                dataType: 'json',
                data: JSON.stringify(postData),
                contentType: "application/json;charset=utf-8",
                async: true
            }).done(function (map) {
                if (map.result) {
                    G.showGritterSuccess("添加礼品成功！");
                    $editGiftOutOrInRecordDialog.dialog('close');
                } else {
                    G.showGritterFail("保存失败,请稍后重试！");
                }
                //更新表格数据
                // reloadGrid();
                $gridTable.tjGrid('reloadGrid');

            });
        }

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy('#grid-table-outbound');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>