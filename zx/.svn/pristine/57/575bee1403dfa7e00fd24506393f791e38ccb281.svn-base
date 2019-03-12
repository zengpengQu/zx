package com.taiji.frame.controller.foreignaffairs.bulletinBoard;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.common.util.FileUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.bulletinBoard.BulletinBoard;
import com.taiji.frame.model.entity.foreignaffairs.bulletinBoard.BulletinBoardFile;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.bulletinBoard.BulletinBoardVo;
import com.taiji.frame.service.foreignaffairs.bulletinBoard.BulletinBoardFileService;
import com.taiji.frame.service.foreignaffairs.bulletinBoard.BulletinBoardService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.SysLogService;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * 公告栏管理
 */
@Controller
@RequestMapping(value = "/bulletin-board")
public class BulletinBoardController extends BaseController<BulletinBoard> {
    private static final Logger log = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private BulletinBoardService bulletinBoardService;

    @Autowired
    private BulletinBoardFileService bulletinBoardFileService;

    @Autowired
    private DicUploadFileService dicUploadFileService;
    @Autowired
    private SysLogService sysLogService;


    /**
     * 页面跳转
     * @return
     */
    @RequestMapping(value = "/jump-to-bulletin-board-list",method = RequestMethod.GET)
    /**
     * id 主页传入的ID 单条数据展示
     */
    public String jumpPage(Map<String, Object> map,String id){
            map.put("bulletinIndexMainId", id);
        return "foreignaffairs/bulletinBoard/bulletin-board-list";
    }

    /**
     * 公告栏列表
     * @param carrier
     * @param bulletinIndexMainId  单条数据ID
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-bulletin-board-list.do",produces = "text/html;charset=UTF-8")
    public String loadBulletinBoard(Carrier<BulletinBoard> carrier,String title,String publishTime,String publisher,String bulletinIndexMainId){
        HashMap map = new HashMap(16);
        try {
            if(!StringUtils.isEmpty(title)){
                map.put("title","%"+title+"%");
            }
            if(!StringUtils.isEmpty(publishTime)){
                map.put("publishTime",publishTime);
            }
            if (!StringUtils.isEmpty(publisher)){
                map.put("publisher","%"+publisher+"%");
            }
            //孙毅添加
            if (!StringUtils.isEmpty(bulletinIndexMainId)){
                map.put("bulletinIndexMainId",bulletinIndexMainId);
            }

            bulletinBoardService.load(carrier,map);
        }catch (Exception e){
            log.debug(e.getMessage(), e);
        }
        System.out.println("数据为："+gridResult(carrier));
            return gridResult(carrier);
    }

    /**
     * 页面跳转到编辑页面
     * 注：新增和编辑公用一个页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/load-bulletin-board-edit",method = RequestMethod.GET)
    public String jumpEditPage(ModelMap modelMap,String id){
        BulletinBoard bulletinBoard = null;
        String publishTime = null;
        if (!StringUtils.isEmpty(id)){
            bulletinBoard = bulletinBoardService.get(id);

            List<BulletinBoardFile> bulletinBoardFiles = new ArrayList<>();
            if (bulletinBoard != null) {
                publishTime = DateUtil.dateToString(bulletinBoard.getPublishTime(), DateUtil.FORMAT_DAY);
                List<BulletinBoardFile> files = bulletinBoardFileService.findByBulletinId(bulletinBoard.getId());
                bulletinBoardFiles.addAll(files);
            }
            List<JSONObject> jsonFileObject = getFileData(bulletinBoardFiles);
            modelMap.addAttribute("jsonFileObject", jsonFileObject);
        }
        modelMap.addAttribute("bulletinBoard",bulletinBoard);
        modelMap.addAttribute("publishTime",publishTime);
        return "foreignaffairs/bulletinBoard/bulletin-board-edit";
    }

    /**
     * 新增或编辑保存数据
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-bulletin-board-save.do",method = RequestMethod.POST)
    public Map<String,Object> saveOrUpdateBulletinBoard(BulletinBoardVo bulletinBoardVo, HttpServletRequest request){
        String basePath = UploadConstant.uploadBaseDir;
        DicUser curUser = getCurUser();
        Map<String, Object> map = bulletinBoardService.saveData(bulletinBoardVo,basePath,curUser);
        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("公告栏");
        if(StringUtils.isEmpty(bulletinBoardVo.getId())){
            sysLogVo.setRecordType(0);
            sysLogVo.setEntityId(String.valueOf(map.get("id")));
        }else {
            sysLogVo.setRecordType(1);
            sysLogVo.setEntityId(bulletinBoardVo.getId());
        }
        sysLogVo.setEntityName(bulletinBoardVo.getTitle());
        sysLogVo.setResult("true");
        sysLogService.record(sysLogVo);
        map.remove("bulletinBoard");
        return map;
    }

    /**
     * 删除公告栏的某条数据信息
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-bulletin-board-delete.do",method = RequestMethod.POST)
    public Map<String,Object> delBulletinBoard(String id){
        HashMap map = new HashMap(3);
        try {
            //根据ID查找公告栏管理信息
            BulletinBoard bulletinBoard = bulletinBoardService.get(id);
            //设置删除标志为1
            bulletinBoard.setDelFlag("1");
            //保存数据
            bulletinBoardService.save(bulletinBoard);
            map.put("result",true);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("公告栏");
                sysLogVo.setRecordType(2);
            sysLogVo.setEntityName(bulletinBoard.getTitle());
            sysLogVo.setEntityId(bulletinBoard.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            log.debug(e.getMessage(),e);
            map.put("result",false);
        }
        return map;
    }

    /**
     * 获取公告栏的文件列表
     *
     * @param modelMap
     * @param id
     */
    @ResponseBody
    @RequestMapping(value = "/get-bulletin-file-list.do", method = RequestMethod.POST)
    public Map<String, Object> getReceptionFileList(ModelMap modelMap, String id) {
        Map<String, Object> map = new HashMap<>(1);

        if (StringUtils.isNotEmpty(id)) {
            BulletinBoard bulletinBoard = bulletinBoardService.get(id);
            List<BulletinBoardFile> receptionFiles = new ArrayList<>();
            if (null != bulletinBoard) {
                List<BulletinBoardFile> files = bulletinBoardFileService.findByBulletinId(bulletinBoard.getId());
                receptionFiles.addAll(files);
            }

            List<JSONObject> fileList = getFileData(receptionFiles);
            map.put("fileList", fileList);
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("获取公告栏的文件列表");
            sysLogVo.setRecordType(18);
            sysLogVo.setEntityName("");
            sysLogVo.setEntityId("");
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }

        return map;
    }

