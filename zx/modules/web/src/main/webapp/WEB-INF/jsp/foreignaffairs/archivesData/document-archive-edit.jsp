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
                            <form class="form-horizontal" id="documentArchiveForm" role="form" autocomplete="off" method="post">
                                <input id="documentArchiveId" name="documentArchiveId" type="hidden" value="${documentArchive.id}">
                                <div class="row">
                                    <div class="col-xs-12">
                                        <div class="form-group" style="margin-top: 20px;margin-bottom: 30px">
                                            <h1 align="center"
                                                style="font-weight:bolder;letter-spacing: 2pt;font-family:华文宋体">
                                                <c:choose>
                                                    <c:when test="${documentArchive.id eq null}"> 档案资料新增</c:when>
                                                    <c:otherwise> 档案资料编辑</c:otherwise>
                                                </c:choose></h1>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" >案卷分类：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-parentTeamId"
                                                        name="parentTeamId">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${parentDocumentTeamList}" var="parentDocumentTeam">
                                                        <option value="${parentDocumentTeam.id}"  <c:if test="${documentArchive.documentTeam.parentId eq parentDocumentTeam.id}">selected</c:if> >${parentDocumentTeam.teamName}</option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" >叶子节点：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-teamId"
                                                        name="teamId">
                                                    <option value="">---------请选择---------</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-fondsNumber" >全宗号：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-fondsNumber" name="fondsNumber"
                                                       class="form-control " value="${documentArchive.fondsNumber}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-catalogNumber" >目录号：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-catalogNumber" name="catalogNumber"
                                                       class="form-control " value="${documentArchive.catalogNumber}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-fileNumber" >案卷号：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-fileNumber" name="fileNumber"
                                                       class="form-control " value="${documentArchive.fileNumber}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-archiveNumber" >档案号：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-archiveNumber" name="archiveNumber"
                                                       class="form-control " value="${documentArchive.archiveNumber}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-year" >年度：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy">
                                                    <input class="form-control" name="year" id="form-field-year"
                                                           value="${documentArchive.jsonObject.year}" type="text"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-retentionPeriod" >保管期限：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-retentionPeriod" name="retentionPeriod"
                                                       class="form-control " value="${documentArchive.retentionPeriod}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-fileName" >案卷题名：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-fileName" name="fileName"
                                                       class="form-control " value="${documentArchive.fileName}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-fileSum" style="padding-right: 0px;padding-left: 0px;text-align: left">卷内文件份数：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-fileSum" name="fileSum"
                                                       class="form-control " value="${documentArchive.fileSum}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-pageSum" >页数：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-pageSum" name="pageSum"
                                                       class="form-control " value="${documentArchive.pageSum}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-department" >编制单位：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 deptDiv">
                                                <input type="text" id="form-field-department" name="department"
                                                       class="hide" value=""/>
                                                <input type="text" class="form-control" id="form-field-deptName"
                                                       name="deptName" value="" style="cursor: pointer;" readonly/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-compileDate" style="padding-left: 0px;padding-right: 0px;text-align: left">编制开始日期：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="compileDate" id="form-field-compileDate"
                                                           value="${documentArchive.jsonObject.compileDate}" type="text"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-endDate" style="padding-left: 0px;padding-right: 0px;text-align: left">编制结束日期：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="endDate" id="form-field-endDate"
                                                           value="${documentArchive.jsonObject.endDate}" type="text"/>
                                                    <span class="input-group-addon">
                                                    <i class="fa fa-calendar bigger-110"></i>
                                                </span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-writer" >立卷人：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-writer" name="writer"
                                                       class="form-control " value="${documentArchive.writer}"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-secretLevel" >密级：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <select class="form-control" id="form-field-secretLevel"
                                                        name="secretLevel">
                                                    <option value="">---------请选择---------</option>
                                                    <option value="0" <c:if test="${documentArchive.secretLevel eq '0'}">selected</c:if>>秘密</option>
                                                    <option value="1" <c:if test="${documentArchive.secretLevel eq '1'}">selected</c:if>>机密</option>
                                                    <option value="2" <c:if test="${documentArchive.secretLevel eq '2'}">selected</c:if>>绝密</option>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-rummager" >检查人：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <input type="text" id="form-field-rummager" name="rummager"
                                                       class="form-control " value="${documentArchive.rummager}"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-4">
                                        <div class="form-group">
                                            <label class="col-sm-4 control-label" for="form-field-rummagerDate" >检查日期：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-8 ">
                                                <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                                                    <input class="form-control" name="rummagerDate" id="form-field-rummagerDate"
                                                           value="${documentArchive.jsonObject.rummagerDate}" type="text"/>
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
                                            <label class="col-sm-2 control-label" for="form-field-content" style="padding-left: 0px;padding-right: 0px;text-align: left;width: 11%">本卷情况说明：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-10" style="width: 89%">
                                            <textarea class="form-control limited" id="form-field-content"
                                                      name="content" maxlength="200" style="min-height: 100px;">${documentArchive.content}</textarea>
                                            </div>
                                        </div>

                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-12 ">
                                        <div class="form-group">
                                            <label class="col-sm-2 control-label" for="form-field-notes" style="padding-left: 0px;padding-right: 0px;width: 11%">备注：<span
                                                    class="required">&nbsp;</span></label>
                                            <div class="col-sm-10" style="width: 89%">
                                            <textarea class="form-control limited" id="form-field-notes"
                                                      name="notes" maxlength="200" style="min-height: 100px;">${documentArchive.notes}</textarea>
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

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker({
            todayHighlight : true
        });

        G.initDept('deptDiv',true,['${dicDept}'],TREE_NODE);

        $('#form-field-year').datetimepicker({
             format: 'yyyy',
             weekStart: 1,
             autoclose: true,
             startView: 2,
             maxViewMode: 2,
             minViewMode:2,
             forceParse: false,
             language: 'zh-CN'
        });

        var $documentArchiveForm = $('#documentArchiveForm');
        var $documentArchiveId = $('#documentArchiveId');
        var $parentTeamId = $('#form-field-parentTeamId');
        var $teamId = $('#form-field-teamId');
        var $fondsNumber = $('#form-field-fondsNumber');
        var $catalogNumber = $('#form-field-catalogNumber');
        var $fileNumber = $('#form-field-fileNumber');
        var $archiveNumber = $('#form-field-archiveNumber');
        var $year = $('#form-field-year');
        var $retentionPeriod = $('#form-field-retentionPeriod');
        var $fileName = $('#form-field-fileName');
        var $fileSum = $('#form-field-fileSum');
        var $pageSum = $('#form-field-pageSum');
        var $department = $('#form-field-department');
        var $compileDate = $('#form-field-compileDate');
        var $endDate = $('#form-field-endDate');
        var $writer = $('#form-field-writer');
        var $secretLevel = $('#form-field-secretLevel');
        var $rummager = $('#form-field-rummager');
        var $rummagerDate = $('#form-field-rummagerDate');
        var $content = $('#form-field-content');
        var $notes = $('#form-field-notes');

        //编辑时叶子节点下来列表回显
        findChildNodeByParentId('edit');

        //编辑时案卷节点信息不可修改
        if ('' != $documentArchiveId.val()) {
            $parentTeamId.prop("disabled", true);
            $teamId.prop("disabled", true);
        }

        $parentTeamId.change(function () {
            var parentTeamId = $parentTeamId.val();
            if ('' != parentTeamId) {
                findChildNodeByParentId();
            } else {
                renderChildDocumentTeam(null, 'noData');
            }
        });

        //案卷分类改变时查找叶子节点
        function findChildNodeByParentId(type) {
            var loadId = G.showAjaxLoading();
            $.ajax({
                type: 'POST',
                url: '${basePath}/document-archive/find-child-node.do',
                dataType: 'json',
                data: {parentId: $parentTeamId.val()},
                success: function(response) {
                    G.doneAjaxLoading(loadId);
                    var childDocumentTeamList = response.childDocumentTeamList;
                    if (childDocumentTeamList == 'empty') {
                        renderChildDocumentTeam(null, 'noData');
                        G.alert({message: '当前案卷分类下没有叶子节点,请返回添加或重新选择!'});
                    } else {
                        if (undefined == childDocumentTeamList) {
                            renderChildDocumentTeam(null, 'noData');
                        } else {
                            renderChildDocumentTeam(childDocumentTeamList, 'haveData');
                        }
                        //编辑时数据回显
                        if (type == 'edit') {
                            var tempDpId = '${documentArchive.documentTeam.id}';
                            var tempElement = document.getElementById('form-field-teamId');
                            for (var i = 0; i < tempElement.length; i ++) {
                                if(tempElement[i].value == tempDpId) {
                                    tempElement[i].selected = "selected";
                                }
                            }
                        }
                    }
                }
            });
        }

        //叶子节点下拉列表生成
        function renderChildDocumentTeam(childDocumentTeamList, type) {
            $teamId.empty();
            var html = '{{#each documentTeams}}<option value="{{id}}">{{teamName}}</option>{{/each}}';
            var documentTeams = [{id: '', teamName: '---------请选择---------'}];
            if (type == 'haveData') {
                for (var i = 0; i < childDocumentTeamList.length; i++) {
                    var childDocumentTeam = childDocumentTeamList[i];
                    documentTeams.push(childDocumentTeam);
                }
            }
            var temp = Handlebars.compile(html);
            var view = temp({documentTeams: documentTeams});
            $teamId.append(view);
        }

        function getDocumentArchiveData() {
            var documentArchiveData = {};
            var documentTeam = {};
            var dicDept = {};
            documentArchiveData.id = $documentArchiveId.val();
            documentArchiveData.fondsNumber = $fondsNumber.val();
            documentArchiveData.catalogNumber = $catalogNumber.val();
            documentArchiveData.fileNumber = $fileNumber.val();
            documentArchiveData.archiveNumber = $archiveNumber.val();
            documentArchiveData.year = $year.val();
            documentArchiveData.retentionPeriod = $retentionPeriod.val();
            documentArchiveData.fileName = $fileName.val();
            documentArchiveData.fileSum = $fileSum.val();
            documentArchiveData.pageSum = $pageSum.val();
            documentArchiveData.compileDate = $compileDate.val();
            documentArchiveData.endDate = $endDate.val();
            documentArchiveData.writer = $writer.val();
            documentArchiveData.secretLevel = $secretLevel.val();
            documentArchiveData.rummager = $rummager.val();
            documentArchiveData.rummagerDate = $rummagerDate.val();
            documentArchiveData.content = $content.val();
            documentArchiveData.notes = $notes.val();

            documentTeam.id =  $teamId.val();
            documentArchiveData.documentTeam = documentTeam;

            dicDept.id = $department.val();
            documentArchiveData.dicDept = dicDept;

            return documentArchiveData;
        }

        var $saveBtn = $("#saveBtn");
        var $backBtn = $("#backBtn");

        var saveUrl = '${basePath}/document-archive/document-archive-save.do';

        $saveBtn.unbind('click').bind('click', function (e) {
            if ($documentArchiveForm.validate().form()) {
                var compileDate = moment($compileDate.val(),'YYYY-MM-DD').toDate();
                var endDate = moment($endDate.val(),'YYYY-MM-DD').toDate();
                if (compileDate > endDate) {
                    G.alert({message : '编制结束日期应大于等于编制日期！'});
                    e.preventDefault();
                } else {
                    var data = getDocumentArchiveData();
                    G.confirm({
                        message: '确认保存此条案卷信息吗？',
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
                                        G.pjaxLoadPageContentDiv('#page/document-archive/document-archive-list');
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
            }
        });

        $documentArchiveForm.tjValidate({
            focusInvalid: true,
            rules: {
                parentTeamId: {required: true},
                teamId: {required: true},
                fondsNumber: {required: true},
                catalogNumber: {required: true},
                fileNumber: {required: true},
                archiveNumber: {required: true},
                year: {required: true},
                retentionPeriod: {required: true},
                fileName: {required: true},
                fileSum: {required: true, digits:true},
                pageSum: {required: true, digits:true},
                deptName: {required: true},
                compileDate: {required: true},
                endDate: {required: true},
                writer: {required: true},
                secretLevel: {required: true},
                rummager: {required: true},
                rummagerDate: {required: true},
                content: {required: true}
            },
            messages: {
                parentTeamId: {required: "案卷分类必须选择"},
                teamId: {required: "叶子节点必须选择"},
                fondsNumber: {required: "全宗号必须填写"},
                catalogNumber: {required: "目录号必须选择"},
                fileNumber: {required: "案卷号必须填写"},
                archiveNumber: {required: "档案号必须填写"},
                year: {required: "年度必须填写"},
                retentionPeriod: {required: "保管期限必须填写"},
                fileName: {required: "案卷题名必须填写"},
                fileSum: {required: "卷内文件份数必须填写"},
                pageSum: {required: "页数必须填写"},
                deptName: {required: "编制单位必须选择"},
                compileDate: {required: "编制日期必须填写"},
                endDate: {required: "编制结束日期必须填写"},
                writer: {required: "立卷人必须填写"},
                secretLevel: {required: "密级必须选择"},
                rummager: {required: "检查人必须填写"},
                rummagerDate: {required: "检查日期必须填写"},
                content: {required: "本卷情况说明必须填写"}
            }
        });

        $backBtn.unbind('click').bind('click', function (e) {
            e.preventDefault();
            var listUrl = '#page/document-archive/document-archive-list';
            var postData = $documentArchiveForm.serializeObject();
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
                    message: "您有案卷信息未保存，确认退出吗？",
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