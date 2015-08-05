package com.sm.dao;

import java.util.List;

import org.bson.types.ObjectId;
import org.springframework.data.domain.Sort;
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.data.mongodb.core.query.Query;
import org.springframework.data.mongodb.core.query.Update;
import org.springframework.stereotype.Repository;

import com.sm.common.MongoGenDao;
import com.sm.common.Pagination;
import com.sm.entity.User;

@Repository
public class UserDao extends MongoGenDao<User> {

	public void save(User user) {
		super.save(user);
	}
	
	public void update(User user) {
		Update update = new Update();
		update.set("name", user.getName());
		update.set("games", user.getGames());
		super.update(Query.query(Criteria.where("_id").is(user.getId())), update);
	}
	
	public List<User> getUserList() {
		return (List<User>) super.findList(new Query().with(new Sort(Direction.DESC, "_id")));
	}
	
	public Pagination<User> getUserListPage(int currentPage, int pageSize, String baseUrl) {
		return super.queryPage(new Query().with(new Sort(Direction.DESC, "_id")), (currentPage - 1) * pageSize, pageSize, baseUrl);
	}
	
	public List<User> getUserListByGameId(String gid) {
		return (List<User>) super.findList(Query.query(Criteria.where("games._id").is(new ObjectId(gid))).with(new Sort(Direction.DESC, "_id")));
	}
	
	public User getUserById(String id) {
		return (User) super.findOne(Query.query(Criteria.where("_id").is(id)));
	}
	
	public User getUserByName(String name) {
		return (User) super.findOne(Query.query(Criteria.where("name").is(name)));
	}
	
	public void deleteById(String id) {
		super.delete(Query.query(Criteria.where("_id").is(id)));
	}
	
	public Long countUserByGameId(String gid) {
		return super.getPageCount(Query.query(Criteria.where("games._id").is(new ObjectId(gid))));
	}
	
	@Override
	protected Class<User> getEntityClass() {
		return User.class;
	}
	
}
