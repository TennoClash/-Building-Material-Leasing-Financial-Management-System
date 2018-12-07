package bmlfms.controller;

import java.io.UnsupportedEncodingException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import bmlfms.entity.Page;
import bmlfms.entity.User_Table;
import bmlfms.service.UserService;

@Controller
public class UserController {
	@Autowired
	private UserService userService;

	@RequestMapping(value = "/vpass", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String vpass(String id) {
		int i = userService.vPass(id);
		return "1";
	}

	@RequestMapping(value = "/usered", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String usered(User_Table user_Table) {
		int i = userService.updateUser(user_Table);
		return "1";
	}

	@RequestMapping("/userTable")
	public String searchInvList(Page page, HttpServletRequest request) throws UnsupportedEncodingException {
		Page p = page;
		int pageSize = 5;
		p.setPageSize(pageSize);
		int curPage = p.getCurrentPage();

		if (curPage == 0) {
			curPage = 1;
			p.setCurrentPage(curPage);
		}
		int startRow = page.getStartRow();

		if (!(p.getCurrentPage() == 0)) {
			startRow = getStartRowBycurrentPage(curPage, pageSize);
		}
		p.setStartRow(startRow);

		String queryCondition = null;
		if (page.getQueryCondition() != null) {
			queryCondition = page.getQueryCondition();
		}
		List<User_Table> user_Tables = getInvListByCondition(page);
		Integer totalCounts = userService.searchTotalCountT(page);
		int totalPages = (totalCounts % pageSize == 0) ? (totalCounts / pageSize) : (totalCounts / pageSize + 1);
		p.setTotalPage(totalPages);
		page.setTotalRows(totalCounts);
		request.setAttribute("user_Tables", user_Tables);
		request.setAttribute("page", page);
		return "userma";
	}

	private List<User_Table> getInvListByCondition(Page page) {
		List<User_Table> user_Tables = null;
		if (page.getQueryCondition() == null) {
			user_Tables = userService.searchInvListT(page);
			return user_Tables;
		}
		user_Tables = userService.getInvBycondtionT(page);
		return user_Tables;
	}

	public int getStartRowBycurrentPage(int currentPage, int pageSize) {
		int startRow = 0;
		if (currentPage == 1) {
			return startRow = 0;
		}
		startRow = (currentPage - 1) * pageSize;
		return startRow;
	}

}
