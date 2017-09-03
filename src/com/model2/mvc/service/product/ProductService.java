package com.model2.mvc.service.product;


import java.util.Map;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;

import sun.net.www.content.text.plain;


public interface ProductService {
	
	public void removeProduct(int prodNo) throws Exception;
	
	public int addProduct(Product product) throws Exception;
	
	public Product getProduct(int prodNo ) throws Exception;

	public void updateProduct(Product product) throws Exception;

	public Map<String, Object> getProductList(Search search) throws Exception;


}
