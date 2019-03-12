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

<div class="row">
    <div class="col-xs-10 col-sm-offset-1">
        <div class="widget-box transparent">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" id="new-edit-form" role="form" method="post">
                                <input id="id-party-id" name="taiWanParty.id" type="hidden" value="${taiWanParty.id}">
                                <input id="id" name="id" type="hidden" value="${taiWanParty.id}">

                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 5px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${taiWanParty.id eq null}">台湾社团新增</c:when>
                                                    <c:otherwise>台湾社团编辑</c:otherwise>
                                                </c:choose>
                                            </h1>
                                        </div>
                                    </div>
                                </div>
                                <div style="margin-top: 5%"></div>
                                <!-- 社团名称 -->
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-partyName" >
                                                社团名称：<span class="required">*</span>
                                            </label>
                                            <div class="col-sm-10"  style="padding-left: 7px;">
                                                <input type="text" id="form-field-partyName" name="partyName"
                                                       class="form-control" value="${taiWanParty.partyName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 空格 -->
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <!-- 社团简介 -->
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-partyDesc" >
                                                社团简介：<span class="required">*</span>
                                            </label>
                                            <div class="col-sm-10 " style="padding-left: 7px;">
                                                <textarea id="form-field-partyDesc" name="partyDesc"
                                                          class="form-control "style="min-height: 100px;"
                                                          placeholder="社团简介">${taiWanParty.partyDesc}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 空格 -->
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>


                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                &nbsp;&nbsp;&nbsp;&nbsp;<span class="required"></span></label>

                                            <div class="col-sm-10">
                                                <button class="btn btn-info btn-sm" type="button"
                                                        id="openName2">点击添加台湾主要人士信息
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row" id="congressUserNameDiv">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label">
                                                台湾主要人士：<span class="required">&nbsp;</span></label>

                                            <div class="col-sm-10" style=" width: 82%;padding-left: 7px;padding-right: 0px;">
                                                <table class="table table-striped table-bordered" id="workStudy"
                                                       name="taiWanPoliticsLists">
                                                    <thead>
                                                    <tr>
                                                        <th class="center hide">id</th>
                                                        <th class="center hide">是否删除</th>
                                                        <th class="center" style="width: 12%">姓名</th>
                                                        <th class="center" style="width: 15%">出生日期</th>
                                                        <th class="center" style="width: 15%">单位</th>
                                                        <th class="center" style="width: 7%">性别</th>
                                                        <th class="center" style="width: 25%">职务</th>
                                                        <th class="center" style="width: 17%">操作</th>
                                                    </tr>
                                                    </thead>
                                                    <tbody>
                                                    <c:if test="${!empty taiWanParty.taiWanPoliticsList}">
                                                        <c:forEach items="${taiWanParty.taiWanPoliticsList}" var="politicsList">
                                                            <tr class="dateType" data-id="${politicsList.id}">

                                                                <td class="center hide politicsListId">${politicsList.jsonObject.id}</td>

                                                                <td class="center hide politicsListDelFlag ">${politicsList.jsonObject.delFlag}</td>

                                                                <td class="center politicsListMainName">${politicsList.jsonObject.mainName}</td>


                                                                <td class="center politicsListBirthday">${politicsList.jsonObject.birthdayStr}</td>

                                                                <td class="center politicsListBelongOrg">${politicsList.jsonObject.belongOrg}</td>

                                                                <td class="center politicsListGender">${politicsList.jsonObject.gender}</td>

                                                                <td class="center politicsListDuty">${politicsList.jsonObject.duty}</td>
                                                                <td class="center">
                                                                    <button class="btn btn-minier btn-white btn-purple row-record-edit">
                                                                        <i class="ace-icon fa fa-pencil blue"></i>
                                                                        编辑
                                                                    </button>
                                                                    <button class="btn btn-minier btn-white btn-danger row-record-delete">
                                                                        <i class="ace-icon fa fa-times"></i>
                                                                        删除
                                                                    </button>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </c:if>
                                                    <c:if test="${taiWanParty.id eq null}">
                                                        <tr class="empty-row">
                                                            <th style="width: 100%" colspan="6" class="center">无内容！</th>
                                                        </tr>
                                                    </c:if>

                                                    </tbody>
                                                </table>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 空格 -->
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>

                                <!-- 与政协交往情况 -->
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-cppccInteract" >
                                                与政协交往情况：<span class="required">*</span>
                                            </label>
                                            <div class="col-sm-10 " style="padding-left: 7px;">
                                                <textarea id="form-field-cppccInteract" name="cppccInteract"
                                                          class="form-control " maxlength="200" style="min-height: 100px;"
                                                          placeholder="与政协交往情况">${taiWanParty.cppccInteract}</textarea>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- 空格 -->
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <!-- 上传社团图片 -->
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" >
                                                上传社团图片：<span class="required">&nbsp;</span>
                                            </label>
                                            <div class="col-sm-10">
                                                <input id="message-file" type="file"/>
                                                <div id="message-file-queue"></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
                                </div>
                                <!-- 已上传图片预览 -->
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" id="uploadedDiv">
                                            <div class="col-xs-12">
                                                <label style="width: 15%" class="col-xs-2 control-label no-padding-left">
                                                    已上传图片：
                                                </label>
                                                <div class="col-xs-8 no-padding-left">
                                                    <span id="download-file"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-10"></div>
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

