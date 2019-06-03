package com.cafe24.jblog.controller.api;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe24.jblog.dto.JSONResult;
import com.cafe24.jblog.service.BlogService;
import com.cafe24.jblog.vo.CategoryVo;
import com.cafe24.jblog.vo.PostVo;
import com.cafe24.jblog.vo.UserVo;
import com.cafe24.security.Auth;
import com.cafe24.security.AuthUser;

// Ajax 요청 처리
@Controller("blogAPIController")
@RequestMapping("/blog/admin/api")
public class BlogController {
	
	@Autowired
	BlogService blogService;

	@Auth
	@ResponseBody
	@RequestMapping(value="/category", method = RequestMethod.POST)
	public JSONResult write(
			@ModelAttribute @Valid CategoryVo categoryVo,
			BindingResult result,
			@AuthUser UserVo authUser
			) {
		
		//잘못된 접근
		if(!authUser.getId().equals(categoryVo.getBlogId()))
			return JSONResult.fail("잘못된 접근입니다.");
		if(result.hasErrors())
			return JSONResult.fail("잘못된 접근입니다.");
		
		if(blogService.addCategory(categoryVo))
			return JSONResult.success(true);
		else
			return JSONResult.fail("작성 실패");
		
	}
	
	@Auth
	@ResponseBody
	@RequestMapping(value="/category", method = RequestMethod.GET)
	public JSONResult list(
			@RequestParam(value="blogId", required = true, defaultValue = "-1") String blogId,
			@AuthUser UserVo authUser
			) {
		
		//잘못된 접근
		if(!authUser.getId().equals(blogId))
			return JSONResult.fail("잘못된 접근입니다.");
		
		Map<String, Object> map = new HashMap<String, Object>();
		List<CategoryVo> categoryList = blogService.getCategoryList(blogId);
		map.put("categoryList", categoryList);
		map.put("cnt", categoryList.size());
		
		return JSONResult.success(map);
		
	}
	

	@Auth
	@ResponseBody
	@RequestMapping(value="/category/delete", method = RequestMethod.POST)
	public JSONResult delete(
			@RequestParam(value="blogId", required = true, defaultValue = "-1") String blogId,
			@RequestParam(value="no", required = true, defaultValue = "-1") Long no,
			@AuthUser UserVo authUser
			) {
		
		//잘못된 접근
		if(!authUser.getId().equals(blogId))
			return JSONResult.fail("잘못된 접근입니다.");
		
		//포스트가 있는 카테고리인지?
		if(blogService.existPost(no))
			return JSONResult.fail("실패 : 포스트가 존재하는 카테고리입니다.");
		
		blogService.delete(blogId, no);
		
		return JSONResult.success(true);
		
	}
	
	
	@ResponseBody
	@RequestMapping(value="/postPaging", method = RequestMethod.POST)
	public JSONResult postPaging(
			@RequestParam(value="blogId", required = true, defaultValue = "-1") String blogId,
			@RequestParam(value="categoryNo", required = true, defaultValue = "-1") Long categoryNo,
			@RequestParam(value="pages", required = true, defaultValue = "1") int pages
			) {
		
		//포스트 리스트
		Map<String, Object> postMap = blogService.getPostListAjax(blogId, categoryNo, pages);
		
		return JSONResult.success(postMap);
	}
}
