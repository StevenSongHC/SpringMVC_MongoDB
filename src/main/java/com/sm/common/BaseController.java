package com.sm.common;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sm.service.UserService;

@Controller
@RequestMapping
public class BaseController {
	
	@Autowired
	private UserService uService;
	
	@RequestMapping("index")
	public String index(ModelMap model) {
		return "index";
	}
	
	@RequestMapping("users_games")
	public String usersGames(ModelMap model) {
		return "redirect:/users_games/1";
	}
	
	@RequestMapping("users_games/{page}")
	public String usersGamesList(ModelMap model,
								 @PathVariable int page) {
		final int PAGE_SIZE = 5;
		model.put("collectionPage", uService.getUserListPage(page, PAGE_SIZE, "users_games/"));
		return "user-game-list";
	}
	
}
