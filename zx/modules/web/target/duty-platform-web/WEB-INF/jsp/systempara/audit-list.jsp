<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
  String path = request.getContextPath();
  String basePath =  path;
  pageContext.setAttribute("basePath", basePath);
%>

<title>履职支撑平台</title>
<link rel="stylesheet" href="${basePath}/plugin/ace/assets/css/chosen.css"/>

<div style="background-color: white;">

  <div class="boxcenter position_r">
    <div class="positionimg"><img src="${basePath}/images/index/qxj_arrow2.png" width="28" height="29"/></div>
    <div class="positioninfo" style="color: #000000;">您的当前位置：系统用户管理
      <i class="ace-icon fa fa-angle-double-right"></i>
      <small style="color: cornflowerblue;">
        证书审核
      </small>
    </div>
  </div>

  <%--前空行--%>
  <div class="row">
    <div class="space-20"></div>
    <div class="space-20"></div>
  </div>

  <div class="row">
    <div class="col-xs-12">
      <div class="row">
        <div class="col-xs-12 widget-container-col ">
          <!-- #section:custom/widget-box -->
          <div class="accordion-style2 accordion">
            <div class="group group-bottom">
              <h5 class="accordion-header">
                查询条件
                <i class="ace-icon glyphicon glyphicon-zoom-in orange"></i>
              </h5>

              <div class="widget-body">
                <div class="widget-main">
                  <div class="col-xs-12">
                    <form class="form-horizontal" id="searchForm">

                      <div class="form-group">

                        <%--<label class="col-xs-2 control-label no-padding-left">所属机构：</label>--%>

                        <%--<div class="col-xs-2 ">--%>
                          <%--<select id="search-orgId" name="emType" class="form-control">--%>
                            <%--<option value="A">全部</option>--%>
                            <%--<c:forEach items="${dicOrgList}" var="org">--%>
                              <%--<c:if test="${org.id == org.parentId}">--%>
                                <%--<option value="${org.id}" <c:if test="${org.id == orgId}">selected</c:if>--%>
                                        <%-->--%>
                                    <%--${org.orgName}</option>--%>
                              <%--</c:if>--%>
                              <%--<c:if test="${org.id != org.parentId}">--%>
                                <%--<option value="${org.id}" <c:if test="${org.id == orgId}">selected</c:if>--%>
                                        <%-->&nbsp;&nbsp;&nbsp;&nbsp;${org.orgName}</option>--%>
                              <%--</c:if>--%>
                            <%--</c:forEach>--%>
                          <%--</select>--%>
                        <%--</div>--%>
                        <label class="col-xs-2 control-label no-padding-left">用户姓名：</label>

                        <div class="col-xs-2 ">
                          <input class="form-control" type="text" id="search-empName">
                        </div>

                        <label class="col-xs-2 control-label no-padding-left">登录名：</label>

                        <div class="col-xs-2 ">
                          <input class="form-control" type="text" id="search-userId">
                        </div>
                      </div>
                      <div class="form-group">
                        <div class="center">
                          <button class="btn btn-success btn-sm" type="button"
                                  id="searchBtn">
                            <span class="ace-icon fa fa-search icon-on-right bigger-110"></span>
                            查询
                          </button>
                          <button class="btn btn-warning btn-sm " type="button" id="resetBtn">
                            <span class="ace-icon fa fa-retweet icon-on-right bigger-110"></span>
                            重置
                          </button>
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
  </div>
    <div class="row">
      <div class="col-xs-12" style="z-index: 0;">
        <table id="grid-table"></table>
      </div>
    </div>
  <%--后空行--%>
  <div class="row">
    <div class="space-30"></div>
  </div>
