package com.qianfeng.controller;

import com.qianfeng.bean.Users;
import com.qianfeng.dao.RolesDao;
import com.qianfeng.dao.UsersDao;
import com.qianfeng.service.UsersServices;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class UsersController {
    @Resource
    private UsersDao ud;
    @Resource
    private UsersServices us;

    //查询单个用户
    @RequestMapping("dologin.do")
    @ResponseBody
    public String doLogin(Users users){
        ud.login(users);
        return "success";
    }
    //查询所有用户
    @RequestMapping("findAllUsers.do")
    @ResponseBody
    public Map<String,Object> findAllUsers(int page,int pagesize){
        System.out.println(page+"......"+pagesize);
        return us.findAllUsers(page,pagesize);
    }
    //添加新用户
    @RequestMapping("addUsers.do")
    @ResponseBody
    public int addUsers(Users users){
        return us.addUsers(users);
    }
    //删除用户信息
    @RequestMapping("removeUsersByStatus.do")
    @ResponseBody
    public String removeUsersByStatus(@RequestBody ArrayList<Integer> data){
        System.out.println("删除data"+data);
        return  us.removeUsersByStatus(data);
    }
    //修改用户信息
    @RequestMapping("updateUsers.do")
    @ResponseBody
    public int updateUsers(Users users){
        System.out.println("修改users"+users);
        return us.updateUsers(users);
    }
    //搜索用户
    @RequestMapping("searchUsersBylike.do")
    @ResponseBody
    public List<Users> searchUsersBylike(String type,String key){
        return us.searchUsersBylike(type,key);
    }

}
