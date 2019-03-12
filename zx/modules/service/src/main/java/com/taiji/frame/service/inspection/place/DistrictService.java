package com.taiji.frame.service.inspection.place;

import com.taiji.frame.model.entity.inspection.place.District;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;


/**
 * @author SY
 *
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class DistrictService extends BaseDAO<District> {

    /**
     * 查询所有省份
     */
    public List<District> districtParentCode() {

        String Str = " from  District  where parentCode = '000000' ";

        return find(Str);
    }


}
