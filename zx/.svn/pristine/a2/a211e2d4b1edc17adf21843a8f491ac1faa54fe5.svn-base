<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>

<div class="row">
    <div class="col-xs-12">

        <div class="hidden">
            <input type="text" id="form-field-abroadInfoId" name="id" value="${abroadInfoId}"/>
        </div>

        <div class="row">
            <div class="space-16"></div>
        </div>

        <div class="row">
            <div class="col-xs-12">
                <table id="grid-table-passport"></table>
            </div>
        </div>

    </div>
</div>

<div class="row">
    <div class="col-xs-12">
        <div id="view-dialog-passport" class="hide">
            <div class="row">
                <div class="col-xs-12">
                    <div class="profile-user-info profile-user-info-striped">



                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<div id="borrow-dialog" class="hidden">
    <form id="borrowForm" autocomplete="off" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >借取人：
                        <span class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <input type="text" id="borrowPerson" name="borrowPerson"
                               class="form-control " placeholder="借取人"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >借取人电话：
                        <span class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <input type="text" id="borrowPersonTel" name="borrowPersonTel"
                               class="form-control " placeholder="借取人电话"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >应归还日期：
                        <span class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                            <input class="form-control" name="returnDate" id="returnDate"
                                   type="text" placeholder="应归还日期"/>
                            <span class="input-group-addon">
                                <i class="fa fa-calendar bigger-110"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-4 control-label text-right" >借出经办人：
                        <span class="required">*</span></label>

                    <div class="col-sm-8 ">
                        <input type="text" id="borrowAgent" name="borrowAgent"
                               class="form-control " placeholder="借出经办人"/>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<div id="return-dialog" class="hidden">
    <form id="returnForm" autocomplete="off" role="form">
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right" >
                        归还经办人：<span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <input type="text" id="returnAgent" name="returnAgent"
                               class="form-control " placeholder="归还经办人"/>
                    </div>
                </div>
            </div>
        </div>
        <div class="space-8"></div>
        <div class="row">
            <div class="col-xs-12">
                <div class="form-group">
                    <label class="col-sm-5 control-label text-right" >
                        实际归还日期：<span class="required">*</span></label>

                    <div class="col-sm-7 ">
                        <div class="input-group date date-picker" data-date-format="yyyy-mm-dd">
                            <input class="form-control" name="actualReturnDate" id="actualReturnDate"
                                   type="text" placeholder="实际归还日期"/>
                            <span class="input-group-addon">
                                <i class="fa fa-calendar bigger-110"></i>
                            </span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</div>

