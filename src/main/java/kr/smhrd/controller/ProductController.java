package kr.smhrd.controller;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.smhrd.entity.Category;
import kr.smhrd.entity.Image;
import kr.smhrd.entity.PIC;
import kr.smhrd.entity.Product;
import kr.smhrd.mapper.ProductMapper;

@Controller
public class ProductController {
	private final ServletContext servletContext;
	@Autowired
	public ProductController(ServletContext servletContext) {
	        this.servletContext = servletContext;
	}
	 
	@Autowired
	private ProductMapper mapper;
	
	@RequestMapping("/plist")
	public String plist() {
		return "product/product_list";
	}
	@RequestMapping("/detail")
	public String detail() {
		return "product/product_detail";
	}

	@GetMapping("/p_create")
	public String create(Model model) {
		//List<Category> clist=mapper.getCategorys();
		//model.addAttribute("clist", clist);
		return "product/product_create";
	}
	
	@RequestMapping("/p_categoryList")
	public @ResponseBody List<Category> categoryList(){
		List<Category> clist=mapper.getCategorys();
		return clist;
	}
	
	@PostMapping("/p_create")
	public String create(Product pvo) {
		mapper.productInsert(pvo);
		return "redirect:/p_sales";
	}
	
	//@RequestMapping("/login")
	//@RequestMapping("/logout")
	@RequestMapping("/p_list")
	public String p_list(Model model) {
		List<PIC> list=mapper.productList();
		model.addAttribute("list", list);
		System.out.println(list);
		return "product/product_list";
	}
	
	@RequestMapping("/p_detail")
	public String detail(int id, Model model) {
		PIC pic=mapper.productDetail(id);
		model.addAttribute("pic", pic);
		List<Image> imglist=mapper.getImages(id);
		model.addAttribute("imglist", imglist);
		return "product/product_detail";
	}
	
	/*
	 * @RequestMapping("/p_create") public String create() { return
	 * "product/product_create"; }
	 */
	@RequestMapping("/p_sales")
	public String sales(Model model) {
		List<PIC> list=mapper.productList2();
		System.out.println(list);
		model.addAttribute("list", list);
		return "product/sales_list";
	}

	@RequestMapping("/p_image")
	public String image(int id, Model model) {
		// t_product 정보만 가져오면 된다
		Product pic=mapper.productGetById(id);
		model.addAttribute("pic", pic);
		// t_image정보도 가져오기
		// select * from t_image where product_id=?
		List<Image> mlist=mapper.imageList(id);
		model.addAttribute("mlist", mlist);
		return "product/imageInsert";
	}
	
	@PostMapping("/upload")
    public @ResponseBody void handleFileUpload(MultipartFile[] files, Image imgvo) {
		System.out.println(imgvo);
		String uploadDirectory = servletContext.getRealPath("/resources/upload");
		String productDirectoryPath = uploadDirectory + File.separator + imgvo.getProduct_id();
		    File productDirectory = new File(productDirectoryPath);
		    if (!productDirectory.exists()) {
		        productDirectory.mkdirs();
		    }
		    for (MultipartFile file : files) {
		        if (!file.isEmpty()) {
		            try {
		                String fileName = file.getOriginalFilename();
		                String filePath = productDirectoryPath + File.separator + fileName;
		                File uploadFile = new File(filePath);
		                file.transferTo(uploadFile);
		                // Optionally, perform further processing or database operations with the uploaded file
		                // 데이터베이스에저장(productImageInsert : product_id, type, path)
		                imgvo.setPath(fileName);
		                mapper.productImageInsert(imgvo);
		            } catch (IOException e) {
		                e.printStackTrace();
		            }
		        }
		    }
        return; // Redirect the user back to the upload page or show a success message
    }
	
	@GetMapping("/p_download/{product_id}/{path:.+}")
	@ResponseBody
	public byte[] downloadImage(
	        @PathVariable("product_id") int product_id,
	        @PathVariable("path") String path,
	        HttpServletResponse response) throws IOException {
	    String uploadDirectory = servletContext.getRealPath("/resources/upload");
	    String imagePath = uploadDirectory + File.separator + product_id + File.separator + path;
	    System.out.println(path);
	    File imageFile = new File(imagePath);
	    
	    // Check if the image file exists
	    if (imageFile.exists() && imageFile.isFile()) {
	        System.out.println("OK");
	    	response.setContentType("image/jpeg"); // Adjust the content type based on your image format
	        response.setContentLength((int) imageFile.length());

	        FileInputStream fileInputStream = new FileInputStream(imageFile);
	        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
	        
	        // Copy the image data to the byte array output stream
	        byte[] buffer = new byte[4096];
	        int bytesRead;
	        while ((bytesRead = fileInputStream.read(buffer)) != -1) {
	            outputStream.write(buffer, 0, bytesRead);
	        }
	        
	        // Close the streams
	        fileInputStream.close();
	        outputStream.close();
	        
	        return outputStream.toByteArray();
	    } else {
	        // If the image file doesn't exist, you can handle the error or provide a default image
	        response.sendError(HttpServletResponse.SC_NOT_FOUND);
	        return null;
	    }
	}
	@RequestMapping("/p_imageDelete")
	public @ResponseBody void imageDelete(int id) {
		mapper.imageDelete(id);
		return;
	}
	
	@GetMapping("/p_update")
	public String update(int id, Model model) {
		// t_product 정보만 가져오면 된다
		Product pic=mapper.productGetById(id);
		Category cate=mapper.getCategoryById(pic.getCategory_id());
		model.addAttribute("pic", pic);
		model.addAttribute("cate", cate);
		// t_image정보도 가져오기
		// select * from t_image where product_id=?
		// List<Image> mlist=mapper.imageList(id);
		// model.addAttribute("mlist", mlist);
		return "product/product_update";
	}
	
	@GetMapping("/p_delete")
	public String delete(int id) {
		// 먼저 이미지를 지워야 한다.
		mapper.imageProductDelete(id);
		mapper.productDelete(id);
		// 폴더도 지우기(?)
		return "redirect:/p_sales";
	}
	
	@PostMapping("/p_update")
	public String update(Product vo) {
		mapper.productUpdate(vo);
		return "redirect:/p_sales";
	}
}





