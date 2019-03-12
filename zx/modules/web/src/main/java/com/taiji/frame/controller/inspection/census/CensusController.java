package com.taiji.frame.controller.inspection.census;

import com.taiji.frame.BaseController;
import com.taiji.frame.common.util.Carrier;
import com.taiji.frame.model.entity.inspection.place.District;
import com.taiji.frame.model.entity.inspection.place.Place;
import com.taiji.frame.model.systempara.DicDept;
import com.taiji.frame.service.inspection.census.CensusService;
import com.taiji.frame.service.inspection.place.DistrictService;
import com.taiji.frame.service.systempara.DicDeptService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author sy
 */
@Controller
@RequestMapping(value = "/census")
public class CensusController extends BaseController<Place> {
    private static final Logger LOG = LoggerFactory.getLogger(CensusController.class);

    @Autowired
    CensusService censusService;
    @Autowired
    private DicDeptService dicDeptService;
    @Autowired
    private DistrictService districtService;
    /**
     * 页面跳转
     */
    @RequestMapping(value = "/census-list", method = RequestMethod.GET)
    public String toCensus(Map<String, Object> map) {
        //部门名称
//        List<DicDept> deptList = dicDeptService.getBelongDept("01");
//        map.put("deptList", deptList);
        List<District> districtList =  districtService.districtParentCode();
        map.put("districtList", districtList);
        return "inspection/census/census-list";
    }


    /**
     * load grid单位表格数据
     */
    @ResponseBody
    @RequestMapping(value = "/load-census-List.do", produces = "text/html;charset=UTF-8")
    public String placeListLoad(Carrier<Place> carrier) {
        HashMap map = new HashMap(1);
        try {
            censusService.load(carrier);
        } catch (Exception e) {
            LOG.debug(e.getMessage(), e);
        }
        return gridResult(carrier);
    }

}