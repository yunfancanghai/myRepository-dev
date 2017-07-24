package com.qianfeng.controller;

import com.qianfeng.bean.Roles;
import com.qianfeng.bean.Users;
import com.qianfeng.dao.RolesDao;

import com.qianfeng.service.RolesService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.management.relation.Role;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
public class RolesController {
    @Resource
    private RolesDao rd;
    @Resource
    private RolesService rs;

    //加载数据，显示所有的角色
    @RequestMapping("findAllRoles.do")
    @ResponseBody
    public Map<String, Object> findAllRoles(int page, int pagesize) {
        return rs.findAllRoles(page,pagesize);
    }

    //搜索
    /*@RequestMapping("search.do")
    @ResponseBody*/

   /* public Map<String,Object> search(String type, String key) {

        Map<String,Object> map =rs.search(type,key);

        System.out.println(type+"ddddddddd"+key);
        System.out.println("-----------"+map);
        return rs.search(type,key);
    }*/


  /*  //通过用户查询对应角色
    @RequestMapping("findRolesByUser.do")
    public List<Roles> findRolesByUser(HttpSession session) {
        Users user = (Users) session.getAttribute("user");
        return rd.findRolesByUser(user.getId());
    }

    //通过角色查询对应的所有用户
    @RequestMapping("findUsersByRoles.do")
    public List<Users> findUsersByRoles(HttpSession session) {
        Roles role = (Roles) session.getAttribute("role");
        return rd.findUsersByRoles(role.getId());
    }*/

    //删除角色  所有拥有该角色的用户都会失去该角色
    @RequestMapping("deleteRoles.do")
    @ResponseBody
    public String deleteRoles(@RequestBody ArrayList<Integer> data) {
        return  rs.deleteRoles(data);

    }

    //添加角色
    @RequestMapping("addRole.do")
    @ResponseBody
    public int addRole(Roles roles) {
          return  rs.addRole(roles);
    }

    //分配用户角色
    @RequestMapping("fenp.do")
    public String fenp(@RequestBody ArrayList<Integer> data) {

        return "rd.fenp(data)";
    }

    //删除某个用户旧角色
    @RequestMapping("deleteOldRoles.do")
    public void deleteOldRoles(int id) {
        rd.deleteOldRoles(id);
    }


}
