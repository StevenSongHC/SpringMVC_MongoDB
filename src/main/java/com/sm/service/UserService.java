package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.common.Pagination;
import com.sm.dao.UserDao;
import com.sm.entity.User;

@Service
public class UserService {

	@Autowired
	private UserDao uDao;
	
	public void save(User user) {
		uDao.save(user);
	}
	
	public void update(User user) {
		uDao.update(user);
	}
	
	public List<User> getUserList() {
		return uDao.getUserList();
	}
	
	public Pagination<User> getUserListPage(int currentPage, int pageSize, String baseUrl) {
		return uDao.getUserListPage(currentPage, pageSize, baseUrl);
	}
	
	public List<User> getUserListByGameId(String gid) {
		return uDao.getUserListByGameId(gid);
	}
	
	public User getUserById(String id) {
		return uDao.getUserById(id);
	}
	
	public User getUserByName(String name) {
		return uDao.getUserByName(name);
	}
	
	public void deleteById(String id) {
		uDao.deleteById(id);
	}
	
	public Long countUserByGameId(String gid) {
		return uDao.countUserByGameId(gid);
	}
	
}
