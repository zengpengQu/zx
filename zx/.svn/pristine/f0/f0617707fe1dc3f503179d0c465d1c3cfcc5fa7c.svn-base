package com.taiji.frame.service.foreignaffairs.file;

import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.file.FileManage;
import com.taiji.frame.model.entity.foreignaffairs.file.FileManageFile;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.file.FileManageVo;
import com.taiji.frame.service.foreignaffairs.circulate.CirculateRecordService;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/07/25
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class FileManageService extends BaseDAO<FileManage> {
    private static final Logger log = LoggerFactory.getLogger(CirculateRecordService.class);

    @Autowired
    private FileManageFileService fileManageFileService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private SysLogService sysLogService;

    /**
     * 文件管理表格展示
     * @param carrier
     * @param map
     */
    @Transactional(rollbackFor = Exception.class)
    public void load(Carrier<FileManage> carrier, HashMap map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from FileManage fm where 1 = 1");
        if (map.containsKey("secClassStr")){
            hql.append(" and fm.secClass = :secClassStr");
        }
        if (map.containsKey("fileType")){
            hql.append(" and fm.fileType = :fileType");
        }
        if (map.containsKey("receiveTime")){
            hql.append(" and to_char(fm.receiveTime,'yyyy-MM-dd') = :receiveTime");
        }
        if (map.containsKey("senderOrg")){
            hql.append(" and fm.senderOrg = :senderOrg");
        }
        hql.append(" and fm.delFlag = '0'");
        find(carrier,hql.toString(),map);
    }


    @Transactional(rollbackFor = Exception.class)
    public void setFileManageData(FileManageVo fileManageVo,FileManage fileManage) throws ParseException {
        String inSerialNum = fileManageVo.getInSerialNum();
        fileManage.setInSerialNum(inSerialNum);
        String receiveTimeSt = fileManageVo.getReceiveTimeSt();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        if (!StringUtils.isEmpty(receiveTimeSt)) {
            fileManage.setReceiveTime(sdf.parse(receiveTimeSt));
        }
        String senderOrg = fileManageVo.getSenderOrg();
        fileManage.setSenderOrg(senderOrg);
        String secClass = fileManageVo.getSecClassStr();
        fileManage.setSecClass(secClass);
        String fileNum = fileManageVo.getFileNum();
        fileManage.setFileNum(fileNum);
        String quantity = fileManageVo.getQuantity();
        fileManage.setQuantity(quantity);
        String secDeadline = fileManageVo.getSecDeadline();
        fileManage.setSecDeadline(secDeadline);
        String recycleStatus = fileManageVo.getRecycleStatus();
        fileManage.setRecycleStatus(recycleStatus);
        String fileType = fileManageVo.getFileType();
        fileManage.setFileType(fileType);
        String recycleProp = fileManageVo.getRecycleProp();
        fileManage.setRecycleProp(recycleProp);
        String fileTitle = fileManageVo.getFileTitle();
        fileManage.setFileTitle(fileTitle);
        // 设置更新时间
        Date updateTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN);
        fileManage.setUpdateTime(updateTime);
        fileManage.setDelFlag("0");
    }

    //新增或编辑---保存数据
    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> saveData(FileManageVo fileManageVo, String basePath, SysLogVo sysLogVo) {
        Map<String, Object> map = new HashMap<String, Object>();
        String dstDir = UploadConstant.fileManage;
        FileManage fileManage = null;
        String fileManageId = fileManageVo.getFileManageId();
        try {
            if (StringUtils.isNotEmpty(fileManageId)){
                //编辑
                fileManage = this.get(fileManageId);
                //给对象属性赋值
                this.setFileManageData(fileManageVo,fileManage);
                this.save(fileManage);
                //附件上传
                String fileIds = fileManageVo.getFileIds();
                if (StringUtils.isNotEmpty(fileIds)){
                    JSONArray jsonArray = JSONArray.fromObject(fileIds);

                    for(Object json : jsonArray) {
                        JSONObject jsonObject = JSONObject.fromObject(json);
                        String fileId = String.valueOf(jsonObject.get("fileId"));

                        Boolean isExist = checkIsExist(fileManageId, fileId);

                        if (!isExist) {
                            //不存在
                            DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                            dicUploadFileService.transfer(uploadFile, dstDir);
                            FileManageFile file = fileManageFileService.getFileManageFile(fileId);
                            if (file != null) {
                                //之前上传过附件,更新
                                file.setDicUploadFile(uploadFile);
                                fileManageFileService.save(file);
                            } else {
                                //原本就不存在附件,新增
                                this.saveFileManageFile(fileManage, uploadFile);
                            }
                        }
                    }
                }
                map.put("result",true);
            }else {
                //新增
                fileManage = new FileManage();
                //设置创建时间
                fileManage.setCreateTime(new Date());
                //给对象属性赋值
                this.setFileManageData(fileManageVo,fileManage);
                this.save(fileManage);
                //附件上传
                String fileIds = fileManageVo.getFileIds();
                if (StringUtils.isNotEmpty(fileIds)) {
                    JSONArray jsonArray = JSONArray.fromObject(fileIds);
                    for (Object json : jsonArray) {
                        JSONObject jsonObject = JSONObject.fromObject(json);
                        String fileId = String.valueOf(jsonObject.get("fileId"));
                        DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                        try {
                            dicUploadFileService.transfer(uploadFile, dstDir);
                            this.saveFileManageFile(fileManage, uploadFile);
                        } catch (Exception e) {
                            e.printStackTrace();
                            map.put("result",false);
                            return map;
                        }
                    }
                }
                map.put("result",true);
            }
            sysLogVo.setTypeName("文件管理");
            if(org.apache.commons.lang.StringUtils.isEmpty(fileManageId)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(fileManage.getFileTitle());
            sysLogVo.setEntityId(fileManage.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            log.error("文件信息失败" + e.getMessage(),e);
            map.put("result",false);
            return map;
        }
        return map;
    }

    @Transactional(rollbackFor = Exception.class)
    public Boolean checkIsExist(String fileManageId, String fileId) {
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from FileManageFile t where 1 = 1");
        if (StringUtils.isNotEmpty(fileManageId)) {
            hql.append(" and t.fileManage.id = :fileManageId");
            params.put("fileManageId", fileManageId);
        }
        if (StringUtils.isNotEmpty(fileId)) {
            hql.append(" and t.dicUploadFile.id = :fileId");
            params.put("fileId", fileId);
        }
        List<FileManageFile> list = find(hql.toString(), params);
        if (null != list && list.size() > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public void saveFileManageFile(FileManage fileManage, DicUploadFile uploadFile) {
        Assert.notNull(fileManage, "fileManage must not be null");
        Assert.notNull(uploadFile, "uploadFile must not be null");

        FileManageFile fileManageFile = new FileManageFile();
        fileManageFile.setDicUploadFile(uploadFile);
        fileManageFile.setFileManage(fileManage);
        fileManageFile.setSeq(0);
        fileManageFileService.save(fileManageFile);
    }
}
