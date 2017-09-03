package com.model2.mvc.web.Purchase;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.purchase.PurchaseService;


//==> 회원관리 RestController
@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	//setter Method 구현 않음
		
	public PurchaseRestController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping( value="json/getPurchase/{tranNo}", method=RequestMethod.GET )
	public Purchase getPurchase( @PathVariable int tranNo ) throws Exception{
		System.out.println("여기는 purchase rest controller :"+tranNo);
		System.out.println("이건 purchaseService.getPurchase(tranNo)");
		System.out.println(purchaseService.getPurchase(tranNo));
		System.out.println("/purchase/json/getPurchase : GET");
		
		//Business Logic
		return purchaseService.getPurchase(tranNo);
	}

/*	@RequestMapping( value="json/addPurchase", method=RequestMethod.POST )
	public Purchase addPurchase(	@RequestBody Purchase purchase ) throws Exception{
	
		System.out.println("/purchase/json/addPurchase : POST");
		//Business Logic
		System.out.println("::"+purchase);
		purchaseService.addPurchase(purchase);
		   		
		return purchase;
	}
	
	@RequestMapping( value="json/updatePurchase", method=RequestMethod.POST )
	public Purchase updatePurchase(	@RequestBody Purchase purchase ) throws Exception{
	
		System.out.println("/purchase/json/updatePurchase : POST");
		//Business Logic
		System.out.println("::"+purchase);
		
		purchaseService.updatePurchase(purchase);
						
		return purchase;
	}
	
	@RequestMapping( value="json/getPurchaseList", method=RequestMethod.POST )
	public Map getPurchaseList(	@RequestBody Search search ) throws Exception{
	
		System.out.println("/purchase/json/getPurchaseList : POST");
		//Business Logic
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		Map<String , Object> map=purchaseService.getPurchaseList(search);
		System.out.println("map ::"+map);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage ::" + resultPage);
		System.out.println("map tostring ::" + map.toString());
		
		return map;
	}
*/	
}