<script type="text/javascript">
    var scripts = [null, null];
    $('.page-content-area').ace_ajax('loadScripts', scripts, function () {

        G.datepicker();

        var $abroadInfoId = $("#form-field-abroadInfoId");

        var $gridTable = $("#grid-table-passport");
        var $viewDialog = $("#view-dialog-passport");

        var loadUrl = '${basePath}/abroad-passport/load-passport-list.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'userName', header: '姓名', index: 'userName', sortable: false},
            {name: 'passportNo', header: '护照号', index: 'passportNo', sortable: false},
            {name: 'issuePlace', header: '签发地', index: 'issuePlace', sortable: false},
            {name: 'issueDate', header: '签发日期', index: 'issueDate', sortable: false},
            {name: 'validDate', header: '护照有效期', index: 'validDate', sortable: false},
            {name: 'keepUnit', header: '保管单位', index: 'keepUnit', sortable: false},
            {name: 'storeAddress', header: '存放地址', index: 'storeAddress', sortable: false},
            {
                header: '状态',
                sortable: false,
                editable: false,
                width:220,
                formatter: statusFormatter
            },
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 220,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];

        function statusFormatter(cellvalue, options, rowData, action) {
            var isCancel = rowData.isCancel;
            var isDestroy = rowData.isDestroy;
            var isBorrow = rowData.isBorrow;
            var operations = [];
            if ('0' == isCancel && '0' == isDestroy) {//正常
                operations.push("<span class='label label-success arrowed arrowed-right'>" + '正常' + "</span>");
                if ("1" == isBorrow) {
                    operations.push("<span class='label label-info arrowed arrowed-in'>" + '已借出' + "</span>");
                }
            } else if ('1' == isCancel && '0' == isDestroy) {//已注销
                operations.push("<span class='label label-warning arrowed arrowed-right'>" + '已注销' + "</span>");
            } else if ('0' == isCancel && '1' == isDestroy) {//已销毁
                operations.push("<span class='label label-danger arrowed arrowed-right'>" + '已销毁' + "</span>");
            } else if ('1' == isCancel && '1' == isDestroy) {//注销并销毁
                operations.push("<span class='label label-inverse arrowed arrowed-right'>" + '注销并销毁' + "</span>");
            }
            cellvalue = operations.join('');
            return cellvalue;
        }

        function basicOperationFormatter(cellvalue, options, rowData, action) {
            var isCancel = rowData.isCancel;
            var isDestroy = rowData.isDestroy;
            var isBorrow = rowData.isBorrow;

            var operations = [];

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            operations.push(' <button title="查看" class="btn btn-minier btn-white btn-primary row-record-view">');
            operations.push('<i class="ace-icon glyphicon glyphicon-zoom-out blue row-record-view"></i> 查看');
            operations.push('</button>');

            if ('0' == isCancel && '0' == isDestroy && '0' == isBorrow) {
                operations.push(' <button title="编辑" class="btn btn-minier btn-white btn-purple row-record-borrow">');
                operations.push('<i class="ace-icon fa fa-pencil blue row-record-edit"></i> 借出');
                operations.push('</button>');
            }

            if ("1" == isBorrow) {
                operations.push(' <button title="归还"  class="btn btn-minier btn-white btn-primary row-record-return">');
                operations.push(' <i class="ace-icon orange fa fa-undo blue row-record-return"></i> 归还');
                operations.push('</button>');
            }

            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            postData: {
                abroadInfoId: $abroadInfoId.val()
            },
            sortname: 'updateTime',
            sortorder: 'desc',
            rowNum: -1,
            pgbuttons: false,
            pginput: false,
            onSelectRow: function (id, stat, e) {
                // 构造 id 数组，方便调用因公护照的方法
                var idArray = [];
                idArray.push(id);

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }

                if (className.indexOf('row-record-view') !== -1) {
                    var viewUrl = '#page/business-passport/business-passport-view';

                    var viewHash = viewUrl + "?id=" + id + '&date=' + new Date().getTime();
                    G.pjaxLoadPageContentDiv(viewHash);
                } else if (className.indexOf('row-record-borrow') !== -1) {

                    openBorrowDialog(JSON.stringify(idArray));
                } else if (className.indexOf('row-record-return') !== -1) {
                    console.log('return')
                    openReturnDialog(JSON.stringify(idArray));
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        /*----------借出 begin----------*/
        var $borrowDialog = $('#borrow-dialog');
        var $borrowForm = $('#borrowForm');
        var $borrowPerson = $('#borrowPerson');
        var $borrowPersonTel = $('#borrowPersonTel');
        var $returnDate = $('#returnDate');
        var $borrowAgent = $('#borrowAgent');

        function openBorrowDialog(ids) {

            $borrowDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 410,
                width: 450,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-share blue'></i>借出</div>",
                title_html: true,
                close: function () {
                    $borrowForm.resetForm();
                    reloadGrid();
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
                            if($borrowForm.validate().form()) {
                                var url = '${basePath}/business-passport/business-passport-borrow.do';
                                $.post(url,
                                    {
                                        ids: ids,
                                        borrowPerson: $borrowPerson.val(),
                                        borrowPersonTel : $borrowPersonTel.val(),
                                        returnDate : $returnDate.val(),
                                        borrowAgent : $borrowAgent.val()
                                    },
                                    function (response) {
                                        if (response.result) {
                                            reloadGrid();
                                            G.alertSuccess({message: '借出成功!'});
                                            $this.dialog("close");
                                        } else {
                                            G.alert({message: '借出失败!'});
                                        }
                                    }
                                );
                            }
                        }
                    }
                ]
            });
            $borrowDialog.dialog('open');
        }

        $borrowForm.tjValidate({
            focusInvalid: true,
            rules: {
                borrowPerson: {required: true},
                borrowPersonTel: {required: true, maxlength: 20, isTel:true},
                returnDate: {required: true},
                borrowAgent: {required: true}
            },
            messages: {
                borrowPerson: {required: "借取人必须填写"},
                borrowPersonTel: {required: "借取人电话必须填写"},
                returnDate: {required: "应归还日期必须填写"},
                borrowAgent: {required: "借出经办人必须填写"}
            }
        });
        /*----------借出end----------*/


        /*----------归还 begin----------*/
        var $returnDialog = $('#return-dialog');
        var $returnForm = $('#returnForm');
        var $returnAgent = $('#returnAgent');
        var $actualReturnDate = $('#actualReturnDate');

        function openReturnDialog(id) {
            $returnDialog.removeClass('hidden').dialog({
                resizable: false,
                height: 280,
                width: 450,
                modal: true,
                title: "<div class='widget-header'><h4 class='smaller border'style='margin-top: 12px'><i class='ace-icon fa fa-check green'></i>归还</div>",
                title_html: true,
                close: function () {
                    $returnForm.resetForm();
                    reloadGrid();
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
                            if($returnForm.validate().form()) {
                                var url = '${basePath}/business-passport/business-passport-return-back.do';
                                $.post(url,
                                    {
                                        ids: id,
                                        returnAgent: $returnAgent.val(),
                                        actualReturnDate : $actualReturnDate.val()
                                    },
                                    function (response) {
                                        if (response.result) {
                                            reloadGrid();
                                            G.alertSuccess({message: '归还成功!'});
                                            $this.dialog("close");
                                        } else {
                                            G.alert({message: '归还失败!'});
                                        }
                                    }
                                );
                            }
                        }
                    }
                ]
            });
            $returnDialog.dialog('open');
        }

        $returnForm.tjValidate({
            focusInvalid: true,
            rules: {
                returnAgent: {required: true},
                actualReturnDate: {required: true}
            },
            messages: {
                returnAgent: {required: "归还经办人必须填写"},
                actualReturnDate: {required: "实际归还日期必须填写"}
            }
        });
        /*----------归还end----------*/


        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }


        $(document).one('ajaxloadstart.page', function (e) {
            // $.jgrid.gridDestroy("#grid-table-passport");
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
