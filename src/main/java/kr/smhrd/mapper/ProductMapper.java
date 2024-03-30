package kr.smhrd.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import kr.smhrd.entity.Board;
import kr.smhrd.entity.Category;
import kr.smhrd.entity.Image;
import kr.smhrd.entity.Member;
import kr.smhrd.entity.PIC;
import kr.smhrd.entity.Product;

// JDBC -> MyBatis->Spring
//@Mapper
public interface ProductMapper {
	
	public List<PIC> productList();
	public List<PIC> productList2();
	public PIC productDetail(int id);
	public List<Image> getImages(int id);
	public void productInsert(Product pvo);
	public void productImageInsert(Image img);
	public List<Category> getCategorys();
	public Product productGetById(int id);
	public List<Image> imageList(int product_id);
	public void imageDelete(int id);
	public void productDelete(int id);
	public void imageProductDelete(int product_id);
	public Category getCategoryById(int id);
	public void productUpdate(Product vo);
}