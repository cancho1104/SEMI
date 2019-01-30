package common.controller;

import java.io.*;
import java.util.*;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebInitParam;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 * Servlet implementation class FrontController
 */
@WebServlet(
		description = "사용자가 웹에서 *.do 를 했을경우 이 클래스가 먼저 응답을 해주도록 한다.", 
		urlPatterns = { "*.do" }, 
		initParams = { 
				@WebInitParam(name = "propertyConfig", value = "C:/myjsp/SEMI/WebContent/WEB-INF/Command.properties", description = "*.do 에 대한 클래스의 매핑파일")
		})
public class FrontController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	HashMap<String, Object> cmdMap = new HashMap<String, Object>();

	/**
	 * @see Servlet#init(ServletConfig)
	 */
	public void init(ServletConfig config) throws ServletException {
		
		// *** 확인용 *** //
		System.out.println("확인용 ==> 서블릿 FrontController 의 init(ServletConfig config) 메소드가 실행됨");
		/*
			웹브라우저 주소창에서 *.do 를 하면 FrontController 서블릿이 받는데
			맨 처음에 자동적으로 실행되어지는 메소드가 init(ServletConfig config) 이다.
			그런데 이 메소드는 WAS(톰캣서버)가 구동되어진 후 딱 1번만 수행되어지고, 그 이후에는 수행되지 않는다.
		*/
		
		String props = config.getInitParameter("propertyConfig");
		// 초기화 파라미터 데이터 값인 "C:/myjsp/MyMVC/WebContent/WEB-INF/Command.properties" 을
		// 가져와서 String props 변수에 저장시켰다.
		
		// *** 확인용 *** //
		System.out.println("<<확인용>> 초기화 파라미터 데이터 값이 저장된 파일명 props => " + props);
		// <<확인용>> 초기화 파라미터 데이터 값이 저장된 파일명 props : C:/myjsp/MyMVC/WebContent/WEB-INF/Command.properties
		
		Properties pr = new Properties();
		
		FileInputStream fis = null;
		
		try {
			fis = new FileInputStream(props);
			
			pr.load(fis);
			/*
				pr.load(fis); 는 C:/myjsp/MyMVC/WebContent/WEB-INF/Command.properties 파일을 읽어다가
				Properties 클래스의 객체인 pr 에 로드시킨다.
				그러면 pr 은 읽어온 파일(Command.properties)의 내용에서
				= 을 기준으로 왼쪽은 키로 보고, 오른쪽은 value 로 인식한다.
			*/
			/* ===================================================================================
			String str_className = pr.getProperty("/test1.do");
												// "/test1.do" 가 key 이다.
			
			// *** 확인용 *** //
			System.out.println("<<확인용>> key가 /test1.do 인 value => " + str_className);
			// <<확인용>> key가 /test1.do 인 value => test.controller.Test1Controller
			
			Class<?> cls = Class.forName(str_className);
			// 제너릭의 ? 는 아무거나 1개를 말한다.
			Object obj = cls.newInstance();
			
			cmdMap.put("/test1.do", obj);
			=================================================================================== */
			
			Enumeration<Object> en = pr.keys();
			/*
				pr.keys(); 은 C:/myjsp/MyMVC/WebContent/WEB-INF/Command.properties 파일의 내용물에서
				= 을 중심으로 왼쪽에 있는 모든 key 들만 읽어오는 것이다.
			*/
			
			while(en.hasMoreElements()) {
				
				String key_urlcmd = (String)en.nextElement();
				String className = pr.getProperty(key_urlcmd);
				
				if(className != null) {
					className = className.trim();
				
					Class<?> cls = Class.forName(className); 
					// 무엇이 들어올지 모르기 때문에 제너릭에 ? 를 주어 담아준다.
					// 예 ) Test1Controller cls = null; 과 같다.
					Object obj = cls.newInstance();
					// 예 ) Object obj = new Test1Controller(); 과 같다.
					cmdMap.put(key_urlcmd, obj);
				}
				
			}// end of while-----------------------
			
		} catch (ClassNotFoundException e) {
			System.out.println("문자열로 명명되어진 클래스가 없습니다.");
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			System.out.println("C:/myjsp/MyMVC/WebContent/WEB-INF/Command.properties 파일이 없습니다.");
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
	}// end of init()---------------------------------

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		requestProcess(request, response);
		
	}// end of doGet()-------------------


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		requestProcess(request, response);
		
	}// end of doPost()---------------
	
	
	private void requestProcess(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		// 웹브라우저상의 주소입력창에서
		// http://localhost:9090/MyMVC/test2.do?name=홍길동&addr=서울
		// 와 같이 입력되었더라면
		
	//	String url = request.getRequestURL().toString();
		// url은 http://localhost:9090/MyMVC/test2.do 이다.
		
		String uri = request.getRequestURI();
		// uri는 /MyMVC/test2.do 이다.
		
		String ctxPath = request.getContextPath();
		// ctxPath 는 /MyMVC 이다.
		
		String mapKey = uri.substring(ctxPath.length());
		// mapKey 는 /test2.do
		
		AbstractController action = (AbstractController)cmdMap.get(mapKey); // 부모에게서 상속받은 객체들은 부모로 전부 받아올 수 있다.
		
		if(action == null) {
			System.out.println(mapKey + " URL 패턴에 매핑된 객체가 없습니다.");
			return;
		}
		else {
			try {
				action.execute(request, response);
				
				String viewPage = action.getViewPage();
				boolean bool = action.isRedirect();
				
				if(bool) {
					// VIEW단 페이지를 sendRedirect 방법으로 이동시킨다.
					response.sendRedirect(viewPage);
				}
				else {
					// VIEW단 페이지를 forward 방법으로 이동시킨다.
					RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
					dispatcher.forward(request, response);
					
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}// end of requestProcess()----------------------------------

}
