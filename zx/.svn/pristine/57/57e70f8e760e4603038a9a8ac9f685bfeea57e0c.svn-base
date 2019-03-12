<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>
<link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/chosen.css"/>
<link type="text/css" rel="stylesheet" href="${basePath}/plugin/zTree_v3/css/zTreeStyle/zTreeStyle.css"/>
<script src="${basePath}/plugin/bootstrap-menu/BootstrapMenu.min.js"></script>

<div class="row">
    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-12 widget-container-col ">
                <!-- #section:custom/widget-box -->
                <div class="accordion-style2 accordion">
                    <div class="group group-bottom">
                        <h5 class="group-header accordion-header" style="width: 160px;">
                            <span class="searchTj">
                                查询条件
                            </span>
                        </h5>

                        <div class="widget-body" style="border-top-width: 1px;background: #fff;">
                            <div class="widget-main" >
                                <div class="col-xs-12" >
                                    <form class="form-horizontal" role="form" autocomplete="off" id="searchForm">
                                        <div class="row">
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-parentTeamId">分类：</label>
                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-parentTeamId"
                                                                name="parentTeamId">
                                                            <option value="">-----请选择-----</option>
                                                            <c:forEach items="${parentDocumentTeamList}" var="parentDocumentTeam">
                                                                <option value="${parentDocumentTeam.id}"  <c:if test="${documentArchive.documentTeam.parentId eq parentDocumentTeam.id}">selected</c:if> >${parentDocumentTeam.teamName}</option>
                                                            </c:forEach>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-teamId">叶子节点：</label>

                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-teamId"
                                                                name="teamId">
                                                            <option value="">-----请选择-----</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-fondsNumber">全宗号：</label>

                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="fondsNumber"
                                                               id="form-field-fondsNumber" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-fileNumber">案卷号：</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="fileNumber"
                                                               id="form-field-fileNumber" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-archiveNumber">档案号：</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="archiveNumber"
                                                               id="form-field-archiveNumber" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-catalogNumber">目录号：</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="catalogNumber"
                                                               id="form-field-catalogNumber" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-secretLevel">密级：</label>
                                                    <div class="col-sm-8 ">
                                                        <select class="form-control" id="form-field-secretLevel"
                                                                name="secretLevel">
                                                            <option value="">-----请选择-----</option>
                                                            <option value="0">秘密</option>
                                                            <option value="1">机密</option>
                                                            <option value="2">绝密</option>
                                                        </select>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-fileName">案卷题名：</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="fileName"
                                                               id="form-field-fileName" type="text"/>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label"
                                                           for="form-field-retentionPeriod">保管期限：</label>
                                                    <div class="col-sm-8 ">
                                                        <input class="form-control" name="retentionPeriod"
                                                               id="form-field-retentionPeriod" type="text"/>
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="col-xs-3">
                                                <div class="form-group">
                                                    <label class="col-sm-4 control-label">编制日期: </label>
                                                    <div class="col-sm-8">
                                                        <div class="input-daterange input-group"
                                                             data-date-format="yyyy-mm-dd">
                                                            <input type="text" class="form-control"
                                                                   name="startDate" id="form-field-startDate"/>
                                                            <span class="input-group-addon">
												            <i class="fa fa-exchange"></i>
											                </span>
                                                            <input type="text" class="form-control"
                                                                   name="endDate" id="form-field-endDate"/>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-xs-3 pull-right">
                                                <div class="btn-group pull-right">
                                                    <button class="btn btn-success btn-sm" type="button" id="searchBtn">
                                                        <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                                                        查询
                                                    </button>
                                                    <button class="btn btn-warning btn-sm" type="button" id="resetBtn">
                                                        <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                                                        重置
                                                    </button>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- /section:custom/widget-box -->
            </div>
        </div>
        <div class="row">
            <div class="space-10"></div>
        </div>
        <div class="row">
            <div class="col-xs-12">
                <div class="btn-group pull-right contacts-exportBtn">
                    <c:forEach items="${curOperateAuth}" var="curOpertate">
                        <c:if test="${'67_1' eq curOpertate}">
                            <button class="btn btn-info btn-sm" type="button" id="addBtn" style="top: 6px;right: 155px;">
                                <span class="ace-icon fa fa-plus icon-on-right bigger-110"></span>
                                录入案卷
                            </button>
                        </c:if>
                    </c:forEach>
                    <button class="btn btn-sm btn-primary" id="addParentNodeBtn"
                            style="top: 6px;right: 15px;">
                        <i class="ace-icon fa fa-folder-open  bigger-110"></i>
                        添加目录节点
                    </button>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-xs-2" style="padding-right: 0px">
                <div class="widget-box widget-color-blue2" style="margin-top: 0px">
                    <div class="widget-header">
                        <h5 class="widget-title bigger lighter" style="color: #000;">
                            案卷分类
                        </h5>
                    </div>
                    <div class="widget-body">
                        <div class="content_wrap">
                            <div class="scrollable left" data-size="685">
                                <ul id="document-team-list" class="ztree" style="height: 685px"></ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xs-10">
                <div class="header-table-th">档案资料列表</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="grid-table"></table>
                    </div>
                </div>
            </div>
            <div class="col-xs-10">
                <div class="header-table-th">文件信息列表</div>
                <div class="table-content col-md-12">
                    <div class="col-md-12" style="padding: 0px;background: #fff;">
                        <table id="file-grid-table"></table>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
