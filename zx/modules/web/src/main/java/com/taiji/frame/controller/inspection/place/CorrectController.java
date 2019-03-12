package com.taiji.frame.controller.inspection.place;

import com.taiji.frame.BaseController;
import com.taiji.frame.model.entity.inspection.place.Correct;
import com.taiji.frame.model.entity.inspection.place.Place;
import com.taiji.frame.model.vo.SysLogVo;
import com.taiji.frame.service.inspection.place.CorrectService;
import com.taiji.frame.service.inspection.place.PlaceService;
import com.taiji.frame.service.systempara.SysLogService;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeansException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @author sy
 * 活动安排
 */
@Controller
@RequestMapping(value = "/correct")
public class CorrectController extends BaseController<Correct> {

    private static final Logger LOG = LoggerFactory.getLogger(CorrectController.class);

    @Autowired
    private  CorrectService correctService;

    @Autowired
    private PlaceService placeService;
    @Autowired
    private SysLogService sysLogService;

    /**
     * 活动安排调整页面跳转
     */
    @RequestMapping(value = "/correct-edit.do", method = RequestMethod.GET)
    public String toCorrect(String id,ModelMap modelMap) {
        Place place =  placeService.get(id);
        modelMap.put("place",place);
        return "inspection/place/place-correct-edit";
    }

    /**
     * 新增调整
     */
    @ResponseBody
    @RequestMapping(value = "/correct-edit-save.do", method = RequestMethod.POST)
    public Map<String, Object> saveContacts(String id,String text) {
        Map<String, Object> map = new HashMap<>(1);
        try {
            Place place = placeService.get(id);
            place.setReportState("4");
            Correct correct =  new Correct();
            correct.setPlaceList(place);
            correct.setText(text);
            correct.setState("1");
            correctService.save(correct);
            map.put("result", true);

            SysLogVo sysLogVo = getSysLogVo();
            sysLogVo.setTypeName("视察考察调研活动调整");
                sysLogVo.setRecordType(0);
                sysLogVo.setEntityId(correct.getId());
                sysLogVo.setEntityName(correct.getText());
            sysLogVo.setResult("true");
            sysLogService.record(sysLogVo);
        } catch (BeansException e) {
            LOG.debug(e.getMessage(), e);
            map.put("result", false);
        }
        return map;
    }





    /**
     * 活动安排调整页面跳转
     */
    @RequestMapping(value = "/correct-load.do", method = RequestMethod.GET)
    public String toCorrectLoad(String id,ModelMap modelMap) {
        List<Correct> corrects = correctService.find("from Correct where placeList.id = '"+id+"'");
        modelMap.put("correctList",corrects);
        return "inspection/place/place-correct-load";
    }

}
