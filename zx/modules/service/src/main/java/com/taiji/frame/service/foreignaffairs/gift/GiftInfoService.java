package com.taiji.frame.service.foreignaffairs.gift;

import com.taiji.frame.model.entity.foreignaffairs.gift.GiftInfo;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class GiftInfoService extends BaseDAO<GiftInfo>{
}
