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
    <%--部门树形结构--%>
    <div class="col-xs-12 col-sm-4" style="padding: 0">
        <!-- #section:pages/search.well -->
        <div class="search-area well well-sm" style="background-color: transparent;height: 630px">
            <div class="widget-box widget-color-blue2" style="margin-top: 0px">
                <div class="widget-header">
                    <h5 class="widget-title bigger lighter" style="color: #000;">
                        部门树形结构
                    </h5>
                </div>
            </div>
            <div class="space-10"></div>
            <%--搜索框--%>
            <form>
                <div class="row">
                    <div class="col-xs-12">
                        <div class="input-group">
                            <input type="text" id="search_value" value="" class="form-control" name="keywords"/>
                            <div class="input-group-btn">
                                <button type="button" class="btn btn-default no-border btn-sm" id="search-bt">
                                    <i class="ace-icon fa fa-search icon-on-right bigger-110"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
            <!-- #section:plugins/fuelux.treeview -->
            <div class="hr hr-dotted"></div>
            <%--树形结构--%>
            <div class="content_wrap">
                <div class="zTreeDemoBackground scrollable left" data-size="500">
                    <ul id="tree1" class="ztree" style="height: 500px"></ul>
                </div>
            </div>
        </div>
        <!-- /section:pages/search.well -->
    </div>
    <%-- 部门信息浏览 --%>
    <div class="col-xs-12 col-sm-8" style="padding: 0">
        <div style="background-color: transparent;height: 630px">
            <div id="detailId" class="profile-user-info profile-user-info-striped" style="height: 630px">

            </div>
        </div>
    </div>
