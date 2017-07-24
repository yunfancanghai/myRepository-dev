package com.qianfeng.bean;

/**
 * Created by Administrator on 2017/7/20 0020.
 */
public class Roles {
    private int id;
    private String roles_name;
    private String roles_status;
    private Users user;

    public Roles() {
    }

    public Roles(int id, String roles_name, String roles_status, Users user) {
        this.id = id;
        this.roles_name = roles_name;
        this.roles_status = roles_status;
        this.user = user;
    }

    public Users getUser() {
        return user;
    }

    public void setUser(Users user) {
        this.user = user;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getRoles_name() {
        return roles_name;
    }

    public void setRoles_name(String roles_name) {
        this.roles_name = roles_name;
    }

    public String getRoles_status() {
        return roles_status;
    }

    public void setRoles_status(String roles_status) {
        this.roles_status = roles_status;
    }
}

