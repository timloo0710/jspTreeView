<%@page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("Big5");
response.setCharacterEncoding("Big5");
%>
<%@page import="com.codecharge.*,com.codecharge.components.*,com.codecharge.util.*,com.codecharge.events.*,com.codecharge.feature.*,com.codecharge.db.*,com.codecharge.validation.*,java.util.*,java.io.*,com.codecharge.util.cache.CacheEvent,com.codecharge.util.cache.ICache,com.codecharge.template.*"%>
<%
  	String ikey   = (String)request.getParameter("ikey");  
  	String merge_name  = new String(Utils.convertToString(request.getParameter("merge_name")).getBytes("ISO-8859-1"), "UTF-8"); 
  	String lno = Utils.convertToString(DBTools.dLookUp("LICENSE_DESC","BM_BASE","INDEX_KEY='"+ikey+"'", "SynctConn"));
  	String w_count = Utils.convertToString(DBTools.dLookUp(" substr(max(WID),5,6) ","WKITEMLIST","INDEX_KEY='" + ikey + "' and wid like 'wk5m%' ", "SynctConn"));
  	String msq = "";
  	int LNO_cnt = 0;
  	if (StringUtils.isEmpty(w_count)) {
		LNO_cnt = 0; //Count(*)
		msq = String.format("%02d", LNO_cnt+1);

  	} else {
		LNO_cnt = Utils.convertToLong(DBTools.dLookUp(" substr(max(WID),5,6) ","WKITEMLIST","INDEX_KEY='" + ikey + "' and wid like 'wk5m%' ", "SynctConn")).intValue(); //Count(*)
		msq = String.format("%02d", LNO_cnt+1);
  	}
	msq = "wk5m"+msq;
  	//String wid    = (String)request.getParameter("WID");  
	
  	JDBCConnection  Conn= JDBCConnectionFactory.getJDBCConnection("SynctConn");
	String Sql = "INSERT INTO WKITEMLIST   (    WID,    WDESC,    LICENSE_DESC,    INDEX_KEY     ) "+
				 "	VALUES  (    '"+msq+"','"+merge_name+"','"+lno+"','"+ikey+"'  )";

	//out.println("Sql:" + Sql);

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

%>

