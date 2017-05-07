<%@page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("Big5");
response.setCharacterEncoding("Big5");
%>
<%@page import="com.codecharge.*,com.codecharge.components.*,com.codecharge.util.*,com.codecharge.events.*,com.codecharge.feature.*,com.codecharge.db.*,com.codecharge.validation.*,java.util.*,java.io.*,com.codecharge.util.cache.CacheEvent,com.codecharge.util.cache.ICache,com.codecharge.template.*"%>
<%
  	String ikey   = (String)request.getParameter("IKEY");  
  	String wid    = (String)request.getParameter("WID");  
	String item1  = new String(Utils.convertToString(request.getParameter("ITEM1")).getBytes("ISO-8859-1"), "UTF-8"); 

	String item2  = new String(Utils.convertToString(request.getParameter("ITEM2")).getBytes("ISO-8859-1"), "UTF-8"); 
	String item3  = new String(Utils.convertToString(request.getParameter("ITEM3")).getBytes("ISO-8859-1"), "UTF-8"); 
	String item4  = new String(Utils.convertToString(request.getParameter("ITEM4")).getBytes("ISO-8859-1"), "UTF-8"); 
	String item5  = new String(Utils.convertToString(request.getParameter("ITEM5")).getBytes("ISO-8859-1"), "UTF-8"); 
	String item6  = new String(Utils.convertToString(request.getParameter("ITEM6")).getBytes("ISO-8859-1"), "UTF-8"); 
	String item7  = new String(Utils.convertToString(request.getParameter("ITEM7")).getBytes("ISO-8859-1"), "UTF-8"); 
	String item8  = new String(Utils.convertToString(request.getParameter("ITEM8")).getBytes("ISO-8859-1"), "UTF-8"); 
	String item9  = new String(Utils.convertToString(request.getParameter("ITEM9")).getBytes("ISO-8859-1"), "UTF-8"); 
	String item10  = new String(Utils.convertToString(request.getParameter("ITEM10")).getBytes("ISO-8859-1"), "UTF-8"); 


  	JDBCConnection  Conn= JDBCConnectionFactory.getJDBCConnection("SynctConn");
	String Sql = "UPDATE WKITEMLIST SET ITEM1 = '" + item1 + "', "+
				 " ITEM2   = '" + item2 + "', "+
				 " ITEM3   = '" + item3 + "', "+
				 " ITEM4   = '" + item4 + "', "+
				 " ITEM5   = '" + item5 + "', "+
				 " ITEM6   = '" + item6 + "', "+
				 " ITEM7   = '" + item7 + "', "+
				 " ITEM8   = '" + item8 + "', "+
				 " ITEM9   = '" + item9 + "', "+
				 " ITEM10  = '" + item10 + "' "+
				 "	WHERE WID = '"+wid+"' AND INDEX_KEY='"+ikey+"'";
	System.err.println("Sql:" + Sql);
	out.println(Sql);
	Conn.executeUpdate(Sql);

	Conn.closeConnection(); 
	out.println("Y");

%>