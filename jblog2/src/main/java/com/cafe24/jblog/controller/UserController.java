package com.cafe24.jblog.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafe24.jblog.service.UserService;
import com.cafe24.jblog.vo.UserVo;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	UserService userService;

	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		
		return "user/join";
	}
	
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(
			@ModelAttribute @Valid UserVo userVo,
			BindingResult result
			) {
		
		//입력값이 잘못되었을 때
		if(result.hasErrors()) return "redirect:/user/join";
		
		//약관동의
		if(userVo.getAgreeProv().equals("n")) return "redirect:/user/join";
		
		//유저추가
		if(userService.addUser(userVo))
			return "redirect:/user/joinsuccess";
		else
			return "redirect:/";	// 잘못된 시도는 메인으로 팅김
	}

	@RequestMapping("/joinsuccess")
	public String joinsuccess() {
		
		return "user/joinsuccess";
	}
	
	@RequestMapping("/login")
	public String login() {
		
		return "user/login";
	}
	
}