</div>

  <div class="row">
    <div class="col-xs-12">
      <div id="audit-dialog" class="hide">
        <div class="col-xs-12">
          <div class="col-sm-6">
            <div class="widget-box widget-color-blue2" style="margin-top: 20px">
              <div class="widget-header">
                <h5 class="widget-title bigger lighter">
                  <i class="ace-icon fa fa-table"></i>
                  角色列表
                </h5>
              </div>
              <div class="widget-body">
                <div class="widget-main padding-8" style="height: 350px">
                  <ul id="role-list" class="scrollable pro-ul" data-size="345">

                  </ul>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-6">
            <div class="widget-box widget-color-blue2" style="margin-top: 20px">
              <div class="widget-header">
                <h5 class="widget-title bigger lighter">
                  <i class="ace-icon fa fa-check-square-o "></i>
                  已选角色
                </h5>
              </div>
              <div class="widget-body">
                <div class="widget-main padding-8" style="height: 350px">
                  <input type="hidden" id="checked-role-name" name="userRoles">
                  <input type="hidden" id="checked-role-id" name="roleIds">
                  <ul id="checked-role-list" class="scrollable pro-ul"
                      data-size="345">

                  </ul>
                </div>
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

    G.datepicker();
    $(".accordion").accordion({
      collapsible: true,
      active: true,
      heightStyle: "content",
      animate: 250,
      header: ".accordion-header"
    });
    //滚动条
    $('.scrollable').each(function () {
      var $this = $(this);
      $(this).ace_scroll({
        size: $this.attr('data-size') || 100
        //styleClass: 'scroll-left scroll-margin scroll-thin scroll-dark scroll-light no-track scroll-visible'
      });
    });

    //查询
    var $searchOrgId = $("#search-orgId");
    var $searchEmpName = $("#search-empName");
    var $searchUserId = $("#search-userId");
    var $searchBtn = $("#searchBtn");


    //grid
    var $gridTable = $('#grid-table');

    //新增
    var $addNewUser = $("#add-new-user");
    var $orgId = $("#org-id");
    var $deptId = $("#dept-id");
    var $profession = $("#profession");
    var $professionId = $("#profession-id");
    var $professionDialog = $("#profession-dialog");
    var $roleList = $("#role-list");
    var $checkedRoleList = $("#checked-role-list");
    var $checkedRoleName = $("#checked-role-name");
    var $checkedRoleId = $("#checked-role-id");
    var $userId = $("#userId");//登录名
    var $user = $("#user-id");//用户id
    var $roleName =$("#role-name");//用户姓名
    var $email =$("#email");//邮箱
    var $mobile =$("#mobile");//手机
    var $fax =$("#fax");//传真
