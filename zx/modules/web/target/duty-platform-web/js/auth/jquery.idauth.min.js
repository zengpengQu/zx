
/// <reference path="jquery.min.js" />

/* ===================================================================================
* 版权声明：Copyright (C) 1998-2016 Westone 版权所有
* 类    别：统一身份认证jquery扩展插件
* 文件描述：将统一身份认证前端功能以插件方式进行封装，方便调用。
* 创 建 人：张博
* ==================================================================================*/

$.extend({
    // 单点登录
    idauth: function (options) {
        var challengeUrl = options.challengeUrl;
        var idauthUrl = options.idauthUrl;
        var controlId = options.controlId;
        var webSocketUrl = options.webSocketUrl == undefined ? "ws://127.0.0.1:30318" : options.webSocketUrl;
        var simpleLoginUrl=options.simpleLoginUrl;
     
        if(options.onSubmit){
        	options.onSubmit();
        }
        $.ajax({
            type: "POST",
            url: challengeUrl,
            dataType: "json",
            success: function (data) {
            	if(data.code!=0){
            		if(options.onError){
            			if(simpleLoginUrl!=null)
            				window.location.href=simpleLoginUrl;
            			else
            				options.onError(data.message);
            		}else{
            			if(simpleLoginUrl!=null)
            				window.location.href=simpleLoginUrl;
            			else
            				alert(data.message);
            		}
            		   
            		   return false;
            	}
            	if(window.WebSocket){
            		//alert("websocket");
            		if(webSocketUrl.indexOf("36107")==-1)
            			$.idauthViaWebSocket2(data.message, webSocketUrl, idauthUrl, options);
            		else
            			$.idauthViaWebSocket(data.message, webSocketUrl, idauthUrl, options);
            	}else{
            		//alert("activex");
            		 $.idauthViaControl(data.message, controlId, idauthUrl, options);
            	}
               
            },
            error: function (data) {
            	if(simpleLoginUrl!=null)
    				window.location.href=simpleLoginUrl;
    			elsed
    				alert( data);
            }
        });
    },
    

    // 采用客户端控件技术获取认证数据
  idauthViaControl: function (challenge, controlId, idauthUrl, options) {
    	
        var control = document.getElementById(controlId);
        // 调用控件进行挑战数签名并获取身份票据
        var value=control.GetSignAndToken(challenge);
        if(control.lResult != 0){
          //$.messager.alert("提示", "获取票据失败", "info");
        	if(options.onError){
        		options.onError("客户端处理错误:"+control.bstrError);
        	}else{
        		 alert("客户端处理错误:"+control.bstrError);
        	}
          return false;
        }
       

        $.idauthSubmit(control.bstrSignValAndToken, idauthUrl, options);
    	
    	
    	
    },
    // 采用WebSocket技术获取认证数据
    idauthViaWebSocket: function (challenge, webSocketUrl, idauthUrl, options) {
        // 调用WebSocket进行挑战数签名并获取身份票据
        var body = "<body><plain><info><random>" + challenge + "</random></info></plain></body>";

        // 获取WebSocket消息体长度
        var bodyLength = 0;
        for (var i = 0; i < body.length; i++) {
            if (body.charAt(i).match(/^[\u4e00-\u9fa5]+$/)) {
                bodyLength += 3;
            } else {
                bodyLength++;
            }
        }

        bodyLength = String(bodyLength);
        var length = 10 - bodyLength.length;
        for (i = 0; i < length ; i++) {
            bodyLength = "0" + bodyLength;
        }

        // 创建到认证客户端WebSocket服务的连接
        var webSocket = new WebSocket(webSocketUrl);
        webSocket.onopen = function (event) {
//alert("websocket open");
            webSocket.send("<head><bsid>   ml0305c</bsid><bodylen>" + bodyLength + "</bodylen><digest_id>                    </digest_id><cipher_id>                    </cipher_id></head>" + body + "");
        }
        webSocket.onerror = function (event) {
            // 未登录时，没有进入到错误事件方法里
        	 if (options.onError) {
                 options.onError("客户端处理错误!");
             }
        }
        webSocket.onclose = function (event) {
           // alert("ws:close");
        }
        webSocket.onmessage = function (event) {
//alert(event.data);
            var signAndToken = event.data.split("</appendix>")[0].split("<appendix>")[1];
           
            $.idauthSubmit(signAndToken, idauthUrl, options);
        }
    },
    
    
    // 采用WebSocket技术获取认证数据
    idauthViaWebSocket2: function (challenge, webSocketUrl, idauthUrl, options) {
        // 调用WebSocket进行挑战数签名并获取身份票据
        var body = "<?xml version=\"1.0\" encoding=\"utf-8\"?><getsignandtokenreq version=\"1\"><challenge>"+challenge+"</challenge></getsignandtokenreq>";

        // 获取WebSocket消息体长度
        var bodyLength = 0;
        for (var i = 0; i < body.length; i++) {
            if (body.charAt(i).match(/^[\u4e00-\u9fa5]+$/)) {
                bodyLength += 3;
            } else {
                bodyLength++;
            }
        }

        bodyLength = String(bodyLength);
        var length = 10 - bodyLength.length;
        for (i = 0; i < length ; i++) {
            bodyLength = "0" + bodyLength;
        }

        // 创建到认证客户端WebSocket服务的连接
        var webSocket = new WebSocket(webSocketUrl);
        webSocket.onopen = function (event) {
//alert("websocket open");
            webSocket.send(body);
        }
        webSocket.onerror = function (event) {
            // 未登录时，没有进入到错误事件方法里
        	 if (options.onError) {
                 options.onError("客户端处理错误!");
             }
        }
        webSocket.onclose = function (event) {
            //alert("ws:close");
        }
        webSocket.onmessage = function (event) {
//alert(event.data);
        	var result=event.data.split("</result>")[0].split("<result>")[1];
        	if(result==0){
        		var signAndToken = event.data.split("</tokeninfo>")[0].split("<tokeninfo>")[1];
                
                $.idauthSubmit(signAndToken, idauthUrl, options);
        	}else{
        		var  errorinfo=event.data.split("</errorinfo>")[0].split("<errorinfo>")[1];
        		if (options.onError) {
                    options.onError(errorinfo);
                    
                }else{
               	 alert(errorinfo);
                }
        		
        		return false;
        	}
            
        }
    },
    
    
    // 提交认证
    idauthSubmit: function (signAndToken, idauthUrl, options) {
        // 由于未登录时，没有进入到错误事件方法里，因此这里先应急处理。
        if (signAndToken == "sign random error") {
        	 if (options.onError) {
                 options.onError("客户端处理错误，请确认是否进行身份认证！");
                 
             }else{
            	 alert( "客户端处理错误!");
             }
        	 return false;
        }
        if(signAndToken==""){
       	 if (options.onError) {
                options.onError("票据为空，客户端处理错误!");
            }else{
           	 alert("票据为空，客户端处理错误!");
            }
       	 return false;
       }
        
        $.ajax({
            type: "POST",
            dataType: "json",
            data: { signAndToken: signAndToken },
            url: idauthUrl,
            success: function (result) {
            	if(result.code==0){
            		 if (options.onSuccess) {
                         options.onSuccess();
                     }
           	}else {
           		if(options.onError){
            		options.onError(result.message);
            		}else{
            			alert(result.message);
            		}
               }
            },
            error: function (result) {
            	 if (options.onError) {
                     options.onError(result.responseText);
                 }else{
                	 alert(result);
                 }

                 return false;
            }
        });
    }
});
