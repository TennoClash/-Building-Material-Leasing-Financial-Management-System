package bmlfms.dao;

import java.util.List;

import bmlfms.entity.Page;
import bmlfms.entity.User_Table;


public interface UserDao {
	public User_Table getUser(User_Table user);

	public User_Table getUserByName(String i);
	
	public int registration(User_Table user_Table);
	
	public Integer getRole_Id(int id);
	
	public int updataUserRole(int i);
	
	public List<User_Table> searchInvListT(Page page);

	public List<User_Table> getInvBycondtionT(Page page);

	public Integer searchTotalCountT(Page page);
	
	public int updateUser(User_Table user_Table);
	
	public int vPass(String id);
}