    /**
     * 获公告栏文件信息
     * @param fileList
     * @return
     */
    private List<JSONObject> getFileData(List<BulletinBoardFile> fileList) {

        if (null == fileList || fileList.size() == 0) {
            return null;
        }
        List<JSONObject> jsonObjectList = new ArrayList<>();
        for (BulletinBoardFile file : fileList) {

            JSONObject jsonFileObject = new JSONObject();
            DicUploadFile dicUploadFile = file.getDicUploadFile();

            // 只显示状态为 1 的有效文件
            if (null != dicUploadFile && dicUploadFile.getStatus() == 1) {
                String fileId = dicUploadFile.getId();
                String fileName = dicUploadFile.getFileName();
                jsonFileObject.put("fileName", fileName);
                jsonFileObject.put("id", fileId);
                jsonObjectList.add(jsonFileObject);
            }
        }

        return jsonObjectList;
    }
    /**
     * 下载文件
     * @param id
     * @param response
     * @param request
     * @param type
     * @throws IOException
     */
    @RequestMapping(value = "/download.action")
    public void downloadFile(String id, HttpServletResponse response, HttpServletRequest request, String type) throws IOException {
        DicUploadFile dicUploadFile = dicUploadFileService.get(id);
        String fileName = dicUploadFile.getFileName();
        String path = dicUploadFile.getPath();

        SysLogVo sysLogVo = getSysLogVo();
        sysLogVo.setTypeName("下载文件");
        sysLogVo.setRecordType(14);
        sysLogVo.setEntityName(dicUploadFile.getFileName());
        sysLogVo.setEntityId(dicUploadFile.getId());
        sysLogVo.setResult("true");
        sysLogService.record(sysLogVo);
        //下载文件
        FileUtil.downOrPreview(fileName,path,response,request,type);
    }

}
