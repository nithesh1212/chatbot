package main.java.com;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.alicebot.ab.Bot;
import org.alicebot.ab.Chat;
import org.alicebot.ab.History;
import org.alicebot.ab.MagicBooleans;
import org.alicebot.ab.MagicStrings;
import org.alicebot.ab.utils.IOUtils;

/**
 * Servlet implementation class ChatServlet
 */
//@WebServlet("/chatServlet")
public class ChatServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final boolean TRACE_MODE = false;
	static String botName = "super";

       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChatServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		System.out.println("Hellllllloooooooooo");
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// TODO Auto-generated method stub
		try {
			System.out.println("Hellllllloooooooooo");

			String resourcesPath = getResourcesPath();
			System.out.println(resourcesPath);
			MagicBooleans.trace_mode = TRACE_MODE;
			Bot bot = new Bot("super", resourcesPath);
			Chat chatSession = new Chat(bot);
			bot.brain.nodeStats();
			String textLine = "";

			while(true) {
				System.out.print("Human : ");
				textLine = IOUtils.readInputTextLine();
				if ((textLine == null) || (textLine.length() < 1))
					textLine = MagicStrings.null_input;
				if (textLine.equals("q")) {
					System.exit(0);
				} else if (textLine.equals("wq")) {
					bot.writeQuit();
					System.exit(0);
				} else {
					String requestBot = textLine;
					if (MagicBooleans.trace_mode)
						System.out.println("STATE=" + requestBot + ":THAT=" + ((History) chatSession.thatHistory.get(0)).get(0) + ":TOPIC=" + chatSession.predicates.get("topic"));
					String responseBot = chatSession.multisentenceRespond(requestBot);
					while (responseBot.contains("&lt;"))
						responseBot = responseBot.replace("&lt;", "<");
					while (responseBot.contains("&gt;"))
						responseBot = responseBot.replace("&gt;", ">");
					System.out.println("Robot : " + responseBot);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		//doGet(request, response);
	}
	
	private static String getResourcesPath() {
		File currDir = new File(".");
		String path = currDir.getAbsolutePath();
		path = path.substring(0, path.length() - 2);
		System.out.println(path);
		String resourcesPath = path + File.separator + "src" + File.separator + "main" + File.separator + "resources";
		return resourcesPath;
	}


}
