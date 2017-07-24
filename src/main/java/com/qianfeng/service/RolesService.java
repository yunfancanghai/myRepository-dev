package com.qianfeng.service;

import com.qianfeng.bean.Roles;
import com.qianfeng.dao.RolesDao;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/20 0020.
 */
@Service
public class RolesService {
    @Resource
    private RolesDao rd;

    //加载数据
    public Map<String, Object> findAllRoles(int page, int pagesize) {
        int start = (page - 1) * pagesize;
        List<Roles> allRoles = rd.findAllRoles(start, pagesize);
        System.out.print("duixiang" + allRoles);
        int total = rd.countRoles();
        System.out.print("duixiang" + total);
        Map<String, Object> rolesMap = new HashMap<String, Object>();
        rolesMap.put("total", total);
        rolesMap.put("allroles", allRoles);
        return rolesMap;
    }

    //搜索
  /*  public Map<String,Object> search(String type, String key) {
        try {
            Map<String, String> data = new HashMap<String, String>();
            data.put("type", type);
            data.put("key", "%" + key + "%");
            System.out.println(data);
         //   System.out.println(rd.search(data));
            return rd.search(data);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }

    }*/
    //添加

    public int addRole(Roles roles) {

        try {
            rd.addRole(roles);
            return 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;

    }

    //删除
    public String deleteRoles(ArrayList<Integer> data) {
        try {
            rd.deleteRoles(data);
            return "删除角色成功";
        } catch (Exception e) {
            e.printStackTrace();

        }
        return "删除角色失败";
    }


    //角色分配
    public void fenp(ArrayList<Integer> data) {
        //获取所选的用户
        int userid = data.get(0);
        data.remove(0);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("user_id", userid);
        map.put("role_id", data);
        //删除旧角色
        rd.deleteOldRoles(userid);
        //分配新角色
        rd.fenp(map);
    }
}
