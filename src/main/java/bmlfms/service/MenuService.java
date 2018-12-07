package bmlfms.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import bmlfms.dao.MenuDao;
import bmlfms.entity.Menu;


@Service
public class MenuService {
	@Autowired private MenuDao menuDao;
	
	public List<Menu> menuX(int i) {
		return menuDao.menuX(i);
	}
	
	public List<Menu> getTreeMenu(int i){
		return menuDao.getTreeMenu(i);
	}
	
	public int updateByPrimaryKeySelective(Menu record) {
		return menuDao.updateByPrimaryKeySelective(record);
	}
	public int addMenu(Menu menu) {
		return menuDao.addMenu(menu);
	}
	
	public int orderplus(Menu menu) {
		return menuDao.orderplus(menu);
	}
	public int getSortById(int i) {
		return menuDao.getSortById(i);
	}
	
	public int orderreduce(Menu menu) {
		return menuDao.orderreduce(menu);
	}
	
	public int deleteByPrimaryKey(int i) {
		return menuDao.deleteByPrimaryKey(i);
	}
}
