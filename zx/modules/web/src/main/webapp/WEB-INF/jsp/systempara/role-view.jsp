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

<div class="row">
    <div class="col-xs-12">
        <div class="row">
            <div class="col-sm-5">
                <div class="widget-box widget-color-blue2" style="margin-top: 20px">
                    <div class="widget-header">
                        <h5 class="widget-title bigger lighter">
                            <i class="ace-icon fa fa-table"></i>
                            角色类别
                        </h5>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main padding-8" style="height: 400px">
                            <div class="tab-content padding-8">
                                <div class="tab-pane active">
                                    <ul class="item-list ui-sortable">
                                        <c:forEach items="${dicParaDtlList}" var="para">
                                            <li class="item-blue clearfix ui-sortable-handle">
                                                <label class="inline" style="cursor: pointer" paraId="${para.id}">
                                                    <i class="ace-icon fa fa-globe blue"></i>
                                                    <span class="lbl"> ${para.paraName}</span>
                                                </label>
                                            </li>
                                        </c:forEach>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-sm-7">
                <div class="widget-box widget-color-blue2" style="margin-top: 20px">
                    <div class="widget-header">
                        <h5 class="widget-title bigger lighter">
                            <i class="ace-icon fa fa-check-square-o "></i>
                            功能树
                        </h5>
                    </div>
                    <div class="widget-body">
                        <div class="widget-main padding-8" style="height: 400px">
                            <div class="scrollable" data-size="340">
                                <ul id="dic-view-list" class="ztree"></ul>
                            </div>
                            <div class="hr hr10 hr-dotted"></div>
                            <div class="pull-right">
                                <i class="ace-icon fa fa-hand-o-right icon-animated-hand-pointer blue bigger-150 mar_r_10"></i>
                                <button class="btn btn-mini btn-success" id="save-role">
                                    <i class="ace-icon fa fa-gavel  bigger-120"></i>
                                    保存权限
                                </button>
                            </div>
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

        //滚动条
        $('.scrollable').each(function () {
            var $this = $(this);
            $(this).ace_scroll({
                size: $this.attr('data-size') || 100
                //styleClass: 'scroll-left scroll-margin scroll-thin scroll-dark scroll-light no-track scroll-visible'
            });
        });

        var $dicViewList = $("#dic-view-list");
        var $saveRole = $("#save-role");
        //菜单设置
        var orgSetting ={
            data     : {
                simpleData : {
                    enable : true,
                    idKey  : "id",
                    pIdKey : "pId"
                }
            },
            check:{
                enable : true
            }
        };

        //页面初始化加载函数
        loadLoading();
        function loadLoading(){
            var $loadObj = $("label.inline:eq(0)");
            $loadObj.addClass("blue");
            var id = $loadObj.attr("paraId");
            loadRoleView(id);
        }

        //角色点击
        $("label.inline").click(function(){
            $("label.inline").each(function(){
                var $that = $(this);
                $that.removeClass("blue");
            });
            var $this = $(this);
            $this.addClass("blue");
            var paraId = $this.attr("paraId");
//            $dicViewList.empty();
            loadRoleView(paraId);
        });

        //载入权限
        function loadRoleView(id){
            $.post('${basePath}/role/getRoleView.do', {id: id}, function (response) {
                if (response.result) {
                    var viewIds = response.viewIds;
                    loadSelectView(viewIds)
                }
            })
        }

        //添加已经选中的菜单项
        function loadSelectView(roleViewArray){
            $.fn.zTree.init($dicViewList,orgSetting,roleViewArray);
        }

        //保存权限
        $saveRole.click(function(){
            var $loadObj = $("label.blue");
            var id = $loadObj.attr("paraId");
            var array = getCheckedView();
            if(array.length == 0){
                G.alert({
                    message:"请选择角色权限！"
                })
                return;
            }
            G.confirm({
                message  : '确定修改权限？',
                callback : function (result) {
                    if (result) {

                        $.post('${basePath}/role/saveView.do',{array:array,id:id},function(response){
                            if(response.result){
                                G.showGritterSuccess();
                            }
                        },'json')
                    }
                }
            })
        })

        //获取选择的权限项
        function getCheckedView(){
            var treeObj = $.fn.zTree.getZTreeObj("dic-view-list");
            var nodes = treeObj.getCheckedNodes();
            var array = [];
            for(var i=0, l=nodes.length; i<l; i++){
                var node = nodes[i];
                array.push(node.id);
            }
            return array;
        }
    });
</script>