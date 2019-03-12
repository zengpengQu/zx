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
                            <form class="form-horizontal" id="new-edit-form" role="form" method="post">
                                <input id="id-taiwan-card-id" name="id" type="hidden" value="${taiWanCard.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${taiWanCard.id eq null}">赴台通行证新增</c:when>
                                                    <c:otherwise>赴台通行证编辑</c:otherwise>
                                                </c:choose>
                                            </h1>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 3%"></div>

                                <div class="row">
                                    <!-- 工作部门 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-department" >
                                                工作部门：<span class="red">*</span>
                                            </label>
                                            <div class="col-sm-8 deptDiv">
                                                <input type="text" id="form-field-department" name="department"
                                                       class="hide" value=""/>
                                                <input type="text" class="form-control" id="form-field-deptName"
                                                       name="deptName" value="" style="cursor: pointer;" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 姓名 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-peopleId" >
                                                姓名：<span class="red">*</span>
                                            </label>
                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-peopleId"
                                                        name="peopleId">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${dicUserList}" var="dicUser">
                                                        <option value="${dicUser.id}"  <c:if test="${taiWanCard.dicUser.id eq dicUser.id}">selected</c:if> >${dicUser.empName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <!-- 签发机关 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-signOrg" >
                                                签发机关：<span class="red">*</span>
                                            </label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-signOrg"
                                                       name="signOrg"
                                                       class="form-control " value="${taiWanCard.signOrg}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 身份证号 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-idNumber" >
                                                身份证号：<span class="red">*</span>
                                            </label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-idNumber"
                                                       name="idNumber"
                                                       class="form-control " value="${taiWanCard.idNumber}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <!-- 证件新旧 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-newOld" >
                                                证件新旧：<span class="red">*</span>
                                            </label>
                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-newOld"
                                                        name="newOld">
                                                    <option value="">---------请选择---------</option>
                                                    <option value="0"<c:if test="${'0' eq taiWanCard.jsonObject.newOld}">selected</c:if>>旧的</option>
                                                    <option value="1"<c:if test="${'1' eq taiWanCard.jsonObject.newOld}">selected</c:if>>新的</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <%--<!-- 是否过期 -->--%>
                                    <%--<div class="col-xs-6">--%>
                                        <%--<div class="form-group">--%>
                                            <%--<label class="col-sm-4 control-label" for="form-field-isExpired" >--%>
                                                <%--是否过期：<span class="red">*</span>--%>
                                            <%--</label>--%>
                                            <%--<div class="col-sm-8 ">--%>
                                                <%--<select class="form-control" id="form-field-isExpired"--%>
                                                        <%--name="isExpired">--%>
                                                    <%--<option value="">---------请选择---------</option>--%>
                                                    <%--<option value="0"<c:if test="${taiWanCard.isExpired eq '0'}">selected</c:if>>临近逾期</option>--%>
                                                    <%--<option value="1"<c:if test="${taiWanCard.isExpired eq '1'}">selected</c:if>>逾期</option>--%>
                                                    <%--<option value="2"<c:if test="${taiWanCard.isExpired eq '2'}">selected</c:if>>过期</option>--%>
                                                    <%--<option value="3"<c:if test="${taiWanCard.isExpired eq '3'}">selected</c:if>>正常</option>--%>
                                                <%--</select>--%>
                                            <%--</div>--%>
                                        <%--</div>--%>
                                    <%--</div>--%>
                                </div>

                                <div class="row">
                                    <!-- 签发日期 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-signDate" >
                                                签发日期：<span class="required">*</span>
                                            </label>
                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="signDateStr"
                                                           id="form-field-signDate"
                                                           type="text" value="${taiWanCard.jsonObject.signDate}"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 有效期至 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-validDate" >
                                                有效期至：<span class="required">*</span>
                                            </label>
                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="validDateStr"
                                                           id="form-field-validDate"
                                                           type="text" value="${taiWanCard.jsonObject.validDate}"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <!-- 保管机构 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-keepOrg" >
                                                保管机构：<span class="red">*</span>
                                            </label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-keepOrg"
                                                       name="keepOrg"
                                                       class="form-control " value="${taiWanCard.keepOrg}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 证件号码 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-permitCode" >
                                                证件号码：<span class="red">*</span>
                                            </label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-permitCode"
                                                       name="permitCode"
                                                       class="form-control "
                                                       value="${taiWanCard.permitCode}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <!-- 签发地点 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-signSite" >
                                                签发地点：<span class="red">*</span>
                                            </label>
                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-signSite"
                                                       name="signSite"
                                                       class="form-control " value="${taiWanCard.signSite}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 上传扫描件 -->
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label"
                                                   for="form-field-file"  >上传扫描件：<span
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
                                <!-- 备注 -->
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-notes"
                                             style="width: 187px;height: 28px;padding-left: 115px;">备注：</label>
                                            <div class="col-sm-8 " style="padding-left: 0px;">
                                            <textarea class="form-control limited" id="form-field-notes"
                                                      name="notes" maxlength="200" style="min-height: 100px;">${taiWanCard.notes}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 扫描件预览 -->
                                <div class="row">
                                    <div class="col-xs-12" style="margin-top: 25px;padding-left: 0px;">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label text-right"
                                                   style="font-weight: bold; color: deepskyblue;">扫描件预览：</label>
                                            <div class="col-sm-4">
                                                <img src="" id="showImg" height="300px" width="300px">
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 按钮 -->
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
        //初始化图片回显
        showImg(${jsonFileObject});

        function showImg(jsonFileObject) {
            if (null != jsonFileObject) {
                $('#showImg').prop("src", '${basePath}/file/download.action?id=' + jsonFileObject.id + '&type=0');
            }
        }

        //时间控件校验
        G.datepicker({autoclose: true, todayHighlight: true});

        G.initDept('deptDiv',true,['${dicDept}'],TREE_NODE);

        // 控件类全局变量
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        // 表单类全局变量
        var $saveForm = $("#new-edit-form");

        //其他全局变量
        var fd = new FormData();
        var realName;
        var fileId;
        var taiwanCardId = $saveForm.find("#id-taiwan-card-id").val();
        var $uploadFile = $(".form-field-upload-file");

        var $signDate = $("#form-field-signDate");
        var $validDate = $("#form-field-validDate");

        //本地url
        var url = '${basePath}/taiwan-card/load-taiwan-card-save.do';
        var localUrl = '#page/taiwan-card/taiwan-card-list';
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
        $uploadFile.bind('change',function () {
            $('#showImg').prop("src", '');
            var isImage = true;
            $uploadFile.each(function () {
                var fieldName = $(this).attr('name');
                var files = $(this).data('ace_input_files');
                if (files && files.length > 0) {
                    for (var i = 0;i < files.length;i++){
                        var fileName = files[i].name;
                        if (fileName.indexOf('.JPEG') == -1 && fileName.indexOf('.png') == -1 &&
                            fileName.indexOf('.jpg') == -1 && fileName.indexOf('.gif') == -1 &&
                            fileName.indexOf('.bmp') == -1) {
                            isImage = false;
                            $saveBtn.prop("disabled", false);
                            $backBtn.prop("disabled", false);
                            G.alert({message:'文件上传失败！扫描件只能是：.JPEG .png .jpg .gif .bmp 格式！请重新上传！'});
                        }else {
                            fd.append(fieldName, files[i]);//只有图片附件才往fd追加file
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
                    data: fd //our fd object
                }).done(function (map) {
                    if (map.result) {
                        G.doneAjaxLoading(loadId);
                        fileId = map.fileId;
                        realName = map.realName;
                        fd.delete('uploadFile');
                        G.showGritterSuccess("文件上传成功！");
                        $saveBtn.prop("disabled", false);
                        $backBtn.prop("disabled", false);
                        $('#showImg').prop("src", '${basePath}/file/show-image.action?fileId=' + fileId + '&type=0');
                    } else {
                        G.showGritterFail("文件上传失败！请稍后重试。");
                        G.doneAjaxLoading(loadId);
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
            console.log('clear img')
            $('#showImg').attr('src', "");
        });


        //赴台通行证新增提交数据
        $saveBtn.unbind('click').bind('click',function (e) {
            e.preventDefault();
            var data = $saveForm.serializeObject();
            data["fileId"] = fileId;
            data["taiwanCardId"] = taiwanCardId;
            if ($saveForm.validate().form()){
                var signDate = moment($signDate.val(),'YYYY-MM-DD').toDate();
                var validDate = moment($validDate.val(),'YYYY-MM-DD').toDate();
                if (signDate >= validDate) {
                    G.alert({message : '有效期应大于签发日期！'});
                    e.preventDefault();
                }else {
                    G.confirm({
                        message: '确认保存此条信息吗？',
                        callback: function (result) {
                            if (result){
                                var loadId = G.showAjaxLoading();
                                $.ajax({
                                    url: url,
                                    type: 'POST',
                                    dataType: 'json',
                                    data: data,
                                    async: true
                                }).done(function (map) {
                                    if (map.result){
                                        G.doneAjaxLoading(loadId);
                                        G.showGritterSuccess("保存成功");
                                        G.pjaxLoadPageContentDiv(localUrl);
                                    } else {
                                        G.doneAjaxLoading(loadId);
                                        G.showGritterFail("保存信息失败,请稍后重试！");
                                    }
                                });
                            }
                        }
                    });
                }
            }
        });

        //赴台通行证返回操作
        $backBtn.unbind('click').bind('click',function (e) {
            e.preventDefault();
            var postData = $saveForm.serializeObject();
            var flag = 0;
            $.each(postData,function (index,item) {
                if (item !== ""){
                    flag = 1;
                }
            });
            if (flag === 0){
                G.back();
            } else {
                G.confirm({
                    message: "您的文件信息尚未保存，确认退出吗？",
                    callback: function (result) {
                        G.back();
                    }
                });
            }
        });

        //数据校验
        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                peopleId: {
                    required: true
                },
                department: {
                    required: true
                },
                signOrg: {
                    required: true
                },
                idNumber: {
                    required: true
                },
                newOld: {
                    required: true
                },
                signDateStr: {
                    required: true
                },
                validDateStr: {
                    required: true
                },
                keepOrg: {
                    required: true
                },
                permitCode: {
                    required: true
                },
                isBorrow: {
                    required: true
                },
                signSite: {
                    required: true
                },
                uploadFile: {
                    required: true
                },
            },
            messages: {
                peopleId: {
                    required: "姓名不能为空"
                },
                department: {
                    required: "部门不能为空"
                },
                signOrg: {
                    required: "签发地点不能为空"
                },
                idNumber: {
                    required: "身份证号不能为空"
                },
                newOld: {
                    required: "证件新旧不能为空"
                },
                signDateStr: {
                    required: "签发日期不能为空"
                },
                validDateStr: {
                    required: "有效期至不能为空"
                },
                keepOrg: {
                    required: "保管机构不能为空"
                },
                permitCode: {
                    required: "证件号码不能为空"
                },
                isBorrow: {
                    required: "是否借出不能为空"
                },
                signSite: {
                    required: "签发地点不能为空"
                },
                uploadFile: {
                    required: "请上传图片"
                },
            }
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>