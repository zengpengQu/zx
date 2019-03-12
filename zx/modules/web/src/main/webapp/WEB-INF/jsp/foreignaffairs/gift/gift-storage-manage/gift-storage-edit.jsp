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
                            <form class="form-horizontal" id="giftInfoForm" role="form" method="post">
                                <input id="giftInfoId" name="id" type="hidden" value="${giftInfo.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${giftInfo.id eq null}"> 礼品库存信息新增</c:when>
                                                    <c:otherwise> 礼品库存信息编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-giftName">礼品名称：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-giftName" name="giftName"
                                                       class="form-control " value="${giftInfo.giftName}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-giftCode">礼品编码：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-giftCode" name="giftCode"
                                                       class="form-control " value="${giftInfo.giftCode}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-giftType" >礼品类型：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-giftType" name="giftType">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${dicGiftTypeList}" var="dicGiftType">
                                                        <option value="${dicGiftType.id}"
                                                                <c:if test="${giftInfo.dicGiftType.id eq dicGiftType.id}">selected</c:if> >
                                                                ${dicGiftType.typeName}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-giftState" >库存状态：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-giftState" name="giftState">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${dicParamList}" var="dicParam">
                                                        <option value="${dicParam.id}"
                                                                <c:if test="${giftInfo.dicParam.id eq dicParam.id}">selected</c:if> >
                                                                ${dicParam.name}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-giftCount" >数量：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-giftCount" name="giftCount"
                                                       class="form-control " value="${giftInfo.giftCount}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-giftPrice" >单价：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input class="form-control" name="giftPrice" id="form-field-giftPrice"
                                                       value="${giftInfo.giftPrice}" type="text"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-giftFrame">所属货架：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8">
                                                <select class="form-control" id="form-field-giftFrame" name="giftFrame">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${giftShelvesList}" var="giftShelves">
                                                        <option value="${giftShelves.id}"
                                                                <c:if test="${giftInfo.giftShelves.id eq giftShelves.id}">selected</c:if> >
                                                                ${giftShelves.frameCode}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-createName">录入人：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input class="form-control" name="createName" id="form-field-createName"
                                                       value="${giftInfo.createName}" type="text"/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-createTime" >录入时间：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="createTime" id="form-field-createTime"
                                                           value="${giftInfo.jsonObject.createTime}" type="text"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-giftInstruction">说明：<span
                                                    class="required">&nbsp;</span></label>

                                            <div class="col-sm-10 ">
                                            <textarea class="form-control limited" id="form-field-giftInstruction"
                                                      name="giftInstruction" maxlength="200" style="min-height: 100px;">${giftInfo.giftInstruction}</textarea>
                                            </div>
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
<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({
            todayHighlight : true
        });

        var $uploadFile = $(".form-field-upload-file");
        var realName;
        var fileId;
        var formData = new FormData();

        var uploadUrl = '${basePath}/come/upload-file.do';

        $uploadFile.ace_file_input({
            no_file: ' ...',
            btn_choose: '选择文件',
            btn_change: '重新选择',
            droppable: false,
            onchange: null,
            thumbnail: false //| true | large
        });

        // 读取文件
        $uploadFile.bind('change', function () {
            $uploadFile.each(function () {
                var fieldName = $(this).attr('name');
                var files = $(this).data('ace_input_files');
                if (files && files.length > 0) {
                    for (var i = 0; i < files.length; i++) {
                        formData.append(fieldName, files[i]);
                    }
                }
            });
        });

        // 上传文件
        $uploadFile.bind('change', function () {
            $saveBtn.prop("disabled", true);
            $backBtn.prop("disabled", true);
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: uploadUrl,
                type: 'POST',
                processData: false, //important
                contentType: false, //important
                dataType: 'json',
                data: formData //our FormData object
            }).done(function (map) {
                G.doneAjaxLoading(loadId);
                if (map.result) {
                    fileId = map.fileId;
                    realName = map.realName;
                    formData.delete('uploadFile');
                    G.showGritterSuccess("文件上传成功！");
                    $saveBtn.prop("disabled", false);
                    $backBtn.prop("disabled", false);
                } else {
                    G.showGritterFail("文件上传失败！请稍后再试。");
                    $saveBtn.prop("disabled", false);
                    $backBtn.prop("disabled", false);
                }
            });
        });


        //删除附件，清空数据
        $('.remove').click(function () {
            fileId = '';
            realName = '';
        });

        var $chronicleTBody = $('#chronicleTBody');
        var $addChronicleBtn = $('#addChronicleBtn');
        var $chronicleDialog = $('#chronicle-dialog');
        var $chronicleForm = $('#chronicleForm');
        var $beginTime = $('#beginTime');
        var $endTime = $('#endTime');

        $addChronicleBtn.click(function () {
            $chronicleDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 520,
                width: 450,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-book green'></i>大事记</div>",
                title_html: true,
                close: function () {
                    $chronicleForm.resetForm();
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
                            if($chronicleForm.validate().form()) {
                                var beginTime = moment($beginTime.val(),'YYYY-MM-DD').toDate();
                                var endTime = moment($endTime.val(),'YYYY-MM-DD').toDate();
                                if (beginTime >= endTime) {
                                    G.alert({message : '结束时间应大于开始时间！'});
                                } else {
                                    var data = $chronicleForm.serializeObject();
                                    data.json = JSON.stringify(data);
                                    var html =  '<tr class="chronicleTr" data-item ="{{json}}">' +
                                        '<td style="text-align:center">{{content}}</td>' +
                                        '<td style="text-align:center">{{beginTime}}</td>' +
                                        '<td style="text-align:center">{{endTime}}</td>' +
                                        '<td style="text-align:center">{{notes}}</td>' +
                                        '<td style="text-align:center"><i class="ace-icon red fa fa-trash-o row-record-delete" style="cursor: pointer;" title="删除"></i></td>' +
                                        '</tr>';
                                    var temp = Handlebars.compile(html);
                                    var view = temp(data);
                                    $chronicleTBody.append(view);
                                    $this.dialog('close');
                                }
                            }
                        }
                    }
                ]
            });
            $chronicleDialog.dialog('open');
        });

        $chronicleForm.tjValidate({
            focusInvalid: true,
            rules: {
                content: {required: true},
                beginTime: {required: true},
                endTime: {required: true}
            },
            messages: {
                contact: {required: "内容必须填写"},
                beginTime: {required: "开始时间必须填写"},
                endTime: {required: "结束时间必须填写"}
            }
        });

        var $giftInfoForm = $('#giftInfoForm');
        var $giftInfoId = $('#giftInfoId');
        var $giftName = $('#form-field-giftName');
        var $giftCode = $('#form-field-giftCode');
        var $giftState = $('#form-field-giftState');
        var $giftType = $('#form-field-giftType');
        var $createName =$('#form-field-createName');
        var $giftPrice =$('#form-field-giftPrice');
        var $createTime =$('#form-field-createTime');
        var $giftCount =$('#form-field-giftCount');
        var $giftFrame =$('#form-field-giftFrame');
        var $giftInstruction =$('#form-field-giftInstruction');

        function getAllgiftInfoData() {
            var giftInfoData = {};
            var dicParam = {};
            var dicGiftType = {};
            var giftShelves = {}
            giftInfoData.id = $giftInfoId.val();
            giftInfoData.giftCode = $giftCode.val();
            giftInfoData.giftName = $giftName.val();

            dicGiftType.id = $giftType.val();
            giftInfoData.dicGiftType = dicGiftType;
            dicParam.id = $giftState.val();
            giftInfoData.dicParam = dicParam;

            giftShelves.id = $giftFrame.val();
            giftInfoData.giftShelves = giftShelves;



            giftInfoData.giftCode = $giftCode.val();
            giftInfoData.giftName = $giftName.val();
            giftInfoData.giftType = $giftType.val();
            giftInfoData.createName = $createName.val();
            giftInfoData.giftPrice = $giftPrice.val();
            giftInfoData.createTime = $createTime.val();
            giftInfoData.giftCount = $giftCount.val();
            giftInfoData.giftFrame = $giftFrame.val();
            giftInfoData.giftInstruction = $giftInstruction.val();


            return giftInfoData;
        }

        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        var saveUrl = '${basePath}/giftStore/load-giftStoreInfo-save.do';

        $saveBtn.unbind('click').bind('click', function (e) {
            if ($giftInfoForm.validate().form()) {
                var data = getAllgiftInfoData();
                G.confirm({
                    message: '确认保存此条礼品库存信息吗？',
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
                                G.doneAjaxLoading(loadId);
                                if (map.result == true) {
                                    G.showGritterSuccess("保存成功!");
                                    G.pjaxLoadPageContentDiv('#page/giftStore/gift-storage-manage');
                                } else if (map.result == 'empty') {
                                    G.showGritterFail("请添加礼品库存信息!");
                                    $saveBtn.prop("disabled", false);
                                    $backBtn.prop("disabled", false);
                                } else {
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

        $giftInfoForm.tjValidate({
            focusInvalid: true,
            rules: {
                giftCode: {
                    required: true,
                    maxlength: 32,

                    remote: {
                        url: "${basePath}/giftStore/check-giftCode.do",
                        type: "post",
                        dataType: "json",
                        async: false,
                        data: {
                            id: function () {
                                return $giftInfoId.val();
                            },
                            giftCode: function() {
                                return $giftCode.val();
                            }
                        }
                    }
                },
                giftName: {required: true, maxlength: 32},
                giftState: {required: true},
                giftCount: {required: true, isFloat: true, isFloatGtZero: true, max: 999999999},
                giftPrice: {required: true, isFloat: true, isFloatGtZero: true, max: 99999999},
                giftFrame: {required: true},
                createName: {required: true, maxlength: 32},
                createTime: {required: true},
                giftType: {required: true},
            },
            messages: {
                giftCode: {required: "礼品编码必须填写", remote: "礼品编码重复"},
                giftName: {required: "礼品名称必须填写"},
                giftState: {required: "库存状态必须选择"},
                giftCount: {required: "礼品数量必须填写",
                    isFloat: "请输入正确的数量（纯数字）",
                    isFloatGtZero: "请输入正确的数量（非负数）",
                    max: "数量过大（最大为999999999）"
                },
                giftPrice: {
                    required: "礼品价格必须填写",
                    isFloat: "请输入正确的价格（纯数字）",
                    isFloatGtZero: "请输入正确的价格（非负数)",
                    max: "价格过高（最大为99999999）"
                },
                giftFrame: {required: "所属货架必须选择"},
                createName: {required: "录入人必须填写"},
                createTime: {required: "录入时间必须选择"},
                giftType: {required: "礼品类型必须选择"},
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var listUrl = '#page/giftStore/gift-storage-manage';

            var postData = $giftInfoForm.serializeObject();

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
                    message: "您有礼品库存信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(listUrl);
                        }
                    }
                });
            }

        });

        var $downLoadFile = $("#download-file");

        //获取已上传的附件
        appendAttach($downLoadFile, ${jsonFileObject});

        //获取已上传的附件
        function appendAttach($div, jsonFileObject) {
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
                html.push('<a style="color:grey" href="${basePath}/file/download.action?id=' + jsonFileObject.id + '&type=0">');
                html.push('<i class="ace-icon fa fa-download grey bigger-130"></i>下载</a>&nbsp;');
                html.push('</li>');
                html.push('</ul>');
            }
            $div.append(html.join(""));
        }

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>