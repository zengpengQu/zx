package com.taiji.frame.controller.systempara;

import com.taiji.frame.BaseController;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicUserService;
import com.taiji.frame.service.systempara.WstResourceService;
import com.taiji.frame.util.UtilService;
import com.westone.middleware.toolkit.trustService.TrustServiceException;
import com.westone.middleware.toolkit.trustService.data.SignatureContent;
import com.westone.middleware.toolkit.trustService.data.TrustServiceMessage;
import com.westone.middleware.toolkit.trustService.data.TrustServiceResponse;
import com.westone.middleware.toolkit.trustService.resource.Resource;
import com.westone.middleware.toolkit.trustService.utils.RequestType;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Controller
@RequestMapping(value = "/saveresource")
public class WstResourceController extends BaseController {

    private static final Logger log = LoggerFactory.getLogger(WstResourceController.class);

    @Autowired
    UtilService utilService;

    @Autowired
    DicUserService dicUserService;

    @Autowired
    DicDeptService dicDeptService;

    @Autowired
    WstResourceService wstResourceService;

    @RequestMapping(method = RequestMethod.POST)
    public void saveResource(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        //返回消息
        TrustServiceResponse tsResponse = new TrustServiceResponse();


        // TODO Auto-generated method stub
        String requestParam = req.getParameter("request");
        if (requestParam == null || requestParam.equals("")) {
            throw new NullPointerException("数据格式不正确或数据为空");
        }
        if (requestParam != null && requestParam.length() > 0) {
            SignatureContent sc;
            TrustServiceMessage tsm;
            try {
                tsm=new TrustServiceMessage(requestParam);
                sc = new SignatureContent(
                        new TrustServiceMessage(requestParam)
                                .getSignatureContent());
                if (sc == null) {
                    throw new NullPointerException("数据格式不正确或数据为空");
                }


                if (sc.getContent().getResources().getOperation()
                        .getRequestType().equals(RequestType.push.toString())) {
                    System.out.println(sc.getContent().getResources().getResourceList());

                } else if (sc.getContent().getResources().getOperation()
                        .getRequestType()
                        .equals(RequestType.push_cancel.toString())) {
                    System.out.println(sc.getContent().getResources().getResourceList());

                }

                for(Resource rc:sc.getContent().getResources().getResourceList()){
//					Permission permission = new Permission(rc.getSignatureContent());
//					System.out.println(permission);
//					if (permission.getContent() == null
//							|| permission.getContent().size() == 0) {
//						continue;
//					}
//					System.out.println(permission);

                    if ("Organization".equalsIgnoreCase(rc.getType())) {
                        wstResourceService.saveOrg(rc, tsResponse);
                    } else if("user".equalsIgnoreCase(rc.getType())){
                        wstResourceService.saveUser(rc, tsResponse);

                    }
                }



//				System.out.println("tsm:" + tsm);
//				System.out.println("sc.getcontent.getresources:" + sc.getContent().getResources());
//				System.out.println("sc.getcontent.getresources.getresourcelist:" + sc.getContent().getResources().getResourceList());
//
//				StringBuilder sb = new StringBuilder();
//				sb.append("tsm:" + tsm);
//				sb.append("sc.getcontent.getresources:" + sc.getContent().getResources());
//				sb.append("sc.getcontent.getresources.getresourcelist:" + sc.getContent().getResources().getResourceList());
//				FileUtilities.write("resource.txt", sb.toString(), "utf-8", true);
//				tsResponse.setStatus(0);
            } catch (TrustServiceException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
                tsResponse.setStatus(1);
                tsResponse.setFailReason("消息接受失败");
            }

        }

        //返回消息
        TrustServiceMessage tsrResponseMsg=new TrustServiceMessage();
        SignatureContent sigResponse=new SignatureContent();
        sigResponse.setContent(new SignatureContent.Content(tsResponse));
        tsrResponseMsg.setSignatureContent(sigResponse.toBytes("utf-8"));

        resp.getWriter().write(new String(tsrResponseMsg.toBytes("utf-8")));

    }

}
