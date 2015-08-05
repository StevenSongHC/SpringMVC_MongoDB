package com.sm.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sm.entity.Game;
import com.sm.service.GameService;
import com.sm.service.UserService;

@Controller
@RequestMapping("game")
public class GameController {

	@Autowired
	private GameService gService;
	@Autowired
	private UserService uService;
	
	@RequestMapping
	public String list(ModelMap model) {
		model.put("gameList", gService.getGameList());
		return "GAME/list";
	}
	
	@RequestMapping("list")
	public String defaultList() {
		return "redirect:/game/list/1";
	}
	
	@RequestMapping("list/{page}")
	public String list(ModelMap model,
					   @PathVariable int page) {
		if (page == 0) {
			return "redirect:/game/list/1";
		}
		final int PAGE_SIZE = 5;
		model.put("gamePage", gService.getGameListPage(page, PAGE_SIZE, "game/list/"));
		return "GAME/list";
	}
	
	@RequestMapping("g/{gamename}")
	public String goSetGameCollection(ModelMap model,
						   			  @PathVariable String gamename) {
		Game game = gService.getGameByName(gamename);
		if (game != null) {
			model.put("game", game);
			model.put("userList", uService.getUserListByGameId(game.getId()));
			model.put("userCount", uService.countUserByGameId(game.getId()));
			return "GAME/detail";
		}
		return "STATIC/404";
	}
	
	@ResponseBody
	@RequestMapping("create")
	public Map<String, Object> addGame(String gamename,
									   Float gameprice) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (gService.getGameByName(gamename) == null) {
			Game newGame = new Game();
			newGame.setName(gamename);
			newGame.setPrice(gameprice);
			gService.save(newGame);
			
			result.put("status", 1);
			
			result.put("newGame", newGame);
		}
		else {
			result.put("status", -1);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("update")
	public Map<String, Object> updateGame(String gid,
										  String gamename,
										  Float gameprice) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (gid != null && !gid.isEmpty()) {
			Game game = gService.getGameById(gid);
			if (game != null) {
				game.setName(gamename);
				game.setPrice(gameprice);
				gService.update(game);
				
				result.put("status", 1);
			}
			else {
				result.put("status", -1);
			}
		}
		else {
			result.put("status", 0);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping("delete")
	public Map<String, Object> deleteGame(String gid) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (gid != null && !gid.isEmpty()) {
			if (gService.getGameById(gid) != null) {
				gService.deleteById(gid);
				
				result.put("status", 1);
			}
			else {
				result.put("status", -1);
			}
		}
		else {
			result.put("status", 0);
		}
		return result;
	}
	
}
