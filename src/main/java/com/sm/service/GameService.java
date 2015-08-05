package com.sm.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sm.common.Pagination;
import com.sm.dao.GameDao;
import com.sm.entity.Game;

@Service
public class GameService {

	@Autowired
	GameDao gDao;
	
	public void save(Game game) {
		gDao.save(game);
	}
	
	public void update(Game game) {
		gDao.update(game);
	}
	
	public List<Game> getGameList() {
		return gDao.getGameList();
	}
	
	public Pagination<Game> getGameListPage(int currentPage, int pageSize, String baseUrl) {
		return gDao.getGameListPage(currentPage, pageSize, baseUrl);
	}
	
	public Game getGameById(String id) {
		return gDao.getGameById(id);
	}
	
	public Game getGameByName(String name) {
		return gDao.getGameByName(name);
	}
	
	public void deleteById(String id) {
		gDao.deleteById(id);
	}
	
}
