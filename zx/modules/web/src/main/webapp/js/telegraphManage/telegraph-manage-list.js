/***************************文件管理的CRUD*************************/
var scripts = [null, null];
//URL
var fileLocalUrl = '/file-manage/load-file-manage-list.do';
var fileEditUrl = '#page/file-manage/load-file-manage-edit';
var fileDeleteUrl = '/file-manage/load-file-manage-delete.do';
var fileInsertUrl = '#page/circulate-record/load-circulate-record-add';
var fileViewUrl = '#page/circulate-record/load-circulate-record-view';

$('.page-content-area').ace_ajax('loadScripts', scripts, function () {


    //文件搜索条件
    $(".accordions").accordion({
        collapsible: true,
        active: true,
        heightStyle: "content",
        animate: 250,
        header: ".accordion-header"
    });
    //时间控件
    $('.input-daterange').datepicker({
            format: 'yyyy-mm-dd',
            autoclose: true,
            todayHighlight: true
        }
    );


});



