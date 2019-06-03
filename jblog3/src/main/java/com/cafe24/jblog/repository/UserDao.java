package com.cafe24.jblog.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.cafe24.jblog.vo.UserVo;

@Repository
public class UserDao {

	@Autowired
	SqlSession sqlSession;

	public int countById(String id) {
		return (Integer)sqlSession.selectOne("user.countById", id);
	}

	public boolean insert(UserVo userVo) {
		int count = sqlSession.insert("user.insert", userVo);
		return count == 1;
	}

	public UserVo getByIdPw(UserVo userVo) {
		return (UserVo)sqlSession.selectOne("user.getByIdPw", userVo);
	}
}
