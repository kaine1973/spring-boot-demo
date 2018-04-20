package rk.po;

public class WebUser {
    private Integer id;
    private String userName;
    private String userPwd;
    private String userToken;

    public WebUser() {
    }

    public WebUser(Integer id, String userName, String userPwd) {
        this.id = id;
        this.userName = userName;
        this.userPwd = userPwd;
    }

    public WebUser(Integer id, String userName, String userPwd, String userToken) {
        this.id = id;
        this.userName = userName;
        this.userPwd = userPwd;
        this.userToken = userToken;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserPwd() {
        return userPwd;
    }

    public void setUserPwd(String userPwd) {
        this.userPwd = userPwd;
    }


    public String getUserToken() {
        return userToken;
    }

    public void setUserToken(String userToken) {
        this.userToken = userToken;
    }
}

