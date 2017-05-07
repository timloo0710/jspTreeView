<%@page import="com.codecharge.*,com.codecharge.components.*,com.codecharge.util.*,com.codecharge.events.*,com.codecharge.feature.*,com.codecharge.db.*,com.codecharge.validation.*,java.util.*,java.io.*,com.codecharge.util.cache.CacheEvent,com.codecharge.util.cache.ICache,com.codecharge.template.*"%>
<%@page contentType="text/html; charset=UTF-8"%>

<%
  String wid = request.getParameter("WID");
  String ikey = request.getParameter("IKEY");

  String ITEM1="",ITEM2="",ITEM3="",ITEM4="",ITEM5="";
  String ITEM6="",ITEM7="",ITEM8="",ITEM9="",ITEM10="";
  String RID1="",RID2="",RID3="",RID4="",RID5="";

  JDBCConnection Conn = JDBCConnectionFactory.getJDBCConnection("SynctConn");

  Enumeration rows_docs = null;

  String sql = "select ITEM1,ITEM2,ITEM3,ITEM4,ITEM5,ITEM6,ITEM7,ITEM8,ITEM9,ITEM10,RID1,RID2,RID3,RID4,RID5 FROM WKITEMLIST WHERE index_key='"+ikey+"' and wid='" + wid + "'";
  rows_docs = Conn.getRows(sql);
  if (rows_docs != null && rows_docs.hasMoreElements()) {
      DbRow row_01 = (DbRow) rows_docs.nextElement();
      ITEM1  = Utils.convertToString(row_01.get("ITEM1"));
      ITEM2  = Utils.convertToString(row_01.get("ITEM2"));
      ITEM3  = Utils.convertToString(row_01.get("ITEM3"));
      ITEM4  = Utils.convertToString(row_01.get("ITEM4"));
      ITEM5  = Utils.convertToString(row_01.get("ITEM5"));
      ITEM6  = Utils.convertToString(row_01.get("ITEM6"));
      ITEM7  = Utils.convertToString(row_01.get("ITEM7"));
      ITEM8  = Utils.convertToString(row_01.get("ITEM8"));
      ITEM9  = Utils.convertToString(row_01.get("ITEM9"));
      ITEM10 = Utils.convertToString(row_01.get("ITEM10"));
      RID1  = Utils.convertToString(row_01.get("RID1"));
      RID2  = Utils.convertToString(row_01.get("RID2"));
      RID3  = Utils.convertToString(row_01.get("RID3"));
      RID4  = Utils.convertToString(row_01.get("RID4"));
      RID5  = Utils.convertToString(row_01.get("RID5"));


  }


  Conn.closeConnection();   


  String shtml = "<table class='table table-striped table-bordered'>";
    if (wid.substring(0,3).equals("wk2")){
        shtml += " <tr>";
        shtml += "    <th class='text-warning text-right'>代辦人</th>";
        shtml += "    <td><input type='text' id='item1' onchange='f_saveitem();' value='" + ITEM1 + "'></td>";
        shtml += "    <th class='text-warning text-right'>代辦人電話</th>";
        shtml += "    <td><input type='text' id='item2' onchange='f_saveitem();' value='" + ITEM2 + "'></td>";
        shtml += "    <th class='text-warning text-right'>綁定ID</th>";
        if (StringUtils.isEmpty(RID1))
          shtml += "    <td><input type='checkbox' id='rid1'  value='" + RID1 + "' disabled ></td>";
        else
          shtml += "    <td><input type='checkbox' checked='checked' id='rid1'  value='" + RID1 + "' disabled ></td>";
        shtml += " </tr>";

        shtml += " <tr>";
        shtml += "    <th class='text-warning text-right'>工地主任</th>";
        shtml += "    <td><input type='text' id='item3' onchange='f_saveitem();' value='" + ITEM3 + "'></td>";
        shtml += "    <th class='text-warning text-right'>工地主任電話</th>";
        shtml += "    <td><input type='text' id='item4' onchange='f_saveitem();' value='" + ITEM4 + "'></td>";
        shtml += "    <th class='text-warning text-right'>綁定ID</th>";
        if (StringUtils.isEmpty(RID2))
          shtml += "    <td><input type='checkbox' id='rid2'  value='" + RID2 + "' disabled ></td>";
        else
          shtml += "    <td><input type='checkbox' checked='checked' id='rid2'  value='" + RID2 + "' disabled ></td>";
        shtml += " </tr>";

        shtml += " <tr>";
        shtml += "    <th class='text-warning text-right'>承造人</th>";
        shtml += "    <td><input type='text' id='item5' onchange='f_saveitem();' value='" + ITEM5 + "'></td>";
        shtml += "    <th class='text-warning text-right'>承造人電話</th>";
        shtml += "    <td><input type='text' id='item6' onchange='f_saveitem();' value='" + ITEM6 + "'></td>";
        shtml += "    <th class='text-warning text-right'>綁定ID</th>";
        if (StringUtils.isEmpty(RID3))
          shtml += "    <td><input type='checkbox' id='rid3'  value='" + RID3 + "' disabled ></td>";
        else
          shtml += "    <td><input type='checkbox' checked='checked' id='rid3'  value='" + RID3 + "' disabled ></td>";
        shtml += " </tr>";

        shtml += " <tr>";
        shtml += "    <th class='text-warning text-right'>專業工程師</th>";
        shtml += "    <td><input type='text' id='item7' onchange='f_saveitem();' value='" + ITEM7 + "'></td>";
        shtml += "    <th class='text-warning text-right'>專業工程師電話</th>";
        shtml += "    <td><input type='text' id='item8' onchange='f_saveitem();' value='" + ITEM8 + "'></td>";
        shtml += "    <th class='text-warning text-right'>綁定ID</th>";
        if (StringUtils.isEmpty(RID4))
          shtml += "    <td><input type='checkbox' id='rid4'  value='" + RID4 + "' disabled ></td>";
        else
          shtml += "    <td><input type='checkbox' checked='checked' id='rid4'  value='" + RID4 + "' disabled ></td>";
        shtml += " </tr>";

        shtml += " <tr>";
        shtml += "    <th class='text-warning text-right'>監造建築師</th>";
        shtml += "    <td><input type='text' id='item9' onchange='f_saveitem();' value='" + ITEM9 + "'></td>";
        shtml += "    <th class='text-warning text-right'>監造建築師</th>";
        shtml += "    <td><input type='text' id='item10' onchange='f_saveitem();' value='" + ITEM10 + "'></td>";
        shtml += "    <th class='text-warning text-right'>綁定ID</th>";
        if (StringUtils.isEmpty(RID5))
          shtml += "    <td><input type='checkbox' id='rid5'  value='" + RID5 + "' disabled ></td>";
        else
          shtml += "    <td><input type='checkbox' checked='checked' id='rid5'  value='" + RID5 + "' disabled ></td>";
        shtml += " </tr>";

      }
    //else   
        //shtml += " <tr><td>上傳日期</td><td><input type=\"text\" id=\""+wid+"\"></td><td></td><td></td>";
    
    shtml += "  </table>";      
   
out.println(shtml); 

%>