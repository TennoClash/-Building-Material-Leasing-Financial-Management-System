package bmlfms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bmlfms.dao.UserDao;
import bmlfms.entity.Page;
import bmlfms.entity.User_Table;


@Service
public class UserService {
@Autowired private UserDao userDao;

public List<User_Table> searchInvListT(Page page){
	return userDao.searchInvListT(page);
}
public List<User_Table> getInvBycondtionT(Page page){
	return userDao.getInvBycondtionT(page);
}
public Integer searchTotalCountT(Page page){
	return userDao.searchTotalCountT(page);
}
public int updateUser(User_Table user_Table) {
	return userDao.updateUser(user_Table);
}
public int vPass(String id) {
	return userDao.vPass(id);
}
}
