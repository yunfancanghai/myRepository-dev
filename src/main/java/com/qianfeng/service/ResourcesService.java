package com.qianfeng.service;

import com.qianfeng.bean.Resources;
import com.qianfeng.dao.ResourcesDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ResourcesService {
    @Resource
    private ResourcesDao rd;
    /**
     * 查询所有资源，显示树
     * @return 返回的树形式的map集合
     */
    public Map<String,Object> findAllResources(){
        Map<String,Object> map=new HashMap();
        List<Resources> resources=  rd.findAllResources();
        map.put("rows",resources);
        return map;
    }

}
