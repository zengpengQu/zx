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
                            <form class="form-horizontal" id="privatePassportForm" role="form" autocomplete="off" method="post">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                护照信息新增</h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <!--工作部门 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-department" >工作部门：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 deptDiv">
                                                <input type="text" id="form-field-department" name="department"
                                                       class="hide" value=""/>
                                                <input type="text" class="form-control" id="form-field-deptName"
                                                       name="deptName" value=""  style="cursor: pointer;" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 姓名 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-peopleName">
                                                姓名：<span class="red">*</span>
                                            </label>
                                            <div class="col-sm-8 ">
                                                <input class="hidden" id="form-field-peopleId"
                                                       name="peopleId" value="${dicUser.id}" readonly/>
                                                <input class="form-control" id="form-field-peopleName"
                                                       name="peopleName" value="${dicUser.empName}" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-passportCode" >证件号码：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-passportCode" name="passportCode"
                                                       class="form-control "/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-signOrg" >签发机关：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-signOrg" name="signOrg"
                                                       class="form-control "/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-signDate" >签发日期：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="signDate" id="form-field-signDate"
                                                           type="text"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-validDate" >有效期至：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="validDate" id="form-field-validDate"
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
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-notes" >备注：<span
                                                    class="required"> </span></label>

                                            <div class="col-sm-10 ">
                                            <textarea class="form-control limited" id="form-field-notes"
                                                      name="notes" maxlength="200" style="min-height: 100px;"></textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label"
                                                   for="form-field-file"  >上传扫描件：<span
                                                    class="required">&nbsp;</span></label>
                                            <div class="col-sm-4 ">
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
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label text-right"
                                                   style="font-weight: bold; color: deepskyblue;">扫描件预览：</label>
                                            <div class="col-sm-8" style="padding-left: 5px;">
                                                <img src="" id="showImg" height="400px" width="350px">
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

        G.initDept('deptDiv',true,['${dicDept}'],TREE_NODE);

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
                            $saveBtn.prop("disabled", false);
                            $backBtn.prop("disabled", false);
                            G.alert({message:'文件上传失败！扫描件只能是：.JPEG .png .jpg .gif .bmp 格式！请重新上传！'});
                        } else {
                            formData.append(fieldName, files[i]);//只有图片附件才往formData追加file
                        }
                    }
                }
            });
            if (isImage) {
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
                        $('#showImg').prop("src", '${basePath}/file/show-image.action?fileId=' + fileId + '&type=0');
                    } else {
                        G.showGritterFail("文件上传失败！请稍后再试。");
                        $saveBtn.prop("disabled", false);
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

        var $privatePassportForm = $('#privatePassportForm');
        var $privatePassportId = $('#privatePassportId');
        var $peopleId = $('#form-field-peopleId');
        var $department = $('#form-field-department');
        var $passportCode = $('#form-field-passportCode');
        var $signOrg = $('#form-field-signOrg');
        var $signDate = $('#form-field-signDate');
        var $validDate = $('#form-field-validDate');
        var $notes = $('#form-field-notes');

        function getPrivatePassportData() {
            var privatePassportData = {};
            var dicUser = {};
            var dicDept = {};
            var privatePassportFile = {};
            privatePassportData.id = $privatePassportId.val();
            privatePassportData.passportCode = $passportCode.val();
            privatePassportData.signOrg = $signOrg.val();
            privatePassportData.signDate = $signDate.val();
            privatePassportData.validDate = $validDate.val();
            privatePassportData.notes = $notes.val();

            dicUser.id = $peopleId.val();
            privatePassportData.dicUser = dicUser;

            dicDept.id = $department.val();
            privatePassportData.dicDept = dicDept;

            if (fileId) {
                privatePassportFile.fileId = fileId;
                privatePassportData.privatePassportFile = privatePassportFile;
            }

            return privatePassportData;
        }

        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        var saveUrl = '${basePath}/private-passport/private-passport-save.do';

        $saveBtn.unbind('click').bind('click', function (e) {
            if ($privatePassportForm.validate().form()) {
                var signDate = moment($signDate.val(),'YYYY-MM-DD').toDate();
                var validDate = moment($validDate.val(),'YYYY-MM-DD').toDate();
                if (signDate > validDate) {
                    G.alert({message : '有效期应大于等于签发日期！'});
                    e.preventDefault();
                } else {
                    var data = getPrivatePassportData();
                    $saveBtn.prop("disabled", true);
                    $backBtn.prop("disabled", true);
                    G.confirm({
                        message: '确认保存此条因私护照信息吗？',
                        callback: function (result) {
                            if (result) {
                                var loadId = G.showAjaxLoading();
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
                                        G.pjaxLoadPageContentDiv('#page/private-passport/private-passport-list');
                                    } else {
                                        G.doneAjaxLoading(loadId);
                                        G.showGritterFail("保存失败!");
                                        $saveBtn.prop("disabled", false);
                                        $backBtn.prop("disabled", false);
                                    }
                                });
                            } else {
                                $saveBtn.prop("disabled", false);
                                $backBtn.prop("disabled", false);
                            }
                        }
                    });
                }
            }
        });

        $privatePassportForm.tjValidate({
            focusInvalid: true,
            rules: {
                peopleId: {required: true},
                department: {required: true},
                passportCode: {required: true},
                signOrg: {required: true},
                signDate: {required: true},
                validDate: {required: true}
            },
            messages: {
                peopleId: {required: "姓名必须填写"},
                department: {required: "工作部门必须填写"},
                passportCode: {required: "证件号码必须填写"},
                signOrg: {required: "签发机关必须选择"},
                signDate: {required: "签发日期必须填写"},
                validDate: {required: "截止有效期必须填写"}
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var postData = $privatePassportForm.serializeObject();

            var flag = 0;
            $.each(postData, function (index, item) {

                if (item !== "") {
                    flag = 1;
                }
            });

            if (flag === 0) {
                G.back();
            } else {
                G.confirm({
                    message: "您有因私护照信息未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                            G.back();
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