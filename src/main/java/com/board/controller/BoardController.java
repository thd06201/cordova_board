package com.board.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.UUID;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.board.domain.BoardVO;
import com.board.domain.Page;
import com.board.service.BoardService;
import com.kubg.domain.MemberVO;
import com.kubg.utils.UploadFileUtils;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Resource(name="uploadPath")
	private String uploadPath;
	
	@Inject
	BoardService service;

	
	//목록
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String getList(Model model) throws Exception {

		List<BoardVO> list = null;
		list = service.list();

		model.addAttribute("list", list);
	
		return "redirect:/member/signin";
	}
	

	//작성
	@RequestMapping(value = "/write", method = RequestMethod.GET)
	public void getWirte(HttpServletRequest request, Model model) throws Exception {

		String re = request.getHeader("User-Agent");

		if (re.indexOf("Cordova") > 0) {
			model.addAttribute("write", "cordova");
		}
	}
	
	@RequestMapping(value = "/write", method = RequestMethod.POST)
	public String postWirte(BoardVO vo, MultipartFile file, HttpSession session, HttpServletRequest request) throws Exception {
		
		
		MemberVO member = (MemberVO) session.getAttribute("member");
		vo.setUserId(member.getUserId());
		
		String up = request.getSession().getServletContext().getRealPath("resources/imgUpload/");
		String fileName = null;

		String re = request.getHeader("User-Agent");

		if (re.indexOf("Cordova") > 0) {
			if (request.getParameter("file") != null && !request.getParameter("file").equals("")) {
				fileName = UploadFileUtils.fileUpload(up, "cordova.png" , Base64.getDecoder().decode(request.getParameter("file").getBytes()));
			}

		} else {
			if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
				System.out.println(up + "코르도바" + file.getOriginalFilename());
				fileName = UploadFileUtils.fileUpload(up, file.getOriginalFilename(), file.getBytes());
			}
		}
		vo.setgdsImg(fileName);
		
		service.write(vo);

		return "redirect:/board/listPageSearch?num=1";
	}

	// 조회
	@RequestMapping(value = "/view", method = RequestMethod.GET)
	public void getView(@RequestParam("bno") int bno, Model model, HttpSession session) throws Exception {
	
		BoardVO vo = service.view(bno);
		model.addAttribute("view", vo);
		
	}

	// 수정
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public void getModify(@RequestParam("bno") int bno, HttpServletRequest request, Model model) throws Exception {

		String re = request.getHeader("User-Agent");

		if (re.indexOf("Cordova") > 0) {
			model.addAttribute("write", "cordova");
		}
		
		BoardVO vo = service.view(bno);
		model.addAttribute("view", vo);

		System.out.println("view" + bno);
	
		service.modify(vo);
	}

	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String postModify(BoardVO vo, MultipartFile file, HttpServletRequest request) throws Exception {

		String up = request.getSession().getServletContext().getRealPath("resources/imgUpload/");
		
		String fileName = null;

		String re = request.getHeader("User-Agent");

		if (re.indexOf("Cordova") > 0) {
			if (request.getParameter("file") != null && !request.getParameter("file").equals("")) {
				fileName = UploadFileUtils.fileUpload(up, "cordova.png" , Base64.getDecoder().decode(request.getParameter("file").getBytes()));
				vo.setgdsImg(fileName);
			} else {
				vo.setgdsImg(request.getParameter("gdsImg"));
			}

		} else {
			if (file.getOriginalFilename() != null && !file.getOriginalFilename().equals("")) {
				System.out.println(up + "코르도바" + file.getOriginalFilename());
				fileName = UploadFileUtils.fileUpload(up, file.getOriginalFilename(), file.getBytes());
				vo.setgdsImg(fileName);
			} else {
				vo.setgdsImg(request.getParameter("gdsImg"));
				System.out.println(request);
			}
		}
		 
		service.modify(vo);
		return "redirect:/board/listPageSearch?num=1";
	}

	// 삭제
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String getDelete(@RequestParam("bno") int bno) throws Exception {

		service.delete(bno);
		return "redirect:/board/listPageSearch?num=1";
	}
	
	// 검색
	@RequestMapping(value = "/listPageSearch", method = RequestMethod.GET)
		public void getListPageSearch(Model model, @RequestParam("num") int num,
				@RequestParam(value = "keyword", required = false, defaultValue = "") String keyword,
				@RequestParam(value =  "regDate", required = false, defaultValue = "") String regDate) throws Exception {

			Page page = new Page();

			page.setNum(num);
			page.setCount(service.searchCount( keyword, regDate));
			
			
			page.setKeyword(keyword);
			page.setRegDate(regDate);

			List<BoardVO> list = null;

			list = service.listPageSearch(page.getDisplayPost(), page.getPostNum(), keyword, regDate);

			model.addAttribute("list", list);
			model.addAttribute("page", page);
			model.addAttribute("select", num);

	}
	
	// ck 에디터에서 파일 업로드
		 @RequestMapping(value = "/ckUpload", method = RequestMethod.POST)
		 public void ckUpload(HttpServletRequest req,
		           HttpServletResponse res,
		           @RequestParam MultipartFile upload) throws Exception {
		  
		  // 랜덤 문자 생성
		  UUID uid = UUID.randomUUID();
		  
		  OutputStream out = null;
		  PrintWriter printWriter = null;
		    
		  // 인코딩
		  res.setCharacterEncoding("utf-8");
		  res.setContentType("text/html;charset=utf-8");
		  
		  try {
		   
		   String fileName = upload.getOriginalFilename();  // 파일 이름 가져오기
		   byte[] bytes = upload.getBytes();
		   
		   // 업로드 경로
		   String ckUploadPath = uploadPath + File.separator + "ckUpload" + File.separator + uid + "_" + fileName;
		   
		   out = new FileOutputStream(new File(ckUploadPath));
		   out.write(bytes);
		   out.flush();  // out에 저장된 데이터를 전송하고 초기화
		   
		   String callback = req.getParameter("CKEditorFuncNum");
		   printWriter = res.getWriter();
		   String fileUrl = "/imgUpload/ckUpload/" + uid + "_" + fileName;  // 작성화면
		   
		   // 업로드시 메시지 출력
		   printWriter.println("<script type='text/javascript'>"
		      + "window.parent.CKEDITOR.tools.callFunction("
		      + callback+",'"+ fileUrl+"','이미지를 업로드하였습니다.')"
		      +"</script>");
		   
		   printWriter.flush();
		   
		  } catch (IOException e) { e.printStackTrace();
		  } finally {
		   try {
		    if(out != null) { out.close(); }
		    if(printWriter != null) { printWriter.close(); }
		   } catch(IOException e) { e.printStackTrace(); }
		  }
		  
		  return; 
		 }

	
	
}