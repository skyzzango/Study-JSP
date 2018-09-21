package rest;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.safety.Cleaner;
import org.jsoup.safety.Whitelist;
import org.jsoup.select.Elements;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class SendPost {
	private static Matcher matcher;
	private static final String DOMAIN_NAME_PATTERN = "([a-zA-Z0-9]([a-zA-Z0-9\\-]{0,61}[a-zA-Z0-9])?\\.)+[a-zA-Z]{2,15}";
	private static final String DOMAIN_NAME_PATTERN2 = "^(([a-zA-Z]{1})|([a-zA-Z]{1}[a-zA-Z]{1})|([a-zA-Z]{1}[0-9]{1})|([0-9]{1}[a-zA-Z]{1})|([a-zA-Z0-9][a-zA-Z0-9-_]{1,61}[a-zA-Z0-9]))\\.([a-zA-Z]{2,6}|[a-zA-Z0-9-]{2,30}\\.[a-zA-Z]{2,3})$";
	private static final String DOMAIN_NAME_PATTERN3 = "^[a-zA-Z0-9][a-zA-Z0-9-_]{0,61}[a-zA-Z0-9]{0,1}\\.([a-zA-Z]{1,6}|[a-zA-Z0-9-]{1,30}\\.[a-zA-Z]{2,3})$";
	private static final String DOMAIN_NAME_PATTERN4 = "^[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,6}$";
	private static final String DOMAIN_NAME_PATTERN5 = "(((?!-))(xn--|_{1,1})?[a-z0-9-]{0,61}[a-z0-9]{1,1}\\.)*(xn--)?([a-z0-9\\-]{1,61}|[a-z0-9-]{1,30}\\.[a-z]{2,})";
	private static Pattern patrn = Pattern.compile(DOMAIN_NAME_PATTERN);

	private static HttpURLConnection con;

	public static void main(String[] args) {

		aladinSerarch();

	}

	public static void createRequest(int count, String title, String content) {
		String url = "http://localhost:8080/boardone/writeProc.jsp";
		String urlParameters = "&num=0" +
						"&writer=Books " + count +
						"&password=123" +
						"&email=email@example.com" +
						"&subject=" + title +
						"&content=" + content +
						"&ref=1" +
						"&step=0" +
						"&depth=0";
		doPost(url, urlParameters);
	}

	public static void aladinSerarch() {
		// 국내 20, 외국 6, 컴퓨터 20
		int count = 1;
		for (int i = 0; i < 20; i++) {
			String url = "http://www.aladin.co.kr/shop/common/wbest.aspx?BestType=Bestseller&BranchType=1&CID=0&page=" + i + "&cnt=1000&SortOrder=1";
			String url1 = "http://www.aladin.co.kr/shop/common/wbest.aspx?BestType=ForeignEnglish&BranchType=7&CID=0&page=" + i + "&cnt=300&SortOrder=1";
			String url2 = "http://www.aladin.co.kr/shop/common/wbest.aspx?BestType=Bestseller&BranchType=1&CID=351&page=" + i + "&cnt=1000&SortOrder=1";
			try {
				Document doc = Jsoup.connect(url2).get();
				Elements items = doc.select(".bo3");
				for (Element item : items) {
					System.out.println("aladinSerarch Run: " + count);
					createRequest(count++, item.text(), item.attr("href"));
				}
			} catch (IOException e) {
				System.out.println("Error: aladinSerarch Exception");
				e.printStackTrace();
			}
		}
	}

	public static void googleSearch(String query) {
		String url = "https://www.google.co.kr/search?q=" + query +
				"&num=10&lr=lang_ko&tbs=lr:lang_1ko,qdr:y";
		try {
			Document doc = Jsoup
					.connect(url)
					.userAgent("Jsoup client")
					.timeout(5000).get();

			Elements links = doc.select("a[href]");
			Map<String, String> result = new HashMap<>();

			System.out.println("\n[전체 URL]");
			for (Element link : links) {
				String attr1 = link.attr("href");
				String attr2 = link.attr("class");
				if (!attr2.startsWith("imx0m") && attr1.startsWith("/url?q=")) {
					result.put(getDomainName(attr1), link.text());
				}
				System.out.println(link);
			}
			System.out.println("\n[검색 URL]");
			for (String el : result.keySet()) {
				System.out.println("[" + result.get(el) + "] [" + el + "]");
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static String getDomainName(String url) {
		return url.split("&")[0].substring(7);
	}

	public static String getDomainName2(String url) {
		String domainName = "";
		matcher = patrn.matcher(url);
		if (matcher.find()) {
			domainName = matcher.group(0).toLowerCase().trim();
		}
		return domainName;
	}

	public static Document doGetSanitize(String url) {
		Document document = null;
		try {
			document = Jsoup.connect(url).get();
			boolean valid = Jsoup.isValid(document.html(), Whitelist.basic());
			if (valid) {
				System.out.println("The document is valid");
			} else {
				System.out.println("The document is not valid.");
				System.out.println("Cleaned document");
				Document dirtyDoc = Jsoup.parse(document.html());
				document = new Cleaner(Whitelist.basic()).clean(dirtyDoc);
			}
		} catch (IOException e) {
			System.out.println("Error: doGetSanitize Exception");
			e.printStackTrace();
		}
		return document;
	}

	public static void doPost(String url, String urlParameters) {
		System.out.println("urlParam: " + urlParameters);
		byte[] postData = urlParameters.getBytes(StandardCharsets.UTF_8);
		try {
			URL myUrl = new URL(url);
			con = (HttpURLConnection) myUrl.openConnection();
			con.setConnectTimeout(300);
			con.setReadTimeout(300);
			con.setDoOutput(true);
			con.setRequestMethod("POST");
			con.setRequestProperty("User-Agent", "Java client");
			con.setRequestProperty("BoardDTO-Type", "application/x-www-form-urlencoded");
			con.setRequestProperty("Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8");
			con.setRequestProperty("Accept-Encoding", "gzip, deflate, br");
			con.setRequestProperty("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7");
			try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
				wr.write(postData);
			}
			StringBuilder content = getContent(); // response
		} catch (IOException e) {
			System.out.println("Error: doPost Exception");
			e.printStackTrace();
		} finally {
			con.disconnect();
		}
	}

	public static void doGet(String url) {
		try {
			URL myUrl = new URL(url);
			con = (HttpURLConnection) myUrl.openConnection();
			con.setRequestMethod("GET");
			StringBuilder content = getContent(); // response
		} catch (IOException e) {
			System.out.println("Error: doGet Exception");
			e.printStackTrace();
		} finally {
			con.disconnect();
		}
	}

	private static StringBuilder getContent() throws IOException {
		StringBuilder content;
		try (BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()))) {
			String line;
			content = new StringBuilder();
			while ((line = in.readLine()) != null) {
				content.append(line);
				content.append(System.lineSeparator());
			}
		}
		return content;
	}
}
