package bmlfms.service;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bmlfms.dao.UserDao;
import bmlfms.entity.User_Table;
import bmlfms.util.MD5Hex;


@Service
public class LoginService {
@Autowired private UserDao userDao;

public boolean execute(String user_number, String password) {
	User_Table user = new User_Table();
	user.setUserName(user_number);
	user.setPassword(password);
	User_Table u = userDao.getUser(user);
	if (u != null) {
		return true;
	} else {
		return false;
	}
}

public User_Table getUser(String user_number, String password) {
	User_Table user = new User_Table();
	user.setUserName(user_number);
	user.setPassword(password);
	User_Table u = userDao.getUser(user);
	return u;
}

public User_Table getUserByName(String i) {
	return userDao.getUserByName(i);
}

public int registration(User_Table user_Table) {
	Date date = new Date();
	String nowTime = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(date);
	Timestamp goodsC_date = Timestamp.valueOf(nowTime);
	String pass=user_Table.getPassword();
	String pass_MD5=new MD5Hex().MD5(pass);
	user_Table.setPassword(pass_MD5);
	user_Table.setCreateTime(goodsC_date);
	user_Table.setModifyTime(goodsC_date);
	return userDao.registration(user_Table);
}

public Integer getRole_Id(int id) {
	return userDao.getRole_Id(id);
}

public int updataUserRole(int i) {
	return userDao.updataUserRole(i);
}
}
