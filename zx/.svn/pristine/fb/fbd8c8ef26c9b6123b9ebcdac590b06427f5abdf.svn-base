package com.taiji.frame.service.foreignaffairs.telegraph;

import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.telegraph.TelegraphManage;
import com.taiji.frame.model.entity.foreignaffairs.telegraph.TelegraphManageFile;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.systempara.DicUser;
import com.taiji.frame.model.systempara.SysLog;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.telegraph.TelegraphManageVo;
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
 * 电报管理服务
 * @author qzp
 * @date 2018/07/25
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class TelegraphManageService extends BaseDAO<TelegraphManage> {
    private static final Logger log = LoggerFactory.getLogger(CirculateRecordService.class);

    @Autowired
    private UtilService utilService;


    @Autowired
    private TelegraphManageFileService telegraphManageFileService;

    @Autowired
    private DicUploadFileService dicUploadFileService;
    @Autowired
    private SysLogService sysLogService;


    /**
     * 电报管理表格展示
     * @param carrier
     * @param map
     */
    @Transactional(rollbackFor = Exception.class)
    public void load(Carrier<TelegraphManage> carrier, HashMap map) {
        StringBuffer hql = new StringBuffer();
        hql.append(" from TelegraphManage tm where 1 = 1");
        if (map.containsKey("secClass")){
            hql.append(" and tm.secClass like :secClass");
        }
        if (map.containsKey("telegramType")){
            hql.append(" and tm.telegramType like :telegramType");
        }
        if (map.containsKey("receiveTime")){
            hql.append(" and to_char(tm.receiveTime,'yyyy-MM-dd') = :receiveTime");
        }
        if (map.containsKey("recoder")){
            hql.append(" and tm.dicUser.empName like :recoder");
        }
        hql.append(" and tm.delFlag = '0'");
        find(carrier,hql.toString(),map);
    }


    @Transactional(rollbackFor = Exception.class)
    public TelegraphManage setTelegraphManage(TelegraphManage telegraphManage,TelegraphManageVo telegraphManageVo, DicUser curUser) throws ParseException {
        String inSerialNum = telegraphManageVo.getInSerialNum();
        telegraphManage.setInSerialNum(inSerialNum);
        String receiveTimeStr = telegraphManageVo.getReceiveTimeStr();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        telegraphManage.setReceiveTime(sdf.parse(receiveTimeStr));
        String telegramNum = telegraphManageVo.getTelegramNum();
        telegraphManage.setTelegramNum(telegramNum);
        String secClass = telegraphManageVo.getSecClass();
        telegraphManage.setSecClass(secClass);
        String telegramType = telegraphManageVo.getTelegramType();
        telegraphManage.setTelegramType(telegramType);
        String quantity = telegraphManageVo.getQuantity();
        telegraphManage.setQuantity(quantity);
        String senderOrg = telegraphManageVo.getSenderOrg();
        telegraphManage.setSenderOrg(senderOrg);
        String telegramTitle = telegraphManageVo.getTelegramTitle();
        telegraphManage.setTelegramTitle(telegramTitle);
        telegraphManage.setDicUser(curUser);
        // 设置更新时间
        Date updateTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        telegraphManage.setUpdateTime(updateTime);
        telegraphManage.setDelFlag("0");
        return telegraphManage;
    }


    @Transactional(rollbackFor = Exception.class)
    public void saveTelegraphManageFile(TelegraphManage telegraphManage, DicUploadFile dicUploadFile) {
        Assert.notNull(telegraphManage, "telegraphManage must not be null");
        Assert.notNull(dicUploadFile, "dicUploadFile must not be null");

        TelegraphManageFile telegraphManageFile = new TelegraphManageFile();
        telegraphManageFile.setDicUploadFile(dicUploadFile);
        telegraphManageFile.setTelegraphManage(telegraphManage);
        telegraphManageFile.setSeq(0);
        try {
            telegraphManageFileService.save(telegraphManageFile);
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> saveData(TelegraphManageVo telegraphManageVo, String basePath, DicUser curUser, SysLogVo sysLogVo) {
        Map<String, Object> map = new HashMap<>();
        String dstDir = UploadConstant.telegraphManage;
        TelegraphManage telegraphManage = null;
        String telegraphId = telegraphManageVo.getTelegraphId();
        try {
            if (StringUtils.isNotEmpty(telegraphId)){
                //编辑
                telegraphManage = this.get(telegraphId);
                //给对象属性赋值
                this.setTelegraphManage(telegraphManage,telegraphManageVo,curUser);
                this.save(telegraphManage);
                //附件上传
                String fileIds = telegraphManageVo.getFileIds();
                if (StringUtils.isNotEmpty(fileIds)) {
                    JSONArray jsonArray = JSONArray.fromObject(fileIds);

                    for (Object json : jsonArray) {
                        JSONObject jsonObject = JSONObject.fromObject(json);
                        String fileId = String.valueOf(jsonObject.get("fileId"));

                        Boolean isExist = checkIsExist(telegraphId, fileId);
                        if (!isExist) {
                            //不存在
                            DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                            dicUploadFileService.transfer(uploadFile, dstDir);
                            TelegraphManageFile file = telegraphManageFileService.getTelegraphFile(fileId);
                            if (file != null) {
                                //之前上传过附件,更新
                                file.setDicUploadFile(uploadFile);
                                telegraphManageFileService.save(file);
                            } else {
                                //原本就不存在附件,新增
                                this.saveTelegraphManageFile(telegraphManage, uploadFile);
                            }
                        }
                    }
                }
                map.put("result",true);
            }else {
                //新增
                telegraphManage = new TelegraphManage();
                //设置创建时间
                telegraphManage.setCreateTime(new Date());
                //给对象属性赋值
                this.setTelegraphManage(telegraphManage,telegraphManageVo,curUser);
                this.save(telegraphManage);
                //附件上传
                String fileIds = telegraphManageVo.getFileIds();
                if (StringUtils.isNotEmpty(fileIds)) {
                    JSONArray jsonArray = JSONArray.fromObject(fileIds);
                    for (Object json : jsonArray) {
                        JSONObject jsonObject = JSONObject.fromObject(json);
                        String fileId = String.valueOf(jsonObject.get("fileId"));

                        DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                        try {
                            dicUploadFileService.transfer(uploadFile, dstDir);
                            this.saveTelegraphManageFile(telegraphManage, uploadFile);
                        } catch (Exception e) {
                            e.printStackTrace();
                            map.put("result",false);
                            return map;
                        }
                    }
                }
                map.put("result",true);
                sysLogVo.setTypeName("出访信息");
                if(org.apache.commons.lang.StringUtils.isEmpty(telegraphId)){
                    sysLogVo.setRecordType(0);
                }else {
                    sysLogVo.setRecordType(1);
                }
                sysLogVo.setEntityName(telegraphManage.getTelegramTitle());
                sysLogVo.setEntityId(telegraphManage.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            log.error("电报信息失败" + e.getMessage(),e);
            map.put("result",false);
            return map;
        }
        return map;
    }

    @Transactional(rollbackFor = Exception.class)
    public Boolean checkIsExist(String telegraphId, String fileId) {
        Map<String, Object> params = new HashMap<String, Object>();
        StringBuffer hql = new StringBuffer(" from TelegraphManageFile t where 1 = 1");
        if (StringUtils.isNotEmpty(telegraphId)) {
            hql.append(" and t.telegraphManage.id = :telegraphId");
            params.put("telegraphId", telegraphId);
        }
        if (StringUtils.isNotEmpty(fileId)) {
            hql.append(" and t.dicUploadFile.id = :fileId");
            params.put("fileId", fileId);
        }
        List<TelegraphManageFile> list = find(hql.toString(), params);
        if (null != list && list.size() > 0) {
            return true;
        } else {
            return false;
        }
    }
}
