package kr.smhrd.entity;

import lombok.AllArgsConstructor;
import lombok.Data;

// 게시물(Object)=>번호, 제목, 내용, 작성자, 작성일, 조회수/
@Data
public class Board { // {"idx":1,"memId":"aaa","title":"게시판"~~~~}
  private int idx;
  // 추가
  private String memId; //회원아이디
  private String title;
  private String content;
  private String writer;
  private String indate;
  private int count;
}
