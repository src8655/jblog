package com.cafe24.jblog.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cafe24.jblog.repository.BlogDao;
import com.cafe24.jblog.repository.CategoryDao;
import com.cafe24.jblog.repository.UserDao;
import com.cafe24.jblog.vo.BlogVo;
import com.cafe24.jblog.vo.CategoryVo;
import com.cafe24.jblog.vo.UserVo;

@Service
public class UserService {
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	BlogDao blogDao;
	
	@Autowired
	CategoryDao categoryDao;

	public boolean addUser(UserVo userVo) {
		boolean result = false;
		
		//아이디가 있는지 확인
		int id_cnt = userDao.countById(userVo.getId());
		if(id_cnt == 0) {
			//없을 때 추가
			result = userDao.insert(userVo);

			//블로그 생성
			BlogVo blogVo = new BlogVo();
			blogVo.setBlogId(userVo.getId());
			blogVo.setTitle(userVo.getName() + "님의 블로그");
			result = blogDao.insert(blogVo);
			
			//카테고리 생성
			CategoryVo categoryVo = new CategoryVo();
			categoryVo.setName("미분류");
			categoryVo.setDescription("카테고리를 지정하지 않은 경우");
			categoryVo.setBlogId(blogVo.getBlogId());
			categoryDao.insert(categoryVo);
		}
		
		return result;
	}

	public UserVo getUser(UserVo userVo) {
		return userDao.getByIdPw(userVo);
	}

	public boolean existId(String id) {
		int count = userDao.countById(id);
		return count != 0;
	}
}
