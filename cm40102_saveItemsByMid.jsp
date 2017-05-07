<%@page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("Big5");
response.setCharacterEncoding("Big5");
%>
<%@page import="com.codecharge.*,com.codecharge.components.*,com.codecharge.util.*,com.codecharge.events.*,com.codecharge.feature.*,com.codecharge.db.*,com.codecharge.validation.*,java.util.*,java.io.*,com.codecharge.util.cache.CacheEvent,com.codecharge.util.cache.ICache,com.codecharge.template.*"%>


<%
  	String ikey   = (String)request.getParameter("ikey");  
  	String mid    = (String)request.getParameter("mid");  
  	String items    = (String)request.getParameter("items"); 

	int cnt = 0; 
	String Sql = "";
  	JDBCConnection  Conn= JDBCConnectionFactory.getJDBCConnection("SynctConn");

	 String[] tokens = items.split(",");
	 for (String token:tokens) {
	   cnt = Utils.convertToLong(DBTools.dLookUp("Count(*)","WKITEMLIST","INDEX_KEY='" + ikey + "' and wid='"+token+"' and   merge = '"+mid+"' ", "SynctConn")).intValue();
		if (cnt==0)
  		{
			Sql = "UPDATE wkitemlist SET  merge ='"+mid+"'　 where wid = '"+token+"'  and INDEX_KEY='"+ikey+"'  ";
			out.println(Sql); 
			 Conn.executeUpdate(Sql);
  		}
	 }  	

	String html = "";
    Sql = "select  WID,WDESC,CASE WHEN merge is null THEN 'N' ELSE 'Y' END SELECTED　　from wkitemlist where (merge = '"+mid+"' or merge is null ) and length(wid)=6 AND wid not like 'wk5m%' and INDEX_KEY='"+ikey+"' order by 1";
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
/*
                          <option value='elem_1' selected>11樓版</option>
                          <option value='elem_2' selected>12樓版</option>
                          <option value='elem_3'>13樓版</option>
                          <option value='elem_4'>14樓版</option>
                          <option value='elem_100'>15樓版</option>
 */

%>