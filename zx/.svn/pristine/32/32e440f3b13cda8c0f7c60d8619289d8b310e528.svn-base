package com.taiji.frame.service.foreignaffairs.taiwan;

import com.taiji.frame.common.constants.UploadConstant;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.model.entity.foreignaffairs.taiwan.TaiWanParty;
import com.taiji.frame.model.entity.foreignaffairs.taiwan.TaiWanPartyFile;
import com.taiji.frame.model.entity.foreignaffairs.taiwan.TaiWanPolitics;
import com.taiji.frame.model.systempara.DicUploadFile;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.taiwan.TaiWanPartyVo;
import com.taiji.frame.model.vo.taiwan.TaiWanPoliticsVo;
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

import java.text.ParseException;
import java.util.*;

/**
 * @author qzp
 * @date 2018/08/07
 * 台湾社团信息服务
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class TaiWanPartyService extends BaseDAO<TaiWanParty> {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanPartyService.class);

    @Autowired
    private UtilService utilService;

    @Autowired
    private DicUploadFileService dicUploadFileService;

    @Autowired
    private TaiWanPartyFileService taiWanPartyFileService;
    @Autowired
    private SysLogService sysLogService;
    @Transactional(rollbackFor = Exception.class)
    public void load(Carrier<TaiWanParty> carrier, Map<String,Object> map) {
        StringBuilder hql = new StringBuilder(" from TaiWanParty tp where 1 = 1");
        if (map.containsKey("partyName")){
            hql.append(" and tp.partyName like :partyName");
        }
        hql.append(" and tp.delFlag = '0'");
        find(carrier,hql.toString(),map);
    }

    @Transactional(rollbackFor = Exception.class)
    public Map<String,Object> saveData(TaiWanPartyVo taiWanPartyVo, String basePath, SysLogVo sysLogVo) {
        HashMap map = new HashMap(1);
        TaiWanParty taiWanParty = null;
        String dstDir = UploadConstant.taiwanParty;
        String partyId = taiWanPartyVo.getId();
        try {
            if (StringUtils.isNotEmpty(partyId)){
                taiWanParty = this.get(partyId);
                //给对象设置属性
                this.setPartyData(taiWanParty,taiWanPartyVo);
                this.save(taiWanParty);
                //上传图片
                List<TaiWanPartyFile> list = taiWanPartyVo.getWanPartyFileList();
                if (null != list && list.size() > 0){
                    for (TaiWanPartyFile taiWanPartyFile : list){
                        String fileId = taiWanPartyFile.getFileId();
                        DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                        dicUploadFileService.transfer(uploadFile,dstDir);
                        taiWanPartyFile.setTaiWanParty(taiWanParty);
                        taiWanPartyFileService.save(taiWanPartyFile);
                    }
                }
                map.put("result",true);
            }else {
                //新增
                taiWanParty = new TaiWanParty();
                //设置创建时间
                taiWanParty.setCreateTime(new Date());
                this.setPartyData(taiWanParty,taiWanPartyVo);
                this.save(taiWanParty);
                //上传图片
                List<TaiWanPartyFile> list = taiWanPartyVo.getWanPartyFileList();
                if (null != list && list.size() > 0){
                    for (TaiWanPartyFile taiWanPartyFile : list){
                        String fileId = taiWanPartyFile.getFileId();
                        DicUploadFile uploadFile = dicUploadFileService.get(fileId);
                        dicUploadFileService.transfer(uploadFile,dstDir);
                        taiWanPartyFile.setTaiWanParty(taiWanParty);
                        taiWanPartyFileService.save(taiWanPartyFile);
                    }
                }
                map.put("result",true);
            }

            sysLogVo.setTypeName("出访信息");
            if(org.apache.commons.lang.StringUtils.isEmpty(partyId)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(taiWanParty.getPartyName());
            sysLogVo.setEntityId(taiWanParty.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOGGER.error(e.getMessage(),e);
            map.put("result",false);
            return map;
        }
        return map;
    }

    private void setPartyData(TaiWanParty taiWanParty, TaiWanPartyVo taiWanPartyVo) throws ParseException {
        String partyName = taiWanPartyVo.getPartyName();
        taiWanParty.setPartyName(partyName);
        String partyDesc = taiWanPartyVo.getPartyDesc();
        taiWanParty.setPartyDesc(partyDesc);
        String cppccInteract = taiWanPartyVo.getCppccInteract();
        taiWanParty.setCppccInteract(cppccInteract);

        // 设置更新时间
        Date updateTime = DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY);
        taiWanParty.setUpdateTime(updateTime);
        taiWanParty.setDelFlag("0");
        List<TaiWanPoliticsVo> taiWanPoliticsListVo = taiWanPartyVo.getTaiWanPoliticsListVo();
        List<TaiWanPolitics> taiWanPoliticsList = new ArrayList<>();
        for (TaiWanPoliticsVo p:taiWanPoliticsListVo) {
            if(p!=null) {
                TaiWanPolitics t = new TaiWanPolitics();
                t.setDelFlag("0");
                t.setGender(p.getGender());
                t.setTaiWanParty(taiWanParty);
                t.setMainName(p.getMainName());
                t.setBelongOrg(p.getBelongOrg());
                t.setDuty(p.getDuty());
                t.setBirthday(DateUtil.stringToDate(p.getBirthdayStr(),DateUtil.FORMAT_DAY));
                t.setUpdateTime(DateUtil.dateToDateByFormat(utilService.getSysTime(), DateUtil.FORMAT_DAY_HOUR_MIN));
                taiWanPoliticsList.add(t);
            }
        }
        taiWanParty.setTaiWanPoliticsList(taiWanPoliticsList);

    }

    @Transactional(rollbackFor = Exception.class)
    public List<TaiWanParty> getList() {
        StringBuffer hql = new StringBuffer(" from TaiWanParty where delFlag = '0'");
        Map<String, Object> map = new HashMap<>();
        List<TaiWanParty> list = find(hql.toString(),map);
        return list;
    }
}
