<%@page contentType="text/html; charset=UTF-8"%>
<%
request.setCharacterEncoding("Big5");
response.setCharacterEncoding("Big5");
%>
<%@page import="com.codecharge.*,com.codecharge.components.*,com.codecharge.util.*,com.codecharge.events.*,com.codecharge.feature.*,com.codecharge.db.*,com.codecharge.validation.*,java.util.*,java.io.*,com.codecharge.util.cache.CacheEvent,com.codecharge.util.cache.ICache,com.codecharge.template.*"%>
<%@page import="org.json.simple.JSONObject, org.json.simple.JSONArray,org.json.simple.JSONValue"%>

<%
  	String ikey   = (String)request.getParameter("ikey");  
  	String fid    = (String)request.getParameter("fid");  
  	//wk5011m002
  	String uid    = fid.substring(0, 6);
  	int cnt = Utils.convertToLong(DBTools.dLookUp(" count(*) ","WKITEMLIST","INDEX_KEY='" + ikey + "' and wid like '"+uid+"0%' and length(wid)=10 ", "SynctConn")).intValue(); //Count(*)
  	out.println("cnt"+cnt);
  	JDBCConnection  Conn= JDBCConnectionFactory.getJDBCConnection("SynctConn");
  	String Sql = "";
  	if (cnt ==0)
  	{
	  	String[] locs = new String[6];
	  	locs[0]="A區";
	  	locs[1]="B區";
	  	locs[2]="C區";
	  	locs[3]="D區";
	  	locs[4]="E區";
	  	locs[5]="F區";
  		String ffid = uid;
		for(int i = 1; i <= 6; i++) {
			ffid += String.format("%04d", i);

			Sql = "INSERT INTO WKITEMLIST   (    WID,    WDESC,  INDEX_KEY     ) "+
				 "	VALUES  (    '"+ffid+"','"+locs[i-1]+"','"+ikey+"'  )";
			out.println("Sql    :       "+Sql);	 
			Conn.executeUpdate(Sql);
			ffid = uid;
		}  		

	}


	Sql = "select WID,WDESC ,CASE WHEN merge is null THEN 'N' ELSE 'Y' END SELECTED　from wkitemlist where  (merge = '"+fid+"' or merge is null ) and  wid not like '"+uid+"m%'  and INDEX_KEY='"+ikey+"' and length(wid)=10 order by 1";

	out.println("select :  "+Sql);
	String html = "";

    Enumeration rows_WDESC = Conn.getRows(Sql);
	while (rows_WDESC != null && rows_WDESC.hasMoreElements()) {
	   DbRow row_01 = (DbRow) rows_WDESC.nextElement();
	   String w01 = Utils.convertToString(row_01.get("WDESC"));
	   String w02 = Utils.convertToString(row_01.get("WID"));
	   String sel = Utils.convertToString(row_01.get("SELECTED"));
	  // out.println(sel); 
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