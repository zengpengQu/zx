package com.taiji.frame.service;

import com.westone.middleware.toolkit.trustService.TrustServiceException;
import com.westone.middleware.toolkit.trustService.authorization.AuthentificationClient;
import com.westone.middleware.toolkit.trustService.authorization.AuthentificationResponse;
import com.westone.middleware.toolkit.trustService.data.TrustServiceMessage;

/*
 * 在线鉴权
 */
public class AuthentificationService {
	public static void main(String[] args) {
		String remoteAddress="http://192.168.2.21:9011/pa/check";
		String appIdString="82e2aabf-6a3d-49cc-9036-f4692b5906f2";
//		String subjectNoString="ef8a5b64-b7a4-4f04-b300-98f420815930";
//		String objectNoString="82e2aabf-6a3d-49cc-9036-f4692b5906f2";
		
		String subjectNoString="82e2aabf-6a3d-49cc-9036-f4692b5906f2";
		String objectNoString="ef8a5b64-b7a4-4f04-b300-98f420815930";
		AuthentificationClient aClient=new AuthentificationClient(remoteAddress, appIdString);
		TrustServiceMessage tsm=aClient.authenticate(subjectNoString, objectNoString);
		AuthentificationResponse auResponse;
		try {
			auResponse = new AuthentificationResponse(tsm.getSignatureContent());
			if(auResponse.getContent().getResult().getStatus()==0){
				System.out.println(auResponse.getContent().getResult().getPolicy());
				
			}else{
				System.out.println(auResponse.getContent().getResult().getFailReason());
			}
			
		} catch (TrustServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
