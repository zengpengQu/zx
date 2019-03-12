package com.taiji.frame.service.inspection.place;

import com.taiji.frame.model.entity.inspection.place.Correct;
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
public class CorrectService extends BaseDAO<Correct> {

    /**
     * 根据placeId获得当前调整信息，t:为true时 表示以调整，将状态设为2，flase:不做操作
     * @param id
     * @param t
     * @return
     */
    public List<Correct> findByPlaceId(String id,boolean t){
        String str;
        if(t){
            str = "from Correct where placeList.id = '"+ id +"'";
        }else {
            str = "from Correct where placeList.id = '"+ id +"' and state != '2' ";
        }

        List<Correct> corrects = find(str);
        if(!t) {
            for (Correct correct : corrects) {
                correct.setState("2");
                save(correct);
            }
        }
        return corrects;
    }


}
