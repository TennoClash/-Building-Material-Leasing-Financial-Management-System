package bmlfms.controller;

import java.security.NoSuchAlgorithmException;
import java.security.interfaces.RSAPrivateKey;
import java.security.interfaces.RSAPublicKey;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import bmlfms.entity.User_Table;
import bmlfms.service.LoginService;
import bmlfms.util.RSACrypt;

@Controller
public class LoginController {

	@Autowired
	private LoginService loginService;

	@RequestMapping("/login")
	public String login() {
		return "login";
	}

	@RequestMapping("/welcome")
	public String welcome() {
		return "welcome";
	}

	@RequestMapping("/userma")
	public String userma() {
		return "userma";
	}

	@RequestMapping("/registration")
	public String registration() {
		return "registration";
	}

	@RequestMapping("/jump/jumplogin")
	public String jumplogin() {
		return "jump/jumplogin";
	}

	@RequestMapping("/menumanage")
	public String menumanage() {
		return "menumanage";
	}

	@RequestMapping(value = "/logout", produces = "text/html;charset=UTF-8")
	public String logout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "/login";
	}

	@RequestMapping(value = "/ajax_login", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String login_submit(String name, String pass, HttpServletRequest request, HttpSession session)
			throws Exception {
		String privateKey = (String) session.getAttribute("privateKeyStr");
		pass = RSACrypt.decrypt(RSACrypt.loadPrivateKey(privateKey), RSACrypt.strToBase64(pass));
		boolean result = loginService.execute(name, pass);
		if (result) {
			User_Table user = loginService.getUserByName(name);
			int usertype = user.getUserType();
			int user_id = user.getUserId();
			String user_number = user.getUserName();
			String account_name = user.getRealName();
			Integer i = loginService.getRole_Id(user.getUserId());
			if (usertype == 0) {
				User_Table user2 = loginService.getUser(name, pass);
				session.setAttribute("user", user2);
				session.setAttribute("account_name", account_name);
				session.setAttribute("user_type", usertype);
				session.setAttribute("role_id", i);
				session.setAttribute("user_number", user_number);
				session.setAttribute("user_id", user_id);
				return "管理员登录成功";
			} else {
				User_Table user2 = loginService.getUser(name, pass);
				session.setAttribute("user", user2);
				session.setAttribute("account_name", account_name);
				session.setAttribute("user_type", usertype);
				session.setAttribute("role_id", i);
				session.setAttribute("user_number", user_number);
				session.setAttribute("user_id", user_id);
				return "学员登录成功";
			}
		} else {
			return "用户名或密码错误";
		}

	}

	@RequestMapping(value = "/getKey", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String getKey(HttpSession session) throws NoSuchAlgorithmException {
		HashMap<String, String> map2 = RSACrypt.getKeys();
		String privateKeyStr = map2.get("privateKey");
		String publicKeyStr = map2.get("publicKey");
		session.setAttribute("privateKeyStr", privateKeyStr);
		return publicKeyStr;
	}

	@RequestMapping(value = "/ajax_registration", produces = "text/html;charset=UTF-8")
	@ResponseBody
	public String registration_submit(User_Table user_Table) {
		int i = loginService.registration(user_Table);
		User_Table user = loginService.getUserByName(user_Table.getUserName());
		int ii = loginService.updataUserRole(user.getUserId());
		if (i != 0) {
			return "0";
		} else {
			return "1";
		}
	}

}
