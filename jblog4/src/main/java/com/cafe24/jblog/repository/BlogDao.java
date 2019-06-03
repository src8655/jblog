package com.cafe24.jblog.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cafe24.jblog.vo.BlogVo;

@Repository
public class BlogDao {

	@Autowired
	SqlSession sqlSession;

	public boolean insert(BlogVo blogVo) {
		int count = sqlSession.insert("blog.insert", blogVo);
		return count == 1;
	}

	public BlogVo getByBlogId(String blogId) {
		return (BlogVo)sqlSession.selectOne("blog.getByBlogId", blogId);
	}

	public boolean update(BlogVo blogVo) {
		int count = sqlSession.update("blog.update", blogVo);
		return count == 1;
	}
}
