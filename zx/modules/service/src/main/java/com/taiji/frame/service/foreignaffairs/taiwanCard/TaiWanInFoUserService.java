package com.taiji.frame.service.foreignaffairs.taiwanCard;

import com.taiji.frame.model.entity.foreignaffairs.taiwanCard.TaiWanInfoUser;
import com.taiji.frame.util.BaseDAO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


/**
 * @author qzp
 * @date 2018/08/10
 * 赴台通行证服务
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class TaiWanInFoUserService extends BaseDAO<TaiWanInfoUser> {
    private static final Logger LOGGER = LoggerFactory.getLogger(TaiWanInFoUserService.class);


}
