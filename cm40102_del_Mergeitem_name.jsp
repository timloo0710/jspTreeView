<%@page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("Big5");
response.setCharacterEncoding("Big5");
%>
<%@page import="com.codecharge.*,com.codecharge.components.*,com.codecharge.util.*,com.codecharge.events.*,com.codecharge.feature.*,com.codecharge.db.*,com.codecharge.validation.*,java.util.*,java.io.*,com.codecharge.util.cache.CacheEvent,com.codecharge.util.cache.ICache,com.codecharge.template.*"%>
<%
  	String ikey   = (String)request.getParameter("ikey");  
  	String mid   = (String)request.getParameter("mid");  
  	//String wid    = (String)request.getParameter("WID");  
	
  	JDBCConnection  Conn= JDBCConnectionFactory.getJDBCConnection("SynctConn");
	String Sql = "DELETE FROM  WKITEMLIST where  INDEX_KEY='"+ikey+"' AND wid='"+mid+"'  ";

	System.err.println("Sql:" + Sql);

	Conn.executeUpdate(Sql);

	Sql = "UPDATE wkitemlist SET  merge = NULL　 where merge = '"+mid+"'  and INDEX_KEY='"+ikey+"'  ";

	Conn.executeUpdate(Sql);

	String html = "";
    Sql = "select WDESC,WID　from wkitemlist where wid like 'wk5m%' and INDEX_KEY='"+ikey+"' order by 1";
    Enumeration rows_WDESC = Conn.getRows(Sql);
	while (rows_WDESC != null && rows_WDESC.hasMoreElements()) {
	   DbRow row_01 = (DbRow) rows_WDESC.nextElement();
	   String w01 = Utils.convertToString(row_01.get("WDESC"));
	   String w02 = Utils.convertToString(row_01.get("WID"));
		html += "<button type='button' onclick='modifyMergeItem(this)'  class='list-group-item btn-success' data-ikey='"+w02+"' >"+w01+"</button><img src='img/edit.png' onclick='edtMergeItem(this)' data-ikey3='"+w02+"' alt='Smiley face' height='25' width='25'><img src='img/x.png' onclick='delMergeItem(this)' data-ikey2='"+w02+"' alt='Smiley face' height='25' width='25'>";
	}

	Conn.closeConnection(); 
	
	out.println(html);

/*
                      <button type="button" class="list-group-item btn-success" >1+2+3</button>
                      <button type="button" class="list-group-item btn-success">4+5</button>
                      <button type="button" class="list-group-item btn-success">6+7+8+9+10</button>


 */

%>