<div id="view-dialog01" class="hide">

    <form class="form-horizontal" id="new-form" role="form" method="post">

        <div class="hide">
            <input type="text" id="form-field-uuid" class="form-control" name="uuid"/>
        </div>

        <div style="margin-top: 5%"></div>
        <!-- 填写信息 -->
        <div class="row">
            <!-- 姓名 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="form-field-mainName" >
                        姓名：<span class="required">*</span>
                    </label>
                    <div class="col-sm-8 ">
                        <input type="text" id="form-field-mainName"
                               name="mainName" class="form-control "/>
                    </div>
                </div>
            </div>
            <!-- 出生日期 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="form-field-birthday" >
                        出生日期：<span class="required"></span>
                    </label>
                    <div class="col-sm-8 ">
                        <div class="input-group">
                            <input class="form-control date-picker"
                                   name="birthdayStr"
                                   id="form-field-birthday"
                                   data-date-format="yyyy-mm-dd" type="text"/>
                            <span class="input-group-addon">
                                <i class="fa fa-calendar bigger-110"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- 空格 -->
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <!-- 单位 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="form-field-belongOrg" >
                        单位：<span class="required"></span>
                    </label>
                    <div class="col-sm-8 ">
                        <input type="text" id="form-field-belongOrg"
                               name="belongOrg" class="form-control "/>
                    </div>
                </div>
            </div>
            <!-- 性别 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label" >
                        性别：<span class="required">*</span>
                    </label>
                    <div class="col-xs-8">
                        <label>
                            <input name="gender" class="ace input-lg " id="inputSexNan"
                                   value="0" type="radio" checked/>
                            <span class="lbl bigger-120"> 男</span>
                        </label>
                        &nbsp;&nbsp;
                        <label>
                            <input name="gender" class="ace input-lg" id="inputSexNv"
                                   value="1" type="radio"/>
                            <span class="lbl bigger-120"> 女</span>
                        </label>
                    </div>
                </div>
            </div>
        </div>
        <!-- 空格 -->
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <!-- 职务 -->
            <div class="col-xs-6">
                <div class="form-group">
                    <label class="col-sm-4 control-label" for="form-field-duty" >
                        职务：<span class="required"></span>
                    </label>
                    <div class="col-sm-8 ">
                        <input type="text" id="form-field-duty"
                               name="duty" class="form-control "/>
                    </div>
                </div>
            </div>
        </div>
        <!-- 空格 -->
        <div class="row">
            <div class="space-10"></div>
        </div>
    </form>
</div>



