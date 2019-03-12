package com.taiji.frame.common.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.Base64Utils;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * Created by CHX on 2016/3/10.
 */
public class FileUtil {

    public static final Logger logger = LoggerFactory.getLogger(FileUtil.class);

    public static Map uploadFile(MultipartFile file,String fileDir) throws Exception{

        FileOutputStream fos = null;
        InputStream inputStream = null;
        Map<String,Object> map = new HashMap<>();
        try{
            File saveFile = new File(fileDir);
            if(!saveFile.exists()){
                saveFile.mkdirs();
            }

            String originalFilename = file.getOriginalFilename();
            String [] nameArray = originalFilename.split("\\.");
            String fileName;
            if (nameArray.length < 2) {
                fileName = fileDir + UUID.randomUUID();
            } else {
                fileName = fileDir + UUID.randomUUID() +
                        originalFilename.substring(originalFilename.lastIndexOf("."));
            }
            fos = new FileOutputStream(fileName) ;
            inputStream = file.getInputStream();
            byte[] bytes = new byte[4096];
            int bytesRead;
            while ((bytesRead = inputStream.read(bytes)) != -1){
                fos.write(bytes,0,bytesRead);
            }
            map.put("realName",originalFilename);
            map.put("fileDir",fileName);
            fos.flush();
        }catch (IOException e){
            logger.debug(e.getMessage(),e);
        }finally {
            if(null != inputStream){
                inputStream.close();
            }
            if(null != fos){
                fos.close();
            }
        }

        return map;

    }

    /**
     * 下载文件
     * @param fileName
     * @param path
     * @param response
     * @param request
     * @param type
     * @throws IOException
     */
    public static void downOrPreview(String fileName, String path, HttpServletResponse response, HttpServletRequest request, String type) throws IOException {
        BufferedInputStream bis = null;
        BufferedOutputStream bos = null;
        try {
            response = setting(fileName,response,request,type);
            bis = new BufferedInputStream(new FileInputStream(path));
            bos = new BufferedOutputStream(response.getOutputStream());
            byte[] buff = new byte[2048];
            int bytesRead;
            while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
                bos.write(buff, 0, bytesRead);
            }
            bos.flush();
        } catch (Exception e) {
            logger.debug(e.getMessage(), e);
        } finally {
            if (null != bis) {
                bis.close();
            }
            if (null != bos) {
                bos.close();
            }
        }
    }

    public static HttpServletResponse setting(String fileName,HttpServletResponse response,HttpServletRequest request,String type) throws Exception{
        String header = request.getHeader("User-Agent");
        if (header.toLowerCase().indexOf("firefox") > 0) {
            fileName = "=?UTF-8?B?" + Base64Utils.encodeToString(fileName.getBytes("UTF-8")) + "?=";
        } else if (header.toUpperCase().indexOf("MSIE") > 0) {
            fileName = URLEncoder.encode(fileName, "UTF-8");
        } else {
            fileName = URLEncoder.encode(fileName, "UTF-8");
            fileName = encodeContent(fileName);
        }
        response.reset();
        if ("0".equals(type)){
            response.setHeader("Content-Disposition", "attachment; filename=" + fileName);
            response.setContentType("application/octet-stream;charset=UTF-8");
        }else{
            response.setHeader("Content-Disposition", "filename=" + new String(fileName.getBytes("utf-8"), "ISO8859-1"));
        }
        return response;
    }

    public static String encodeContent(String s) throws UnsupportedEncodingException {
        if (null != s){
            s =new String(s.getBytes("iso8859_1"),"utf-8");
        }
        return s;
    }
}
