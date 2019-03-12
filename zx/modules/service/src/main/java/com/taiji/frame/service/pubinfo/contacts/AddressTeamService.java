package com.taiji.frame.service.pubinfo.contacts;

import com.taiji.frame.model.entity.pubinfo.contacts.AddressTeam;
import com.taiji.frame.util.BaseDAO;
import com.taiji.frame.util.ExecuteDAO;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.Map;

/**
 * @author sy
 * 通讯录组
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class AddressTeamService extends BaseDAO<AddressTeam> {


}
