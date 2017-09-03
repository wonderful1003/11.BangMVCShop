package com.model2.mvc.web.product;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
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
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.product.ProductService;


//==> 회원관리 Controller
@Controller
@RequestMapping("/product/*")
public class ProductController {
	
	///Field
	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	//setter Method 구현 않음
			
	public ProductController(){
		System.out.println(this.getClass());
	}
	
	//==> classpath:config/common.properties  ,  classpath:config/commonservice.xml 참조 할것
	//==> 아래의 두개를 주석을 풀어 의미를 확인 할것
	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	@RequestMapping("uploadform")  
	   public ModelAndView uploadForm(){  
	       return new ModelAndView("uploadform");    
	}  
	 
	@RequestMapping(value="removeProduct", method=RequestMethod.POST)
	public ModelAndView removeProduct(@RequestParam("prodNo") int prodNo , Model model) throws Exception {

		System.out.println("/removeProduct");
				
		productService.removeProduct(prodNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/listProduct?menu=manage");
				
		return modelAndView;

	}
	
	@RequestMapping(value="addProductView", method=RequestMethod.GET)
	public ModelAndView addProductView() throws Exception {

		System.out.println("/addProductView");
				
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/addProductView");
				
		return modelAndView;
	}
	
	@RequestMapping(value="addProduct", method=RequestMethod.POST)
	public ModelAndView addProduct( @ModelAttribute("product") Product product,
									@RequestParam("file") MultipartFile file,									
									HttpServletRequest request
									) throws Exception {

		System.out.println("/addProduct 여기 일단 들어오지?");    
	    
	    ModelAndView modelAndView = new ModelAndView();

	    try {

	       String uploadDir = "C:\\workspace\\11.BangMVCShop\\WebContent\\images\\uploadFiles\\";
	       //String realPath = request.getServletContext().getRealPath(uploadDir);
	      
	       File transferFile = new File(uploadDir  + file.getOriginalFilename()); 
	       file.transferTo(transferFile);
	       System.out.println("file transferred.... ");
	       product.setFileName(file.getOriginalFilename());
	       product.setManuDate(product.getManuDate().replaceAll("/",""));
	       /////////////////////////////////////////////////////////////////
	       System.out.println("the product that I`m trying to add is :: "+product);
	       /////////////////////////////////////////////////////////////////
	       
	       } catch (Exception e) {
	          e.printStackTrace();
	          }


		productService.addProduct(product);
		String message = "상품을 추가하세요";
		
		modelAndView.setViewName("/product/addProduct.jsp");
		modelAndView.addObject("message",message);
		modelAndView.addObject("product", product);
		System.out.println("addProduct Post");
			    
		return modelAndView;
	}
	
	@RequestMapping( value="getProduct", method=RequestMethod.GET)
	public ModelAndView getProduct( @RequestParam("prodNo") int prodNo,
								@RequestParam(value="menu",defaultValue="") String menu ,
								Model model ) throws Exception {
		
		System.out.println("/getProduct");				
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		System.out.println(product);
		
		
		ModelAndView modelAndView = new ModelAndView();
		System.out.println(menu);
		
		if(menu!=""){
			if(menu.equals("manage")){
//				modelAndView.setViewName("/product/updateProductView.jsp");
				modelAndView.setViewName("/product/updateProduct");
				return modelAndView;
			}
		}
		
/*		Cookie cookie=null;
	      if(history == null){
	         cookie = new Cookie("history",prodNo);
	         System.out.println("히스토리가 널일때 첫생성");
	      }else{
	         int check = 0;
	         String[] temp = history.split(",");
	         for(int i = 0; i<temp.length; i++){
	            if(temp[i].equals(prodNo)){
	               check = 1;
	            }
	         }
	         if(!(check == 1)){
	            cookie = new Cookie("history",history+","+prodNo);
	         }
	         System.out.println("히스토리가 널이 아닐때 전쿠키에 추가");
	      }
	      if(cookie!=null){
	         cookie.setMaxAge(60*3);
	         cookie.setPath("/");
	         response.addCookie(cookie);
	      }
*/	      
	      
		modelAndView.setViewName("/product/getProduct.jsp");
		return modelAndView;
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.GET)
	public ModelAndView updateProduct( @RequestParam("prodNo") int prodNo , Model model ) throws Exception{

		System.out.println("/updateProductView");
		//Business Logic
		Product product = productService.getProduct(prodNo);
		// Model 과 View 연결
		model.addAttribute("product", product);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/updateProductView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value="updateProduct", method=RequestMethod.POST)
	public ModelAndView updateProduct( @ModelAttribute("product") Product product , Model model , HttpSession session) throws Exception{

		System.out.println("/updateProduct");
		//Business Logic
		System.out.println("product 나야나 "+product);
		
		product.setManuDate(product.getManuDate().replaceAll("/",""));
		productService.updateProduct(product);
		
		//model.addAttribute("product", product.getProdNo());
		System.out.println("product 수정후 나야나 "+product.getProdNo());
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/getProduct.jsp");
		
		return modelAndView;
	}
			
	@RequestMapping(value="listProduct")
	public ModelAndView listProduct( @ModelAttribute("search") Search search , Model model , HttpServletRequest request) throws Exception{
		
		Product product = new Product();
		
		System.out.println("/listProduct");
		
		if(search.getCurrentPage() ==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=productService.getProductList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
	
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/product/listProduct.jsp");
	
		System.out.println(resultPage);
		System.out.println("get tran Code : " + product.getProTranCode());
		System.out.println("list : "+map.get("list"));
		
		
		return modelAndView;
	}
}