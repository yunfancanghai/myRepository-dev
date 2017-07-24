package com.qianfeng.dao;

import com.qianfeng.bean.Resources;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ResourcesDao {

    List<Resources> findAllResources();
}
