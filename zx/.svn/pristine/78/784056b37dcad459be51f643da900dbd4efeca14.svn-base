package com.taiji.frame.service.pubinfo.supervision;

import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.pubinfo.schedule.WorkFeedback;
import com.taiji.frame.model.entity.pubinfo.supervision.SupervisionFeedBack;
import com.taiji.frame.model.entity.pubinfo.supervision.SupervisionFeedBackFile;
import com.taiji.frame.model.entity.pubinfo.supervision.SupervisionMatter;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.pubinfo.supervision.SupervisionFeedBackVo;
import com.taiji.frame.service.systempara.DicUploadFileService;
import com.taiji.frame.service.systempara.SysLogService;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.UtilService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.Assert;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author qzp
 * @date 2018/08/23
 * 督查事项反馈服务
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class SupervisionFeedBackService extends BaseDAO<SupervisionFeedBack> {

    @Autowired
    private SupervisionFeedBackFileService supervisionFeedBackFileService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private SupervisionMatterService supervisionMatterService;

    @Autowired
    private UtilService utilService;

    @Autowired
    private SysLogService sysLogService;

    @Transactional(rollbackFor = Exception.class)
    public Map<String, Object> saveData(String id,String status,SupervisionFeedBackVo supervisionFeedBackVo, String basePath,
    SysLogVo sysLogVo) {
        HashMap<String, Object> map = new HashMap<>();
        String dstDir = UploadConstant.feedBack;
        String feedBackId = supervisionFeedBackVo.getFeedBackId();
        SupervisionFeedBack supervisionFeedBack = null;
        try {
            if (StringUtils.isNotEmpty(feedBackId)){
                //编辑
                supervisionFeedBack = this.get(feedBackId);
                this.setData(id,supervisionFeedBack,supervisionFeedBackVo);
                this.save(supervisionFeedBack);
                String fileId = supervisionFeedBackVo.getFileId();
                if (StringUtils.isNotEmpty(fileId)){
                    Boolean isExist = supervisionFeedBackFileService.isExist(fileId,feedBackId);
                    if (!isExist){
                        //不存在
                        DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                        dicUploadFileService.transfer(uploadFile,dstDir);
                        SupervisionFeedBackFile file = supervisionFeedBackFileService.getFeedBackFile(feedBackId);
                        if (file != null){
                            //之前上传过附件，更新
                            file.setDicUploadFile(uploadFile);
                            supervisionFeedBackFileService.save(file);
                        }else {
                            //原来就没有，新增
                            this.insertFile(uploadFile,supervisionFeedBack);
                        }
                    }
                }
            }
            map.put("result",true);
            map.put("id",id);
            sysLogVo.setTypeName("督查事项反馈");
            if (StringUtils.isNotEmpty(feedBackId)){
                sysLogVo.setRecordType(1);
            }else {
                sysLogVo.setRecordType(0);
            }
                sysLogVo.setEntityId("");
                sysLogVo.setEntityName("");
            sysLogVo.setResult(map.get("result").toString());
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            e.printStackTrace();
            map.put("result",false);
            return map;
        }
        return map;
    }

    //添加附件
//    @Transactional(rollbackFor = Exception.class)
    public void insertFile(DicUploadFile uploadFile, SupervisionFeedBack supervisionFeedBack) {
        Assert.notNull(supervisionFeedBack, "supervisionFeedBack must not be null");
        Assert.notNull(uploadFile, "uploadFile must not be null");
        SupervisionFeedBackFile supervisionFeedBackFile = new SupervisionFeedBackFile();
        supervisionFeedBackFile.setDicUploadFile(uploadFile);
        supervisionFeedBackFile.setSupervisionFeedBack(supervisionFeedBack);
        supervisionFeedBackFile.setSeq(0);
        try {
            supervisionFeedBackFileService.save(supervisionFeedBackFile);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void setData(String id,SupervisionFeedBack supervisionFeedBack, SupervisionFeedBackVo supervisionFeedBackVo) {
        SupervisionMatter supervisionMatter = new SupervisionMatter();
        supervisionMatter.setId(id);
        supervisionFeedBack.setSupervisionMatter(supervisionMatter);

        String unitId = supervisionFeedBackVo.getUnitId();
        DicDept dicDept = new DicDept();
        dicDept.setId(unitId);
        supervisionFeedBack.setUnit(dicDept);

        String name = supervisionFeedBackVo.getName();
        supervisionFeedBack.setName(name);

        String isTransfer = supervisionFeedBackVo.getIsTransfer();
        supervisionFeedBack.setIsTransfer(isTransfer);

        String feedBackDateStr = supervisionFeedBackVo.getFeedBackDateStr();
        supervisionFeedBack.setFeedBackDate(DateUtil.stringToDate(feedBackDateStr,DateUtil.FORMAT_DAY));

        String summary = supervisionFeedBackVo.getSummary();
        supervisionFeedBack.setSummary(summary);

        String status = supervisionFeedBackVo.getStatus();
        supervisionFeedBack.setStatus(status);

        String feedBackId = supervisionFeedBackVo.getFeedBackId();
        supervisionFeedBack.setId(feedBackId);

        supervisionFeedBack.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(),DateUtil.FORMAT));

        supervisionFeedBack.setDelFlag("0");
    }

    @Transactional(rollbackFor = Exception.class)
    public SupervisionFeedBack getByMatter(String id,String unitId) {
        HashMap<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from SupervisionFeedBack sb where 1 = 1");
        if (StringUtils.isNotEmpty(id)){
            hql.append(" and sb.supervisionMatter.id = :id");
            params.put("id",id);
        }
        if (StringUtils.isNotEmpty(unitId)){
            hql.append(" and sb.unit.id = :unitId");
            params.put("unitId",unitId);
        }
        hql.append(" and sb.delFlag = '0'");
        SupervisionFeedBack supervisionFeedBack = findUnique(hql.toString(), params);
        return supervisionFeedBack;
    }

    @Transactional(rollbackFor = Exception.class)
    public SupervisionFeedBack findByHostUnitIdAndMatterId(String id, String hostUnitId) {
        Map<String,Object> map = new HashMap<>(2);
        StringBuffer hql = new StringBuffer(" from SupervisionFeedBack sf where 1 = 1");
        if (!StringUtils.isEmpty(id)) {
            hql.append(" and sf.supervisionMatter.id = :id");
            map.put("id",id);
        }
        if (!StringUtils.isEmpty(hostUnitId)) {
            hql.append(" and sf.unit.id = :hostUnitId");
            map.put("hostUnitId",hostUnitId);
        }
        hql.append(" and sf.delFlag = '0'");
        SupervisionFeedBack supervisionFeedBack = findUnique(hql.toString(),map);
        return supervisionFeedBack;
    }

    @Transactional(rollbackFor = Exception.class)
    public void load(Carrier<SupervisionFeedBack> carrier, Map map) {
        StringBuffer hql = new StringBuffer(" from SupervisionFeedBack sf where 1 = 1");
        if (map.containsKey("matterId")) {
            hql.append(" and sf.supervisionMatter.id = :matterId");
        }
        if (map.containsKey("unitId")) {
            hql.append(" and sf.unit.id = :unitId");
        }
        if (map.containsKey("statusList")) {
            hql.append(" and sf.status in (:statusList)");
        }
        hql.append(" and sf.delFlag = '0'");
        find(carrier, hql.toString(), map);
    }

    @Transactional(rollbackFor = Exception.class)
    public List<SupervisionFeedBack> findByMatterIdAndStatus(String matterId, String status) {
        Map<String, Object> map = new HashMap<String, Object>(2);
        StringBuffer hql = new StringBuffer(" from SupervisionFeedBack sf where 1 = 1");
        if (StringUtils.isNotEmpty(matterId)){
            hql.append(" and sf.supervisionMatter.id = :matterId");
            map.put("matterId",matterId);
        }
        if (StringUtils.isNotEmpty(status)){
            hql.append(" and sf.status = :status");
            map.put("status",status);
        }
        hql.append(" and sf.delFlag = '0' order by sf.updateTime desc ");
        List<SupervisionFeedBack> list = find(hql.toString(),map);
        return list;
    }
}
