package com.taiji.frame.service.systempara;

import com.taiji.frame.model.systempara.UrlPara;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

/**
 * Created by CHX on 2016/5/11.
 * @author CHX
 */
@Service
@Transactional(propagation = Propagation.REQUIRED,readOnly = true,rollbackFor = Exception.class)
public class UrlParaService extends BaseDAO<UrlPara> {
}