<script src="${basePath}/plugin/ace/assets/js/ace/elements.fileinput.js"></script>
<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        G.datepicker({autoclose: true, endDate: new Date()});
        var $saveForm = $("#new-edit-form");
        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        //重要人士信息
        var $saveFormOne = $("#new-form");
        var $openName2 = $("#openName2");
        var $viewDialog = $("#view-dialog01");
        var politicsListStr = [];

        //其他全局变量
        var fd = new FormData();
        var arrayId = new Array();
        var realName;
        var fileId;
        var partyId = $saveForm.find("#id-party-id").val();
        var $uploadFile = $(".form-field-upload-file");


        //本地URL
        var url = '#page/taiwan-party/taiwan-party-list';
        var editUrl = '${basePath}/taiwan-party/load-taiwan-party-save.do';
        var uploadUrl = '${basePath}/file/upload-files.do';

        //文件上传全局变量
        var $partyId = $('#id-party-id');
        var $messageFile = $('#message-file');
        var $messageFileQueue = $('#message-file-queue');
        var $uploadedDiv = $('#uploadedDiv');
        var $downLoadFile = $("#download-file");

        //新增时隐藏
        if ('' == $partyId.val()) {
            $uploadedDiv.addClass('hide');
        }

        function getFileListArray(messageFileQueue) {
            var wanPartyFileArray = [];
            messageFileQueue.find('.uploadifive-queue-item').each(function () {
                var $this = $(this);
                var fileId = $this.find(".progress").attr('hiddenFileId');
                var fileName = $this.find(".progress").attr('hiddenFileName');
                var documentFile = {};
                documentFile.fileId = fileId;
                documentFile.fileName = fileName;
                wanPartyFileArray.push(documentFile);
            });
            return wanPartyFileArray;
        }

        //新增或编辑保存
        $saveBtn.unbind('click').bind('click',function (e) {
            e.preventDefault();
            var data = $saveForm.serializeObject();
            var wanPartyFileArray = getFileListArray($messageFileQueue);
            data.wanPartyFileList = wanPartyFileArray;
            data.taiWanPoliticsListVo = politicsListStr;
            data["partyId"] = partyId;
            if ($saveForm.validate().form()){
                G.confirm({
                    message: '确认保存此条信息吗？',
                    callback: function (result) {
                        if (result) {
                            var loadId = G.showAjaxLoading();
                            $.ajax({
                                url: editUrl,
                                type: 'POST',
                                dataType: 'json',
                                contentType: "application/json;charset=utf-8",
                                data: JSON.stringify(data),
                                async: true
                            }).done(function (map) {
                                if (map.result) {
                                    G.doneAjaxLoading(loadId);
                                    G.showGritterSuccess("保存成功");
                                    G.pjaxLoadPageContentDiv(url);
                                } else {
                                    G.doneAjaxLoading(loadId);
                                    G.showGritterFail("保存信息失败,请稍后重试!");
                                }
                            });
                        }
                    }
                });
            }
        });

        //新增或编辑返回操作
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
                G.pjaxLoadPageContentDiv(url);
            } else {
                G.confirm({
                    message: "您的社团信息尚未保存，确认退出吗？",
                    callback: function (result) {
                        if (result) {
                        G.pjaxLoadPageContentDiv(url);
                        }
                    }
                });
            }
        });

        //数据校验
        $saveForm.tjValidate({
            focusInvalid: false,
            rules: {
                partyName: {required: true},
                partyDesc: {required: true},
                cppccInteract: {required: true}
            },
            messages: {
                partyName: {required: "社团名称必须填写"},
                partyDesc: {required: "社团简介必须填写"},
                cppccInteract: {required: "与政协交往情况必须填写"}
            }
        });

        /*--------附件上传start--------*/
        bindUpload($messageFile, "message-file-queue");

        function bindUpload(fileInput, queueId) {
            fileInput.uploadifive({
                'uploadScript': '${basePath}/file/upload-file.do',
                'queueID': queueId,//列表区域id
                'queueSizeLimit': 10,
                'uploadLimit': 0,
                'auto': true,
                'multi': false,
                'fileObjName': 'uploadFile',
                'height': 30,
                'width': 100,
                'simUploadLimit': 2,
                'buttonCursor': 'hand',
                'buttonClass': 'btn btn-sm btn-primary',
                'buttonText': '&nbsp;&nbsp添加附件&nbsp;&nbsp',
                'removeCompleted': false,
                'method': 'post',
                'fileSizeLimit': 1024000,
                'fileType':['image/png','image/jpeg','image/gif'],
                'overrideEvents': ['onUploadComplete'],
                'onUploadComplete': function (file, data, response) {
                    var result = JSON.parse(data);
                    if (result.result) {
                        var realName = result.realName;
                        var fileId = result.fileId;
                        file.queueItem.find('.progress-bar').css('width', '100%');
                        file.queueItem.find('.fileinfo').html(' - 完成');
                        file.queueItem.find('.progress').slideUp(250);
                        file.queueItem.find('.progress').attr('hiddenFileName',realName);
                        file.queueItem.find('.progress').attr('hiddenFileId',fileId);
                        file.queueItem.addClass('complete');
                        if($downLoadFile.html().indexOf('暂无') !== -1) {
                            $downLoadFile.empty();
                        }
                    } else {
                        G.showGritterFail();
                    }

                }
            });
        }
        /*--------附件上传end---------*/

        /*--------附件预览删除start--------*/
        //获取已上传的附件
        appendAttach($downLoadFile, ${jsonFileList});

        //获取已上传的附件
        function appendAttach($div, attachList) {
            $div.empty();
            var html = [];
            if (attachList == null) {
                html.push('<ul class="list-unstyled list-striped pricing-table-header"><li style="margin-top:5px">');
                html.push('暂无已上传图片！');
                html.push('</li></ul>');
            } else {
                html.push('<ul class="list-unstyled list-striped pricing-table-header">');
                for (var i in attachList) {
                    var attach = attachList[i];
                    html.push('<li class="blue"  style="cursor:pointer;margin-top:5px;background-color: white;">');
                    html.push('<a class="filePreview" fileId="' + attach.id + '" style="color:#478FCA;font-family:仿宋, Arial, Helvetica, sans-serif;font-size: 18px;">');
                    html.push(attach.fileName);
                    html.push('</a>&nbsp&nbsp&nbsp');
                    html.push('<a style="color:grey" href="${basePath}/file/download.action?id=' + attach.id + '&type=0">');
                    html.push('<i class="ace-icon fa fa-download grey bigger-130"></i>下载</a>&nbsp;');
                    html.push('<span class="red fileDelete" fileId="' + attach.id + '">');
                    html.push('<i class="ace-icon fa fa-trash-o red bigger-130 fileDelete"></i>删除&nbsp;');
                    html.push('</span>');
                    html.push('</li>');
                }
                html.push('</ul>');
            }
            $div.append(html.join(""));
            deleteFile();
        }

        //删除已上传附件
        function deleteFile() {
            $('.fileDelete').click(function () {
                var $this = $(this);
                var fileId = $this.attr("fileId");
                G.confirm({
                    message: '确定删除该附件信息？',
                    callback: function (result) {
                        if (result) {
                            var url = '${basePath}/taiwan-party/taiwan-party-file-delete.do';
                            $.post(url, {id: fileId}, function (response) {
                                if (response.result) {
                                    G.showGritterSuccess();
                                }
                                $this.parent().remove();
                            });
                        }
                    }
                })
            })
        }
        /*--------附件预览删除end---------*/


        /*--------重要人士添加删除编辑操作end---------*/

        $openName2.click(function () {
            initViewDialog($viewDialog,"add");
        })
        function initViewDialog($container,type,datas,i,e) {
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                maxHeight: 600,
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>台湾主要人士</h4></div>",
                title_html: true,
                close: function () {
                    $container.addClass("hide");
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {$(this).dialog("close");}
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            if ($saveFormOne.validate().form()) {
                                if("add" === type){
                                    var data = $saveFormOne.serializeObject();
                                    var mainName = data.mainName;
                                    var sex;
                                    data.gender = $("input:radio:checked").val();
                                    if(data.gender === 0){
                                        sex = "男";
                                    }else if(data.gender === 1){
                                        sex = "女";
                                    }else {
                                        sex = "未知";
                                    }
                                    if("" !==(mainName.toString()) && mainName.toString().length<=100) {
                                        var array = [];
                                        if (data.uuid === undefined || data.uuid === "") {
                                            var mydate = new Date();
                                            var uuid = "cmssunyi" + mydate.getDay() + mydate.getHours() + mydate.getMinutes() + mydate.getSeconds() + mydate.getMilliseconds() + Math.round(Math.random() * 1000);
                                            data.uuid = uuid;
                                        }
                                        $("#workStudy").find('tr.empty-row').remove();
                                        array.push(' <tr class="workStudy" data-id="'+data.uuid+'">'     );
                                        array.push('     <td class="center hide"></td>'                  );
                                        array.push('     <td class="center hide">0</td>'                 );
                                        array.push('     <td class="center">'+mainName+'</td> '          );
                                        array.push('     <td class="center">'+data.birthdayStr+' </td>'  );
                                        array.push('     <td class="center">'+data.belongOrg+'</td>'     );
                                        array.push('     <td class="center">'+sex+'</td>'                );
                                        array.push('     <td class="center">'+data.duty+'</td>'          );


                                        array.push('     <td class="center">                                                           ');
                                        array.push('         <button class="btn btn-minier btn-white btn-purple row-record-edit">                ');
                                        array.push('              <i class="ace-icon fa fa-pencil blue"></i>                           ');
                                        array.push('             编辑                                                                   ');
                                        array.push('         </button>                                                                 ');

                                        array.push('         <button class="btn btn-minier btn-white btn-danger row-record-delete">               ');
                                        array.push('             <i class="ace-icon fa fa-times"></i>                                   ');
                                        array.push('             删除                                                                    ');
                                        array.push('         </button>                                                                  ');

                                        array.push('     </td>                                                                          ');
                                        array.push(' </tr>                                                                              ');

                                        $("#workStudy").find('tbody').append(array.join(''));

                                        G.datepicker({autoclose: true, todayHighlight: true});

                                        $("#view-dialog01 input[name='mainName']").val("");
                                        $("#view-dialog01 input[name='belongOrg']").val("");
                                        $("#view-dialog01 input[name='duty']").val("");
                                        $("#view-dialog01 input[name='duty']").val("");
                                        $("#view-dialog01 input[name='birthdayStr']").val("");
                                        if(data.gender==1){
                                            $inputSexNv.attr("checked" ,true);
                                        }else {
                                            $inputSexNan.attr("checked" ,true);
                                        }
                                        $(this).dialog("close");
                                        politicsListStr.push(data);
                                        if(i!== -1 || i!==undefined) {
                                            delete datas[i];
                                            $(e.target).closest('tr').remove();
                                        }
                                    }
                                }else if("update" === type){
                                    var data = $saveFormOne.serializeObject();
                                    data.id=data.uuid;
                                    data['taiWanParty.id'] = $partyId.val();

                                    $.ajax({
                                        url: '${basePath}/taiwan-politics/load-taiwan-politics-save.do',
                                        type: 'POST',
                                        dataType: 'json',
                                        data: data
                                    }).done(function (map) {
                                        if (map.result) {

                                            G.doneAjaxLoading(G.showAjaxLoading());
                                            G.showGritterSuccess("保存成功");
                                            var politics = map.taiWanPolitics;
                                            e.children(".politicsListId").html(politics.id);
                                            e.children(".politicsListDelFlag").html(politics.delFlag);
                                            e.children(".politicsListMainName").html(politics.mainName);
                                            e.children(".politicsListBirthday").html(politics.birthdayStr);
                                            e.children(".politicsListBelongOrg").html(politics.belongOrg);
                                            e.children(".politicsListGender").html(politics.genderStr);
                                            e.children(".politicsListDuty").html(politics.duty);
                                            $container.dialog("close");
                                        } else {
                                            G.doneAjaxLoading(G.showAjaxLoading());
                                            G.showGritterFail("保存信息失败,请稍后重试!");
                                        }
                                    });
                                }
                            }
                        }
                    }
                ]
            });
        }

        $("#workStudy").on('click','.row-record-delete',function (e) {
            e.preventDefault();
            var id = $(e.target).closest('tr').data('id');
            var data = politicsListStr;
            if(id.indexOf("cmssunyi")===0){
                for(var i=0;i<data.length;i++){
                    if(data[i]!==undefined) {
                        if (data[i].uuid === id) {
                            delete data[i];
                            $(e.target).closest('tr').remove();
                        }
                    }
                }
            }else {
                //删除数据库
                $.ajax({
                    url: '${basePath}/taiwan-politics/load-taiwan-politics-delete.do',
                    type: 'POST',
                    dataType: 'json',
                    data: {"id":id}
                }).done(function (map) {
                    if (map.result) {
                        G.doneAjaxLoading(G.showAjaxLoading());
                        G.showGritterSuccess("删除成功");
                        $(e.target).closest('tr').remove();
                    } else {
                        G.doneAjaxLoading(G.showAjaxLoading());
                        G.showGritterFail("删除信息失败,请稍后重试!");
                    }
                });
            }
        })


        var $mainName = $("#form-field-mainName");
        var $uuid = $("#form-field-uuid");
        var $birthday = $("#form-field-birthday");
        var $belongOrg = $("#form-field-belongOrg");
        var $duty = $("#form-field-duty");
        var $inputSexNan = $("#inputSexNan");
        var $inputSexNv = $("#inputSexNv");

        $("#workStudy").on('click','.row-record-edit',function (e) {
            e.preventDefault();
            var id = $(e.target).closest('tr').data('id');
            var data = politicsListStr;
            if(id.indexOf("cmssunyi")===0){//新增时编辑
                for(var i=0;i<data.length;i++){
                    if(data[i]!==undefined) {
                        if (data[i].uuid === id) {
                            $mainName.val(data[i].mainName);
                            $uuid.val(data[i].uuid);
                            $birthday.val(data[i].birthdayStr);
                            $belongOrg.val(data[i].belongOrg);
                            $duty.val(data[i].duty);
                            if(data[i].gender===1){
                                $inputSexNv.attr("checked" ,true);
                            }else {
                                $inputSexNan.attr("checked" ,true);
                            }
                            initViewDialog($viewDialog,"add",data,i,e);
                        }
                    }
                }
            }else {//数据库已有数据的编辑
                var tr = $(this).parent().parent();
                var Id= tr.children(".politicsListId").html();
                var DelFlag= tr.children(".politicsListDelFlag").html();
                var MainName= tr.children(".politicsListMainName").html();
                var Birthday= tr.children(".politicsListBirthday").html();
                var BelongOrg= tr.children(".politicsListBelongOrg").html();
                var Gender= tr.children(".politicsListGender").html();
                var Duty= tr.children(".politicsListDuty").html();
                $mainName.val(MainName);
                $uuid.val(Id);
                $birthday.val(Birthday);
                $belongOrg.val(BelongOrg);
                $duty.val(Duty);

                if(Gender===1){
                    $inputSexNv.attr("checked" ,true);
                }else {
                    $inputSexNan.attr("checked" ,true);
                }
                initViewDialog($viewDialog,"update",null,-1,tr);
            }

        });


        $saveFormOne.tjValidate({
            focusInvalid: true,
            rules: {
                mainName: {required: true, maxlength: 100},
                belongOrg: {required: false, maxlength: 200},
                duty: {required: false, maxlength: 100}
            },
            messages: {
                mainName: {required: "姓名必须填写"},
                birthdayStr: {required: "社团简介必须填写"}
            }
        });
        /*--------重要人士添加删除编辑操作end---------*/
        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>