package com.cafe24.jblog.controller.api;

import java.util.HashMap;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.jblog.dto.JSONResult;
import com.cafe24.jblog.service.UserService;
import com.cafe24.jblog.vo.UserVo;

//Ajax 요청 처리
@Controller("userAPIController")
@RequestMapping("/user/api")
public class UserController {
	
	@Autowired
	UserService userService;

	@ResponseBody
	@RequestMapping("/checkid")
	public JSONResult checkEmail(@RequestParam(value="id", required = true, defaultValue = "") String id) {
		boolean exist = userService.existId(id);
		return JSONResult.success(exist);
	}
	
	@ResponseBody
	@RequestMapping(value="/checklogin", method = RequestMethod.POST)
	public JSONResult checklogin(
			@ModelAttribute UserVo userVo
			) {
		
		UserVo authUser = userService.getUser(userVo);
		
		if(authUser == null)
			return JSONResult.fail("아이디 또는 비밀번호를 확인해 주세요.");
		return JSONResult.success(true);
	}
}
