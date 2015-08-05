package com.sm.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Pagination<T> {
	
	/**
	 * Default values
	 */
	private Integer currentPage;					// displaying page
	private Integer pageSize;						// data size per page
	private Long totalCount;						// data total count
	private Integer totalPage;						// page total count
	private String baseUrl;							// base url link
	// all those maps contains 2 keys - {"url"}, {"visible"}
	private Map<String, Object> firstPage;
	private Map<String, Object> lastPage;
	private Map<String, Object> previousPage;			
	private Map<String, Object> nextPage;
	private List<T> dataItems;						// data item list
	// indexes list map contains 3 keys - {"url"}, "{value}", {"isCurrentPage"}
	private List<Map<String, Object>> pageIndexes;	// pagination item list

	public Integer getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(Integer currentPage) {
		this.currentPage = currentPage;
	}
	public Integer getPageSize() {
		return pageSize;
	}
	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}
	public Long getTotalCount() {
		return totalCount;
	}
	public void setTotalCount(Long totalCount) {
		this.totalCount = totalCount;
	}
	public Integer getTotalPage() {
		return totalPage;
	}
	public void setTotalPage(Integer totalPage) {
		this.totalPage = totalPage;
	}
	public String getBaseUrl() {
		return baseUrl;
	}
	public void setBaseUrl(String baseUrl) {
		this.baseUrl = baseUrl;
	}
	public Map<String, Object> getFirstPage() {
		return firstPage;
	}
	public void setFirstPage(Map<String, Object> firstPage) {
		this.firstPage = firstPage;
	}
	public Map<String, Object> getLastPage() {
		return lastPage;
	}
	public void setLastPage(Map<String, Object> lastPage) {
		this.lastPage = lastPage;
	}
	public Map<String, Object> getPreviousPage() {
		return previousPage;
	}
	public void setPreviousPage(Map<String, Object> previousPage) {
		this.previousPage = previousPage;
	}
	public Map<String, Object> getNextPage() {
		return nextPage;
	}
	public void setNextPage(Map<String, Object> nextPage) {
		this.nextPage = nextPage;
	}
	public List<T> getDataItems() {
		return dataItems;
	}
	public void setDataItems(List<T> dataItems) {
		this.dataItems = dataItems;
	}
	public List<Map<String, Object>> getPageIndexes() {
		return pageIndexes;
	}
	public void setPageIndexes(List<Map<String, Object>> pageIndexes) {
		this.pageIndexes = pageIndexes;
	}
	
	public Pagination(int currentPage, int pageSize, long totalCount) {
		this.setPageSize(pageSize);
		this.setTotalCount(totalCount);
		this.setTotalPage(totalCount % pageSize == 0 ? (int) (totalCount / pageSize) : (int) (totalCount / pageSize) + 1);
		// make the currentPage param legit
		if (currentPage < 1) {
			this.setCurrentPage(1);
		}
		else if (currentPage > this.totalPage) {
			this.setCurrentPage(totalPage);
		}
		else {
			this.setCurrentPage(currentPage);
		}
	}

	/**
	 * set up page navigation bar
	 * @param dataItems
	 */
	public void make(List<T> dataItems, String baseUrl) {
		this.setDataItems(dataItems);
		this.setBaseUrl(baseUrl);
		
		// set up page navigation bar
		Map<String, Object> firstPage = new HashMap<String, Object>();
		Map<String, Object> lastPage = new HashMap<String, Object>();
		Map<String, Object> previousPage = new HashMap<String, Object>();
		Map<String, Object> nextPage = new HashMap<String, Object>();
		// when currentPage is the first page, then hide "firstPage" & "previousPage"
		if (this.getCurrentPage() == 1) {
			firstPage.put("visible", false);
			lastPage.put("url", baseUrl + this.getTotalPage());
			lastPage.put("visible", true);
			previousPage.put("visible", false);
			nextPage.put("url", baseUrl + (this.getCurrentPage() + 1));
			nextPage.put("visible", true);
		}
		// when currentPage is the last page, then hide "lastPage" & "nextPage"
		else if (this.getCurrentPage() == this.getTotalPage()) {
			firstPage.put("url", baseUrl + 1);
			firstPage.put("visible", true);
			lastPage.put("visible", false);
			previousPage.put("url", baseUrl + (this.getCurrentPage() - 1));
			previousPage.put("visible", true);
			nextPage.put("visible", false);
		}
		else {
			firstPage.put("url", baseUrl + 1);
			firstPage.put("visible", true);
			lastPage.put("url", baseUrl + this.getTotalPage());
			lastPage.put("visible", true);
			previousPage.put("url", baseUrl + (this.getCurrentPage() - 1));
			previousPage.put("visible", true);
			nextPage.put("url", baseUrl + (this.getCurrentPage() + 1));
			nextPage.put("visible", true);
		}
		this.setFirstPage(firstPage);
		this.setLastPage(lastPage);
		this.setPreviousPage(previousPage);
		this.setNextPage(nextPage);
		// time for page indexes list
		List<Map<String, Object>> pageIndexes = new ArrayList<Map<String, Object>>();
		// find the boundary of page index, endIndex can't not be bigger than the total page count
		// first of all find the lastFlag which means current page is num 10*n
		int lastFlag = this.getCurrentPage() % 10 == 0 ? 1 : 0;
		int startIndex = (this.getCurrentPage() / 10 - lastFlag) * 10 + 1;
		int endIndex = (this.getCurrentPage() / 10 - lastFlag) * 10 + 10 > this.getTotalPage() ? this.getTotalPage() : (this.getCurrentPage() / 10 - lastFlag) * 10 + 10;
		// add pageIndex to the list
		for (int i=startIndex; i<=endIndex; i++) {
			Map<String, Object> pageIndex = new HashMap<String, Object>();
			pageIndex.put("url", baseUrl + i);
			pageIndex.put("value", i);
			if (i == this.getCurrentPage()) {
				pageIndex.put("isCurrentPage", true);
			}
			else {
				pageIndex.put("isCurrentPage", false);
			}
			pageIndexes.add(pageIndex);
		}
		this.setPageIndexes(pageIndexes);
	}

}
