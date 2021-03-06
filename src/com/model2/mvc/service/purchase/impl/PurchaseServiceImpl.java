package com.model2.mvc.service.purchase.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.impl.ProductServiceImpl;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseDao;
import com.model2.mvc.service.purchase.PurchaseService;

@Service("purchaseServiceImpl")
public class PurchaseServiceImpl implements PurchaseService{
	
	@Autowired
	@Qualifier("purchaseDaoImpl")

	
	private PurchaseDao purchaseDao;
	public void setPurchaseDao(PurchaseDao purchaseDao) {
		this.purchaseDao = purchaseDao;
	}

	public PurchaseServiceImpl() {
		// TODO Auto-generated constructor stub
		//purchaseDao = new purchaseDaoImpl();
	}

	public void addPurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		purchaseDao.addPurchase(purchase);
	}
	
	public Purchase getPurchase(int tranNo) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("여기는 purchaseserviceImpl");
		return purchaseDao.getPurchase(tranNo);
	}

	public Purchase getPurchaseByProd(int prodNo) throws Exception {
		// TODO Auto-generated method stub
		return purchaseDao.getPurchaseByProd(prodNo);
	}
	
	public void updatePurchase(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		purchaseDao.updatePurchase(purchase);
	}

	public void updateTranCode(Purchase purchase) throws Exception {
		// TODO Auto-generated method stub
		purchaseDao.updateTranCode(purchase);
	}

	public Map<String, Object> getPurchaseList(Search search, String buyer) throws Exception {
		// TODO Auto-generated method stub
		
		Map map = new HashMap(); //HashMap	

		map.put("search", search);
		map.put("buyer", buyer);

		System.out.println("111111111111111111");
		List<Purchase> list = purchaseDao.getPurchaseList(map); // purchase 객체를 element로 받는 list 생성
		System.out.println("222222222222222222");
		int totalCount = purchaseDao.getTotalCount(search);// totalCount는 getTotalCount method를 이용하여 return 된 값을 대입
		System.out.println("3333333333333333333");

		
		
		System.out.println("List<Product> 내용 => 2. product list : "+list);
		System.out.println("List<Product> 내용 => 1. totalCount : "+ totalCount);
		
		map.put("list", list);
		map.put("totalCount", new Integer(totalCount));

		System.out.println("===================================");
		System.out.println("search :" + search);
		System.out.println("buyer :" + buyer);
		System.out.println("===================================");
		return map;
	}

	public Map<String, Object> getSaleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

}
