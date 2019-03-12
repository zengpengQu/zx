package com.taiji.frame.service;

import java.io.UnsupportedEncodingException;

import com.westone.middleware.toolkit.trustService.TrustServiceException;
import com.westone.middleware.toolkit.trustService.timestamp.Timestamp;
import com.westone.middleware.toolkit.trustService.timestamp.TimestampClient;
import com.westone.middleware.toolkit.trustService.timestamp.TimestampVerifyResult;
import com.westone.security.cryptography.crypto.digests.SHA1Digest;
/*
 * 申请时间戳，验证时间戳
 */
public class TimestampService {
	//直接运行main函数
	public static void main(String[] args) throws UnsupportedEncodingException, TrustServiceException {
//				String url = "http://192.168.1.201:3018";
		String url = "http://192.168.2.22:9031/ts.tsp";

		String hashAlgorithm = "1.3.14.3.2.26";
		byte[] messge = new String("Westone").getBytes("utf-8");
/*
 * 摘要
 */
		SHA1Digest digest = new SHA1Digest();
		digest.reset();
		byte[] hashedMsg = new byte[digest.getDigestSize()];
		digest.update(messge, 0, messge.length);
		digest.doFinal(hashedMsg, 0);
		
		
		TimestampClient client = new TimestampClient(url);
		/*
		 * 申请时间戳
		 */
		Timestamp timestamp = client.request(hashAlgorithm, hashedMsg, false);
		System.out.println(timestamp.toString());
		
		/*
		 * 验证时间戳
		 */
		byte[] wrongMsg="123".getBytes();
		TimestampVerifyResult result=client.verify(hashedMsg, timestamp.getTimestampToken());
		TimestampVerifyResult wrongResult=client.verify(wrongMsg, timestamp.getTimestampToken());
		System.out.println(result.getStatusCode());
		System.out.println(result.getErrorString());
		System.out.println(wrongResult.getStatusCode());
		System.out.println(wrongResult.getErrorString());
		
	  
		
	}

}
