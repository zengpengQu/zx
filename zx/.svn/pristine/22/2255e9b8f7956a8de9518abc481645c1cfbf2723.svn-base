package com.taiji.frame.controller.foreignaffairs.nationCondition;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.common.util.DateUtil;
import com.taiji.frame.controller.systempara.SysLogController;
import com.taiji.frame.model.entity.foreignaffairs.nationCondition.*;
import com.taiji.frame.model.systempara.DicNation;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.model.vo.foreignaffairs.nationCondition.CitySceneryIntroVo;
import com.taiji.frame.model.vo.foreignaffairs.nationCondition.ContactConditionVo;
import com.taiji.frame.model.vo.foreignaffairs.nationCondition.ParliamentIntroVo;
import com.taiji.frame.model.vo.foreignaffairs.nationCondition.VipPersonIntroVo;
import com.taiji.frame.service.foreignaffairs.nationCondition.*;
import com.taiji.frame.service.systempara.DicNationService;
import com.taiji.frame.service.systempara.SysLogService;
import net.sf.json.JSON;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;

/**
 * 国家情况管理
 * Created by yuLei on 2018/8/13.
 */
@Controller
@RequestMapping(value = "/nation-condition")
public class NationConditionController extends BaseController<NationConditionManagement> {

    private static final Logger LOG = LoggerFactory.getLogger(SysLogController.class);

    @Autowired
    private NationConditionService nationConditionService;

    @Autowired
    private VipPersonIntroService vipPersonIntroService;

    @Autowired
    private ParliamentIntroService parliamentIntroService;

    @Autowired
    private ContactConditionService contactConditionService;

    @Autowired
    private CitySceneryIntroService citySceneryIntroService;

    @Autowired
    private DicNationService dicNationService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 跳转至列表页
     * @param map
     * @return
     */
    @RequestMapping(value = "/nation-condition-list", method = RequestMethod.GET)
    public String list(Map<String, Object> map) {
        List<DicNation> dicNationList = dicNationService.findDicNationList();
        map.put("dicNationList", dicNationList);
        return "foreignaffairs/nationCondition/nation-condition-list";
    }

    /**
     * 组装表格数据
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/load-nation-condition-list.do", produces = "text/html;charset=UTF-8")
    public String load(Carrier<NationConditionManagement> carrier, String nationName) {
        HashMap<String, Object> map = new HashMap();
        try {
            if (StringUtils.isNotEmpty(nationName)) {
                map.put("nationName", "%" + nationName + "%");
            }
            nationConditionService.load(carrier, map);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

    /**
     * 删除
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/nation-condition-delete.do", method = RequestMethod.POST)
    public Map<String, Object> delete(String id) {
        HashMap<String, Object> map = new HashMap();
        try {
            if (StringUtils.isNotEmpty(id)) {
                NationConditionManagement nation = nationConditionService.get(id);
                nation.setDelFlag("1");
                nationConditionService.save(nation);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("国家情况管理");
                    sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(nation.getDicNation().getNationName());
                sysLogVo.setEntityId(nation.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 导出前预览
     * @param id
     * @return
     */
    @RequestMapping(value = "/nation-condition-preview.do",  method = RequestMethod.GET)
    public String preview(Map<String, Object> map, String id) {

        Calendar calendar = Calendar.getInstance();
        calendar.setTime(getCurDate());
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH) + 1;
        int day = calendar.get(Calendar.DAY_OF_MONTH);
        map.put("year", year);
        map.put("month", month);
        map.put("day", day);