//        var $password =$("#password");//密码
    var $professionalId =$("#professionalId");//专业类别
    var $phone =$("#phone");//办公电话
    var $position =$("#position");//单位职务
    var $notes =$("#notes");//NOTES
    var $passwordDiv =$("#password-div");
    var $userCancel =$("#user-cancel");
    var $auditDialog = $('#audit-dialog');


    var colModel = [
      {name: 'id', header: 'id', hidden: true},
      {name: 'empName', header: '用户姓名', width: 80},
      {name: 'orgName', header: '所属机构', sortable: false, width: 80},
      {name: 'dicDept',header: '所属部门', sortable: false, width: 80},
      {name: 'userId', header: '登录名称', sortable: false, width: 60},
      {name: 'dutynames',header: '人员职责', sortable: false, width: 130},
      {name: 'isactive', header: '激活状态', width: 70, formatter: isActiveFormatter},
      {name: 'op', header: '操作', width: 70, sortable: false, formatter: operationFormatter}

    ];

    function operationFormatter(cellvalue, options, rowData, action) {
      cellvalue = '';
      var isactive = rowData.isactive;
      var accordFlag = rowData.accordFlag;
      var operations = [];
      operations.push(' <button class="btn btn-minier btn-success auditUser">');
      operations.push('<i class="ace-icon fa fa-pencil bigger-120"></i> 审核');
      operations.push('</button>');
      cellvalue = operations.join('');
      return cellvalue;
    }

    function isActiveFormatter(cellvalue, options, rowData, action) {
      cellvalue = '';
      var isactive = rowData.isactive;

      var operations = [];


        operations.push('<span class="label label-sm  arrowed arrowed-right label-primary">待审核</span>');

      operations.push('</div>');
      cellvalue = operations.join('');
      return cellvalue;
    }

    $gridTable.tjGrid({
      loadUrl: '${basePath}/audit/load.do',
      height: '100%',
      width: 970,
      colModel: colModel,
      sortname: 'createDate',
      sortorder: 'desc',
      caption: "待审核信息",
      onSelectRow: function (id, stat, e) {
        var className = $(e.target).attr('class');
        if (!className) {
          return false;
        }
        if (className.indexOf('auditUser') != -1) {
          $.post('${basePath}/audit/getRole.do', {id: id}, function (response) {
            if (response.result) {
              var secRoleList = response.secRoleList;
              openAuditDialog(id,secRoleList)
            }
          });
        }
      },
      gridComplete: function () {
        $('[data-rel="popover"]').popover({html: true});

          //调整表格宽度
          var parent_column = $gridTable.closest('[class*="col-"]');
          $gridTable.tjGrid("triggerResizeGrid");
          $gridTable.closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
      }
    });

    $gridTable.tjGrid('bindResizeGrid');

    function reloadGrid() {
      $gridTable.tjGrid('reloadGrid');
    }

    $searchBtn.click(function () {
      search();
    });

    var $searchForm = $("#searchForm");
    var $resetBtn = $("#resetBtn");
    $resetBtn.click(function () {
      $searchForm.resetForm();
      search();
    });

    function search() {
      var searchUserId = $searchUserId.val(),
              searchEmpName = $searchEmpName.val();
      $gridTable.tjGrid('setPostData', {
        empName: searchEmpName,
        searchUserId: searchUserId
      });
      reloadGrid();
    }

    $('#modal-user .wizard-actions .btn[data-dismiss=modal]').removeAttr('disabled');


    function clearPreviousValue(){
      if($(".remote").data("previousValue")){
        $(".remote").removeData("previousValue");
      }
    };


    function checkedRole(){
      var roleIds = $checkedRoleId.val();
      if(roleIds!= ''){
        var roleIdArry = roleIds.split(",");
        $("#role-list").find('input[name="role-check"]').each(function () {
          var $this = $(this);
          var value = $this.val();
          for(var i=0; i<roleIdArry.length;i++){
            if(value == roleIdArry[i]){
              $this.prop("checked",true)
            }
          }
        });
      }
    }

    //角色信息checkbox选择事件
    function clickRoleView() {
      $('input[name="role-check"]').click(function () {
        var dataArray = [];
        var dataIds = [];
        var dataNames = [];
        $("#role-list").find('input[name="role-check"]').each(function () {
          var $this = $(this);
          if ($this.prop("checked")) {
            var value = $this.val();
            var proname = $this.attr("proname");
            dataArray.push({
              id: value,
              roleName: proname
            })
            dataIds.push(value);
            dataNames.push(proname);
          }
        });
        $checkedRoleName.val(dataNames.join(','));
        $checkedRoleId.val(dataIds.join(','));
        appendCheckedRoleView(dataArray);
      });
    }

    //展示选中角色
    function appendCheckedRoleView(dataArray) {
      $checkedRoleList.empty();
      var html = [];
      for (var i =0;i< dataArray.length;i++) {
        var role = dataArray[i];
        html.push('<li class="roleView" style="cursor: pointer" roleId="' + role.id + '" roleName ="' + role.roleName + '">');
        html.push('<label>');
        html.push('<span class="lbl"> <i class="ace-icon fa fa-user green"></i>&nbsp;' + role.roleName + '</span>');
        html.push('</label>');
        html.push('</li>');
      }
      $checkedRoleList.append(html.join(''));
      uncheckRoleView();
    }

    //单机取消选中角色
    function uncheckRoleView() {
      $(".roleView").click(function () {
        var $this = $(this);
        var roleId = $this.attr("roleId");
        var dataIds = [];
        var dataNames = [];
        $("#role-list").find('input[name="role-check"]').each(function () {
          var $this = $(this);
          if ($this.prop("checked")) {
            var value = $this.val();
            var roleName = $this.attr('proname');
            if (value == roleId) {
              $this.prop("checked", false);
            } else {
              dataIds.push(value);
              dataNames.push(roleName);
            }

          }
        });
        $this.remove();
        $checkedRoleName.val(dataNames.join(','));
        $checkedRoleId.val(dataIds.join(','));
      })
    }

    function saveRole(id){
        var userRoles = $checkedRoleName.val();
        var roleIds = $checkedRoleId.val();
        var data = {
          id:id,
          userRoles:userRoles,
          roleIds:roleIds
        };
        $.post('${basePath}/audit/saveRole.do',data,function(response){
          if(response.result){
            $auditDialog.dialog('close');
            reloadGrid();
            G.showGritterSuccess();
          }
          else {
            $auditDialog.dialog("close");
            G.showGritterFail();
          }
        },'json')

    }

    function openAuditDialog(id,roleList) {
      $roleList.empty();
      var html = [];
      for (var i=0; i< roleList.length;i++) {
        var role = roleList[i];
        html.push('<li>');
        html.push('<div class="checkbox ">');
        html.push('<label>');
        html.push('<input value=' + role.id + ' proname=' + role.roleName + ' name="role-check" class="ace" type="checkbox">');
        html.push('<span class="lbl"> <i class="ace-icon fa fa-user blue"></i>&nbsp;' + role.roleName + '</span>');
        html.push('</label>');
        html.push('</div>');
        html.push('</li>');
      }
      $roleList.append(html.join(''));
      clickRoleView();
      checkedRole();
      $auditDialog.removeClass('hide').dialog({
        resizable: false,
        height: 600,
        width: 980,
        modal: true,
        close: function () {
          $checkedRoleId.val('');
          $checkedRoleList.empty();
          $roleList.empty();
        },
        title: "<div class='widget-header header-bg'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-fire green'></i> 认证审核</div>",
        title_html: true,

        buttons: [
          {
            html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
            "class": "btn btn-warning",
            click: function () {
              G.confirm({
                message: '确定取消操作？',
                callback: function (result) {
                  if (result) {
                    $auditDialog.dialog("close");
                  }
                }
              })

            }
          },
          {
            html: "<i class='ace-icon glyphicon	glyphicon-tag  bigger-110'></i>&nbsp; 通过",
            "class": "btn btn-primary",
            click: function () {
              saveRole(id);
            }
          }
        ]
      });
    }


  });
</script>