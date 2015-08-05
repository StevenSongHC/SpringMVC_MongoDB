package com.sm.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sm.entity.Game;
import com.sm.entity.User;
import com.sm.service.GameService;
import com.sm.service.UserService;

@Controller
@RequestMapping("user")
public class UserController {

	@Autowired
	private UserService uService;
	@Autowired
	private GameService gService;
	
	@RequestMapping
	public String index(ModelMap model) {
		model.put("userList", uService.getUserList());
		return "USER/list";
	}
	
	@RequestMapping("list")
	public String defaultList() {
		return "redirect:/user/list/1";
	}
	
	@RequestMapping("list/{page}")
	public String list(ModelMap model,
					   @PathVariable int page) {
		if (page == 0) {
			return "redirect:/user/list/1";
		}
		final int PAGE_SIZE = 10;
		model.put("userPage", uService.getUserListPage(page, PAGE_SIZE, "user/list/"));
		return "USER/list";
	}
	
	@RequestMapping("u/{username}")
	public String goSetGameCollection(ModelMap model,
						   			  @PathVariable String username) {
		User user = uService.getUserByName(username);
		if (user != null) {
			model.put("user", uService.getUserByName(username));
			model.put("gameList", gService.getGameList());
			return "USER/game-collection";
		}
		return "STATIC/404";
	}
	
	@ResponseBody
	@RequestMapping("set_game_collection")
	public Map<String, Object> SetGameCollection(String uid,
												 @RequestParam(value="gamesArr[]", required=false) String[] gamesArr) {
		Map<String, Object> result = new HashMap<String, Object>();
		User user = uService.getUserById(uid);
		if (user != null) {
			if (gamesArr != null) {
				List<Game> games = new ArrayList<Game>();
				for (String gid: gamesArr) {
					games.add(gService.getGameById(gid));
				}
				user.setGames(games);
			}
			// empty game collection
			else {
				user.setGames(null);
			}
			uService.update(user);
			result.put("status", 1);
		}
		// User Does Not Existed
		else {
			result.put("status", -1);
		}
		return result;
	}
	
	@ResponseBody
	@RequestMapping("ajax")
	public Map<String, Object> ajax() {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("userList", uService.getUserList());
		return result;
	}
	
	@ResponseBody
	@RequestMapping("create")
	public Map<String, Object> addUser(String username) {
		Map<String, Object> result = new HashMap<String, Object>();
		// non-existed username
		if (uService.getUserByName(username) == null) {
			User newUser = new User();
			newUser.setName(username);
			uService.save(newUser);
			
			result.put("status", 1);
			
			// return new user info
			result.put("newUser", newUser);
		}
		// existed username is not allowed
		else {
			result.put("status", -1);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping("update")
	public Map<String, Object> updateUser(String uid,
										  String username) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (uid != null && !uid.isEmpty()) {
			User user = uService.getUserById(uid);
			if (user != null) {
				if (uService.getUserByName(username) == null) {
					// validated
					user.setName(username);
					uService.update(user);
					
					result.put("status", 1);
				}
				// username already been used
				else {
					result.put("status", -2);
				}
			}
			// non-existed user
			else {
				result.put("status", -1);
			}
		}
		// illegal uid
		else {
			result.put("status", 0);
		}
		return result;
	}

	@ResponseBody
	@RequestMapping("delete")
	public Map<String, Object> deleteUser(String uid) {
		Map<String, Object> result = new HashMap<String, Object>();
		if (uid != null && !uid.isEmpty()) {
			if (uService.getUserById(uid) != null) {
				// delete the validate user document
				uService.deleteById(uid);
				
				result.put("status", 1);
			}
			// non-existed user
			else {
				result.put("status", -1);
			}
		}
		// illegal uid
		else {
			result.put("status", 0);
		}
		return result;
	}
	
}
