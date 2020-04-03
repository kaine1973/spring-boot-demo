package rk.po;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class User {
    private Integer roleId;
    private Integer id;
    private String userName;
    private String userPwd;
    private String salt;
    private String userToken;
    private String header;
    private String preferColor;

    public void setId(Integer id) {
        this.id = id;
    }
    public User(Integer id, String userName, String userPwd) {
        this.id = id;
        this.userName = userName;
        this.userPwd = userPwd;
    }

}

