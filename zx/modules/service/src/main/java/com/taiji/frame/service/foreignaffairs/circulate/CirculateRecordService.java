package com.taiji.frame.service.foreignaffairs.circulate;

import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.circulate.CirculateRecord;
import com.taiji.frame.model.entity.foreignaffairs.file.FileManage;
import com.taiji.frame.model.entity.foreignaffairs.telegraph.TelegraphManage;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.circulate.CirculateRecordVo;
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

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 传阅服务
 * @author qzp
 * @date 2018/07/25
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class CirculateRecordService extends BaseDAO<CirculateRecord> {
    private static final Logger log = LoggerFactory.getLogger(CirculateRecordService.class);

    @Autowired
    private UtilService utilService;
    @Autowired
    private SysLogService sysLogService;


    @Transactional(rollbackFor = Exception.class)
    public void saveTelegraphCirculate(CirculateRecordVo circulateRecordVo, SysLogVo sysLogVo) throws ParseException {
        CirculateRecord circulateRecord = new CirculateRecord();
        String telegraphId = circulateRecordVo.getTelegraphId();
        TelegraphManage telegraphManage = new TelegraphManage();
        telegraphManage.setId(telegraphId);
        circulateRecord.setTelegraphManage(telegraphManage);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String lendTime = circulateRecordVo.getLendTimeStr();
        circulateRecord.setLendTime(sdf.parse(lendTime));
        String archiveFlag = circulateRecordVo.getArchiveFlag();
        circulateRecord.setArchiveFlag(archiveFlag);
        String returnTime = circulateRecordVo.getReturnTimeStr();
        circulateRecord.setReturnTime(sdf.parse(returnTime));
        String destination = circulateRecordVo.getDestination();
        circulateRecord.setDestination(destination);
        String circulation = circulateRecordVo.getCirculation();
        circulateRecord.setCirculation(circulation);
        // 设置更新时间
        Date updateTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT);
        circulateRecord.setUpdateTime(updateTime);
        Date createTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT);
        circulateRecord.setCreateTime(createTime);
        circulateRecord.setDelFlag("0");
        try {
            this.save(circulateRecord);
            sysLogVo.setTypeName("保存电报传阅服务");
                sysLogVo.setRecordType(0);
            sysLogVo.setEntityName(circulateRecord.getNotes());
            sysLogVo.setEntityId(circulateRecord.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            log.error("保存电报传阅信息失败" + e.getMessage(),e);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public void saveFileCirculate(CirculateRecordVo circulateRecordVo,SysLogVo sysLogVo) throws ParseException  {
        String fileId = circulateRecordVo.getFileId();
        FileManage fileManage = new FileManage();
        fileManage.setId(fileId);
        CirculateRecord circulateRecord = new CirculateRecord();
        circulateRecord.setFileManage(fileManage);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String lendTimeStr = circulateRecordVo.getLendTimeStr();
        circulateRecord.setLendTime(sdf.parse(lendTimeStr));
        String returnTimeStr = circulateRecordVo.getReturnTimeStr();
        circulateRecord.setReturnTime(sdf.parse(returnTimeStr));

        String archiveFlag = circulateRecordVo.getArchiveFlag();
        circulateRecord.setArchiveFlag(archiveFlag);
        String destination = circulateRecordVo.getDestination();
        circulateRecord.setDestination(destination);
        String circulation = circulateRecordVo.getCirculation();
        circulateRecord.setCirculation(circulation);
        // 设置更新时间
        Date updateTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT);
        circulateRecord.setUpdateTime(updateTime);
        Date createTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT);
        circulateRecord.setCreateTime(createTime);
        circulateRecord.setDelFlag("0");
        try {
            this.save(circulateRecord);
            sysLogVo.setTypeName("保存文件传阅服务");
            sysLogVo.setRecordType(0);
            sysLogVo.setEntityName(circulateRecord.getNotes());
            sysLogVo.setEntityId(circulateRecord.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        }catch (Exception e){
            log.error("保存文件传阅信息失败" + e.getMessage(),e);
        }
    }

    @Transactional(rollbackFor = Exception.class)
    public Map<String,List<CirculateRecord>> findByTelegraphId(String id) {
        Map<String, List<CirculateRecord>> recordMap = new LinkedHashMap<>();
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from CirculateRecord cr where 1 = 1");
        if (StringUtils.isNotEmpty(id)){
            hql.append(" and cr.telegraphManage.id = :id");
            params.put("id",id);
        }
        hql.append(" order by cr.createTime desc");
        List<CirculateRecord> list = find(hql.toString(), params);
        for (CirculateRecord circulateRecord:list) {
            String createTime = DateUtil.dateToString(circulateRecord.getCreateTime(), DateUtil.FORMAT_DAY);
            if (recordMap.containsKey(createTime)){
                List<CirculateRecord> records = recordMap.get(createTime);
                records.add(circulateRecord);
            }else {
                List<CirculateRecord> records = new ArrayList<>();
                records.add(circulateRecord);
                recordMap.put(createTime,records);
            }
        }
        return recordMap;
    }

    @Transactional(rollbackFor = Exception.class)
    public Map<String,List<CirculateRecord>> findByFileId(String id) {
        Map<String, List<CirculateRecord>> recordMap = new LinkedHashMap<>();
        Map<String, Object> params = new HashMap<>();
        StringBuffer hql = new StringBuffer(" from CirculateRecord cr where 1 = 1");
        if (StringUtils.isNotEmpty(id)){
            hql.append(" and cr.fileManage.id = :id");
            params.put("id",id);
        }
        hql.append(" order by cr.createTime desc");
        List<CirculateRecord> list = find(hql.toString(), params);
        for (CirculateRecord circulateRecord:list) {
            String createTime = DateUtil.dateToString(circulateRecord.getCreateTime(), DateUtil.FORMAT_DAY);
            if (recordMap.containsKey(createTime)){
                List<CirculateRecord> records = recordMap.get(createTime);
                records.add(circulateRecord);
            }else {
                List<CirculateRecord> records = new ArrayList<>();
                records.add(circulateRecord);
                recordMap.put(createTime,records);
            }
        }
        return recordMap;
    }
}