</div>
<%-- ztree添加修改--%>
<div id="edit-dialog" class="hide"></div>
<div id="update-dialog" class="hide"></div>
<script type="text/javascript">

    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {
        //滚动条
        $('.scrollable').each(function () {
            var $this = $(this);
            $(this).ace_scroll({
                size: $this.attr('data-size') || 100
            });
        });

        //zTree变量
        var zTree;
        var $editDialog = $("#edit-dialog");
        var $upDateDialog = $("#update-dialog");

        var setting = {
            view: {
                addHoverDom: addHoverDom,
                removeHoverDom: removeHoverDom,
                fontCss: setHighlight,
                selectedMulti: false
            },
            edit: {
                drag: {
                    isCopy: false,
                    isMove: true,
                    autoExpandTrigger: true,
                    prev: true,
                    inner: false,
                    next: true
                },
                enable: true,
                editNameSelectAll: true,
                showRemoveBtn: showRemoveBtn,
                showRenameBtn: showRenameBtn,
                removeTitle: "删除",
                renameTitle: "编辑"

            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: 'id',
                    pIdKey: 'PId',
                    rootPId: '0'
                }
            },
            callback: {
                beforeEditName: beforeEditName,
                beforeRemove: beforeRemove,
                onClick: zTreeOnClick,
                beforeDrop: zTreeBeforeDrop,
                onDrop: zTreeOnDrop
            }
        };
        //树形结构数据
        var jsonzNode = '${array}';
        var zNodes = JSON.parse(jsonzNode);
        //初始化树形结构
        $(document).ready(function () {
            var tre = $("#tree1");
            $.fn.zTree.init(tre, setting, zNodes);
            zTree = $.fn.zTree.getZTreeObj("tree1");
            var node = zTree.getNodeByParam("id", '${deptCode}', null);
            zTree.expandNode(node, true, false);
            //初始化部门信息
            createTable();
        });

        // 设置高亮字体
        function setHighlight(treeId, treeNode) {
            return (treeNode.highlight) ? {
                color: "green",
                "font-weight": "bold",
                "background-color": "#ddd"
            } : {color: "#000", "font-weight": "normal"};
        }
        //捕获节点被拖拽放下之前的事件回调函数，并且根据返回值确定是否允许拖拽完成（只允许同一父节点下的拖拽排序）
        function zTreeBeforeDrop(treeId, treeNodes, targetNode, moveType) {
            var parentTreeNode = treeNodes[0].getParentNode();
            var parentTargetNode = targetNode.getParentNode();
            if (parentTreeNode.tId !== parentTargetNode.tId) {
                G.alert({message : '只允许在同一父节点下的拖拽排序！'});
                return false;
            }
            return true;
        };
        //拖拽排序结束后的回调（维护seq）
        // function zTreeOnDrop(event, treeId, treeNodes, targetNode, moveType) {
        function zTreeOnDrop(event, treeId, treeNodes) {

            var updateSeqUrl = '${basePath}/dept/update-seq.do';

            var treeObj = $.fn.zTree.getZTreeObj("tree1");
            var node = treeObj.getNodeByTId(treeNodes[0].tId);
            //获取拖拽后节点前一个节点（没有的话preNodeSeq赋值0）
            var preNode = node.getPreNode();
            var preNodeSeq = 0.00;
            if (preNode !== undefined && preNode !== null && preNode !== "") {
                preNodeSeq = preNode.seq;
            }
            //获取拖拽后节点后一个节点(没有的话nextNodeSeq赋值前一个节点+1)
            var nextNodeSeq = preNodeSeq + 1;
            var nextNode = node.getNextNode();
            if (nextNode !== undefined && nextNode !== null && nextNode !== "") {
                nextNodeSeq = nextNode.seq;
            }
            //根据前一节点和后一节点的seq维护当前节点的新seq
            node.seq = (preNodeSeq + nextNodeSeq) / 2;
            treeObj.updateNode(node);
            $.ajax({
                url: updateSeqUrl,
                type: 'POST',
                data: {seq : node.seq,id : node.id},
                dataType: 'json',
                success: function (data) {
                    if (!data.result) {
                        G.showGritterFail("更新部门序列失败！");
                    }
                }
            });
        };

        //查看部门详情
        function zTreeOnClick(event, treeId, treeNode) {
            var $deptId = zTree.getSelectedNodes()[0].id;
            var detailUrl = '${basePath}/dept/dept-view';
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'97_4' eq curOpertate}">
            var loadId = G.showAjaxLoading();
            $.ajax({
                url: detailUrl,
                type: 'POST',
                data: {deptCode: $deptId},
                dataType: 'json',
                success: function (data) {
                    G.doneAjaxLoading(loadId);
                    if (data.result) {
                        var dept = data.dicDept;
                        var ownership = dept.ownership;
                        var property = data.property;
                        var category = data.category;
                        var authType = dept.authType;

                        var deptTree = new Object();
                        deptTree.deptName = dept.deptName;
                        deptTree.deptDscr = dept.deptDscr;
                        deptTree.updEmp = dept.updEmp;
                        deptTree.updDate = dept.updDate;
                        deptTree.ownershipStr = ownership;
                        deptTree.propertyStr = property;
                        deptTree.categoryStr = category;
                        deptTree.authTypeStr = authType;
                        deptTree.postalCode = dept.postalCode;
                        deptTree.tel = dept.tel;
                        deptTree.address = dept.address;
                        viewTables(deptTree);
                    }
                }, error: function () {
                    G.doneAjaxLoading(loadId);
                    G.alert({message: "操作失败！"});
                }
            });

            //点击某个节点 然后将该节点的名称赋值值文本框
            var nodes = zTree.getSelectedNodes(), v = "";
            //根据id排序
            nodes.sort(function compare(a, b) {
                return a.id - b.id;
            });
            for (var i = 0, l = nodes.length; i < l; i++) {
                v += nodes[i].name + ",";
            }
            //将选中节点的名称显示在文本框内
            if (v.length > 0) v = v.substring(0, v.length - 1);
            var dicky = $("#search_value");
            dicky.prop("value", v);
            </c:if>
            </c:forEach>
        }

        //显示删除图标
        function showRemoveBtn(treeId, treeNode) {
            var treeId_ = treeNode.id;
            var flag;
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'97_3' eq curOpertate}">
            if (treeId_.length > 2) {
                flag = true;
            } else {
                flag = false;
            }
            </c:if>
            </c:forEach>
            return flag;
        }

        //显示编辑图标
        function showRenameBtn(treeId, treeNode) {
            var treeId_ = treeNode.id;
            var flag;
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'97_2' eq curOpertate}">
            if (treeId_.length > 2) {
                flag = true;
            } else {
                flag = false;
            }
            </c:if>
            </c:forEach>
            return flag;
        }

        //tree新增 && 显示新增图标
        function addHoverDom(treeId, treeNode) {
            var treeId = treeNode.id;
            <c:forEach items="${curOperateAuth}" var="curOpertate">
            <c:if test="${'97_1' eq curOpertate}">
            if (treeId.length < 10) {
                var sObj = $("#" + treeNode.tId + "_span");
                if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0) return;
                var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
                    + "' title='新增' onfocus='this.blur();'></span>";
                sObj.after(addStr);
                var btn = $("#addBtn_" + treeNode.tId);
                if (btn) btn.bind("click", function () {
                    var treePId = treeNode.PId;
                    exupDate("add", treeId, treePId);
                    return false;
                });
            }
            </c:if>
            </c:forEach>
        };

        //新增图标消失
        function removeHoverDom(treeId, treeNode) {
            $("#addBtn_" + treeNode.tId).unbind().remove();
        };

        //tree编辑
        function beforeEditName(treeId, treeNode) {
            var treeId = treeNode.id;
            var treePId = treeNode.PId;
            exupDate("up", treeId, treePId);
            return false;
        }

        //tree删除
        function beforeRemove(treeId, treeNode) {
            var treeId = treeNode.id;
            var treePId = treeNode.PId;
            exupDate("del", treeId, treePId);
            return false;
        }

        //部门增删改
        function exupDate(upda, treeId, treePId) {
            var psId = treeId;
            var isNode = treePId;
            if (upda == "add") {
                var editUrl = '${basePath}/dept/to-dept-edit.do';
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: editUrl,
                    type: "POST",
                    data: {"deptCode": psId},
                    dataType: "html",
                    success: function (String) {
                        $editDialog.html(String);
                        G.doneAjaxLoading(loadId);
                        initEditDialog($editDialog);
                    },
                    error: function () {
                        G.doneAjaxLoading(loadId);
                        G.showGritterSuccess("操作失败!");
                    }
                });
            } else if (upda == "del") {

                //判断要删除的节点是子节点还是父节点
                var checkNodeUrl = '${basePath}/dept/has-child-dept.do';
                var delUrl = '${basePath}/dept/dept-delete.do';
                var messages = '';
                $.ajax({
                    type: 'post',
                    dataType: 'json',
                    url: checkNodeUrl,
                    data: {deptCode : psId},
                    async: true
                }).done(function (result) {
                    if (result.result) {
                        messages = '此部门下还有其他子部门，确认删除吗？';
                    } else {
                        messages = '确认删除此部门吗？';
                    }
                    G.confirm({
                        message: messages,
                        callback: function (result) {
                            if (result) {
                                $.post(delUrl, {id: psId}, function (data) {
                                    if (data.result) {
                                        G.showGritterSuccess("删除成功!");
                                        var treeNode = data.jsonArray;
                                        $.fn.zTree.init($("#tree1"), setting, treeNode);
                                        zTree = $.fn.zTree.getZTreeObj("tree1");

                                        var dept = data.dicDept;
                                        var property = data.property;
                                        var category = data.category;

                                        var deptTree = new Object();
                                        deptTree.deptName = dept.deptName;
                                        deptTree.deptDscr = dept.deptDscr;
                                        deptTree.updEmp = dept.updEmp;
                                        deptTree.updDate = dept.updDate;
                                        deptTree.ownershipStr = dept.ownership;
                                        deptTree.propertyStr = property;
                                        deptTree.categoryStr = category;
                                        deptTree.authTypeStr = dept.authType;
                                        deptTree.postalCode = dept.postalCode;
                                        deptTree.tel = dept.tel;
                                        deptTree.address = dept.address;
                                        viewTables(deptTree);

                                        var dicky = $("#search_value");
                                        dicky.prop("value", dept.deptName);
                                    }
                                });
                            }
                        }
                    });
                });
            } else if (upda == "up") {
                //修改部门名字
                var updateUrl = '${basePath}/dept/to-dept-update.do';
                var loadId = G.showAjaxLoading();
                $.ajax({
                    url: updateUrl,
                    type: "POST",
                    data: {"deptCode": psId},
                    dataType: "html",
                    success: function (String) {
                        $upDateDialog.html(String);
                        G.doneAjaxLoading(loadId);
                        initupDateDialog($upDateDialog);
                    },
                    error: function () {
                        G.doneAjaxLoading(loadId);
                        G.showGritterSuccess("操作失败!");
                    }
                });
            }
        }

        //初始化新增部门
        function initEditDialog($container) {
            var $form = $("#saveForm");
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>新增部门分组</h4></div>",
                title_html: true,
                close: function () {
                    $container.empty();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            if ($form.validate().form()) {
                                $form.ajaxSubmit({
                                    success: function (map) {
                                        if (map.result) {
                                            G.showGritterSuccess("保存成功!");
                                            $container.dialog("close");
                                            var treeNode = map.jsonArray;
                                            $.fn.zTree.init($("#tree1"), setting, treeNode);
                                            zTree = $.fn.zTree.getZTreeObj("tree1");
                                            var newNode = zTree.getNodeByParam("id", map.code, null);
                                            zTree.expandNode(newNode, true, false);
                                            var dept = map.dicDept;
                                            var property = map.property;
                                            var category = map.category;
                                            editTable(dept, property, category);

                                            var dicky = $("#search_value");
                                            dicky.prop("value", dept.deptName);
                                        } else {
                                            G.showGritterFail("保存失败,请稍后重试!");
                                        }
                                    }
                                });
                            }
                        }
                    }
                ]
            });
        }

        //初始化部门修改页面
        function initupDateDialog($container) {
            var $form = $("#saveForm");
            $container.removeClass('hide').dialog({
                resizable: false,
                height: 'auto',
                width: 800,
                modal: true,
                title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>部门分组修改</h4></div>",
                title_html: true,
                close: function () {
                    $container.empty();
                },
                buttons: [
                    {
                        html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                        "class": "btn btn-warning",
                        click: function () {
                            $container.dialog("close");
                        }
                    },
                    {
                        html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 提交",
                        "class": "btn btn-success",
                        click: function () {
                            if ($form.validate().form()) {
                                $form.ajaxSubmit({
                                    success: function (map) {
                                        if (map.result) {
                                            G.showGritterSuccess("修改成功!");
                                            $container.dialog("close");
                                            var treeNode = map.jsonArray;
                                            $.fn.zTree.init($("#tree1"), setting, treeNode);
                                            zTree = $.fn.zTree.getZTreeObj("tree1");
                                            var newNode = zTree.getNodeByParam("id", map.editCode, null);
                                            zTree.expandNode(newNode, true, false);
                                            var dept = map.dicDept;
                                            var property = map.property;
                                            var category = map.category;
                                            editTable(dept, property, category);

                                            var dicky = $("#search_value");
                                            dicky.prop("value", dept.deptName);
                                        } else {
                                            G.showGritterFail("修改失败,请稍后重试!");
                                        }
                                    }
                                });
                            }
                        }
                    }
                ]
            });
        }

        // 有输入后定时执行一次，如果上次的输入还没有被执行，那么就取消上一次的执行
        var timeoutId = null;
        $("#search-bt").click(function () {
            var searchValue = $("#search_value").val();
            searchNode(searchValue);
        });
        $("#search_value").keyup(function () {
            var searchValue = $("#search_value").val();
            if (timeoutId) {
                clearTimeout(timeoutId);
            }
            timeoutId = setTimeout(function () {
                searchNode(searchValue);
            }, 500);
        });

        // 模糊搜索name满足条件的节点
        function searchNode(value) {
            if (value == "" || value == undefined) return;
            // 获取与value匹配的节点，使用的ztreeAPI getNodesByParamFuzzy
            var nodes = zTree.getNodesByParamFuzzy("name", value);
            // 关闭所有节点的高亮
            // 使用API transformToArray获取所有的节点，getNodes()只能获得根节点，属性children也只能获取下一级节点
            var allNodes = zTree.transformToArray(zTree.getNodes());
            for (var i = 0; i < allNodes.length; i++) {
                // 关闭高亮是利用节点属性highlight来控制fontCss实现的
                // 需要配合setting.view中设置的fontCss使用
                allNodes[i].highlight = false;
                // 更新节点，因为hightlight改变了，使用updateNode可以更新节点
                zTree.updateNode(allNodes[i]);
            }
            // 先关闭所有节点
            zTree.expandAll(false);
            // 高亮并展开搜索到的节点
            for (var i = 0; i < nodes.length; i++) {
                nodes[i].highlight = true;
                zTree.updateNode(nodes[i]); // 更新节点，让高亮生效
                // 展开根节点
//                zTree.expandNode(zTree.getNodes()[0],true);
                // 展开搜索到的节点的父节点
                zTree.expandNode(nodes[i].getParentNode(), true);
            }
        }

        //增删改后部门详情
        function editTable(dept, property, category) {
            var deptTree = new Object();
            deptTree.deptName = dept.deptName;
            deptTree.deptDscr = dept.deptDscr;
            deptTree.updEmp = dept.updEmp;
            deptTree.updDate = dept.updDate;
            deptTree.ownershipStr = dept.ownership;
            deptTree.propertyStr = property;
            deptTree.categoryStr = category;
            deptTree.authTypeStr = dept.authType;
            deptTree.postalCode = dept.postalCode;
            deptTree.tel = dept.tel;
            deptTree.address = dept.address;
            viewTables(deptTree);
        }

        //初始化部门详情
        function createTable() {
            var deptTree = new Object();
            deptTree.deptName = '${dicDept.jsonObject.deptName}';
            deptTree.deptDscr = '${dicDept.jsonObject.deptDscr}';
            deptTree.updEmp = '${dicDept.jsonObject.updEmp}';
            deptTree.updDate = '${dicDept.jsonObject.updDate}';
            deptTree.ownershipStr = '${dicDept.jsonObject.ownership}';
            deptTree.propertyStr = '${property}';
            deptTree.categoryStr = '${category}';
            deptTree.authTypeStr = '${dicDept.jsonObject.authType}';
            deptTree.postalCode = '${dicDept.jsonObject.postalCode}';
            deptTree.tel = '${dicDept.jsonObject.tel}';
            deptTree.address = '${dicDept.jsonObject.address}';
            viewTables(deptTree);
        }

        function judge(ownership, property, category, authType) {
            var obj = new Object();
            if (ownership == '1') {
                obj.ownershipStr = "隶属1";
            } else if (ownership == '2') {
                obj.ownershipStr = "隶属2";
            } else if (ownership == '3') {
                obj.ownershipStr = "隶属3";
            }
            if (property == '1') {
                obj.propertyStr = "机关";
            } else if (property == '2') {
                obj.propertyStr = "事业单位";
            }
            if (category == '1') {
                obj.categoryStr = "类别1";
            } else if (category == '2') {
                obj.categoryStr = "类别2";
            } else if (category == '3') {
                obj.categoryStr = "类别3";
            }
            if (authType == '1') {
                obj.authTypeStr = "编制1";
            } else if (authType == '2') {
                obj.authTypeStr = "编制2";
            } else if (authType == '3') {
                obj.authTypeStr = "编制3";
            }
            return obj;
        }

        function viewTables(dept) {
            //清空原有的数据
            $("#detailId").empty();
            var viewTable = [];
            viewTable.push('<div class="profile-info-row">');
            viewTable.push('<div class="profile-info-name">部门名称</div>');
            viewTable.push('<div class="profile-info-value" style="padding: 18px 4px 6px 6px">');
            viewTable.push('<span class="editable" id="deptName">');
            viewTable.push(dept.deptName);
            viewTable.push('</span></div></div>');

            viewTable.push('<div class="profile-info-row">');
            viewTable.push('<div class="profile-info-name">部门描述</div>');
            viewTable.push('<div class="profile-info-value" style="padding: 18px 4px 6px 6px">');
            viewTable.push('<span class="editable" id="deptDscr">');
            viewTable.push(dept.deptDscr);
            viewTable.push('</span></div></div>');

            viewTable.push('<div class="profile-info-row">');
            viewTable.push('<div class="profile-info-name">更新用户</div>');
            viewTable.push('<div class="profile-info-value" style="padding: 18px 4px 6px 6px">');
            viewTable.push('<span class="editable">');
            viewTable.push(dept.updEmp);
            viewTable.push('</span></div></div>');

            viewTable.push('<div class="profile-info-row">');
            viewTable.push('<div class="profile-info-name">更新时间</div>');
            viewTable.push('<div class="profile-info-value" style="padding: 18px 4px 6px 6px">');
            viewTable.push('<span class="editable">');
            viewTable.push(dept.updDate);
            viewTable.push('</span></div></div>');

            viewTable.push('<div class="profile-info-row">');
            viewTable.push('<div class="profile-info-name">隶属关系</div>');
            viewTable.push('<div class="profile-info-value" style="padding: 18px 4px 6px 6px">');
            viewTable.push('<span class="editable">');
            viewTable.push(dept.ownershipStr);
            viewTable.push('</span></div></div>');

            viewTable.push('<div class="profile-info-row">');
            viewTable.push('<div class="profile-info-name">单位性质</div>');
            viewTable.push('<div class="profile-info-value" style="padding: 18px 4px 6px 6px">');
            viewTable.push(dept.propertyStr);
            viewTable.push('</span></div></div>');

            viewTable.push('<div class="profile-info-row">');
            viewTable.push('<div class="profile-info-name">单位类别</div>');
            viewTable.push('<div class="profile-info-value" style="padding: 18px 4px 6px 6px">');
            viewTable.push('<span class="editable">');
            viewTable.push(dept.categoryStr);
            viewTable.push('</span></div></div>');

            viewTable.push('<div class="profile-info-row">');
            viewTable.push('<div class="profile-info-name">编制类型</div>');
            viewTable.push('<div class="profile-info-value" style="padding: 18px 4px 6px 6px">');
            viewTable.push('<span class="editable">');
            viewTable.push(dept.authTypeStr);
            viewTable.push('</span></div></div>');

            viewTable.push('<div class="profile-info-row">');
            viewTable.push('<div class="profile-info-name">邮政编码</div>');
            viewTable.push('<div class="profile-info-value" style="padding: 18px 4px 6px 6px">');
            viewTable.push('<span class="editable">');
            viewTable.push(dept.postalCode);
            viewTable.push('</span></div></div>');

            viewTable.push('<div class="profile-info-row">');
            viewTable.push('<div class="profile-info-name">部门电话</div>');
            viewTable.push('<div class="profile-info-value" style="padding: 18px 4px 6px 6px">');
            viewTable.push('<span class="editable">');
            viewTable.push(dept.tel);
            viewTable.push('</span></div></div>');

            viewTable.push('<div class="profile-info-row">');
            viewTable.push('<div class="profile-info-name">单位地址</div>');
            viewTable.push('<div class="profile-info-value" style="padding: 18px 4px 6px 6px">');
            viewTable.push('<span class="editable">');
            viewTable.push(dept.address);
            viewTable.push('</span></div></div>');

            $("#detailId").append(viewTable.join(''));
        }

        $(document).one('ajaxloadstart.page', function (e) {
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>

