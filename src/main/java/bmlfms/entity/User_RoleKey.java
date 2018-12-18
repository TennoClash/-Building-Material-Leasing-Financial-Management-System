package bmlfms.entity;

import java.io.Serializable;

public class User_RoleKey implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 4415853109312939910L;

	private int userId;

    private int roleId;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }
}