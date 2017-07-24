package com.qianfeng.service;

import com.qianfeng.bean.Users;
import com.qianfeng.dao.UsersDao;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UsersServices {
    @Resource
    private UsersDao ud;
    //多单个用户查询服务
    public void login(){

    }

    public Map<String,Object> findAllUsers(int page,int pagesize){
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            int start = (page-1)*pagesize;
            System.out.println(start);
            List<Users> allusers = ud.findAllUsers(start,pagesize);
            System.out.println("........"+allusers);
            int total = ud.findUsersByCount();
            System.out.println("////////total"+total);
            map.put("total", total);
            map.put("users", allusers);
            return map;
        }catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
    //添加
    public int addUsers(Users users ){
        System.out.println("添加"+users);
        try {
            ud.addUsers(users);
            return 0;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;

    }
    //删除
    public String removeUsersByStatus( ArrayList<Integer> data){
        try {
            ud.removeUsersByStatus(data);
            return "删除用户信息成功";
        }catch (Exception e){
            e.printStackTrace();

        }
        return "删除用户信息失败";

    }
    //修改
    public int updateUsers(Users users){
        System.out.println("修改"+users);
        try{
            ud.updateUsers(users);
            return 1;
        }catch (Exception e){
            e.printStackTrace();
        }
        return -1;
    }
    //搜索
    public List<Users> searchUsersBylike(String type,String key){
        try {
            Map<String, String> data = new HashMap<String, String>();
            data.put("type", type);
            data.put("key", "%" + key + "%");
            return ud.searchUsersBylike(data);
        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