        if (StringUtils.isNotEmpty(id)) {
            NationConditionManagement nation = nationConditionService.get(id);
            List<VipPersonIntro> vipPersonIntroList = vipPersonIntroService.findVipPersonIntroListByNationId(id);
            List<ParliamentIntro> parliamentIntroList = parliamentIntroService.findParliamentIntroListByNationId(id);
            List<ContactCondition> contactConditionList = contactConditionService.findContactConditionListByNationId(id);
            List<CitySceneryIntro> citySceneryIntroList = citySceneryIntroService.findCitySceneryIntroListByNationId(id);
            map.put("nation", nation);
            map.put("vipPersonIntroList", vipPersonIntroList);
            map.put("parliamentIntroList", parliamentIntroList);
            map.put("contactConditionList", contactConditionList);
            map.put("citySceneryIntroList", citySceneryIntroList);
        }
        return "foreignaffairs/nationCondition/nation-condition-preview";
    }

    /**
     * 跳转至编辑页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/nation-condition-edit", method = RequestMethod.GET)
    public String edit(ModelMap modelMap, String id) {
        if (!StringUtils.isEmpty(id)) {
            NationConditionManagement nation = nationConditionService.get(id);
            modelMap.put("nation", nation);
        }
        List<DicNation> dicNationList = dicNationService.findDicNationList();
        modelMap.put("dicNationList", dicNationList);
        return "foreignaffairs/nationCondition/nation-condition-edit";
    }


    /**
     * 国家选择
     *
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/get-all.do", method = RequestMethod.GET)
    public List<JSON> getAllNations() {
        List<DicNation> dicNationList = dicNationService.findDicNationList();
        List<JSON> nationList = new ArrayList<>();
        for (DicNation dicNation: dicNationList) {
            nationList.add(dicNation.getJsonObject());
        }
        return nationList;
    }

    /**
     * 保存
     * @param nation
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/nation-condition-save.do", method = RequestMethod.POST)
    public Map<String, Object> save( NationConditionManagement nation) {
        Map<String, Object> map = new HashMap<>();
        try {
            String id = nation.getId();
            if (StringUtils.isNotEmpty(id)) {//编辑
                NationConditionManagement $nation = nationConditionService.get(id);
                $nation.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                $nation.setDicNation(nation.getDicNation());
                $nation.setNationIntro(nation.getNationIntro());
                $nation.setBelongArea(nation.getBelongArea());
                $nation.setIsOborNation(nation.getIsOborNation());
                $nation.setIsAroundNation(nation.getIsAroundNation());
                $nation.setIsArabNation(nation.getIsArabNation());
                $nation.setIsWestNation(nation.getIsWestNation());
                $nation.setIsOtherNation(nation.getIsOtherNation());
                $nation.setMoresProtocolTaboo(nation.getMoresProtocolTaboo());
                $nation.setEhtryNotices(nation.getEhtryNotices());
                nationConditionService.save($nation);
                map.put("result", true);
            } else {//新增
                nation.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                nation.setDelFlag("0");
                nation.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                nationConditionService.save(nation);
                map.put("result", true);
            }
            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("国家情况管理");
            if(org.apache.commons.lang.StringUtils.isEmpty(id)){
                sysLogVo.setRecordType(0);
            }else {
                sysLogVo.setRecordType(1);
            }
            sysLogVo.setEntityName(nation.getDicNation().getNationName());
            sysLogVo.setEntityId(nation.getId());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 跳转至完善页面
     * @param modelMap
     * @param id
     * @return
     */
    @RequestMapping(value = "/nation-condition-edit-more", method = RequestMethod.GET)
    public String editMore(ModelMap modelMap, String id) {
        if (!StringUtils.isEmpty(id)) {
            NationConditionManagement nation = nationConditionService.get(id);
            modelMap.put("nation", nation);
            List<VipPersonIntro> vipPersonIntroList = vipPersonIntroService.findVipPersonIntroListByNationId(id);
            List<ParliamentIntro> parliamentIntroList = parliamentIntroService.findParliamentIntroListByNationId(id);
            List<ContactCondition> contactConditionList = contactConditionService.findContactConditionListByNationId(id);
            List<CitySceneryIntro> citySceneryIntroList = citySceneryIntroService.findCitySceneryIntroListByNationId(id);
            modelMap.put("vipPersonIntroList", vipPersonIntroList);
            modelMap.put("parliamentIntroList", parliamentIntroList);
            modelMap.put("contactConditionList", contactConditionList);
            modelMap.put("citySceneryIntroList", citySceneryIntroList);
        }
        return "foreignaffairs/nationCondition/nation-condition-edit-more";
    }

    /**
     * 保存重要人物简介
     * @param vipPersonIntroVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/vip-person-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveVipPerson(@RequestBody VipPersonIntroVo vipPersonIntroVo) {
        Map<String, Object> map = new HashMap<>();
        VipPersonIntro vipPersonIntro;
        try {
            String nationId = vipPersonIntroVo.getNationId();
            if (StringUtils.isNotEmpty(nationId)) {
                if (StringUtils.isNotEmpty(vipPersonIntroVo.getId())) {//编辑
                    vipPersonIntro = vipPersonIntroService.get(vipPersonIntroVo.getId());
                    vipPersonIntro.setChineseName(vipPersonIntroVo.getChineseName());
                    vipPersonIntro.setForeignName(vipPersonIntroVo.getForeignName());
                    vipPersonIntro.setPersonIntro(vipPersonIntroVo.getPersonIntro());
                    vipPersonIntro.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                } else {//新增
                    NationConditionManagement nation = nationConditionService.get(nationId);
                    vipPersonIntro = new VipPersonIntro();
                    vipPersonIntro.setChineseName(vipPersonIntroVo.getChineseName());
                    vipPersonIntro.setForeignName(vipPersonIntroVo.getForeignName());
                    vipPersonIntro.setPersonIntro(vipPersonIntroVo.getPersonIntro());
                    vipPersonIntro.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    vipPersonIntro.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    vipPersonIntro.setDelFlag("0");
                    vipPersonIntro.setNationConditionManagement(nation);
                }
                vipPersonIntroService.save(vipPersonIntro);
                String createTime = DateUtil.dateToString(vipPersonIntro.getCreateTime(), DateUtil.FORMAT);
                map.put("result", true);
                map.put("createTime", createTime);
                map.put("vipPersonId", vipPersonIntro.getId());
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("重要人物简介");
                if(org.apache.commons.lang.StringUtils.isEmpty(nationId)){
                    sysLogVo.setRecordType(0);
                }else {
                    sysLogVo.setRecordType(1);
                }
                sysLogVo.setEntityName(vipPersonIntro.getChineseName());
                sysLogVo.setEntityId(vipPersonIntro.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 保存重要议会简介
     * @param parliamentIntroVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/parliament-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveParliament(@RequestBody ParliamentIntroVo parliamentIntroVo) {
        Map<String, Object> map = new HashMap<>();
        ParliamentIntro parliamentIntro;
        try {
            String nationId = parliamentIntroVo.getNationId();
            if (StringUtils.isNotEmpty(nationId)) {
                if (StringUtils.isNotEmpty(parliamentIntroVo.getId())) {//编辑
                    parliamentIntro = parliamentIntroService.get(parliamentIntroVo.getId());
                    parliamentIntro.setParliamentName(parliamentIntroVo.getParliamentName());
                    parliamentIntro.setParliamentIntro(parliamentIntroVo.getParliamentIntro());
                    parliamentIntro.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                } else {//新增
                    NationConditionManagement nation = nationConditionService.get(nationId);
                    parliamentIntro = new ParliamentIntro();
                    parliamentIntro.setParliamentName(parliamentIntroVo.getParliamentName());
                    parliamentIntro.setParliamentIntro(parliamentIntroVo.getParliamentIntro());
                    parliamentIntro.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    parliamentIntro.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    parliamentIntro.setDelFlag("0");
                    parliamentIntro.setNationConditionManagement(nation);
                }
                parliamentIntroService.save(parliamentIntro);
                String createTime = DateUtil.dateToString(parliamentIntro.getCreateTime(), DateUtil.FORMAT);
                map.put("result", true);
                map.put("createTime", createTime);
                map.put("parliamentId", parliamentIntro.getId());
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("重要议会简介");
                if(org.apache.commons.lang.StringUtils.isEmpty(nationId)){
                    sysLogVo.setRecordType(0);
                }else {
                    sysLogVo.setRecordType(1);
                }
                sysLogVo.setEntityName(parliamentIntro.getParliamentName());
                sysLogVo.setEntityId(parliamentIntro.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 保存交往情况
     * @param contactConditionVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/contact-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveContact(@RequestBody ContactConditionVo contactConditionVo) {
        Map<String, Object> map = new HashMap<>();
        ContactCondition contactCondition;
        try {
            String nationId = contactConditionVo.getNationId();
            if (StringUtils.isNotEmpty(nationId)) {
                if (StringUtils.isNotEmpty(contactConditionVo.getId())) {//编辑
                    contactCondition = contactConditionService.get(contactConditionVo.getId());
                    contactCondition.setContactType(contactConditionVo.getContactType());
                    contactCondition.setContactDate(contactConditionVo.getContactDate());
                    contactCondition.setContactCondition(contactConditionVo.getContactCondition());
                    contactCondition.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                } else {//新增
                    NationConditionManagement nation = nationConditionService.get(nationId);
                    contactCondition = new ContactCondition();
                    contactCondition.setContactType(contactConditionVo.getContactType());
                    contactCondition.setContactDate(contactConditionVo.getContactDate());
                    contactCondition.setContactCondition(contactConditionVo.getContactCondition());
                    contactCondition.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    contactCondition.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    contactCondition.setDelFlag("0");
                    contactCondition.setNationConditionManagement(nation);
                }
                contactConditionService.save(contactCondition);
                String createTime = DateUtil.dateToString(contactCondition.getCreateTime(), DateUtil.FORMAT);
                map.put("result", true);
                map.put("createTime", createTime);
                map.put("contactId", contactCondition.getId());

                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("交往情况");
                if(org.apache.commons.lang.StringUtils.isEmpty(nationId)){
                    sysLogVo.setRecordType(0);
                }else {
                    sysLogVo.setRecordType(1);
                }
                sysLogVo.setEntityName(contactCondition.getContactCondition());
                sysLogVo.setEntityId(contactCondition.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 保存城市/景点简介
     * @param citySceneryIntroVo
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/city-scenery-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveCityScenery(@RequestBody CitySceneryIntroVo citySceneryIntroVo) {
        Map<String, Object> map = new HashMap<>();
        CitySceneryIntro citySceneryIntro;
        try {
            String nationId = citySceneryIntroVo.getNationId();
            if (StringUtils.isNotEmpty(nationId)) {
                if (StringUtils.isNotEmpty(citySceneryIntroVo.getId())) {//编辑
                    citySceneryIntro = citySceneryIntroService.get(citySceneryIntroVo.getId());
                    citySceneryIntro.setCitySceneryName(citySceneryIntroVo.getCitySceneryName());
                    citySceneryIntro.setCitySceneryIntro(citySceneryIntroVo.getCitySceneryIntro());
                    citySceneryIntro.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                } else {//新增
                    NationConditionManagement nation = nationConditionService.get(nationId);
                    citySceneryIntro = new CitySceneryIntro();
                    citySceneryIntro.setCitySceneryName(citySceneryIntroVo.getCitySceneryName());
                    citySceneryIntro.setCitySceneryIntro(citySceneryIntroVo.getCitySceneryIntro());
                    citySceneryIntro.setCreateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    citySceneryIntro.setUpdateTime(DateUtil.dateToDateByFormat(getCurDate(), DateUtil.FORMAT));
                    citySceneryIntro.setDelFlag("0");
                    citySceneryIntro.setNationConditionManagement(nation);
                }
                citySceneryIntroService.save(citySceneryIntro);
                String createTime = DateUtil.dateToString(citySceneryIntro.getCreateTime(), DateUtil.FORMAT);
                map.put("result", true);
                map.put("createTime", createTime);
                map.put("citySceneryId", citySceneryIntro.getId());
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("城市/景点简介");
                if(org.apache.commons.lang.StringUtils.isEmpty(nationId)){
                    sysLogVo.setRecordType(0);
                }else {
                    sysLogVo.setRecordType(1);
                }
                sysLogVo.setEntityName(citySceneryIntro.getCitySceneryName());
                sysLogVo.setEntityId(citySceneryIntro.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);

            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 删除重要人物简介
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/vip-person-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteVipPerson(String id) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                VipPersonIntro vipPersonIntro = vipPersonIntroService.get(id);
                vipPersonIntro.setDelFlag("1");
                vipPersonIntroService.save(vipPersonIntro);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("重要人物简介");
                    sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(vipPersonIntro.getChineseName());
                sysLogVo.setEntityId(vipPersonIntro.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 删除重要议会简介
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/parliament-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteParliament(String id) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                ParliamentIntro parliamentIntro = parliamentIntroService.get(id);
                parliamentIntro.setDelFlag("1");
                parliamentIntroService.save(parliamentIntro);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("重要议会简介");
                sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(parliamentIntro.getParliamentName());
                sysLogVo.setEntityId(parliamentIntro.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 删除交往情况
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/contact-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteContact(String id) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                ContactCondition contactCondition = contactConditionService.get(id);
                contactCondition.setDelFlag("1");
                contactConditionService.save(contactCondition);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("交往情况");
                sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(contactCondition.getContactCondition());
                sysLogVo.setEntityId(contactCondition.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 删除城市/景点简介
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/city-scenery-delete.do", method = RequestMethod.POST)
    public Map<String, Object> deleteCityScenery(String id) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                CitySceneryIntro citySceneryIntro = citySceneryIntroService.get(id);
                citySceneryIntro.setDelFlag("1");
                citySceneryIntroService.save(citySceneryIntro);
                map.put("result", true);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("城市/景点简介");
                sysLogVo.setRecordType(2);
                sysLogVo.setEntityName(citySceneryIntro.getCitySceneryName());
                sysLogVo.setEntityId(citySceneryIntro.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 编辑重要人物简介
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/vip-person-edit.do", method = RequestMethod.POST)
    public Map<String, Object> editVipPerson(String id) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                VipPersonIntro vipPersonIntro = vipPersonIntroService.get(id);
                map.put("result", true);
                map.put("intro", vipPersonIntro);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("重要人物简介");
                    sysLogVo.setRecordType(1);
                sysLogVo.setEntityName(vipPersonIntro.getChineseName());
                sysLogVo.setEntityId(vipPersonIntro.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 编辑重要议会简介
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/parliament-edit.do", method = RequestMethod.POST)
    public Map<String, Object> editParliament(String id) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                ParliamentIntro parliamentIntro = parliamentIntroService.get(id);
                map.put("result", true);
                map.put("intro", parliamentIntro);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("重要议会简介");
                sysLogVo.setRecordType(1);
                sysLogVo.setEntityName(parliamentIntro.getParliamentName());
                sysLogVo.setEntityId(parliamentIntro.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 编辑交往情况
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/contact-edit.do", method = RequestMethod.POST)
    public Map<String, Object> editContact(String id) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                ContactCondition contactCondition = contactConditionService.get(id);
                map.put("result", true);
                map.put("intro", contactCondition);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("交往情况");
                sysLogVo.setRecordType(1);
                sysLogVo.setEntityName(contactCondition.getContactCondition());
                sysLogVo.setEntityId(contactCondition.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 编辑城市/景点简介
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/city-scenery-edit.do", method = RequestMethod.POST)
    public Map<String, Object> editCityScenery(String id) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                CitySceneryIntro citySceneryIntro = citySceneryIntroService.get(id);
                map.put("result", true);
                map.put("intro", citySceneryIntro);
                SysLogVo sysLogVo = getSysLogVo();
                sysLogVo.setTypeName("城市/景点简介");
                sysLogVo.setRecordType(1);
                sysLogVo.setEntityName(citySceneryIntro.getCitySceneryName());
                sysLogVo.setEntityId(citySceneryIntro.getId());
                sysLogVo.setResult("true");
                sysLogService.record(sysLogVo);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

    /**
     * 通过国家ID查到所属地区
     * @param id
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/find-belong-area.do", method = RequestMethod.POST)
    public Map<String, Object> findBelongArea(String id) {
        Map<String, Object> map = new HashMap<>();
        try {
            if (StringUtils.isNotEmpty(id)) {
                DicNation dicNation = dicNationService.get(id);
                String area = dicNation.getArea();
                map.put("area", area);
                map.put("result", true);
            }
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }

}
