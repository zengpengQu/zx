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
                            <form class="form-horizontal" id="businessPassportForm" role="form" autocomplete="off" method="post">
                                <input id="userId" name="userId" type="hidden" value="${dicUser.id}">
                                <input id="businessPassportId" name="businessPassportId" type="hidden" value="${businessPassport.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">因公护照信息编辑
                                            </h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label">姓名：<span
                                                    class="required">*</span></label>
                                            <div class="col-sm-8 ">
                                                <input type="text" value="${dicUser.empName}" class="form-control" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-storeAddress">存放地址：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-storeAddress" name="storeAddress"
                                                       value="${businessPassport.storeAddress}" class="form-control " placeholder="存放地址"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-passportNo">护照号：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-passportNo" name="passportNo"
                                                       value="${businessPassport.passportNo}" class="form-control" placeholder="护照号"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-issuePlace">签发地：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-issuePlace" name="issuePlace"
                                                       value="${businessPassport.issuePlace}" class="form-control" placeholder="签发地"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-issueDate">发照日期：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="issueDate" id="form-field-issueDate"
                                                           value="${businessPassport.jsonObject.issueDate}" type="text" placeholder="发照日期"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-validDate">护照有效期：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="validDate" id="form-field-validDate"
                                                           value="${businessPassport.jsonObject.validDate}" type="text" placeholder="护照有效期"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-keepUnit">保管单位：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-keepUnit" name="keepUnit"
                                                       value="${businessPassport.keepUnit}" class="form-control" placeholder="保管单位"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-file" >上传扫描件：<span
                                                    class="required">&nbsp;</span></label>
                                            <div class="col-sm-8">
                                                <form id="upload-reception-form" name="uploadReceptionForm"
                                                      method="POST">
                                                    <input type="file" name="uploadFile"
                                                           class="form-field-upload-file"
                                                           id="form-field-file"/>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" align="center">
                                    <div class="col-xs-12">
                                        <label class="col-sm-2 control-label text-right"
                                               style="font-weight: bold; color: deepskyblue;text-align: right;padding-right: 30px;">扫描件预览：</label>
                                        <div class="col-sm-8">
                                            <img src="" id="showImg" height="400px" width="350px">
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <div class="clearfix form-actions center">
                                    <div class="col-xs-12">
                                        <button class="btn btn-info btn-sm" type="button" id="transactBtn">
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

        //初始化图片回显
        showImg(${jsonFileObject});

        function showImg(jsonFileObject) {
            if (null != jsonFileObject) {
                $('#showImg').prop("src", '${basePath}/file/download.action?id=' + jsonFileObject.id + '&type=0');
            }
        }

        G.datepicker({
            todayHighlight : true
        });

        var $uploadFile = $(".form-field-upload-file");
        var realName;
        var fileId;
        var formData = new FormData();

        var uploadUrl = '${basePath}/file/upload-file.do';

        $uploadFile.ace_file_input({
            no_file: ' ...',
            btn_choose: '选择文件',
            btn_change: '重新选择',
            droppable: false,
            onchange: null,
            thumbnail: false //| true | large
        });

        // 读取、上传文件
        $uploadFile.bind('change', function () {
            //$('#showImg').prop("src", '');
            var isImage = true;
            $uploadFile.each(function () {
                var fieldName = $(this).attr('name');
                var files = $(this).data('ace_input_files');
                if (files && files.length > 0) {
                    for (var i = 0; i < files.length; i++) {
                        var fileName = files[i].name;
                        if (fileName.indexOf('.JPEG') == -1 && fileName.indexOf('.png') == -1 &&
                            fileName.indexOf('.jpg') == -1 && fileName.indexOf('.gif') == -1 &&
                            fileName.indexOf('.bmp') == -1) {
                            isImage = false;
                            $transactBtn.prop("disabled", false);
                            $backBtn.prop("disabled", false);
                            G.alert({message:'文件上传失败！扫描件只能是：.JPEG .png .jpg .gif .bmp 格式！请重新上传！'});
                        } else {
                            formData.append(fieldName, files[i]);//只有图片附件才往formData追加file
                        }
                    }
                }
            });
            if (isImage) {
                $transactBtn.prop("disabled", true);
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
                        $transactBtn.prop("disabled", false);
                        $backBtn.prop("disabled", false);
                        $('#showImg').prop("src", '${basePath}/file/show-image.action?fileId=' + fileId + '&type=0');
                    } else {
                        G.showGritterFail("文件上传失败！请稍后再试。");
                        $transactBtn.prop("disabled", false);
                        $backBtn.prop("disabled", false);
                    }
                });
            } else {
                $('#showImg').prop("src", '');
            }
        });


        //删除附件，清空数据
        $('.remove').click(function () {
            fileId = '';
            realName = '';
        });

        var $businessPassportForm = $('#businessPassportForm');
        var $userId = $('#userId');
        var $businessPassportId = $('#businessPassportId');
        var $passportNo = $('#form-field-passportNo');
        var $issuePlace = $('#form-field-issuePlace');
        var $issueDate = $('#form-field-issueDate');
        var $validDate = $('#form-field-validDate');
        var $keepUnit = $('#form-field-keepUnit');
        var $storeAddress = $('#form-field-storeAddress');

        function getBusinessPassportData() {
            var businessPassportData = {};
            var dicUser = {};
            var businessPassportFile = {};
            businessPassportData.id = $businessPassportId.val();
            businessPassportData.passportNo = $passportNo.val();
            businessPassportData.issuePlace = $issuePlace.val();
            businessPassportData.issueDate = $issueDate.val();
            businessPassportData.validDate = $validDate.val();
            businessPassportData.keepUnit = $keepUnit.val();
            businessPassportData.storeAddress = $storeAddress.val();

            dicUser.id = $userId.val();
            businessPassportData.dicUser = dicUser;

            if (fileId) {
                businessPassportFile.fileId = fileId;
                businessPassportData.businessPassportFile = businessPassportFile;
            }

            return businessPassportData;
        }

        var $transactBtn = $("#transactBtn");
        var $backBtn = $("#backBtn");

        var transactUrl = '${basePath}/business-passport/business-passport-transact.do';

        $transactBtn.unbind('click').bind('click', function () {
            if ($businessPassportForm.validate().form()) {
                var issueDate = moment($issueDate.val(),'YYYY-MM-DD').toDate();
                var validDate = moment($validDate.val(),'YYYY-MM-DD').toDate();
                if (issueDate > validDate) {
                    G.alert({message: '护照有效期应大于等于发照日期！'});
                } else {
                    var data = getBusinessPassportData();
                    $transactBtn.prop("disabled", true);
                    $backBtn.prop("disabled", true);
                    G.confirm({
                        message: '确认保存该人员因公护照吗？',
                        callback: function (result) {
                            if (result) {
                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: transactUrl,
                                    type: 'POST',
                                    dataType: 'json',
                                    data: JSON.stringify(data),
                                    contentType: "application/json;charset=utf-8",
                                    async: true
                                }).done(function (map) {
                                    G.doneAjaxLoading(loadId);
                                    if (map.result == true) {
                                        G.showGritterSuccess("保存成功!");
                                        G.pjaxLoadPageContentDiv('#page/business-passport/business-passport-list');
                                    } else {
                                        G.showGritterFail("保存失败!");
                                        $transactBtn.prop("disabled", false);
                                        $backBtn.prop("disabled", false);
                                    }
                                });
                            } else {
                                $transactBtn.prop("disabled", false);
                                $backBtn.prop("disabled", false);
                            }
                        }
                    });
                }
            }
        });

        $businessPassportForm.tjValidate({
            focusInvalid: true,
            rules: {
                passportNo: {required: true},
                issuePlace: {required: true},
                issueDate: {required: true},
                validDate: {required: true},
                keepUnit: {required: true},
                storeAddress: {required: true}
            },
            messages: {
                passportNo: {required: "护照号必须填写"},
                issuePlace: {required: "签发地必须填写"},
                issueDate: {required: "发照日期必须填写"},
                validDate: {required: "护照有效期必须选择"},
                keepUnit: {required: "保管单位必须填写"},
                storeAddress: {required: "存放地址必须选择"}
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var listUrl = '#page/business-passport/business-passport-list';

            var postData = $businessPassportForm.serializeObject();

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
                    message: "您有因公护照未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.pjaxLoadPageContentDiv(listUrl);
                        }
                    }
                });
            }

        });

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>