<div id="add-parent-node-dialog" class="hidden">
    <form id="addParentNodeForm" role="form">
        <input style="display: none;"/>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right">
                        父节点名称：<span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <input type="text" id="parentTeamName" name="parentTeamName"
                               class="form-control"/>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="add-leaf-node-dialog" class="hidden">
    <form id="addLeafNodeForm" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right">
                        叶子节点名称：<span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <input type="text" id="leafTeamName" name="leafTeamName"
                               class="form-control"/>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="update-node-dialog" class="hidden">
    <form id="updateNodeForm" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right">
                        节点名称：<span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <input type="text" id="teamName" name="teamName"
                               class="form-control"/>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        var initParam = G.initGridParam($("#searchForm"));


        $('.input-daterange').datepicker({autoclose: true, todayHighlight: true});

        //滚动条
        $('.scrollable').each(function () {
            var $this = $(this);
            $(this).ace_scroll({
                size: $this.attr('data-size') || 100
            });
        });

        //页面初始化时右键菜单移除初始化
        $(".bootstrapMenu").remove();

        $(".accordion").accordion({
            collapsible: false,
            active: false,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        var $documentTeamList = $('#document-team-list');

        var tempTreeNode;//菜单节点(点击时获取当前节点信息)
        var zTreeObj;//选中节点信息
        //菜单设置
        var zTreeSetting = {
            data: {
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdKey: "pId",
                    rootId: null
                }
            },
            callback: {
                onClick: zTreeOnClick,
                beforeRightClick: zTreeBeforeRightClick
            }
        };

        showZTreeData();

        function showZTreeData() {
            $.fn.zTree.init($documentTeamList, zTreeSetting, ${zTreeData});
            zTreeObj = $.fn.zTree.getZTreeObj('document-team-list');
        }

        function zTreeOnClick(event, treeId, treeNode) {
            var teamId = zTreeObj.getSelectedNodes()[0].id;
            var parentId = zTreeObj.getSelectedNodes()[0].pId;

            if (parentId === null) {
                $parentTeamId.val(teamId);
            } else {
                $parentTeamId.val(parentId);
                $teamId.val(parentId);
            }
            $parentTeamId.trigger('change');

            $gridTable.tjGrid('setPostData', {
                type: 'tree',
                teamId: teamId,
                parentId: parentId
            });
            $fileGridTable.tjGrid('setPostData', {
                type: 'tree',
                teamId: teamId,
                parentId: parentId
            });
            reloadGrid();
        }

        function zTreeBeforeRightClick(event, treeNode) {
            tempTreeNode = treeNode;
        }

        rightMenu('.level0');
        rightMenu('.level1');

        function rightMenu($target) {
            //$(".bootstrapMenu").remove();
            var addParentNode = {
                name: '添加目录节点',
                iconClass: 'ace-icon fa fa-folder-open orange',
                onClick: function () {
                    openAddParentNodeDialog();
                }
            };
            var addLeafNode = {
                name: '添加叶子节点',
                iconClass: 'ace-icon fa fa-leaf green',
                onClick: function (tempTreeNode) {
                    var parentId = tempTreeNode.id;
                    openAddLeafNodeDialog(parentId);
                }
            };
            var updateNodeName = {
                name: '修改节点名称',
                iconClass: 'ace-icon fa fa-pencil blue',
                onClick: function (tempTreeNode) {
                    var parentId = tempTreeNode.pId;
                    var nodeId = tempTreeNode.id;
                    var teamName = tempTreeNode.name;
                    if (parentId == null) {//父节点
                        openUpdateNodeDialog(nodeId, teamName);
                    } else {//子节点
                        openUpdateNodeDialog(nodeId, teamName);
                    }
                }
            };
            var deleteNode = {
                name: '删除该节点',
                iconClass: 'ace-icon fa fa-trash-o red',
                onClick: function (tempTreeNode) {
                    var parentId = tempTreeNode.pId;
                    var nodeId = tempTreeNode.id;
                    if (parentId == null) {//父节点
                        G.confirm({
                            message: '确认删除该目录节点吗?',
                            callback: function (result) {
                                if (result) {
                                    deleteNodeInfo(nodeId, 'parent');
                                }
                            }
                        });
                    } else {//子节点
                        G.confirm({
                            message: '确认删除该叶子节点吗?',
                            callback: function (result) {
                                if (result) {
                                    deleteNodeInfo(nodeId, 'child');
                                }
                            }
                        });
                    }
                }
            };

            if ($target == '.level0') {
                var actions = [addParentNode, addLeafNode, updateNodeName, deleteNode];
            } else if ($target == '.level1') {
                var actions = [updateNodeName, deleteNode];
            }

            var menu = new BootstrapMenu($target, {
                fetchElementData: function () {
                    return tempTreeNode;
                },
                actions: actions
            });
        }

        /*----------添加目录节点start----------*/
        var $addParentNodeBtn = $('#addParentNodeBtn');
        var $addParentNodeDialog = $('#add-parent-node-dialog');
        var $addParentNodeForm = $('#addParentNodeForm');
        var $parentTeamName = $('#parentTeamName');

        $addParentNodeBtn.click(function () {
            openAddParentNodeDialog();
        });

        function openAddParentNodeDialog() {
            $addParentNodeDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 200,
                width: 400,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-folder-open orange'></i>增加目录节点</div>",
                title_html: true,
                close: function () {
                    $addParentNodeForm.resetForm();
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
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            var $this = $(this);
                            if($addParentNodeForm.validate().form()) {
                                var url = '${basePath}/document-archive/add-parent-node.do';
                                $.post(url, {teamName: $parentTeamName.val()}, function (response) {
                                    if (response.result == true) {
                                        G.alertSuccess({message: '添加成功!'});
                                        $this.dialog("close");
                                        G.pjaxLoadPageContentDiv('#page/document-archive/document-archive-list');
                                        $(".bootstrapMenu").remove();
                                    } else {
                                        G.alert({message: '添加失败!'});
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            $addParentNodeDialog.dialog('open');
        }

        $addParentNodeForm.tjValidate({
            focusInvalid: true,
            rules: {
                parentTeamName: {required: true}
            },
            messages: {
                parentTeamName: {required: "父节点名称必须填写"}
            }
        });
        /*----------添加目录节点end----------*/

        /*----------添加叶子节点start----------*/
        var $addLeafNodeDialog = $('#add-leaf-node-dialog');
        var $addLeafNodeForm = $('#addLeafNodeForm');
        var $leafTeamName = $('#leafTeamName');

        function openAddLeafNodeDialog(parentId) {
            $addLeafNodeDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 200,
                width: 400,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-leaf green'></i>增加叶子节点</div>",
                title_html: true,
                close: function () {
                    $addLeafNodeForm.resetForm();
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
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            var $this = $(this);
                            if($addLeafNodeForm.validate().form()) {
                                var url = '${basePath}/document-archive/add-child-node.do';
                                $.post(url, {parentId: parentId, teamName: $leafTeamName.val()}, function (response) {
                                    if (response.result == true) {
                                        G.alertSuccess({message: '添加成功!'});
                                        $this.dialog("close");
                                        G.pjaxLoadPageContentDiv('#page/document-archive/document-archive-list');
                                        $(".bootstrapMenu").remove();
                                    } else {
                                        G.alert({message: '添加失败!'});
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            $addLeafNodeDialog.dialog('open');
        }

        $addLeafNodeForm.tjValidate({
            focusInvalid: true,
            rules: {
                leafTeamName: {required: true}
            },
            messages: {
                leafTeamName: {required: "叶子节点名称必须填写"}
            }
        });
        /*----------添加叶子节点end----------*/

        /*----------修改节点名称start----------*/
        var $updateNodeDialog = $('#update-node-dialog');
        var $updateNodeForm = $('#updateNodeForm');
        var $teamName = $('#teamName');

        function openUpdateNodeDialog(nodeId, teamName) {
            $teamName.val(teamName);
            $updateNodeDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 200,
                width: 400,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-pencil blue'></i>修改节点名称</div>",
                title_html: true,
                close: function () {
                    $updateNodeForm.resetForm();
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
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                        "class": "btn btn-success",
                        click: function () {
                            var $this = $(this);
                            if($updateNodeForm.validate().form()) {
                                var url = '${basePath}/document-archive/update-node-name.do';
                                $.post(url, {nodeId: nodeId, teamName: $teamName.val()}, function (response) {
                                    if (response.result == 'noChange') {
                                        G.alert({message: '请修改节点名称!'});
                                    } else if (response.result == true) {
                                        G.alertSuccess({message: '修改成功!'});
                                        $this.dialog("close");
                                        G.pjaxLoadPageContentDiv('#page/document-archive/document-archive-list');
                                        $(".bootstrapMenu").remove();
                                    } else {
                                        G.alert({message: '修改失败!'});
                                    }
                                });
                            }
                        }
                    }
                ]
            });
            $updateNodeDialog.dialog('open');
        }

        $updateNodeForm.tjValidate({
            focusInvalid: true,
            rules: {
                teamName: {required: true}
            },
            messages: {
                teamName: {required: "节点名称必须填写"}
            }
        });
        /*----------修改节点名称end----------*/

        /*----------删除节点start----------*/
        function deleteNodeInfo(nodeId, nodeType) {
            var url = '${basePath}/document-archive/delete-node.do';
            $.post(url, {nodeId: nodeId, nodeType: nodeType}, function (response) {
                if (response.result == 'existChild') {
                    G.alert({message: '删除失败!该节点下存在叶子节点!'});
                } else if (response.result == 'existData') {
                    G.alert({message: '删除失败!该节点下存在案卷信息!'});
                } else if (response.result == true) {
                    G.alertSuccess({message: '删除成功!'});
                    G.pjaxLoadPageContentDiv('#page/document-archive/document-archive-list');
                    $(".bootstrapMenu").remove();
                } else {
                    G.alert({message: '删除失败!'});
                }
            });
        }
        /*----------删除节点end----------*/

        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        var $addBtn = $("#addBtn");

        var $searchForm = $("#searchForm");
        var $gridTable = $("#grid-table");
        var $fileGridTable = $("#file-grid-table");

        var loadUrl = '${basePath}/document-archive/load-document-archive-list.do';
        var fileLoadUrl = '${basePath}/document/load-document-list.do';
        var editUrl = '#page/document-archive/document-archive-edit';
        var fileEditUrl = '#page/document/document-edit';
        var viewUrl = '#page/document-archive/document-archive-view';
        var fileViewUrl = '#page/document/document-view';
        var deleteUrl = '${basePath}/document-archive/document-archive-delete.do';
        var fileDeleteUrl = '${basePath}/document/document-delete.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'teamName', header: '分类', index: 'teamName', sortable: true},
            {name: 'fondsNumber', header: '全宗号', index: 'fondsNumber', sortable: true},
            {name: 'catalogNumber', header: '目录号', index: 'catalogNumber', sortable: true, hidden: true},
            {name: 'fileNumber', header: '案卷号', index: 'fileNumber', sortable: true},
            {name: 'archiveNumber', header: '档案号', index: 'archiveNumber', sortable: true},
            {name: 'year', header: '年度', index: 'year', sortable: true, width:100},
            {name: 'retentionPeriod', header: '保管期限', index: 'retentionPeriod', sortable: true, hidden: true},
            {name: 'fileName', header: '案卷题名', index: 'fileName', sortable: true, hidden: true},
            {name: 'secretLevel', header: '密级', index: 'secretLevel', sortable: true, hidden: true},
            {name: 'compileDate', header: '编制日期', index: 'compileDate', sortable: true, width:200},
            {name: 'pageSum', header: '页数', index: 'pageSum', sortable: true, hidden: true},
            {
                header: '密级',
                sortable: false,
                editable: false,
                width:150,
                formatter: statusFormatter
            },
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 210,
                fixed: true,
                formatter: basicOperationFormatter
            },
            {
                name: 'work',
                header: '业务操作',
                sortable: false,
                width: 120,
                fixed: true,
                formatter: workOperationFormatter
            }
        ];

        var fileColModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'archiveNumber', header: '档案号', index: 'archiveNumber', sortable: true},
            {name: 'documentNumber', header: '文件编号', index: 'documentNumber', sortable: true},
            {name: 'documentName', header: '文件提名', index: 'documentName', sortable: true, hidden: true},
            {name: 'dutyPerson', header: '责任人', index: 'dutyPerson', sortable: true},
            {name: 'formationDate', header: '文件形成日期', index: 'formationDate', sortable: true, width:200},
            {name: 'pageNumber', header: '页号', index: 'pageNumber', sortable: true},
            {name: 'fileNames', header: '附件', index: 'fileNames', sortable: true, hidden: true},
            {name: 'dmId', header: '档案资料Id', index: 'dmId', sortable: false, hidden: true},
            {
                name: 'basic',
                header: '附件',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: fileNamesFormatter
            },
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: fileBasicOperationFormatter
            }
        ];

        function fileNamesFormatter(cellvalue, options, rowData, action) {
            var fileNames = rowData.fileNames;
            var operations = [];
            operations.push("<span class='blue bolder'>" + fileNames + "</span>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function statusFormatter(cellvalue, options, rowData, action) {
            var secretLevel = rowData.secretLevel;
            var operations = [];
            if ('0' == secretLevel) {
                operations.push("<span class='label label-warning arrowed arrowed-right'>" + '秘密' + "</span>");
            } else if ('1' == secretLevel) {
                operations.push("<span class='label label-danger arrowed arrowed-right'>" + '机密' + "</span>");
            } else if ('2' == secretLevel) {
                operations.push("<span class='label label-inverse arrowed arrowed-right'>" + '绝密' + "</span>");
            }
            cellvalue = operations.join('');
            return cellvalue;
        }

        function basicOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'67_2' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'67_3' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'67_4' eq curOpertate}">
            operations.push(' <button class="btn btn-minier btn-white btn-danger row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue row-record-delete"></i> 删除');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function workOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'67_5' eq curOpertate}">
            operations.push(' <button title="录入文件" class="btn btn-minier btn-white btn-primary row-record-file">');
            operations.push('<i class="ace-icon fa fa-upload blue row-record-file"></i> 录入文件');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        function fileBasicOperationFormatter(cellvalue, options, rowData, action) {
            var operations = [];
            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'67_6' eq curOpertate}">
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary file-row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue file-row-record-view"></i> 查看');
            operations.push('</button>');
            </c:if>
            <c:if test="${'67_7' eq curOpertate}">
            operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple file-row-record-edit">');
            operations.push('<i class="ace-icon fa fa-pencil blue file-row-record-edit"></i> 编辑');
            operations.push('</button>');
            </c:if>
            <c:if test="${'67_8' eq curOpertate}">
            operations.push(' <button class="btn btn-minier btn-white btn-danger file-row-record-delete">');
            operations.push(' <i class="ace-icon orange fa fa-trash-o blue file-row-record-delete"></i> 删除');
            operations.push('</button>');
            </c:if>
            </c:forEach>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            initParam: initParam,
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'updateTime',
            sortorder: 'desc',
            // caption: "档案资料列表",
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }

                if (className.indexOf('row-record-view') !== -1) {
                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm, $gridTable);
                    }
                    var viewHash = viewUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(viewHash);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条档案资料信息吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrl, {id: id}, function (data) {
                                    if (data.result == 'existDocument') {
                                        G.alert({message: '当前档案资料存在文件信息!请先删除文件信息!'})
                                    } else if (data.result == true) {
                                        $gridTable.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('row-record-edit') !== -1) {
                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm, $gridTable);
                    }
                    var editHash = editUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(editHash);
                } else if (className.indexOf('row-record-file') !== -1) {
                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm, $gridTable);
                    }
                    var fileEditHash = fileEditUrl + "?dmId=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(fileEditHash);
                }
            }
        });

        $fileGridTable.tjGrid({
            initParam: initParam,
            loadUrl: fileLoadUrl,
            height: '100%',
            autowidth: true,
            colModel: fileColModel,
            sortname: 'updateTime',
            sortorder: 'desc',
            // caption: "文件信息列表",
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $fileGridTable.jqGrid('getRowData', id);

                if (className.indexOf('file-row-record-view') !== -1) {
                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm, $fileGridTable);
                    }
                    var fileViewHash = fileViewUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(fileViewHash);
                } else if (className.indexOf('file-row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除此条档案资料文件信息吗？',
                        callback: function (result) {
                            if (result) {
                                $.post(fileDeleteUrl, {id: id}, function (data) {
                                    if (data.result) {
                                        $fileGridTable.tjGrid('reloadGrid');
                                    }
                                });
                            }
                        }
                    });
                } else if (className.indexOf('file-row-record-edit') !== -1) {
                    if (initParam !== undefined) {
                        G.keepGridParam($searchForm, $fileGridTable);
                    }
                    var dmId = rowData.dmId;
                    var fileEditHash = fileEditUrl + "?id=" + id + "&dmId=" + dmId + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(fileEditHash);
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        $fileGridTable.tjGrid("triggerResizeGrid");

        var $parentTeamId = $('#form-field-parentTeamId');
        var $teamId = $('#form-field-teamId');
        var $fondsNumber = $('#form-field-fondsNumber');
        var $fileNumber = $('#form-field-fileNumber');
        var $archiveNumber = $('#form-field-archiveNumber');
        var $catalogNumber = $('#form-field-catalogNumber');
        var $secretLevel = $('#form-field-secretLevel');
        var $fileName = $('#form-field-fileName');
        var $retentionPeriod = $('#form-field-retentionPeriod');
        var $startTime = $('#form-field-startDate');
        var $endTime = $('#form-field-endDate');

        $parentTeamId.change(function () {
            var parentTeamId = $parentTeamId.val();
            if ('' != parentTeamId) {
                findChildNodeByParentId();
            } else {
                renderChildDocumentTeam(null, 'noData');
            }
            search();
        });

        //案卷分类改变时查找叶子节点
        function findChildNodeByParentId() {
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
                    }
                }
            });
        }

        //叶子节点下拉列表生成
        function renderChildDocumentTeam(childDocumentTeamList, type) {
            $teamId.empty();
            var html = '{{#each documentTeams}}<option value="{{id}}">{{teamName}}</option>{{/each}}';
            var documentTeams = [{id: '', teamName: '-----请选择-----'}];
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

        $searchBtn.click(function () {
            search();
        });

        function search() {
            $gridTable.tjGrid('setPostData', {
                type: 'search',
                teamId: $teamId.val(),
                parentId: $parentTeamId.val(),
                fondsNumber: $fondsNumber.val(),
                fileNumber: $fileNumber.val(),
                archiveNumber: $archiveNumber.val(),
                catalogNumber: $catalogNumber.val(),
                secretLevel: $secretLevel.val(),
                fileName: $fileName.val(),
                retentionPeriod: $retentionPeriod.val(),
                startTime: $startTime.val(),
                endTime: $endTime.val()
            });
            $fileGridTable.tjGrid('setPostData', {
                type: 'search',
                teamId: $teamId.val(),
                parentId: $parentTeamId.val(),
                fondsNumber: $fondsNumber.val(),
                fileNumber: $fileNumber.val(),
                archiveNumber: $archiveNumber.val(),
                catalogNumber: $catalogNumber.val(),
                secretLevel: $secretLevel.val(),
                fileName: $fileName.val(),
                retentionPeriod: $retentionPeriod.val(),
                startTime: $startTime.val(),
                endTime: $endTime.val()
            });
            reloadGrid();
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
            $fileGridTable.tjGrid('reloadGrid');
        }

        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });

        $addBtn.click(function () {
            G.pjaxLoadPageContentDiv(editUrl);
        });

        $(document).one('ajaxloadstart.page', function (e) {
            $.jgrid.gridDestroy("#grid-table");
            $.jgrid.gridDestroy("#file-grid-table");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });

    });
</script>