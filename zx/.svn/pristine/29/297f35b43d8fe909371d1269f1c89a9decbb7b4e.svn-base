package com.taiji.frame.controller.systempara;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.service.systempara.DicUploadFileService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

/**
 * 文件服务公共类
 * Created by yuLei on 2018/7/20.
 */
@Controller
@RequestMapping(value = "/file")
public class FileController extends BaseController {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private DicUploadFileService dicUploadFileService;

    /**
     * 上传文件
     */
    @ResponseBody
    @RequestMapping(value = "/upload-file.do", method = RequestMethod.POST)
    public Map<String, Object> uploadFile(@RequestParam("uploadFile") MultipartFile file,
                                          HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>(5);
        String uploadPath = UploadConstant.uploadBaseDir;
        try {
            map = dicUploadFileService.upload(file, uploadPath);
            map.put("result", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }

        return map;
    }

    /**
     * 上传文件
     */
    @ResponseBody
    @RequestMapping(value = "/upload-files.do", method = RequestMethod.POST)
    public Map<String, Object> uploadFiles(@RequestParam("uploadFile") MultipartFile[] files,
                                          HttpServletRequest request) {
        Map<String, Object> map = new HashMap<>(5);
        String uploadPath = UploadConstant.uploadBaseDir;
        try {
            map = dicUploadFileService.uploads(files, uploadPath);
            map.put("result", true);
        } catch (Exception e) {
            e.printStackTrace();
            map.put("result", false);
        }
        return map;
    }

    /**
     * 下载文件(也可作图片的回显)
     * @param id
     * @param response
     * @param request
     * @param type
     * @throws IOException
     */
    @Transactional
    @RequestMapping(value = "/download.action")
    public void download(String id, HttpServletResponse response, HttpServletRequest request, String type) throws IOException{
        String path;
        String fileName;
        DicUploadFile dicUploadFile = dicUploadFileService.get(id);
        fileName = dicUploadFile.getFileName();
        path = dicUploadFile.getPath();
        downOrPreview(fileName, path, response, request, type);
    }

    /**
     * 图片回显(用于上传成功后临时路径的回显)
     * @param fileId
     * @param response
     * @param request
     * @param type
     * @throws IOException
     */
    @Transactional
    @RequestMapping(value = "/show-image.action")
    public void showImage(String fileId, HttpServletResponse response, HttpServletRequest request, String type) throws IOException{
        String path;
        String fileName;
        DicUploadFile dicUploadFile = dicUploadFileService.get(fileId);
        fileName = dicUploadFile.getFileName();
        path = dicUploadFile.getTempPath();//回显图片显示的是临时路径
        downOrPreview(fileName, path, response, request, type);
    }

    /**
     * 文件下载
     * @param fileName
     * @param path
     * @param response
     * @param request
     * @throws IOException
     */
    public void downOrPreview(String fileName,String path, HttpServletResponse response,HttpServletRequest request,String type) throws IOException {
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
            LOG.debug(e.getMessage(), e);
        } finally {
            if (null != bis) {
                bis.close();
            }
            if (null != bos) {
                bos.close();
            }
        }
    }

    /**
     * 设置报文
     * @param fileName
     * @param response
     * @param request
     * @return
     * @throws Exception
     */
    public static HttpServletResponse setting(String fileName,HttpServletResponse response,HttpServletRequest request,String type) throws Exception{
        String header = request.getHeader("User-Agent");
        if (header.toLowerCase().indexOf("firefox") > 0) {
            fileName = "=?UTF-8?B?" + Base64Utils.encodeToString(fileName.getBytes("UTF-8")) + "?=";
        } else if (header.toUpperCase().indexOf("MSIE") > 0) {
            fileName = URLEncoder.encode(fileName, "UTF-8");
        } else {
            fileName = URLEncoder.encode(fileName, "UTF-8");
            if (null != fileName){
                fileName =new String(fileName.getBytes("iso8859_1"),"utf-8");
            }
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

    /**
     * 删除文件
     * @param id
     */
    @ResponseBody
    @RequestMapping(value = "/delete-file.do", method = RequestMethod.POST)
    public Map<String, Object> logicDeleteFile(String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {

            DicUploadFile dicUploadFile = dicUploadFileService.get(id);

            // 设置要删除的文件状态为2
            if (null != dicUploadFile) {
                dicUploadFile.setStatus(2);
                try {
                    dicUploadFileService.save(dicUploadFile);
                    map.put("result", true);
                } catch (Exception e) {
                    LOG.debug(e.getMessage(), e);
                    map.put("result", false);
                }
            } else {
                map.put("result", false);
            }
        }

        return map;
    }
}
