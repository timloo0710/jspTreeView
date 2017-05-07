<%@page import="com.codecharge.*,com.codecharge.components.*,com.codecharge.util.*,com.codecharge.events.*,com.codecharge.feature.*,com.codecharge.db.*,com.codecharge.validation.*,java.util.*,java.io.*,com.codecharge.util.cache.CacheEvent,com.codecharge.util.cache.ICache,com.codecharge.template.*"%>
<%@page import="org.json.simple.JSONObject, org.json.simple.JSONArray,org.json.simple.JSONValue"%>
<%@page contentType="text/html; charset=UTF-8"%>



<%
  String ikey = request.getParameter("ikey");

  String KEY = request.getParameter("ikey");
  

  Enumeration rows_lvl01 = null,rows_lvl02= null, rows_lvl03= null;
  DbRow row_01,row_02,row_03;

  String  Sql,w01,w02,w03,u01,u02;
  String  d01,d02,d03 ;//= "select * from bldcode where code_type='WORD'  and SUB_SEQ='"+KIND+"' ORDER BY 1  "; //AND sub_seq1='I30'
  JDBCConnection Conn;	
  LinkedList ll01 = new LinkedList();

  Conn = JDBCConnectionFactory.getJDBCConnection("SynctConn");


  Map jw01 = null ; //new HashMap();
  Map jw02 =null;
  Map jw03 =null;
  
  LinkedList ll02=null;
  LinkedList ll03=null;
  //第一層 3 碼
  Sql = "select WID,WDESC,ISMENU　from wkitemlist where length(wid)=3  and INDEX_KEY='"+KEY+"' order by 1";
  rows_lvl01 = Conn.getRows(Sql);
 
  while (rows_lvl01 != null && rows_lvl01.hasMoreElements()) {
    row_01 = (DbRow) rows_lvl01.nextElement();
    w01 = Utils.convertToString(row_01.get("WDESC"));
    d01 = Utils.convertToString(row_01.get("WID"));
    u01 = Utils.convertToString(row_01.get("ISMENU"));
    jw01 = new HashMap();
    jw01.put("text", w01);
    jw01.put("href", u01+"_"+d01);
    if (u01.equals("0"))
      jw01.put("icon", "glyphicon  glyphicon-list");
    else  
      jw01.put("icon", "glyphicon glyphicon-folder-close");
    //第二層 6 碼
    Sql = "select WID,WDESC,ISMENU　from wkitemlist where merge is null and length(wid)=6 and wid like '"+d01+"%'  and INDEX_KEY='"+KEY+"' order by 1";
    //out.println(Sql);
    rows_lvl02 = Conn.getRows(Sql);
    if (rows_lvl02 != null && rows_lvl02.hasMoreElements()) {
        
        ll02 = new LinkedList();
        jw01.put("nodes", ll02); 
    }
    while (rows_lvl02 != null && rows_lvl02.hasMoreElements()) {
      row_02 = (DbRow) rows_lvl02.nextElement();
      w02 = Utils.convertToString(row_02.get("WDESC")); 
      d02 = Utils.convertToString(row_02.get("WID")); 
      u02 = Utils.convertToString(row_02.get("ISMENU"));
      jw02 = new HashMap();    
      jw02.put("text", w02);
      jw02.put("href", u02+"_"+d02);
      if (u02.equals("0"))
        jw02.put("icon", "glyphicon  glyphicon-list");
      else  
        jw02.put("icon", "glyphicon glyphicon-folder-close");
        
        //第3層 10 碼
        Sql = "select WID,WDESC,ISMENU　from wkitemlist where merge is null and  length(wid)=10 and wid like '"+d02+"%' and INDEX_KEY='"+KEY+"' order by 1";
        rows_lvl03 = Conn.getRows(Sql);
        if (rows_lvl03 != null && rows_lvl03.hasMoreElements()) {
         
         ll03 = new LinkedList(); 
          jw02.put("nodes", ll03);
        }
        while (rows_lvl03 != null && rows_lvl03.hasMoreElements()) {
          row_03 = (DbRow) rows_lvl03.nextElement();
          jw03 = new HashMap();
          w03 = Utils.convertToString(row_03.get("WDESC")); 
          d03 = Utils.convertToString(row_03.get("WID")); 
          jw03.put("text", w03);
          jw03.put("href", "0_"+d03);
          jw03.put("icon", "glyphicon  glyphicon-list");     
          ll03.add(jw03);
          jw03 = null;
        }
        ll02.add(jw02);
        jw02 = null;
    }
    ll01.add(jw01);
    jw01 = null;
  }
Conn.closeConnection(); 
String JSONString = JSONValue.toJSONString(ll01); 

out.println(JSONString);

%>