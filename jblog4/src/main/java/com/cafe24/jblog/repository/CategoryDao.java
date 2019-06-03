package com.cafe24.jblog.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cafe24.jblog.vo.CategoryVo;

@Repository
public class CategoryDao {

	@Autowired
	SqlSession sqlSession;

	public boolean insert(CategoryVo categoryVo) {
		int count  = sqlSession.insert("category.insert", categoryVo);
		return count == 1;
	}

	public List<CategoryVo> getList(String blogId) {
		return sqlSession.selectList("category.getList", blogId);
	}

	public boolean delete(CategoryVo categoryVo) {
		int count = sqlSession.delete("category.delete", categoryVo);
		return count == 1;
	}
}
