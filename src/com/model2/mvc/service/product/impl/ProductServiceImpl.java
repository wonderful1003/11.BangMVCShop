package com.model2.mvc.service.product.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductDAO;
import com.model2.mvc.service.product.ProductService;

@Service("productServiceImpl")
public class ProductServiceImpl implements ProductService{

	///Field
	@Autowired
	@Qualifier("productDaoImpl")
	private ProductDAO productDao;
	
	public ProductServiceImpl() {
		// TODO Auto-generated constructor stub
	}

	@Override
	public void removeProduct(int prodNo) throws Exception {
		// TODO Auto-generated method stub	
		productDao.removeProduct(prodNo);
	}
	
	@Override
	public int addProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		return productDao.addProduct(product);
	}

	public ProductDAO getProductDao() {
		return productDao;
	}

	public void setProductDao(ProductDAO productDao) {
		this.productDao = productDao;
	}

	@Override
	public Product getProduct(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		
		return productDao.getProduct(prodNo);
	}

	@Override
	public void updateProduct(Product product) throws Exception {
		// TODO Auto-generated method stub
		productDao.updateProduct(product);
	}

	@Override
	public Map<String, Object> getProductList(Search search) throws Exception {
		// TODO Auto-generated method stub
		List<Product> list=productDao.getProductList(search);
		int totalCount = productDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}
}
