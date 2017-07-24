package com.qianfeng.dao;

import com.qianfeng.bean.Roles;
import com.qianfeng.bean.Users;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2017/7/20 0020.
 */
@Repository
public interface RolesDao {
    //查询显示所有的角色
    List<Roles> findAllRoles(@Param(value = "start") int start, @Param(value = "pagesize") int pagesize);

    int countRoles();

    //搜索
   // Map<String,Object> search(Map<String,String> data);

    //通过用户查询对应角色
    List<Roles> findRolesByUser(int user_id);

    //通过角色查询对应的所有用户
    List<Users> findUsersByRoles(int roles_id);

    //删除角色
   // void deleteRoles(Map<String, Object> data);
    void deleteRoles(ArrayList<Integer> data);
    //添加角色
    void addRole(Roles roles);
    //删除用户旧角色
    void deleteOldRoles(int id);


    // 分配
    void fenp(Map<String, Object> data);
}