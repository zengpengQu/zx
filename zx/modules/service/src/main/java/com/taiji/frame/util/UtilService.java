package com.taiji.frame.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;

/**
 * Created by CHX on 2016/2/25.
 */
@Service
@Transactional(
        propagation = Propagation.REQUIRED
)
public class UtilService {

    @Autowired
    private ExecuteDAO executeDAO;

    public UtilService() {
    }

    public Date getSysTime() {
        return (Date)this.executeDAO.getSession().createSQLQuery("select statement_timestamp() as sysdate").uniqueResult();
    }
}
