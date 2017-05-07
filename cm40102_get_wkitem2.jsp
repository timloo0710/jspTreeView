<%@page import="com.codecharge.*,com.codecharge.components.*,com.codecharge.util.*,com.codecharge.events.*,com.codecharge.feature.*,com.codecharge.db.*,com.codecharge.validation.*,java.util.*,java.io.*,com.codecharge.util.cache.CacheEvent,com.codecharge.util.cache.ICache,com.codecharge.template.*"%>
<%@page import="org.json.simple.JSONObject, org.json.simple.JSONArray,org.json.simple.JSONValue"%>
<%@page contentType="text/html; charset=UTF-8"%>

<%
  String wid = request.getParameter("wid");
  
  DbRow row_01,row_02,row_03;
  JDBCConnection Conn;  
  Conn = JDBCConnectionFactory.getJDBCConnection("SynctConn");

  Enumeration rows_lvl01 = null,rows_lvl02= null, rows_lvl03= null;
  
  String  Sqla="",w01,d01 ;
  JSONObject[] obj = new JSONObject[100];
  LinkedList ll01 = new LinkedList();
  int i = 0;

 if (wid.length()==3) {
    Sqla = "select WID,WDESC　from WKCODE where WDTYPE = '1' and length(wid)=6 and WID like '"+wid+"%' ";
  }
  else
  {
    Sqla = "select WID,WDESC　from WKCODE where WDTYPE ='1' and length(wid)=10 and WID like '"+wid+"%'";
  }  
   rows_lvl01 = Conn.getRows(Sqla);
  while (rows_lvl01 != null && rows_lvl01.hasMoreElements()) {
      row_01 = (DbRow) rows_lvl01.nextElement();
      w01 = Utils.convertToString(row_01.get("WDESC"));
      d01 = Utils.convertToString(row_01.get("WID"));
      obj[i] = new JSONObject();
      obj[i].put("WID", d01);  
      obj[i].put("WDESC", w01);
      ll01.add(obj[i]);
      i++;  
  }
      
   
Conn.closeConnection(); 
String JSONString = JSONValue.toJSONString(ll01); 

out.println(JSONString); 


%>