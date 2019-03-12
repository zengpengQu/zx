//用于屏蔽右键菜单
//document.attachEvent("oncontextmenu",function(){return false;});
(function (factory) {
    factory(moment);
}(function (moment) {
    return moment.defineLocale('zh-cn', {
        months: '一月_二月_三月_四月_五月_六月_七月_八月_九月_十月_十一月_十二月'.split('_'),
        monthsShort: '1月_2月_3月_4月_5月_6月_7月_8月_9月_10月_11月_12月'.split('_'),
        weekdays: '星期日_星期一_星期二_星期三_星期四_星期五_星期六'.split('_'),
        weekdaysShort: '周日_周一_周二_周三_周四_周五_周六'.split('_'),
        weekdaysMin: '日_一_二_三_四_五_六'.split('_'),
        longDateFormat: {
            LT: 'Ah点mm',
            LTS: 'Ah点m分s秒',
            L: 'YYYY-MM-DD',
            LL: 'YYYY年MMMD日',
            LLL: 'YYYY年MMMD日LT',
            LLLL: 'YYYY年MMMD日ddddLT',
            l: 'YYYY-MM-DD',
            ll: 'YYYY年MMMD日',
            lll: 'YYYY年MMMD日LT',
            llll: 'YYYY年MMMD日ddddLT'
        },
        meridiemParse: /凌晨|早上|上午|中午|下午|晚上/,
        meridiemHour: function (hour, meridiem) {
            if (hour === 12) {
                hour = 0;
            }
            if (meridiem === '凌晨' || meridiem === '早上' ||
                meridiem === '上午') {
                return hour;
            } else if (meridiem === '下午' || meridiem === '晚上') {
                return hour + 12;
            } else {
                // '中午'
                return hour >= 11 ? hour : hour + 12;
            }
        },
        meridiem: function (hour, minute, isLower) {
            var hm = hour * 100 + minute;
            if (hm < 600) {
                return '凌晨';
            } else if (hm < 900) {
                return '早上';
            } else if (hm < 1130) {
                return '上午';
            } else if (hm < 1230) {
                return '中午';
            } else if (hm < 1800) {
                return '下午';
            } else {
                return '晚上';
            }
        },
        calendar: {
            sameDay: function () {
                return this.minutes() === 0 ? '[今天]Ah[点整]' : '[今天]LT';
            },
            nextDay: function () {
                return this.minutes() === 0 ? '[明天]Ah[点整]' : '[明天]LT';
            },
            lastDay: function () {
                return this.minutes() === 0 ? '[昨天]Ah[点整]' : '[昨天]LT';
            },
            nextWeek: function () {
                var startOfWeek, prefix;
                startOfWeek = moment().startOf('week');
                prefix = this.unix() - startOfWeek.unix() >= 7 * 24 * 3600 ? '[下]' : '[本]';
                return this.minutes() === 0 ? prefix + 'dddAh点整' : prefix + 'dddAh点mm';
            },
            lastWeek: function () {
                var startOfWeek, prefix;
                startOfWeek = moment().startOf('week');
                prefix = this.unix() < startOfWeek.unix() ? '[上]' : '[本]';
                return this.minutes() === 0 ? prefix + 'dddAh点整' : prefix + 'dddAh点mm';
            },
            sameElse: 'LL'
        },
        ordinalParse: /\d{1,2}(日|月|周)/,
        ordinal: function (number, period) {
            switch (period) {
                case 'd':
                case 'D':
                case 'DDD':
                    return number + '日';
                case 'M':
                    return number + '月';
                case 'w':
                case 'W':
                    return number + '周';
                default:
                    return number;
            }
        },
        relativeTime: {
            future: '%s内',
            past: '%s前',
            s: '几秒',
            m: '1分钟',
            mm: '%d分钟',
            h: '1小时',
            hh: '%d小时',
            d: '1天',
            dd: '%d天',
            M: '1个月',
            MM: '%d个月',
            y: '1年',
            yy: '%d年'
        },
        week: {
            // GB/T 7408-1994《数据元和交换格式·信息交换·日期和时间表示法》与ISO 8601:1988等效
            dow: 1, // Monday is the first day of the week.
            doy: 4  // The week that contains Jan 4th is the first week of the year.
        }
    });
}));
(function ($) {
    if (!jQuery.validator) {
        return;
    }


    jQuery.validator.addMethod("isIntEqZero", function (value, element) {
        value = parseInt(value);
        return this.optional(element) || value == 0;
    }, "整数必须为0");

    // 判断整数value是否大于0
    jQuery.validator.addMethod("isIntGtZero", function (value, element) {
        value = parseInt(value);
        return this.optional(element) || value > 0;
    }, "整数必须大于0");

    // 判断整数value是否大于或等于0
    jQuery.validator.addMethod("isIntGteZero", function (value, element) {
        value = parseInt(value);
        return this.optional(element) || value >= 0;
    }, "整数必须大于或等于0");

    // 判断整数value是否不等于0
    jQuery.validator.addMethod("isIntNEqZero", function (value, element) {
        value = parseInt(value);
        return this.optional(element) || value != 0;
    }, "整数必须不等于0");

    // 判断整数value是否小于0
    jQuery.validator.addMethod("isIntLtZero", function (value, element) {
        value = parseInt(value);
        return this.optional(element) || value < 0;
    }, "整数必须小于0");

    // 判断整数value是否小于或等于0
    jQuery.validator.addMethod("isIntLteZero", function (value, element) {
        value = parseInt(value);
        return this.optional(element) || value <= 0;
    }, "整数必须小于或等于0");

    // 判断浮点数value是否等于0
    jQuery.validator.addMethod("isFloatEqZero", function (value, element) {
        value = parseFloat(value);
        return this.optional(element) || value == 0;
    }, "浮点数必须为0");

    // 判断浮点数value是否大于0
    jQuery.validator.addMethod("isFloatGtZero", function (value, element) {
        value = parseFloat(value);
        return this.optional(element) || value > 0;
    }, "浮点数必须大于0");

    // 判断浮点数value是否大于或等于0
    jQuery.validator.addMethod("isFloatGteZero", function (value, element) {
        value = parseFloat(value);
        return this.optional(element) || value >= 0;
    }, "浮点数必须大于或等于0");

    // 判断浮点数value是否不等于0
    jQuery.validator.addMethod("isFloatNEqZero", function (value, element) {
        value = parseFloat(value);
        return this.optional(element) || value != 0;
    }, "浮点数必须不等于0");

    // 判断浮点数value是否小于0
    jQuery.validator.addMethod("isFloatLtZero", function (value, element) {
        value = parseFloat(value);
        return this.optional(element) || value < 0;
    }, "浮点数必须小于0");

    // 判断浮点数value是否小于或等于0
    jQuery.validator.addMethod("isFloatLteZero", function (value, element) {
        value = parseFloat(value);
        return this.optional(element) || value <= 0;
    }, "浮点数必须小于或等于0");

    // 判断浮点型
    jQuery.validator.addMethod("isFloat", function (value, element) {
        return this.optional(element) || /^[-\+]?\d+(\.\d+)?$/.test(value);
    }, "只能包含数字、小数点等字符");

    // 匹配integer
    jQuery.validator.addMethod("isInteger", function (value, element) {
        return this.optional(element) || (/^[-\+]?\d+$/.test(value) && parseInt(value) >= 0);
    }, "匹配integer");

    // 判断数值类型，包括整数和浮点数
    jQuery.validator.addMethod("isNumber", function (value, element) {
        return this.optional(element) || /^[-\+]?\d+$/.test(value) || /^[-\+]?\d+(\.\d+)?$/.test(value);
    }, "匹配数值类型，包括整数和浮点数");

    // 只能输入[0-9]数字
    jQuery.validator.addMethod("isDigits", function (value, element) {
        return this.optional(element) || /^\d+$/.test(value);
    }, "只能输入0-9数字");

    // 判断中文字符
    jQuery.validator.addMethod("isChinese", function (value, element) {
        return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
    }, "只能包含中文字符。");

    //只能输入汉字或英文
    jQuery.validator.addMethod("isStr", function (value, element) {
        return this.optional(element) || /^[A-Za-z\u0391-\uFFE5\s]+$/.test(value);
    }, "只能包含中文和英文字符。");

    // 判断英文字符
    jQuery.validator.addMethod("isEnglish", function (value, element) {
        return this.optional(element) || /^[A-Za-z]+$/.test(value);
    }, "只能包含英文字符。");

    // 手机号码验证
    jQuery.validator.addMethod("isMobile", function (value, element) {
        var length = value.length;
        return this.optional(element) || (length == 11 && /^(((13[0-9]{1})|(15[0-9]{1})|(18[0-9]{1}))+\d{8})$/.test(value));
    }, "请正确填写您的手机号码。");

    jQuery.validator.addMethod("isFax", function (value, element) {
        var reg = /^[+]{0,1}(\d){1,3}[ ]?([-]?((\d)|[ ]){1,12})+$/;
        return this.optional(element) || (reg.test(value));
    }, "传真输入有误,请重新输入!");

    // 电话号码验证
    jQuery.validator.addMethod("isPhone", function (value, element) {
        var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
        return this.optional(element) || (tel.test(value));
    }, "请正确填写您的电话号码。");

    // 联系电话(手机/电话皆可)验证
    jQuery.validator.addMethod("isTel", function (value, element) {
        var length = value.length;
        var mobile = /^(((13[0-9]{1})|(15[0-9]{1})|(17[0-9]{1})|(18[0-9]{1}))+\d{8})$/;
        var tel = /^(\d{3,4}-?)?\d{7,9}$/g;
        return this.optional(element) || tel.test(value) || (length == 11 && mobile.test(value));
    }, "请正确填写您的联系方式");

    // 匹配qq
    jQuery.validator.addMethod("isQq", function (value, element) {
        return this.optional(element) || /^[1-9]\d{4,12}$/;
    }, "匹配QQ");

    // 邮政编码验证
    jQuery.validator.addMethod("isZipCode", function (value, element) {
        var zip = /^[0-9]{6}$/;
        return this.optional(element) || (zip.test(value));
    }, "请正确填写您的邮政编码。");

    // 匹配密码，以字母开头，长度在6-12之间，只能包含字符、数字和下划线。
    jQuery.validator.addMethod("isPwd", function (value, element) {
        return this.optional(element) || /^[a-zA-Z]\\w{6,12}$/.test(value);
    }, "以字母开头，长度在6-12之间，只能包含字符、数字和下划线。");

    // 身份证号码验证
    jQuery.validator.addMethod("isIdCardNo", function (value, element) {
        //var idCard = /^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/;
        return this.optional(element) || isIdCardNo(value);
    }, "请输入正确的身份证号码。");

    // IP地址验证
    jQuery.validator.addMethod("ip", function (value, element) {
        return this.optional(element) || /^(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.)(([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))\.){2}([1-9]|([1-9]\d)|(1\d\d)|(2([0-4]\d|5[0-5])))$/.test(value);
    }, "请填写正确的IP地址。");

    // 字符验证，只能包含中文、英文、数字、下划线等字符。
    jQuery.validator.addMethod("stringCheck", function (value, element) {
        return this.optional(element) || /^[a-zA-Z0-9\u4e00-\u9fa5-_]+$/.test(value);
    }, "只能包含中文、英文、数字、下划线等字符");

    // 匹配english
    jQuery.validator.addMethod("isEnglish", function (value, element) {
        return this.optional(element) || /^[A-Za-z]+$/.test(value);
    }, "匹配english");

    // 匹配汉字
    jQuery.validator.addMethod("isChinese", function (value, element) {
        return this.optional(element) || /^[\u4e00-\u9fa5]+$/.test(value);
    }, "匹配汉字");

    // 匹配中文(包括汉字和字符)
    jQuery.validator.addMethod("isChineseChar", function (value, element) {
        return this.optional(element) || /^[\u0391-\uFFE5]+$/.test(value);
    }, "匹配中文(包括汉字和字符) ");

    // 判断是否为合法字符(a-zA-Z0-9-_)
    jQuery.validator.addMethod("isRightfulString", function (value, element) {
        return this.optional(element) || /^[A-Za-z0-9_-]+$/.test(value);
    }, "判断是否为合法字符(a-zA-Z0-9-_)");

    // 判断是否包含中英文特殊字符，除英文"-_"字符外
    jQuery.validator.addMethod("isContainsSpecialChar", function (value, element) {
        var reg = RegExp(/[(\ )(\`)(\~)(\!)(\@)(\#)(\$)(\%)(\^)(\&)(\*)(\()(\))(\+)(\=)(\|)(\{)(\})(\')(\:)(\;)(\')(',)(\[)(\])(\.)(\<)(\>)(\/)(\?)(\~)(\！)(\@)(\#)(\￥)(\%)(\…)(\&)(\*)(\（)(\）)(\—)(\+)(\|)(\{)(\})(\【)(\】)(\‘)(\；)(\：)(\”)(\“)(\’)(\。)(\，)(\、)(\？)]+/);
        return this.optional(element) || !reg.test(value);
    }, "含有中英文特殊字符");

    //判断企业组织机构代码
    jQuery.validator.addMethod("isGroupNo", function (value, element) {
        return this.optional(element) || isGroupNo(value);
    }, "组织机构代码填写错误");

    //判断企业组织机构代码
    jQuery.validator.addMethod("notEasyPsw", function (value, element) {
        return this.optional(element) || notEasyPsw(value);
    }, "请输入5-30位以字母开头,可带数字的字符串");

    //判断上传文件是否为word
    jQuery.validator.addMethod("isWord", function (value, element) {
        return this.optional(element) || isWord(value);
    }, "上传文件格式不正确");

    //验证结束日期必须大于开始日期
    jQuery.validator.addMethod("compareDate", function (value, element, param) {
        return this.optional(element) || compareDate(value, element, param);
    }, "结束日期必须大于等于开始日期");

    // 验证日期格式yyyy-MM-dd
    jQuery.validator.addMethod("validateDate", function (value, element) {
        var reg = RegExp(/^\d{4}[-]\d{2}[-]\d{2}$/);
        return this.optional(element) || validateDate(value);
    }, "日期格式为yyyy-MM-dd");

    //验证3位数字
    jQuery.validator.addMethod("validateNumber", function (value, element) {
        return this.optional(element) || (value.length == 3);
    }, "请输入3位数字");

    //验证护照
    jQuery.validator.addMethod("passport", function (value, element) {
        return this.optional(element) || /(P\d{7})|(G\d{8})/.test(value);
    }, "请填写正确的护照编号。");


    function compareDate(value, element, param) {
        var endDate = new Date(Date.parse(value.replace(/-/g, "/"))).Format("yyyy-MM-dd");
        var startDate = new Date(Date.parse(($(param).val()).replace(/-/g, "/"))).Format("yyyy-MM-dd");
        return _.gte(endDate, startDate);
    }

    function isWord(value) {

        var filepath = value;
        //获得上传文件名
        var fileArr = filepath.split("\\");
        var fileTArr = fileArr[fileArr.length - 1].toLowerCase().split(".");
        var fileType = fileTArr[fileTArr.length - 1];
        //切割出后缀文件名
        if (fileType !== "doc" && fileType !== "docx") {
            return false;
        } else {
            return true;
        }
    }

    //判断企业组织机构代码
    function isGroupNo(num) {

        if (num.length == 10) {
            var ws = [3, 7, 9, 10, 5, 8, 4, 2];
            var str = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
            var reg = /^([0-9A-Z]){8}-[0-9|X]$/;
            if (!reg.test(num))
                return false;

            var sum = 0;
            for (var i = 0; i < 8; i++) {
                sum += str.indexOf(num.charAt(i)) * ws[i];
            }
            var C9 = 11 - (sum % 11);
            if (C9 == 10)
                C9 = 'X';
            else if (C9 == 11)
                C9 = '0';
            if (C9 != num.charAt(9))
                return false;
        }
        else if (num.length == 18) {
            return true;
        } else {
            return false;
        }
        return true;
    }

    //密码校验
    function notEasyPsw(s) {
        var rule = /^[a-zA-Z]{1}([a-zA-Z0-9]){4,19}$/;
        if (!rule.exec(s)) return false;
        return true;

    }

    //身份证号码的验证规则
    function isIdCardNo(num) {
        //if (isNaN(num)) {alert("输入的不是数字！"); return false;}
        var len = num.length, re;
        if (len == 15) {
            re = new RegExp(/^(\d{6})()?(\d{2})(\d{2})(\d{2})(\d{2})(\w)$/);
        }
        else if (len == 18) {
            re = new RegExp(/^(\d{6})()?(\d{4})(\d{2})(\d{2})(\d{3})(\w)$/);
        }
        else {
            //alert("输入的数字位数不对。");
            return false;
        }
        var a = num.match(re);
        if (a != null) {
            if (len == 15) {
                var D = new Date("19" + a[3] + "/" + a[4] + "/" + a[5]);
                var B = D.getYear() == a[3] && (D.getMonth() + 1) == a[4] && D.getDate() == a[5];
            }
            else {
                var D = new Date(a[3] + "/" + a[4] + "/" + a[5]);
                var B = D.getFullYear() == a[3] && (D.getMonth() + 1) == a[4] && D.getDate() == a[5];
            }
            if (!B) {
                //alert("输入的身份证号 "+ a[0] +" 里出生日期不对。");
                return false;
            }
        }
        if (!re.test(num)) {
            //alert("身份证最后一位只能是数字和字母。");
            return false;
        }
        return true;
    }

    //日期格式校验 yyyy-MM-dd
    function validateDate(value) {
        var reg = RegExp(/^\d{4}[-]\d{2}[-]\d{2}$/);
        if (!reg.test(value)) {
            return false;
        } else {
            return true;
        }
    }

})(jQuery);

$(document).ready(function () {
    if ($.bootbox) {
        bootbox.setDefaults({
            locale: 'zh_CN'
        });
    }

    $(document)
        .on('show.bs.modal', '.modal', function (event) {
            var $this = $(this);
            var $back = $this.find('.modal-backdrop');
            var modalHeight = $this.find('.modal-dialog').height();

            $this.find('.modal-dialog').draggable({
                handle: ".modal-header",
                containment: $back,
                scroll: false
            });
        }).on('shown.bs.modal', '.modal.in', function (event) {
        //var $this = $(this);
        //var $back = $this.find('.modal-backdrop');
        //var modalHeight = $this.find('.modal-dialog').height();
        //$this.find('.modal-dialog').css({
        //    'margin-top': function () {
        //        return ($(window).height() / 2 - (modalHeight / 2));
        //    }
        //});
    });

    $(document)
        .on('show.bs.modal', '.modal', function (event) {
            $(this).appendTo($('body'));
        })
        .on('shown.bs.modal', '.modal.in', function (event) {
            setModalsAndBackdropsOrder();
        })
        .on('hidden.bs.modal', '.modal', function (event) {
            setModalsAndBackdropsOrder();
            if ($('.modal.in').length == 0) {
                $('body').removeClass('modal-open');
            }
        });

    function setModalsAndBackdropsOrder() {
        $('body').addClass('modal-open');
        var modalZIndex = $('.modal.in').length + 11500 + 1;
        var backdropZIndex = modalZIndex - 1;
        $('.modal-backdrop').addClass('hidden');
        $('.modal.in:last').css('z-index', modalZIndex);
        $('.modal-backdrop.in:last').css('z-index', backdropZIndex).removeClass('hidden');
    }


    if ($.validator) {
        $.validator.prototype.elements = function () {
            var validator = this,
                rulesCache = {};

            return $(this.currentForm)
                .find("input, select, textarea")
                .not(":submit, :reset, :image, [disabled]") // changed from: .not( ":submit, :reset, :image, [disabled], [readonly]" )
                .not(this.settings.ignore)
                .filter(function () {
                    if (!this.name && validator.settings.debug && window.console) {
                        console.error("%o has no name assigned", this);
                    }

                    if (this.name in rulesCache || !validator.objectLength($(this).rules())) {
                        return false;
                    }

                    rulesCache[this.name] = true;
                    return true;
                });
        };

        $.extend($.validator.defaults, {
            errorElement: 'span',
            focusCleanup: true,
            errorPlacement: function (error, element) { // render error placement for each input type
                if (element.parent(".input-group").size() > 0) {
                    error.insertAfter(element.parent(".input-group"));
                }
                else if (element.attr("data-error-container")) {
                    error.appendTo(element.attr("data-error-container"));
                }
                else if (element.parents('.radio-list').size() > 0) {
                    error.appendTo(element.parents('.radio-list').attr("data-error-container"));
                }
                else if (element.parents('.radio-inline').size() > 0) {
                    error.appendTo(element.parents('.radio-inline').attr("data-error-container"));
                }
                else if (element.parents('.checkbox-list').size() > 0) {
                    error.appendTo(element.parents('.checkbox-list').attr("data-error-container"));
                }
                else if (element.parents('.checkbox-inline').size() > 0) {
                    error.appendTo(element.parents('.checkbox-inline').attr("data-error-container"));
                }
                else {
                    error.insertAfter(element); // for other inputs, just perform default behavior
                }
            },

            //showErrors: function(errorMap, errorList) {
            //    $.each(this.successList, function(index, value) {
            //        return $(value).popover("hide");
            //    });
            //    return $.each(errorList, function(index, value) {
            //        var _popover;
            //        _popover = $(value.element).popover({
            //            trigger: "manual",
            //            placement: "top",
            //            content: value.message,
            //            template: "<div class=\"popover\"><div class=\"arrow\"></div><div class=\"popover-inner\"> <div class=\"popover-content error\"><p></p></div></div></div>"
            //        });
            //        _popover.data("bs.popover").options.content = value.message;
            //        return _popover.popover("show");
            //    });
            //},

            elements: function () {
                var validator = this,
                    rulesCache = {};

                // select all valid inputs inside the form (no submit or reset buttons)
                return $(this.currentForm)
                    .find("input, select, textarea")
                    .not(":submit, :reset, :image, [disabled]")
                    .not(this.settings.ignore)
                    .filter(function () {
                        if (!this.name && validator.settings.debug && window.console) {
                            console.error("%o has no name assigned", this);
                        }

                        // select only the first element for each name, and only those with rules specified
                        if (this.name in rulesCache || !validator.objectLength($(this).rules())) {
                            return false;
                        }

                        rulesCache[this.name] = true;
                        return true;
                    });
            },

            invalidHandler: function (event, validator) { //display error alert on form submit

            },

            highlight: function (element) { // hightlight error inputs
                $(element).closest('.form-group').addClass('has-error'); // set error class to the control group
            },

            unhighlight: function (element) { // revert the change done by hightlight
                $(element).closest('.form-group').removeClass('has-error'); // set error class to the control group
            },

            success: function (label) {
                $(label).closest('.form-group').removeClass('has-error'); // set success class to the control group
                $(label).remove();
            }
        });
    }

    if ($.ui && $.ui.dialog) {
        //override dialog's title function to allow for HTML titles
        $.widget("ui.dialog", $.extend({}, $.ui.dialog.prototype, {
            _title: function (title) {
                var $title = this.options.title || '&nbsp;'
                if (("title_html" in this.options) && this.options.title_html == true) {
                    title.html($title);
                }
                else {
                    title.text($title);
                }
            }
        }));
    }

    if ($.jgrid) {
        $.extend($.jgrid.defaults, {
            mtype: "post",
            datatype: "json",
            jsonReader: {
                root: "data",
                repeatitems: false
            },
            rownumbers: true,
            rowNum: 10,
            rowList: [10, 20, 30],
            altRows: true
        });

        $.extend($.jgrid.nav, {
            edit: false,
            add: false,
            del: false,
            search: false,
            refresh: true,
            refreshicon: 'ace-icon fa fa-refresh green',
            view: false
        });

        $.extend($.fn.fmatter, {
            operationFormatter: function (cellvalue, options, rowData, action) {
                var id = rowData.id;

                cellvalue = '';
                var operations = [];

                operations.push("<div style='margin-left:8px;'>");
                operations.push("<span title='查看' class='ace-icon fa fa-book row-record-view'></span>&nbsp;&nbsp;&nbsp;");
                operations.push("<span title='编辑' class='ace-icon fa fa-edit row-record-edit'></span>&nbsp;&nbsp;&nbsp;");
                operations.push("<span title='删除' class='ace-icon red fa fa-remove row-record-delete'></span>");
                operations.push("</div>");

                cellvalue = operations.join('');

                return cellvalue;
            }
        });
    }
});

//jqgrid更新pagerIcons
//replace icons with FontAwesome icons like above
function updatePagerIcons(table) {
    var replacement =
        {
            'ui-icon-seek-first': 'ace-icon fa fa-angle-double-left bigger-140',
            'ui-icon-seek-prev': 'ace-icon fa fa-angle-left bigger-140',
            'ui-icon-seek-next': 'ace-icon fa fa-angle-right bigger-140',
            'ui-icon-seek-end': 'ace-icon fa fa-angle-double-right bigger-140'
        };
    $('.ui-pg-table:not(.navtable) > tbody > tr > .ui-pg-button > .ui-icon').each(function () {
        var icon = $(this);
        var $class = $.trim(icon.attr('class').replace('ui-icon', ''));

        if ($class in replacement) {
            icon.attr('class', 'ui-icon ' + replacement[$class]);
        }
    })
}

//jqgrid enableTooltips
function enableTooltips(table) {
    $('.navtable .ui-pg-button').tooltip({container: 'body'});
    $(table).find('.ui-pg-div').tooltip({container: 'body'});
}

//隐藏页面记录条数选择框和增加标题如果过长就用。。。表示
function hidePagerSelect(table) {
    $('.ui-pg-table').find('select').hide();
    $('.ui-jqgrid-titlebar-close').hide();
    $('.ui-jqgrid tr.jqgrow td').css("text-overflow", "ellipsis");
}

//调整jqGrid[查看]弹出框样式,在beforeShowForm方法中调用
function style_view_form(form) {
    form.find('.ViewTable').removeClass('EditTable ViewTable').addClass('profile-user-info profile-user-info-striped');
    form.find('.FormData').removeClass('FormData').addClass('profile-info-row');
    form.find('.form-view-label').removeClass('CaptionTD form-view-label ui-widget-content').addClass('profile-info-name');
    form.find('.form-view-data').removeClass('DataTD form-view-data ui-helper-reset ui-widget-content').addClass('profile-info-value');
    form.next().find('tr:first-child').parent().prepend("<tr></tr>");
    var buttons = form.next().find('.EditButton .fm-button');
    buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();//ui-icon, s-icon
    buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-times"></i>');
    buttons.eq(0).removeClass('fm-button-icon-left').addClass('fm-button-icon-right');

    buttons = form.next().find('.navButton a');
    buttons.find('.ui-icon').hide();
    buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
    buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');
}

//调整jqGrid[编辑]弹出框样式,在beforeShowForm方法中调用
function style_edit_form(form) {

    form.find('.CaptionTD').css({"width": "20%"});
    form.find('.FormElement').css({"width": "80%", "height": "35px"});

    //update buttons classes
    var buttons = form.next().find('.EditButton .fm-button');
    buttons.addClass('btn btn-sm').find('[class*="-icon"]').hide();//ui-icon, s-icon
    buttons.eq(0).addClass('btn-primary').prepend('<i class="ace-icon fa fa-check"></i>');
    buttons.eq(1).prepend('<i class="ace-icon fa fa-times"></i>')

    buttons = form.next().find('.navButton a');
    buttons.find('.ui-icon').hide();
    buttons.eq(0).append('<i class="ace-icon fa fa-chevron-left"></i>');
    buttons.eq(1).append('<i class="ace-icon fa fa-chevron-right"></i>');
}

function style_delete_form(form) {
    var buttons = form.next().find('.EditButton .fm-button');
    buttons.addClass('btn btn-sm btn-white btn-round').find('[class*="-icon"]').hide();//ui-icon, s-icon
    buttons.eq(0).addClass('btn-danger').prepend('<i class="ace-icon fa fa-trash-o"></i>');
    buttons.eq(1).addClass('btn-default').prepend('<i class="ace-icon fa fa-times"></i>')
}

Date.prototype.Format = function (fmt) {
    var o = {
        "M+": this.getMonth() + 1, //月份
        "d+": this.getDate(), //日
        "H+": this.getHours(), //小时
        "m+": this.getMinutes(), //分
        "s+": this.getSeconds(), //秒
        "q+": Math.floor((this.getMonth() + 3) / 3), //季度
        "S": this.getMilliseconds() //毫秒
    };
    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
    for (var k in o)
        if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
    return fmt;
};

(function ($) {
    var tjGrid = function (ele, opt) {
        this.$element = ele;
        this.defaults = {
            loadComplete: function () {
                var table = this;
                setTimeout(function () {
                    updatePagerIcons(table);
                    enableTooltips(table);
                    hidePagerSelect(table);
                }, 0);
            },
            onSelectRow: function (id, stat, e) {
                var className = $(e.target).attr('class');

                if (!className) {
                    return false;
                }

                if (className.indexOf('row-record-view') !== -1) {
                    if (initParam !== undefined) {
                        G.keepGridParam(initParam.$form, $("#" + this.id));
                    }
                    var viewHash = viewUrl + "?id=" + id;
                    G.loadPageContent(viewHash);
                } else if (className.indexOf('row-record-edit') !== -1) {
                    if (initParam !== undefined) {
                        G.keepGridParam(initParam.$form, $("#" + this.id));
                    }
                    var editHash = editUrl + "?id=" + id;
                    G.loadPageContent(editHash);
                } else if (className.indexOf('row-record-delete') !== -1) {
                    G.confirm({
                        message: '确认删除记录！',
                        callback: function (result) {
                            if (result) {
                                $.post(deleteUrl,
                                    {id: id},
                                    function (data) {
                                        if (data.result) {
                                            $this.tjGrid('reloadGrid');
                                        }
                                    });
                            }
                        }
                    });
                }
            },
            gridComplete: function () {
                if (initParam === undefined) {
                    $("#" + this.id).setSelection(0, false);
                } else {
                    $("#" + this.id).setSelection(initParam.rowIndex, false);
                }
                //调整表格宽度
                $("#" + this.id).tjGrid("triggerResizeGrid");
                $(ele).closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
            }
        };

        var loadUrl = opt.loadUrl;

        var initParam = opt.initParam;

        var parent_column = $(ele).closest('[class*="col-"]');
        //遍历所有的Url
        var urlMap = {};

        $.each(opt, function (index, item) {

            if (index.indexOf('Url') !== -1) {

                var mapId = 'row-record-' + index.substring(0, index.indexOf('Url'));
                urlMap[mapId] = item;

                if (index.indexOf('Mod') !== -1) {
                    $(parent_column).after('<div id="' + mapId + '-dialog" class="hide"></div>');
                }
            }
        });

        var $this = $(this.$element);
        var id = $this.attr('id');
        //var gridSelector = id + '-grid-table';
        var pageSelector = id + '-grid-pager';
        var colNames = [];

        var colModel = opt.colModel;
        for (var i = 0; i < colModel.length; i++) {
            if (!colModel[i].header) {
                colNames.push('');
            }
            else {
                colNames.push(colModel[i].header);
            }
        }

        var options = $.extend({
            pager: "#" + pageSelector,
            url: loadUrl,
            colNames: colNames
        }, this.defaults, opt, initParam);

        $this.after('<div id="' + pageSelector + '"></div>');

        jQuery("#" + id).jqGrid(options).jqGrid('navGrid', "#" + pageSelector, { 	//navbar options
            edit: false,
            editicon: 'ace-icon fa fa-pencil blue',
            add: false,
            addicon: 'ace-icon fa fa-plus-circle purple',
            del: false,
            delicon: 'ace-icon fa fa-trash-o red',
            search: false,
            searchicon: 'ace-icon fa fa-search orange',
            refresh: true,
            refreshicon: 'ace-icon fa fa-refresh green',
            view: false,
            viewicon: 'ace-icon fa fa-search-plus grey'
        });
    }

    //定义方法集的对象
    var methods = {

        init: function (options) {
            return this.each(function () {

                var $this = $(this),
                    data = $this.data('tjGrid');

                if (!data) {
                    data = new tjGrid(this, options);
                    $(this).data('tjGrid', data);
                }
            });
        },

        initPageContentGrid: function () {
            return this.each(function () {
                var $this = $(this),
                    data = $this.data('tjGrid');

                if (data) {
                    var id = $this.attr('id');
                    var gridSelector = "#" + id;

                    $(window).on('resize.jqGrid', function () {
                        var pwidth = $(gridSelector).closest('[class*="col-"]').width();
                        if (pwidth > 0) {
                            $(gridSelector).jqGrid('setGridWidth', pwidth);
                        }
                        $('#grid-table-grid-pager_left').css('visibility', 'hidden');
                    });

                    $(document).one('ajaxloadstart.page', function (e) {
                        $.jgrid.gridDestroy(gridSelector);
                        $('.ui-jqdialog').remove();
                    });
                }
                else {
                    $.error('Method initPageContentGrid error');
                }
            });
        },
        reloadGrid: function () {
            return this.each(function () {
                var $this = $(this),
                    data = $this.data('tjGrid');

                if (data) {
                    var id = $this.attr('id');
                    var gridSelector = "#" + id;

                    $(gridSelector).jqGrid('setGridParam', {page: 1}).trigger("reloadGrid")
                }
                else {
                    $.error('Method reloadGrid error');
                }
            });
        },

        setPostData: function (param) {
            return this.each(function () {
                var $this = $(this),
                    data = $this.data('tjGrid');

                if (data) {
                    var id = $this.attr('id');
                    var gridSelector = "#" + id;
                    $(gridSelector).setPostData(param);
                }
                else {
                    $.error('Method setPostData error');
                }
            });
        },

        jqGrid: function () {
            var args = arguments;
            var $this = $(this);

            var id = $this.attr('id');
            var gridSelector = "#" + id;
            var $grid = $(gridSelector);
            var result = $grid.jqGrid.apply($grid, args);
            return result;
        },

        triggerResizeGrid: function () {
            var $this = $(this);
            var id = $this.attr('id');
            var grid_selector = "#" + id;
            var parent_column = $(grid_selector).closest('[class*="col-"]');
            //resize to fit page size
            $(window).on('resize.jqGrid', function () {
                $(grid_selector).jqGrid('setGridWidth', parent_column.width());
                $(grid_selector).closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
            });
            //resize on sidebar collapse/expand
            $(document).on('settings.ace.jqGrid', function (ev, event_name, collapsed) {
                if (event_name === 'sidebar_collapsed' || event_name === 'main_container_fixed') {
                    //setTimeout is for webkit only to give time for DOM changes and then redraw!!!
                    setTimeout(function () {
                        $(grid_selector).jqGrid('setGridWidth', parent_column.width());
                        //调整表格宽度
                        $(grid_selector).closest(".ui-jqgrid-bdiv").css({"width": parent_column.width() * 1.00093});
                    }, 20);
                }
            });
            $(window).triggerHandler('resize.jqGrid');//trigger window resize to make the grid get the correct size
        },

        bindResizeGrid: function () {
            return this.each(function () {
                var $this = $(this),
                    data = $this.data('tjGrid');

                if (data) {
                    var id = $this.attr('id');
                    var gridSelector = "#" + id;
                    var $gridSelector = $(gridSelector);

                    $gridSelector.tjGrid('initPageContentGrid');
                    $gridSelector.tjGrid('triggerResizeGrid');
                }
                else {
                    $.error('Method initPageContentGrid error');
                }
            });
        },

        destroy: function () {
            return this.each(function () {

                var $this = $(this),
                    data = $this.data('tjGrid');
                //data.tooltip.remove();

                $this.removeData('tjGrid');
            })
        }

    };

    $.fn.tjGrid =
        function (method) {
            //参数是字符串，并且是methods对象中对应的一个方法的命名空间
            if (typeof method === 'string') {
                if (methods[method]) {
                    //调用第一个参数对于的函数，并把后面的参数提交给该函数
                    return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
                }
                else {
                    return methods['jqGrid'].apply(this, Array.prototype.slice.call(arguments, 0))
                }
            }
            //参数是对象或为空
            else if (typeof method === 'object' || !method) {
                //就执行methods对象中，init属性所对应的函数对象,并把参数method传递给该函数
                return methods.init.apply(this, arguments);
            }
            //找不到对于的方法
            else {
                $.error('Method ' + method + ' does not exist on tjGrid');
            }
        };

})(jQuery);

(function ($) {
    var tjForm = function (ele, opt) {
        this.$element = ele;
        this.defaults = {
            form: {},
            validate: {}
        };

        var $this = $(this.$element);
        var id = $this.attr('id');

        var redirectHash = opt.redirectHash;

        var validateForm = function () {
            if ($this.validate().form()) {
                return true;
            }

            $this.data('submited', false);

            return false;
        }

        var formDefault = {
            type: "post",
            dataType: 'json',
            beforeSubmit: validateForm,
            success: function (data) {
                if (data.result) {
                    G.alert({
                        title: '提示',
                        message: '操作成功！',
                        callback: function () {
                            G.pjaxLoadPageContentDiv(redirectHash);
                        }
                    });
                }
                else {
                    G.alert({
                        title: '提示',
                        message: '操作失败！'
                    });
                }
                ;
                $this.data('submited', false);
            },
            error: function (data) {
                G.alert({
                    title: '提示',
                    message: '操作失败！'
                });
                $this.data('submited', false);
            }
        };

        var formOptions = $.extend({}, formDefault);

        if (opt.form) {
            formOptions = $.extend(formOptions, opt.form);
        }

        //ajaxForm组件初始化
        $this.ajaxForm(formOptions);

        var validateDefault = {
            errorElement: 'span',
            focusInvalid: false
        };

        var validateOptions = $.extend({}, validateDefault);

        if (opt.validate) {
            validateOptions = $.extend(validateOptions, opt.validate);
        }

        //validate组件初始化
        $this.validate(validateOptions);

        //$('.date-picker').change(function() {
        //    $this.validate().element($(this));
        //})
    };


    //定义方法集的对象
    var methods = {
        init: function (options) {
            return this.each(function () {

                var $this = $(this),
                    data = $this.data('tjForm');

                if (!data) {
                    data = new tjForm(this, options);
                    $(this).data('tjForm', data);
                }
            });
        },

        resetForm: function () {
            return this.each(function () {
                var $this = $(this),
                    data = $this.data('tjForm');

                if (data) {
                    $this.validate().resetForm();
                    $this.validate().reset();
                    $this.data('submited', false);

                    $this.find('div.has-error').each(function (index, element) {
                        $(this).removeClass('has-error');
                    });
                }
                else {
                    $.error('Method resetForm error');
                }
            });
        },

        submit: function () {
            return this.each(function () {
                var $this = $(this),
                    data = $this.data('tjForm');

                if (data) {
                    if (!$this.data('submited')) {
                        $this.data('submited', true);
                        $this.submit();
                    }
                }
                else {
                    $.error('Method resetForm error');
                }
            });
        },

        destroy: function () {
            return this.each(function () {

                var $this = $(this),
                    data = $this.data('tjForm');

                $this.removeData('tjForm');
            })
        }


    };

    $.fn.tjForm =
        function (method) {
            //参数是字符串，并且是methods对象中对应的一个方法的命名空间
            if (methods[method]) {
                //调用第一个参数对于的函数，并把后面的参数提交给该函数
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            }
            //参数是对象或为空
            else if (typeof method === 'object' || !method) {
                //就执行methods对象中，init属性所对应的函数对象,并把参数method传递给该函数
                return methods.init.apply(this, arguments);
            }
            //找不到对于的方法
            else {
                $.error('Method ' + method + ' does not exist on tjForm');
            }
        };

})(jQuery);

(function ($) {
    var tjValidate = function (ele, opt) {
        this.$element = ele;
        this.defaults = {
            errorElement: 'span',
            focusInvalid: false
        };

        var $this = $(this.$element);
        var id = $this.attr('id');

        var validateOptions = $.extend({}, this.defaults, opt);

        //validate组件初始化
        $this.validate(validateOptions);
    }


    //定义方法集的对象
    var methods = {
        init: function (options) {
            return this.each(function () {

                var $this = $(this),
                    data = $this.data('tjValidate');

                if (!data) {
                    data = new tjValidate(this, options);
                    $(this).data('tjValidate', data);
                }
            });
        },

        resetForm: function () {
            return this.each(function () {
                var $this = $(this),
                    data = $this.data('tjValidate');

                if (data) {
                    $this.validate().resetForm();
                    $this.validate().reset();

                    $this.find('div.has-error').each(function (index, element) {
                        $(this).removeClass('has-error');
                    });
                }
                else {
                    $.error('Method resetForm error');
                }
            });
        },

        destroy: function () {
            return this.each(function () {

                var $this = $(this),
                    data = $this.data('tjValidate');

                $this.removeData('tjValidate');
            })
        },
        setForm: function (jsonValue) {
            var obj = this;
            $.each(jsonValue, function (name, ival) {
                var $oinput = obj.find(":input[name=" + name + "]");
                if ($oinput.attr("type") == "radio" || $oinput.attr("type") == "checkbox") {
                    $oinput.each(function () {
                        if (Object.prototype.toString.apply(ival) == '[object Array]') {//是复选框，并且是数组
                            for (var i = 0; i < ival.length; i++) {
                                if ($(this).val() == ival[i])
                                    $(this).attr("checked", "checked");
                            }
                        } else {
                            if ($(this).val() == ival)
                                $(this).attr("checked", "checked");
                        }
                    });
                } else if ($oinput.attr("type") == "textarea") {//多行文本框
                    obj.find("[name=" + name + "]").html(ival);
                } else {
                    obj.find("[name=" + name + "]").val(ival);
                }
            });
        }
    };

    $.fn.tjValidate =
        function (method) {
            //参数是字符串，并且是methods对象中对应的一个方法的命名空间
            if (methods[method]) {
                //调用第一个参数对于的函数，并把后面的参数提交给该函数
                return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
            }
            //参数是对象或为空
            else if (typeof method === 'object' || !method) {
                //就执行methods对象中，init属性所对应的函数对象,并把参数method传递给该函数
                return methods.init.apply(this, arguments);
            }
            //找不到对于的方法
            else {
                $.error('Method ' + method + ' does not exist on tjForm');
            }
        };

})(jQuery);


G = {
    //放大图片用，不完善根据具体情况修改
    blowUp: function (viewId, preview, photoPath, width, height) {
        function imagePreview() {

            var xOffset = 10;
            var yOffset = 30;

            preview.hover(function (e) {
                    this.t = this.title;
                    this.title = "";
                    var c = (this.t != "") ? "<br/>" + this.t : "";
                    $(viewId).append("<div id='imagePreview'><img width='" + width + "' height='" + height + "'src='" + photoPath + "' alt='Image preview' />" + c + "</div>");
                    if ((e.pageX - yOffset) < width) {
                        $("#imagePreview")
                            .css("top", (e.pageY - height - xOffset) + "px")
                            .css("left", (e.pageX + yOffset) + "px")
                            .fadeIn("fast");
                    }
                    else {
                        $("#imagePreview")
                            .css("top", (e.pageY - height) + "px")
                            .css("left", (e.pageX - width - yOffset) + "px")
                            .fadeIn("fast");
                    }
                },
                function () {
                    this.title = this.t;
                    $("#imagePreview").remove();
                });
            preview.mousemove(function (e) {
                if ((e.pageX - yOffset) < width) {
                    $("#imagePreview")
                        .css("top", (e.pageY - height - xOffset) + "px")
                        .css("left", (e.pageX + yOffset) + "px")
                        .fadeIn("fast");
                }
                else {
                    $("#imagePreview")
                        .css("top", (e.pageY - height) + "px")
                        .css("left", (e.pageX - width - yOffset) + "px")
                        .fadeIn("fast");
                }
            });
        };
        imagePreview();
    },
    imagePreview: function () {
        var tempFileUrl = NG.uploadFileServer;

        var xOffset = 10;
        var yOffset = 30;

        $('div.preview').each(function (i, n) {
            var $previewItem = $(this);
            var $previewInput = $previewItem.find('input.preview_input');
            var $previewImage = $previewItem.find('img.preview_image');

            var val = $previewInput.val();
            if (val) {
                var file = JSON.parse($previewInput.val());
                $previewImage.prop('src', tempFileUrl + file.path);
            }
        });


        var $preview = $('div.preview');
        $preview.hover(function (e) {
                var $previewItem = $(this);
                var width = $previewItem.data('width');
                var height = $previewItem.data('height');
                var $previewInput = $previewItem.find('input.preview_input');
                var $previewImage = $previewItem.find('img.preview_image');

                var val = $previewInput.val();
                if (!val) {
                    return;
                }
                var file = JSON.parse($previewInput.val());
                var photoPath = tempFileUrl + file.path;
                $previewImage.prop('src', tempFileUrl + file.path);

                this.t = this.title;
                this.title = "";
                var c = (this.t != "") ? "<br/>" + this.t : "";
                $('body').append("<div id='imagePreview' style='z-index: 20000;'><img width='" + width + "' height='" + height + "'src='" + photoPath + "' alt='Image preview' />" + c + "</div>");
                if ((e.pageX - yOffset) < width) {
                    $("#imagePreview")
                        .css("top", (e.pageY - height - xOffset) + "px")
                        .css("left", (e.pageX + yOffset) + "px")
                        .fadeIn("fast");
                }
                else {
                    $("#imagePreview")
                        .css("top", (e.pageY - height) + "px")
                        .css("left", (e.pageX - width - yOffset) + "px")
                        .fadeIn("fast");
                }
            },
            function () {
                this.title = this.t;
                $("#imagePreview").remove();
            });
        $preview.mousemove(function (e) {
            var $previewItem = $(this);
            var width = $previewItem.data('width');
            var height = $previewItem.data('height');
            var $previewInput = $previewItem.find('input.preview_input');
            var val = $previewInput.val();
            if (!val) {
                return;
            }

            if ((e.pageX - yOffset) < width) {
                $("#imagePreview")
                    .css("top", (e.pageY - height - xOffset) + "px")
                    .css("left", (e.pageX + yOffset) + "px")
                    .fadeIn("fast");
            }
            else {
                $("#imagePreview")
                    .css("top", (e.pageY - height) + "px")
                    .css("left", (e.pageX - width - yOffset) + "px")
                    .fadeIn("fast");
            }
        });
    },
    search: function ($form, $grid) {
        var data = $form.serializeObject();
        $grid.tjGrid('setPostData', data);
        $grid.tjGrid('reloadGrid');
    },
    pjaxLoadPageContentDiv: function (hash) {
        if (hash.indexOf('?') != -1) {
            window.location.hash = hash + '&date=' + new Date().getTime();
        } else {
            window.location.hash = hash + '?date=' + new Date().getTime();
        }
    },
    ajaxLoadStartPageCall: function (callback) {
        $(document).one('ajaxloadstart.page', callback);
    },
    /**
     * 全局移除父元素是body的浮动元素。
     */
    globalAjaxLoadStartPageCall: function () {
        $(document).on('ajaxloadstart.page', function () {
            G.removeFloatDiv();
        });
    },
    globalAjaxLoadCompletePageCall: function () {
        $(document).on('ajaxloadcomplete.page', function () {

        });
    },
    globalAjaxScriptsLoadedPageCall: function () {
        $(document).on('ajaxscriptsloaded.page', function () {
            G.datepicker();
            G.datetimepicker();
        });
    },
    globalAjaxCall: function () {
        G.globalAjaxLoadStartPageCall();
        G.globalAjaxLoadCompletePageCall();
        G.globalAjaxScriptsLoadedPageCall();
    },
    alert: function (param) {
        var defaults = {
            title: "<h4 class='smaller'><i class='ace-icon fa fa-exclamation-triangle red'></i> 提示</h4></div>"
        };

        bootbox.setDefaults({
            locale: 'zh_CN'
        });

        var options = $.extend({
            buttons: {
                "ok": {
                    "label": "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                    "className": "btn-sm btn-success"
                }
            }
        }, defaults, param);
        options.message = "<div class='alert alert-info bigger-110'>" + options.message + "</div>";
        bootbox.alert(options);
    },
    alertSuccess: function (param) {
        var defaults = {
            title: "<h4 class='smaller'><i class='ace-icon glyphicon glyphicon-ok green'></i> 提示</h4></div>"
        };

        bootbox.setDefaults({
            locale: 'zh_CN'
        });

        var options = $.extend({
            buttons: {
                "ok": {
                    "label": "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                    "className": "btn-sm btn-success"
                }
            }
        }, defaults, param);
        options.message = "<div class='alert alert-success bigger-110'>" + options.message + "</div>";
        bootbox.alert(options);
    },
    confirm: function (param) {
        var defaults = {
            title: "<h4 class='smaller'><i class='ace-icon fa fa-exclamation-triangle red'></i> 提示</h4></div>"
        };

        bootbox.setDefaults({
            locale: 'zh_CN'
        });

        var options = $.extend({
            buttons: {
                "confirm": {
                    "label": "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                    "className": "btn-sm btn-success"
                },
                "cancel": {
                    "label": "<i class='ace-icon fa fa-reply bigger-110'></i>&nbsp; 取消",
                    "className": "btn-sm btn-warning"
                }
            }
        }, defaults, param);
        options.message = "<div class='alert alert-info bigger-110'>" + options.message + "</div>";
        bootbox.confirm(options);
    },
    back: function () {
        window.history.back();
    },
    hidePopover: function () {
        $('div.popover').popover('hide');
    },
    datepicker: function (opt) {
        var defaults = {
            changeMonth: true,
            changeYear: true
        };

        var options = $.extend({}, defaults, opt);

        $('.date-picker').datepicker(options);

        $('.date-picker- .form-control').change(function () {
            var form = $(this).parents('form');
            if (form && form.validate) {
                form.validate().element($(this));
            }
        });
    },
    datetimepicker: function (opt) {
        //var defaults = {
        //	language:  'zh-CN',
        //	format: 'yyyy-mm-dd hh:ii',
        //	weekStart: 1,
        //	todayBtn:  1,
        //	autoclose: 1,
        //	todayHighlight: 1,
        //	startView: 2,
        //	forceParse: 0,
        //	showMeridian: 1
        //};
        var defaults = {
            dateFormat: 'yy-mm-dd',
            changeMonth: true,
            changeYear: true
        };
        var options = $.extend({}, defaults, opt);

        $('.date-time-picker').datetimepicker(options);

        $('.date-time-picker .form-control').change(function () {
            var form = $(this).parents('form');
            if (form && form.validate) {
                form.validate().element($(this));
            }
        });
    },
    timepicker: function (opt) {
        var defaults = {
            hourGrid: 4,
            minuteGrid: 10
        };

        var options = $.extend({}, defaults, opt);

        $('.timepicker').timepicker(options);


        $('.timepicker .form-control').change(function () {
            var form = $(this).parents('form');
            if (form && form.validate) {
                form.validate().element($(this));
            }
        });
    },

    generateBarCode: function (canvasId, barCodeValue) {
        var btype = 'code128';
        var renderer = 'css';

        var settings = {
            output: renderer,
            bgColor: '#FFFFFF',
            color: '#000000',
            barWidth: '1',
            barHeight: '50',
            moduleSize: '5',
            posX: '15',
            posY: '20',
            addQuietZone: '1'
        };


        $("#" + canvasId).html("").show().barcode(barCodeValue, btype, settings);

        function clearCanvas(id) {
            var canvas = $('#' + id).get(0);
            var ctx = canvas.getContext('2d');
            ctx.lineWidth = 1;
            ctx.lineCap = 'butt';
            ctx.fillStyle = '#FFFFFF';
            ctx.strokeStyle = '#000000';
            ctx.clearRect(0, 0, canvas.width, canvas.height);
            ctx.strokeRect(0, 0, canvas.width, canvas.height);
        }
    },
    openPostWindow: function (url, data, name) {
        function openWindow(name) {
            window.open("about:blank", name, 'height=400,width=600,top=300,left=500,toolbar=no,menubar=no,scrollbars=no, resizable=yes,location=no, status=no');
        }

        var tempForm = document.createElement("form");
        tempForm.id = "tempForm1";
        tempForm.method = "post";
        tempForm.action = url;
        tempForm.target = name;

        var hideInput = document.createElement("input");
        hideInput.type = "hidden";
        hideInput.name = "json";
        hideInput.value = data;
        tempForm.appendChild(hideInput);

        document.body.appendChild(tempForm);

        $(tempForm).on("submit", function () {
            openWindow(name);
        });

        $(tempForm).trigger('submit');
        tempForm.submit();

        document.body.removeChild(tempForm);
    },
    idTag: function ($tagInput, displayField) {
        $tagInput.displayField = displayField;
        $tagInput.objectCache = [];
        $tagInput.add = function (tagObject) {
            if ($tagInput.data('tag').inValues(tagObject[$tagInput.displayField]) == -1) {
                $tagInput.objectCache.push(tagObject);
                $tagInput.data('tag').add(tagObject[$tagInput.displayField]);
            }
        }
        $tagInput.getIds = function () {
            var idarray = [];
            for (var i = 0; i < this.objectCache.length; i++) {
                idarray.push(this.objectCache[i].id);
            }
            return idarray.join(',');
        };
        $tagInput.tag({placeholder: $tagInput.attr('placeholder')});

        $tagInput.on('removed', function (item, data) {
            for (var i = 0; i < $tagInput.objectCache.length; i++) {
                if (data[0].trim() == $tagInput.objectCache[i][$tagInput.displayField].trim()) {
                    $tagInput.objectCache.splice(i, 1);
                    break;
                }
            }
            if ($tagInput.objectCache.length <= 0) {
                $tagInput.siblings("input").removeClass("hidden");
            }
        });

        $tagInput.on('added', function (item, data) {
            for (var i = 0; i < $tagInput.objectCache.length; i++) {
                if (data[0].trim() == $tagInput.objectCache[i][$tagInput.displayField].trim()) {
                    $tagInput.objectCache.splice(i, 1);
                    break;
                }
            }
            if ($tagInput.objectCache.length > 0) {
                var $input = $tagInput.siblings("input");
                if (!$input.hasClass("hidden")) {
                    $input.addClass("hidden");
                }
            }
        });

        var $input = $tagInput.siblings("input");
        $input.keydown(function () {
            return false;
        });
        $input.click(function () {
            return false;
        });
        $input.dblclick(function () {
            return false;
        });
        $input.mousedown(function () {
            return false;
        });
        $input.mouseup(function () {
            return false;
        });
    },

    initdropzone: function (dropElementId) {

        try {
            Dropzone.autoDiscover = false;
            var myDropzone = new Dropzone(dropElementId, {
                paramName: "file", // The name that will be used to transfer the file
                maxFilesize: 5, // MB

                addRemoveLinks: true,
                dictDefaultMessage: '<span class="bigger-150 bolder"><i class="ace-icon fa fa-caret-right red"></i> Drop files</span> to upload \
					<span class="smaller-80 grey">(or click)</span> <br /> \
					<i class="upload-icon ace-icon fa fa-cloud-upload blue fa-3x"></i>'
                ,
                dictResponseError: 'Error while uploading file!',

                //change the previewTemplate to use Bootstrap progress bars
                previewTemplate: "<div class=\"dz-preview dz-file-preview\">\n  <div class=\"dz-details\">\n    <div class=\"dz-filename\"><span data-dz-name></span></div>\n    <div class=\"dz-size\" data-dz-size></div>\n    <img data-dz-thumbnail />\n  </div>\n  <div class=\"progress progress-small progress-striped active\"><div class=\"progress-bar progress-bar-success\" data-dz-uploadprogress></div></div>\n  <div class=\"dz-success-mark\"><span></span></div>\n  <div class=\"dz-error-mark\"><span></span></div>\n  <div class=\"dz-error-message\"><span data-dz-errormessage></span></div>\n</div>"
            });

            $(document).one('ajaxloadstart.page', function (e) {
                try {
                    myDropzone.destroy();
                } catch (e) {
                }
            });

        } catch (e) {
            alert(e);
            alert('Dropzone.js does not support older browsers!');
        }

    },

    initImageViewer: function () {
        var $overflow = '';
        var colorbox_params = {
            rel: 'colorbox',
            reposition: true,
            scalePhotos: true,
            scrolling: false,
            previous: '<i class="ace-icon fa fa-arrow-left"></i>',
            next: '<i class="ace-icon fa fa-arrow-right"></i>',
            close: '&times;',
            current: '{current} of {total}',
            maxWidth: '100%',
            maxHeight: '100%',
            onOpen: function () {
                $overflow = document.body.style.overflow;
                document.body.style.overflow = 'hidden';
            },
            onClosed: function () {
                document.body.style.overflow = $overflow;
            },
            onComplete: function () {
                $.colorbox.resize();
            }
        };
        $('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params);
        $("#cboxLoadingGraphic").html("<i class='ace-icon fa fa-spinner blue fa-spin'></i>");//let's add a custom loading icon
    },

    // 自动消隐，信息提示窗口
    // eg: 1. G.autoMsgDlg("succeed!");
    //     2. G.autoMsgDlg({message: "succeed!", succeed: true});
    autoMsgDlg: function (opts) {
        if ($('#_global_dlg').length <= 0) {
            $('<div id="_global_dlg" class="btn btn-lg btn-success fa fa-border" style="display:none; border: solid 1px white; position:absolute; right:345px;top:5px; width:500px; height:50px;">' +
                '<i class="ace-icon fa fa-check bigger-200"></i>' +
                '<span class="bigger-200" id="_global_dlg_msg"></span>' +
                '</div>').appendTo('body');
        }
        var options = {
            message: '操作成功！',
            succeed: true
        };
        if (typeof opts == "string") {
            options.message = opts;
        } else {
            $.extend(options, opts);
        }
        if (!options.message) {
            alert("please set message option!");
            return;
        }
        var $_globalDlg = $('#_global_dlg');
        var $_globalDlg_icon = $('#_global_dlg i');
        if (options.succeed) {
            $_globalDlg.removeClass("btn-danger")
            $_globalDlg.addClass("btn-success");
            $_globalDlg_icon.removeClass("fa-bolt");
            $_globalDlg_icon.addClass("fa-check");
        } else {
            $_globalDlg.removeClass("btn-success")
            $_globalDlg.addClass("btn-danger");
            $_globalDlg_icon.removeClass("fa-check");
            $_globalDlg_icon.addClass("fa-bolt");
        }
        $('#_global_dlg_msg').text(options.message);
        $('#_global_dlg').fadeIn("fast");
        setTimeout("$('#_global_dlg').fadeOut('slow')", 1000);

    },
    // 初始化echart主题
    // selectorControl：eg: $('#theme-select')
    // getchartfunc, 返回当前页面echart实例的回调函数，eg: function(){return [mychart, mychart2];}
    initChartThemeSelector: function (selectorControl, getchartfunc) {
        if (selectorControl) {
            selectorControl.html(
                '<option selected="true" value="default">默认</option>'
                + '<option value="dark">深色调</option>'
                + '<option value="blue">蓝色调</option>'
                + '<option value="green">绿色调</option>'
                + '<option value="red">红色调</option>'
                + '<option value="gray">灰色调</option>'
                + '<option value="helianthus">柔和色调</option>'
                + '<option value="shine">鲜明色调</option>'
                + '<option value="macarons">清凉色调</option>'
                + '<option value="infographic">信息图</option>'
            );
            selectorControl.on('change', function () {
                var curTheme;
                var theme = $(this).val();
                var mycharts = getchartfunc();
                if (!mycharts) return;
                require(['theme/echart/' + theme], function (tarTheme) {
                    for (var i = 0; i < mycharts.length; i++) {
                        var mychart1 = mycharts[i];
                        mychart1.showLoading();
                        curTheme = tarTheme;
                        mychart1.hideLoading();
                        mychart1.setTheme(curTheme);
                    }
                })
            });
        }
    },
    removeFloatDiv: function () {
        $('.popover').popover('destroy');
        $('.daterangepicker.dropdown-menu,.colorpicker.dropdown-menu,.bootstrap-datetimepicker-widget.dropdown-menu').remove();
        $('.ui-jqdialog').remove();
        $('.ui-dialog').remove();
        $('.datepicker').remove();
        $('.datetimepick').remove();
        // $('.uploadify').uploadify('destroy');
        //$('.timepicker').remove();
    },
    subStringToSubFix: function (title, index) {   //按照固定长度替换字符串为“...”
        if (title.length > index) {
            var result = title.substring(0, index);
            return result + " ..."
        } else {
            return title;
        }
    },
    showGritterSuccess: function (mes) {       //提示成功
        var mes = (mes == undefined || mes == "") ? '操 作 成 功' : mes;
        jQuery.gritter.add({
            title: '',
            text: '<div style="margin: 0px auto;width: 200px;text-align: center;"><h4><b>' + mes + '</b></h4></div>',
            time: '1000',
            class_name: 'gritter-center gritter-info'
        });
    },
    showGritterFail: function (mes) {       //提示失败
        var mes = (mes == undefined || mes == "") ? '操 作 失 败' : mes;
        jQuery.gritter.add({
            title: '',
            text: '<div style="margin: 0px auto;width: 200px;text-align: center;"><h4><b>' + mes + '</b></h4></div>',
            time: '3000',
            class_name: 'gritter-center gritter-error'
        });
    },
    showShortAlert: function (mes) {       //提示成功
        var mes = (mes == undefined || mes == "") ? '操 作 成 功 !' : mes;
        //消息提示全局配置
        toastr.options = {
            "closeButton": false,//是否配置关闭按钮
            "newestOnTop": true,//新消息是否排在最上层
            "progressBar": false,//是否显示进度条
            "positionClass": "toast-top-right",//消息框的显示位置
            "preventDuplicates": false,//是否阻止弹出多个消息框
            "onclick": null,//点击回调函数
            "showDuration": "300",
            "hideDuration": "1000",
            "timeOut": "0",//1.5s后关闭消息框
            "extendedTimeOut": "0",
            "showEasing": "swing",
            "hideEasing": "linear",
            "showMethod": "fadeIn",
            "hideMethod": "fadeOut"
        };
        toastr.warning(mes);
    },
    showMessage: function (mes) {
        var mes = (mes === undefined || mes === "") ? '操 作 失 败' : mes;
        jQuery.gritter.add({
            title: '',
            text: '<div style="margin: 0px auto;width: 250px;text-align: center;"><h4><b>' + mes + '</b></h4></div>',
            time: '3000',
            class_name: 'gritter-center'
        });
    },
    showAjaxLoading: function (mes) {
        var mes = (mes == undefined || mes == "") ? '后台处理中，请等待...' : mes;
        var ajaxLoadingSpiner = jQuery.gritter.add({
            title: '',
            text: '<div style="margin: 0px auto;font-size: 22px;text-align: center;width: 500px;"><i class="ace-icon fa fa-spinner fa-spin orange"></i>&nbsp;&nbsp;' + mes + '</div>',
            sticky: true,
            class_name: 'gritter-center '
        });

        var item = $('#gritter-item-' + ajaxLoadingSpiner);
        $(item).find('.gritter-close').remove();
        return ajaxLoadingSpiner;
    },
    doneAjaxLoading: function (ajaxLoadingSpiner) {
        if (null == ajaxLoadingSpiner || ajaxLoadingSpiner == undefined || ajaxLoadingSpiner == "") {
            jQuery.gritter.removeAll();
        } else {
            jQuery.gritter.remove(ajaxLoadingSpiner, {});
        }
    },
    updateBreadcrumb: function (pathName) {    //处理路径 <li><label>'内容'</label></li>
        var $breadcrumb = $("#breadcrumb");
        $breadcrumb.find('li').not(':eq(0)').remove();
        var pathHtml = [];
        if (_.isArray(pathName)) {
            for (var i = 0; i < pathName.length; i++) {
                if (i !== pathName.length -1) {
                    pathHtml.push('<li><a href="#">'+ pathName[i] +'</a></li>');
                } else {
                    pathHtml.push('<li class="active">'+ pathName[i] +'</li>');
                }
            }
        }
        $breadcrumb.append(pathHtml.join(''));
    },
    canMouseMove: function (target) {      //可以拖拽的
        mouseMoveFlag = false;
        var _x, _y, _b;//鼠标离控件左上角的相对位置
        target.unbind();
        target.mousedown(function (e) {
            mouseMoveFlag = true;
            _x = e.pageX - parseInt(target.css("left"));
            _y = e.pageY;
            _b = parseInt(target.css("bottom"));
        });
        target.mousemove(function (e) {
            if (mouseMoveFlag) {
                var x = e.pageX - _x;//控件左上角到屏幕左上角的相对位置
                var y = _y - e.pageY;
                var b = _b + y;
                target.css({"bottom": b, "left": x});
            }
        });
        target.mouseup(function () {
            mouseMoveFlag = false;
        });
    },

    toUtf8: function (str) {
        var out, i, len, c;
        out = "";
        len = str.length;
        for (i = 0; i < len; i++) {
            c = str.charCodeAt(i);
            if ((c >= 0x0001) && (c <= 0x007F)) {
                out += str.charAt(i);
            } else if (c > 0x07FF) {
                out += String.fromCharCode(0xE0 | ((c >> 12) & 0x0F));
                out += String.fromCharCode(0x80 | ((c >> 6) & 0x3F));
                out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
            } else {
                out += String.fromCharCode(0xC0 | ((c >> 6) & 0x1F));
                out += String.fromCharCode(0x80 | ((c >> 0) & 0x3F));
            }
        }
        return out;
    },

    //element:部门div,flag:是否触发部门点击事件，curDeptArray：如果一个页面有多个部门div，请将初始化数据依次放入curDeptArray
    initDept: function (element, flag, curDeptArray, zNodes) {

        var deptDiv = $('.' + element);

        $.each(deptDiv, function (index) {


            var ele = element;

            var dialogId = G._createDeptDialog(index, ele);
            var $container = $("#" + dialogId);

            var $deptName = $('.' + ele + ':eq(' + index + ')>input:eq(1)');
            var $deptId = $('.' + ele + ':eq(' + index + ')>input:eq(0)');

            if (null != curDeptArray && null !== curDeptArray[index]) {
                var dept = JSON.parse(curDeptArray[index]);

                if (dept.absName !== undefined && dept.absName !== '') {
                    $deptName.attr("value", dept.absName);
                    $deptId.attr("value", dept.id);
                } else {
                    $deptName.attr("value", '');
                    $deptId.attr("value", '');
                }

            }

            G.initTree(zNodes, $container, index, ele);

            if (flag) {

                $deptName.on('click', function () {

                    //每次点击需要初始化
                    var deptName = $deptName.val();
                    var deptId = $deptId.val();
                    $container.find('.' + ele + '_search_' + index + '>input:eq(0)').val(deptId);
                    $container.find('.' + ele + '_search_' + index + '>input:eq(1)').val(deptName);

                    //定位到当前节点
                    var zTreeId = $container.find('.' + ele + '_tree_' + index + '').attr('id');
                    var treeObj = $.fn.zTree.getZTreeObj(zTreeId);
                    var nodes = treeObj.getNodesByParamFuzzy("id", deptId, null);
                    treeObj.selectNode(nodes[0]);
                    treeObj.expandNode(nodes[0], true);
                    treeObj.updateNode(nodes[0]);

                    $container.removeClass('hide').dialog({
                        resizable: false,
                        height: 630,
                        width: 400,
                        modal: true,
                        title: "<div class='widget-header header-bg'><h4 class='smaller'style='margin-top: 12px'><i class='ace-icon fa  fa-globe green'></i>部门选择</h4></div>",
                        title_html: true,
                        close: function () {
                            $(this).addClass('hide');
                        },
                        buttons: [
                            {
                                html: "<i class='ace-icon fa fa-times bigger-110'></i>&nbsp; 取消",
                                "class": "btn btn-warning",
                                click: function () {
                                    $(this).dialog("close");
                                }
                            },
                            {
                                html: "<i class='ace-icon fa fa-check bigger-110'></i>&nbsp; 确定",
                                "class": "btn btn-success",
                                click: function () {

                                    var searchId = $container.find('.' + element + '_search_' + index + '>input:eq(0)').val();
                                    var searchName = $container.find('.' + element + '_search_' + index + '>input:eq(1)').val();
                                    $deptName.prop("value", searchName);
                                    $deptId.prop("value", searchId);
                                    $deptId.trigger('change');

                                    $(this).dialog("close");
                                }
                            }
                        ]
                    });
                })
            }
        });
    },
    initTree: function (zNodes, $container, index, element) {

        var searchId = $container.find('.' + element + '_search_' + index + '>input:eq(0)');
        var searchName = $container.find('.' + element + '_search_' + index + '>input:eq(1)');
        var zTreeId = $container.find('.' + element + '_tree_' + index + '').attr('id');

        var setting = {

            view: {
                selectedMulti: false,
                nameIsHTML: true, //允许name支持html
                showTitle: false
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
                onClick: function () {
                    var zTree = $.fn.zTree.getZTreeObj(zTreeId),
                        nodes = zTree.getSelectedNodes(),
                        v = "", k = "";

                    nodes.sort(function compare(a, b) {
                        return a.id - b.id;
                    });
                    for (var i = 0, l = nodes.length; i < l; i++) {

                        var nodePath = nodes[i].getPath();
                        var path = "";
                        if (nodePath.length === 1) {
                            path = nodePath[0].oldname === undefined ? nodePath[0].name : nodePath[0].oldname;
                        } else {
                            for (var j = 1; j < nodePath.length; j++) {
                                path += nodePath[j].oldname === undefined ? nodePath[j].name : nodePath[j].oldname;
                                if (j !== nodePath.length - 1) {
                                    path += '/';
                                }
                            }
                        }
                        v += path + ",";
                        k += nodes[i].id + ",";
                    }
                    if (v.length > 0) v = v.substring(0, v.length - 1);
                    if (k.length > 0) k = k.substring(0, k.length - 1);

                    searchName.prop("value", v);
                    searchId.prop("value", k);
                },
                onDblClick: function (event, treeId, treeNode) {

                    var $deptName = $('.' + element + ':eq(' + index + ')>input:eq(1)');
                    var $deptId = $('.' + element + ':eq(' + index + ')>input:eq(0)');

                    var deptId = treeNode.id;
                    var nodePath = treeNode.getPath();
                    var path = "";
                    if (nodePath.length === 1) {
                        path = nodePath[0].oldname === undefined ? nodePath[0].name : nodePath[0].oldname;
                    } else {
                        for (var j = 1; j < nodePath.length; j++) {
                            path += nodePath[j].oldname === undefined ? nodePath[j].name : nodePath[j].oldname;
                            if (j !== nodePath.length - 1) {
                                path += '/';
                            }
                        }
                    }
                    searchName.prop("value", path);
                    searchId.prop("value", deptId);

                    $deptName.prop("value", path);
                    $deptId.prop("value", deptId);
                    $deptId.trigger('change');

                    $container.dialog("close");
                    $container.addClass("hide");
                }
            }
        }
        $(document).ready(function () {
            $.fn.zTree.init($("#" + zTreeId), setting, zNodes);
            fuzzySearch(zTreeId, '#' + searchName.attr('id'), null, true,'#' + searchId.attr('id')); //初始化模糊搜索方法
        });
    },
    _createDeptDialog: function (index, ele) {

        var $container = $('.page-content-area').find('.' + ele + '_dialog_' + index);

        if ($container.length === 0) {

            var div = document.createElement('div');
            div.setAttribute('id', ele + 'Dialog_' + index);
            div.setAttribute('class', 'hide ' + ele + '_dialog_' + index);
            $('.page-content-area').append(div);
        }

        $('#' + ele + 'Dialog_' + index).empty();

        var deptArray = [];

        deptArray.push('     <div class="row">                                                                                                     ');
        deptArray.push('         <div class="col-xs-12 col-sm-12">                                                                                 ');
        deptArray.push('             <div class="search-area well well-sm" style="background-color: transparent;height: 500px;margin-bottom: 0px"> ');
        deptArray.push('                 <form>                                                                                                    ');
        deptArray.push('                     <div class="row">                                                                                     ');
        deptArray.push('                         <div class="col-xs-12">                                                                           ');
        deptArray.push('                             <div class="input-group ' + ele + '_search_' + index + '">                                                                     ');
        deptArray.push('                                 <input type="text" id="search_id_' + index + '" value="" class="form-control hide" name="search_id_' + index + '"/>   ');
        deptArray.push('                                 <input type="text" id="search_name_' + index + '" value="" class="form-control" name="search_name_' + index + '"/>    ');
        deptArray.push('                                 <div class="input-group-btn">                                                             ');
        deptArray.push('                                     <button type="button" class="btn btn-default no-border btn-sm" id="search-bt-' + index + '">        ');
        deptArray.push('                                         <i class="ace-icon fa fa-search icon-on-right bigger-110"></i>                    ');
        deptArray.push('                                     </button>                                                                             ');
        deptArray.push('                                 </div>                                                                                    ');
        deptArray.push('                             </div>                                                                                        ');
        deptArray.push('                         </div>                                                                                            ');
        deptArray.push('                     </div>                                                                                                ');
        deptArray.push('                 </form>                                                                                                   ');
        deptArray.push('                 <div class="hr hr-dotted"></div>                                                                          ');
        deptArray.push('                 <div class="content_wrap">                                                                                ');
        deptArray.push('                     <div class="zTreeDemoBackground scrollable left" data-size="400" style="width: 100%">                                     ');
        deptArray.push('                         <ul id="deptTree_' + index + '" class="ztree ' + ele + '_tree_' + index + '" style="height: 400px"></ul>                                       ');
        deptArray.push('                     </div>                                                                                                ');
        deptArray.push('                 </div>                                                                                                    ');
        deptArray.push('             </div>                                                                                                        ');
        deptArray.push('         </div>                                                                                                            ');
        deptArray.push('     </div>                                                                                                                ');

        $('#' + ele + 'Dialog_' + index).append(deptArray.join(''));

        //滚动条
        $('.scrollable').each(function () {
            var $this = $(this);
            $(this).ace_scroll({
                size: $this.attr('data-size') || 100
//                styleClass: 'scroll-left scroll-margin scroll-thin scroll-dark scroll-light no-track scroll-visible'
            });
        });

        return ele + 'Dialog_' + index;
    },
    initGridParam: function ($form) {
        var page = initGridParam.currentPage;
        initGridParam.currentPage = 1;
        var rowIndex = initGridParam.selectedRowIndex;
        initGridParam.selectedRowIndex = 0;
        var postData = $form.serializeObject();
        var primaryData = $form.serializeObject();
        if (initGridParam.gridSearchForm != null) {
            postData = initGridParam.gridSearchForm.serializeObject();
            if (G.compareObjKey(primaryData, postData)) {
                $form.parent().empty().html(initGridParam.gridSearchForm);
            } else {
                page = 1;
                rowIndex = 0;
                postData = primaryData;
            }
            initGridParam.gridSearchForm = null;
        }
        var initParam = {
            page: page,
            rowIndex: rowIndex,
            postData: postData,
            $form: $form
        }
        return initParam;
    },
    keepGridParam: function ($form, $grid) {
        initGridParam.currentPage = $grid.getGridParam('page');
        initGridParam.selectedRowIndex = $grid.getGridParam('selrow');
        initGridParam.gridSearchForm = $form;
    },
    compareObjKey: function (obj1, obj2) {
        for (var key in obj1) {
            if (!obj2.hasOwnProperty(key)) {
                return false;
            }
        }
        return true;
    },
    loadPageContent: function (href) {
        if (href.indexOf('?') != -1) {
            window.location.href = href + '&_date=' + new Date().getTime();
        } else {
            window.location.href = href + '?_date=' + new Date().getTime();
        }
    }

};

