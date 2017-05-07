<%@page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("Big5");
response.setCharacterEncoding("Big5");
%>
<%@page import="com.codecharge.*,com.codecharge.components.*,com.codecharge.util.*,com.codecharge.events.*,com.codecharge.feature.*,com.codecharge.db.*,com.codecharge.validation.*,java.util.*,java.io.*,com.codecharge.util.cache.CacheEvent,com.codecharge.util.cache.ICache,com.codecharge.template.*"%>


<%
  	String ikey   = (String)request.getParameter("ikey");  
  	String fid    = (String)request.getParameter("fid");  
  	String items    = (String)request.getParameter("items"); 
  	String uid    = fid.substring(0, 6);
	int cnt = 0; 
	String Sql = "";
  	JDBCConnection  Conn= JDBCConnectionFactory.getJDBCConnection("SynctConn");

	 String[] tokens = items.split(",");
	 for (String token:tokens) {
	   cnt = Utils.convertToLong(DBTools.dLookUp("Count(*)","WKITEMLIST","INDEX_KEY='" + ikey + "' and wid='"+token+"' and   merge = '"+fid+"' ", "SynctConn")).intValue();
		if (cnt==0)
  		{
			Sql = "UPDATE wkitemlist SET  merge ='"+fid+"'　 where wid = '"+token+"'  and INDEX_KEY='"+ikey+"'  ";
			out.println(Sql); 
			Conn.executeUpdate(Sql);
  		}
	 }  	

	String html = "";
	Sql = "select WID,WDESC ,CASE WHEN merge is null THEN 'N' ELSE 'Y' END SELECTED　from wkitemlist where  (merge = '"+fid+"' or merge is null ) and  wid not like '"+uid+"m%'  and INDEX_KEY='"+ikey+"' and length(wid)=10 order by 1";
    Enumeration rows_WDESC = Conn.getRows(Sql);
	while (rows_WDESC != null && rows_WDESC.hasMoreElements()) {
	   DbRow row_01 = (DbRow) rows_WDESC.nextElement();
	   String w01 = Utils.convertToString(row_01.get("WDESC"));
	   String w02 = Utils.convertToString(row_01.get("WID"));
	   String sel = Utils.convertToString(row_01.get("SELECTED"));
	   if (sel.equals("N"))
		{ html += "<option value='"+w02+"'>"+w01+"</option>";}
		else
		{ html += "<option value='"+w02+"' selected >"+w01+"</option>";}
	}

	Conn.closeConnection(); 
	//out.println(JSONString); //html
	out.println(html); //
%>