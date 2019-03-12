<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt" %>
<%
    String path = request.getContextPath();
    String basePath = path;
    pageContext.setAttribute("basePath", basePath);
%>
<div class="row">
    <div class="space-5"></div>
</div>
<div class="row">
    <div class="col-xs-12">
        <table id="grid-table-gift-store"></table>
    </div>
</div>
<div class="row">
    <div class="col-xs-12 col-sm-offset-0">
            <div class="widget-body">
                <div class="widget-main">
                    <div class="row">
                        <div class="col-xs-12">
                            <form class="form-horizontal" id="saveGiftOutOrInRecordsForm" role="form" method="post">
                                <input id="giftOutOrInRecordId" name="id" type="hidden" value="${giftOutOrInRecords.id}">
                                <div class="row">
                                    <div class="space-50"></div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="form-field-giftCode">礼品编码：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-7 ">
                                                <input type="text" id="form-field-giftCode" name="giftCode"
                                                       class="form-control " value="${giftOutOrInRecords.giftCode}"
                                                       placeholder="礼品编码" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="space-5"></div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="form-field-giftName">礼品名称：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-7 ">
                                                <input type="text" id="form-field-giftName" name="giftName"
                                                       class="form-control " value="${giftOutOrInRecords.giftName}"
                                                       placeholder="礼品名称" readonly/>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="form-field-giftType" >礼品类型：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-7 ">
                                                <select class="form-control" id="form-field-giftType"
                                                         name="giftType" disabled="disabled">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${dicGiftTypeList}" var="dicGiftType">
                                                        <option value="${dicGiftType.id}"
                                                                <c:if test="${giftOutOrInRecords.dicGiftType.id eq dicGiftType.id}">selected</c:if> >
                                                                ${dicGiftType.typeName}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-5"></div>
                                </div>
                                <div class="row">
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="form-field-giftCount" >数量：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-7 ">
                                                <input type="number" id="form-field-giftCount" name="giftCount"
                                                       class="form-control " value="${giftOutOrInRecords.giftCount}"
                                                       placeholder="数量"/>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <div class="form-group">
                                            <label class="col-sm-5 control-label" for="form-field-giftPrice" >单价：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-7 ">
                                                    <input class="form-control" name="giftPrice" id="form-field-giftPrice"
                                                           value="${giftOutOrInRecords.giftPrice}" type="text" placeholder="单价" readonly/>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="space-5"></div>
                                </div>
                                <div class="row hidden">
                                    <div class="col-xs-12">
                                        <div class="form-group">
                                            <label class="col-sm-3 control-label" for="form-field-giftFrame" >所属货架：<span
                                                    class="required">*</span></label>

                                            <div class="col-sm-9">
                                                <select class="form-control" id="form-field-giftFrame"
                                                        style="background-color: #eeeeee" name="giftFrame">
                                                    <option value="">---------请选择---------</option>
                                                    <c:forEach items="${giftShelvesList}" var="giftShelves">
                                                        <option value="${giftShelves.id}"
                                                                <c:if test="${giftOutOrInRecords.giftShelves.id eq giftShelves.id}">selected</c:if> >
                                                                ${giftShelves.frameCode}
                                                        </option>
                                                    </c:forEach>
                                                </select>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </form>
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

        $(".accordion").accordion({
            collapsible: true,
            active: true,
            heightStyle: "content",
            animate: 250,
            header: ".accordion-header"
        });

        //元素类全局变量
        var $giftName = $("#form-field-giftName");
        var $giftCode = $("#form-field-giftCode");
        var $giftType = $("#form-field-giftType");

        //控件类全局变量
        var $searchBtn = $("#searchBtn");
        var $resetBtn = $("#resetBtn");
        //表单类全局变量
        var $gridTable = $("#grid-table-gift-store");
        var $searchForm = $("#searchForm");
        var loadUrl = '${basePath}/giftStore/load-giftStoreInfo-list.do';
        var openGiftUrl = '${basePath}/giftOutOrInRecords/load-giftOutOrInRecords-edit.do';

        var colModel = [
            {name: 'id', index: 'id', hidden: true},
            {name: 'giftCode', header: '礼品编码', index: 'giftCode', sortable: true},
            {name: 'giftName', header: '礼品名称', index: 'giftName', width: 200, sortable: true},
            {name: 'giftType', header: '礼品类型', index: 'giftType', sortable: true},
            {name: 'giftTypeId', header: '礼品类型Id', hidden: true},
            {name: 'giftState', header: '库存状态', index: 'giftState', sortable: true},
            {name: 'giftCount', header: '数量', index: 'giftCount', sortable: true},
            {name: 'giftPrice', header: '单价', index: 'giftPrice', sortable: true},
            {name: 'giftFrame', header: '所属货架', index: 'giftFrame', sortable: true},
            {name: 'giftFrameId', header: '所属货架Id', hidden: true},
            {
                name: 'basic',
                header: '基本操作',
                sortable: false,
                width: 100,
                fixed: true,
                formatter: basicOperationFormatter
            }
        ];


        function basicOperationFormatter(cellvalue, options, rowData, action) {

            var operations = [];

            operations.push("<div style='margin-left:8px;font-size: 20px;'>");
            <c:if test="${true}">
            operations.push(' <button title="选择" class="btn btn-minier btn-white btn-purple row-record-edit">');
            operations.push('<i class="ace-icon fa fa-check blue row-record-edit"></i> 选择');
            operations.push('</button>');
            </c:if>
            operations.push("</div>");
            cellvalue = operations.join('');
            return cellvalue;
        }

        $gridTable.tjGrid({
            loadUrl: loadUrl,
            height: '100%',
            autowidth: true,
            colModel: colModel,
            sortname: 'updateTime',
            sortorder: 'desc',
            caption: "礼品查询列表",
            onSelectRow: function (id, stat, e) {

                if (e === undefined) {
                    return false;
                }
                var className = $(e.target).attr('class');
                if (!className) {
                    return false;
                }
                var rowData = $gridTable.jqGrid('getRowData', id);
                if (className.indexOf('row-record-edit') !== -1) {
                    choiceGift2(rowData);
                }
            }
        });

        $gridTable.tjGrid("triggerResizeGrid");

        function choiceGift(id){
            var $saveGiftOutOrInRecordsForm = $("#saveGiftOutOrInRecordsForm");
            $.ajax({
                url: openGiftUrl,
                type: "GET",
                data: {id: id},
                dataType: "html",
                success: function (String) {
                    $saveGiftOutOrInRecordsForm.html(String);
                },
                error: function () {
                    G.alert({message: "操作失败！"});
                }
            })
        }
        function choiceGift2(rowData){
            var $saveGiftOutOrInRecordsForm = $("#saveGiftOutOrInRecordsForm");
            $saveGiftOutOrInRecordsForm.find("#form-field-giftCode").val(rowData.giftCode);
            $saveGiftOutOrInRecordsForm.find("#form-field-giftName").val(rowData.giftName);
            $saveGiftOutOrInRecordsForm.find("#form-field-giftType").val(rowData.giftTypeId);
            $saveGiftOutOrInRecordsForm.find("#form-field-giftCount").val('1');
            $saveGiftOutOrInRecordsForm.find("#form-field-giftPrice").val(rowData.giftPrice);
            $saveGiftOutOrInRecordsForm.find("#form-field-giftFrame").val(rowData.giftFrameId);
        }

        $searchBtn.click(function () {
            search();
        });

        $resetBtn.click(function () {
            $searchForm.resetForm();
            search();
        });
        function search() {
            var giftName = $giftName.val();
            var giftType = $giftType.val();
            var giftCode = $giftCode.val();

            $gridTable.tjGrid('setPostData', {
                giftName: giftName,
                giftCode: giftCode,
                giftType: giftType,
            });
            reloadGrid();
        }

        function reloadGrid() {
            $gridTable.tjGrid('reloadGrid');
        }

        $(document).one('ajaxloadstart.page', function (e) {
            // $.jgrid.gridDestroy('#grid-table-gift-store');
            $('.ui-jqdialog').remove();
            $('.ui-dialog').remove();
        });
    });
</script>
