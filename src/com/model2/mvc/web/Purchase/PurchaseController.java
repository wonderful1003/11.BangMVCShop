package com.model2.mvc.web.Purchase;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;


//==> ȸ������ Controller
@Controller
@RequestMapping("/purchase/*")
public class PurchaseController {
	
	///Field
	@Autowired
	@Qualifier("purchaseServiceImpl")
	private PurchaseService purchaseService;
	//setter Method ���� ����
	
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method ���� ����
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	//setter Method ���� ����
	
	///Constructor
	public PurchaseController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	
	//@RequestMapping("/addUserView.do")
	//public String addUserView() throws Exception {
	@RequestMapping( value="addPurchase", method=RequestMethod.GET )
	public String addPurchase(@RequestParam("prodNo") String prodNo, 
													Model model) throws Exception{
	
		System.out.println("/purchase/addPurchase : GET");
		
		Product product = productService.getProduct(Integer.parseInt(prodNo));
		model.addAttribute("product", product);
		
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	//@RequestMapping("/addUser.do")
	@RequestMapping( value="addPurchase", method=RequestMethod.POST )
	public String addPurchase( 	@RequestParam("prodNo") String prodNo,
								@RequestParam("buyerId") String buyerId,
								@ModelAttribute("purchase") Purchase purchase,
												Model model) throws Exception {

		System.out.println("/purchase/addPurchase : POST");
		//Business Logic
		System.out.println(userService.getUser(buyerId));
		System.out.println(Integer.parseInt(prodNo));
				
		purchase.setBuyer(userService.getUser(buyerId));
		int prodNoInt = Integer.parseInt(prodNo);
		purchase.setPurchaseProd(productService.getProduct(prodNoInt));
		purchase.setTranCode("1");
		purchaseService.addPurchase(purchase);
		System.out.println("purchase.getTranCode :" + purchase.getTranCode());
		model.addAttribute("prodNo",prodNo);
		model.addAttribute("purchase", purchase);
		model.addAttribute("buyerId", buyerId);
		
		System.out.println("prodNo : " + prodNo);
		System.out.println("purchase : " + purchase);
		System.out.println("buyerId : " + buyerId);
		
		return "forward:/purchase/addPurchasecomplete.jsp";
	}
	
	//@RequestMapping("/getUser.do")
	@RequestMapping( value="getPurchase", method=RequestMethod.GET )
	public String getPurchase( @RequestParam("tranNo") int tranNo , Model model ) throws Exception {
		
		
		System.out.println("tranNo : "+ tranNo);
		System.out.println("/purchase/getPurchase : GET");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		// Model �� View ����
		//purchase.setDivyDate(purchase.getDivyDate().substring(0, 10));
		System.out.println("purchase : " + purchase);
		System.out.println("prodNo : " + purchase.getReceiverName());
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}
	
	@RequestMapping( value="getPurchaseByProd", method=RequestMethod.GET )
	public String getPurchaseByProd( @RequestParam("prodNo") int prodNo , Model model ) throws Exception {
		
		System.out.println("/purchase/getPurchaseByProd : GET");
		//Business Logic
		Purchase purchase = purchaseService.getPurchaseByProd(prodNo);
		// Model �� View ����
		//purchase.setDivyDate(purchase.getDivyDate().substring(0, 10));
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/getPurchase.jsp";
	}

	
	//@RequestMapping("/updateUserView.do")
	//public String updateUserView( @RequestParam("userId") String userId , Model model ) throws Exception{
	@RequestMapping( value="updatePurchaseView", method=RequestMethod.GET)
	public String updatePurchase( @RequestParam("tranNo") int tranNo , Model model ) throws Exception{

		System.out.println("/purchase/updatePurchaseView ");
		//Business Logic
		Purchase purchase = purchaseService.getPurchase(tranNo);
		// Model �� View ����
		
		purchase.setDlvyDate(purchase.getDlvyDate().substring(0, 10).replaceAll("-", ""));
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
	//@RequestMapping("/updateUser.do")
	@RequestMapping( value="updatePurchase", method=RequestMethod.POST )
	public String updatePurchase( @ModelAttribute("purchase") Purchase purchase , Model model ) throws Exception{

		System.out.println("/purchase/updatePurchase : POST");
		
		//Business Logic
		purchaseService.updatePurchase(purchase);
		
		return "redirect:/purchase/getPurchase?tranNo="+purchase.getTranNo();
	}
	
	//@RequestMapping("/updatePurchase.do") // '����' button ������, // ����.....�ߺ��ð�....
	@RequestMapping( value="updateTranCode", method=RequestMethod.GET )
	public String updateTranCode(@ModelAttribute("purchase") Purchase purchase, 
									//@RequestParam("prodNo") int prodNo,
									 Model model ) throws Exception{
		
		System.out.println("/purchase/updateTranCode : GET");
		//Business Logic
		model.addAttribute("menu", "manage");
		//purchase = purchaseService.getPurchaseByProd(prodNo);
		purchaseService.updateTranCode(purchase);
	
		return "redirect:/product/listProduct";
	}
	
	@RequestMapping( value="updateTranCodeByProd", method=RequestMethod.GET )
	public String updateTranCodeByProd(@RequestParam("prodNo") int prodNo,
											@RequestParam("tranCode") String tranCode,
											Model model) throws Exception{
		System.out.println("/purchase/updateTranCodeByProd : GET");
		
		System.out.println("1 ���Ⱑ ������ prodNo : " + prodNo);
		Purchase purchase = purchaseService.getPurchaseByProd(prodNo);
		System.out.println("2 ���Ⱑ ������ tranCode : " + tranCode);
		purchase.setTranCode(tranCode);
		System.out.println("3 ���Ⱑ ������ purchase : " + purchase);
		purchase.setDlvyDate(purchase.getDlvyDate().substring(0, 10).replaceAll("-", ""));
		purchaseService.updatePurchase(purchase);
		
		System.out.println("4 ���Ⱑ ������ purchase : " + purchase.getTranCode());
		
		model.addAttribute("menu", "manage");
		System.out.println("5 ���Ⱑ ������ purchase : " + purchase);
		return "redirect:/product/listProduct";
	}
	
	@RequestMapping( value="listPurchase" )
	public String listPurchase( 	@ModelAttribute("purchase") Purchase purchase,
									@ModelAttribute("search") Search search , 
												Model model , HttpSession session) throws Exception{
				
		System.out.println("/purchase/listPurchase :GET");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		User user = (User) session.getAttribute("user");
		System.out.println(" user :" + user);
		System.out.println(user.getUserId());
		System.out.println(search);
		
		System.out.println("���Ⱑ ������ 0");
		search.setSearchKeyword(user.getUserId());
		System.out.println("���Ⱑ ������ 1");
		Map<String , Object> map=purchaseService.getPurchaseList(search, user.getUserId());
		System.out.println("���Ⱑ ������ 2");
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("resultPage : " +resultPage);
		System.out.println("tranNo : " + purchase.getTranNo());
		System.out.println("buyer" + user.getUserId());
		System.out.println("search" + search);
		
		model.addAttribute("buyer", user.getUserId());
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		System.out.println("list : "+map.get("list"));	
		
		return "forward:/purchase/listPurchase.jsp";
	
	}
}
