<%@page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("Big5");
response.setCharacterEncoding("Big5");
%>
<%@page import="com.codecharge.*,com.codecharge.components.*,com.codecharge.util.*,com.codecharge.events.*,com.codecharge.feature.*,com.codecharge.db.*,com.codecharge.validation.*,java.util.*,java.io.*,com.codecharge.util.cache.CacheEvent,com.codecharge.util.cache.ICache,com.codecharge.template.*"%>
<%
  	String ikey   = (String)request.getParameter("ikey");  
  	String floor   = (String)request.getParameter("floor"); 
  	floor += "m";
  	JDBCConnection  Conn= JDBCConnectionFactory.getJDBCConnection("SynctConn");
	String html = "";
    String Sql = "select WID,WDESC　from wkitemlist where wid like '"+floor+"%' and INDEX_KEY='"+ikey+"' order by 1";
    Enumeration rows_WDESC = Conn.getRows(Sql);
	while (rows_WDESC != null && rows_WDESC.hasMoreElements()) {
	   DbRow row_01 = (DbRow) rows_WDESC.nextElement();
	   String w01 = Utils.convertToString(row_01.get("WDESC"));
	   String w02 = Utils.convertToString(row_01.get("WID"));
		html += "<button type='button' onclick='uptMlocItem(this)'  class='list-group-item btn-success' data-ikey='"+w02+"' >"+w01+"</button><img src='img/edit.png' onclick='edtMergeItem(this)' data-ikey3='"+w02+"' alt='Smiley face' height='25' width='25'><img src='img/x.png' onclick='delMlocItem(this)' data-ikey2='"+w02+"' alt='Smiley face' height='25' width='25'>";
	}

	Conn.closeConnection(); 
	
	out.println(html);


%>