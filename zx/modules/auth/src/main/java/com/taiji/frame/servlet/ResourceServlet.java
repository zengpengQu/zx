package com.taiji.frame.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.service.systempara.DicDeptService;
import com.taiji.frame.service.systempara.DicUserService;
import com.westone.middleware.toolkit.trustService.TrustServiceException;
import com.westone.middleware.toolkit.trustService.authorization.Permission;
import com.westone.middleware.toolkit.trustService.authorization.Permission.Policy;
import com.westone.middleware.toolkit.trustService.data.SignatureContent;
import com.westone.middleware.toolkit.trustService.data.TrustServiceMessage;
import com.westone.middleware.toolkit.trustService.data.TrustServiceResponse;
import com.westone.middleware.toolkit.trustService.data.SignatureContent.Content;
import com.westone.middleware.toolkit.trustService.resource.Resource;
import com.westone.middleware.toolkit.trustService.utils.RequestType;
import com.westone.utilities.FileUtilities;
/*
 * 资源接收
 */
public class ResourceServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		
		//返回消息
		TrustServiceResponse tsResponse=new TrustServiceResponse();
		
		
		// TODO Auto-generated method stub
		String requestParam = req.getParameter("request");
		if (requestParam == null || requestParam.equals("")) {
			throw new NullPointerException("数据格式不正确或数据为空");
		}
		if (requestParam != null && requestParam.length() > 0) {
			// ����request
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
					Permission permission = new Permission(rc.getSignatureContent());
					System.out.println(permission);
					if (permission.getContent() == null
							|| permission.getContent().size() == 0) {
					}
					System.out.println(permission);

					if (rc.getType().equalsIgnoreCase("user")) {


					} else if(rc.getType().equalsIgnoreCase("information")){

						for (Policy policy : permission.getContent()) {
							System.out.println(policy);
						}
					}
				}

				DicDeptService dicDeptService = new DicDeptService();
				DicUserService dicUserService = new DicUserService();

				DicUser dicUser = null;



				System.out.println("tsm:" + tsm);
				System.out.println("sc.getcontent.getresources:" + sc.getContent().getResources());
				System.out.println("sc.getcontent.getresources.getresourcelist:" + sc.getContent().getResources().getResourceList());

				StringBuilder sb = new StringBuilder();
				sb.append("tsm:" + tsm);
				sb.append("sc.getcontent.getresources:" + sc.getContent().getResources());
				sb.append("sc.getcontent.getresources.getresourcelist:" + sc.getContent().getResources().getResourceList());
				FileUtilities.write("resource.txt", sb.toString(), "utf-8", true);


				tsResponse.setStatus(0);
			} catch (TrustServiceException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				tsResponse.setStatus(1);
				tsResponse.setFailReason("消息接受失败及原因");
			}

		}
		
		
		//返回消息
		TrustServiceMessage tsrResponseMsg=new TrustServiceMessage();
		SignatureContent sigResponse=new SignatureContent();
		sigResponse.setContent(new Content(tsResponse));
		tsrResponseMsg.setSignatureContent(sigResponse.toBytes("utf-8"));
		
		resp.getWriter().write(new String(tsrResponseMsg.toBytes("utf-8")));
		
		
		

	}

}
