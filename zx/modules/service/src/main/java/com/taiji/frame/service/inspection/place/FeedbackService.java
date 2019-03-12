package com.taiji.frame.service.inspection.place;

import com.taiji.frame.model.entity.inspection.place.Feedback;
import com.taiji.frame.util.BaseDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;


/**
 * @author SY
 */
@Service
@Transactional(propagation = Propagation.REQUIRED, readOnly = true, rollbackFor = Exception.class)
public class FeedbackService extends BaseDAO<Feedback> {






}
