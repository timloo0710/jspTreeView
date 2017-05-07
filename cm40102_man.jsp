<% 
request.setCharacterEncoding("Big5");
response.setCharacterEncoding("Big5");
%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, java.io.*,com.codecharge.*,com.codecharge.util.*,com.codecharge.db.* " %>


<% 
  JDBCConnection Conn = JDBCConnectionFactory.getJDBCConnection("SynctConn");

  String ikey =  Utils.convertToString(session.getAttribute("INDEX_KEY"));
  //String ikey = (String)request.getParameter("INDEX_KEY");
  String lno = Utils.convertToString(DBTools.dLookUp("LICENSE_DESC","BM_BASE","INDEX_KEY='"+ikey+"'", "SynctConn"));


  String now_wk = Utils.convertToString(DBTools.dLookUp("WDESC","WKITEMLIST","FREEZE = 'Y' AND INDEX_KEY='"+ikey+"' AND WID IN (SELECT MAX(WID) FROM WKITEMLIST where FREEZE = 'Y' AND INDEX_KEY='"+ikey+"')", "SynctConn"));


  if (StringUtils.isEmpty(now_wk) || (!StringUtils.isEmpty(now_wk) && now_wk.equals("null"))) now_wk = "無";

  String PNAME="", ADDRADR_DESC="",ADDR="",DONG="",R_DATE="",O_DATE="";
  //session.setAttribute("ROLEID", ROLE);
  Enumeration rows_docs = null;
  DbRow row_01;
  String sql = "select NAME,ADDRADR_DESC,COMB_ADDR1(ADDRADR_DESC,ADDRAD1,ADDRAD2,ADDRAD3,ADDRAD4,ADDRAD5,ADDRAD6,ADDRAD6_1,ADDRAD7,ADDRAD7_1,ADDRAD8) ADDR,"+
" COMB_ADDR1(O_ADDRADR_DESC,O_ADDRAD1,O_ADDRAD2,O_ADDRAD3,O_ADDRAD4,O_ADDRAD5,O_ADDRAD6,O_ADDRAD6_1,O_ADDRAD7,O_ADDRAD7_1,O_ADDRAD8) ADDR1,"+
" nvl(CHWANG,'  ')||'幢'||nvl(DONG,'  ')||'棟'|| nvl(FLOOR,'  ')||'層'||nvl(HOUSE,'  ')||'戶' DONG,"+
" (select RECEIVE_LICE_DATE from bm_base where index_key=bm_p01.index_key) R_DATE,(select start_date FROM BM_WORK_ST WHERE index_key = bm_p01.index_key and ST_FREQ='01') O_DATE"+
" from bm_p01 where spokesman='Y' and index_key='"+ikey+"'";

  rows_docs = Conn.getRows(sql);
  if (rows_docs != null && rows_docs.hasMoreElements()) {
      row_01 = (DbRow) rows_docs.nextElement();
      PNAME = Utils.convertToString(row_01.get("NAME"));
      ADDRADR_DESC = Utils.convertToString(row_01.get("ADDRADR_DESC"));
      ADDR = Utils.convertToString(row_01.get("ADDR"));
      DONG = Utils.convertToString(row_01.get("DONG"));
      R_DATE = Utils.convertToString(row_01.get("R_DATE"));
      O_DATE = Utils.convertToString(row_01.get("O_DATE"));

      {
        String date_temp = R_DATE;
        if (!StringUtils.isEmpty(date_temp) && date_temp.length() >= 7){
          date_temp = date_temp.substring(0,3) + "/" + date_temp.substring(3,5) + "/" + date_temp.substring(5,7);
          R_DATE = date_temp;
        }
      }

      {
        String date_temp = O_DATE;
        if (!StringUtils.isEmpty(date_temp) && date_temp.length() >= 7){
          date_temp = date_temp.substring(0,3) + "/" + date_temp.substring(3,5) + "/" + date_temp.substring(5,7);
          O_DATE = date_temp;
        }
      }

  }

  sql = " select DIST,(select CODE_DESC from bldcode where code_type='ZON' and code_seq=DIST) DIST_DESC,SECTION,"+
          "(select CODE_DESC from bldcode where code_type='SEC' AND sub_seq1='I80' and code_seq=DIST and SUB_SEQ = SECTION ) SECTION_DESC,"+
          "ROAD_NO1, ROAD_NO2 from bm_lan "+
          "where INDEX_KEY='"+ikey+"' and SPOKESMAN='Y'";
  rows_docs = Conn.getRows(sql);

  if (rows_docs != null && rows_docs.hasMoreElements()) {
    row_01 = (DbRow) rows_docs.nextElement();
    String LAN =  "地號：" + Utils.convertToString(row_01.get("DIST_DESC"));
    LAN += Utils.convertToString(row_01.get("SECTION_DESC"));
    LAN += Utils.convertToString(row_01.get("ROAD_NO1"));
    String ROAD_NO2 = Utils.convertToString(row_01.get("ROAD_NO2"));
    if (StringUtils.isEmpty(ROAD_NO2))
      LAN = LAN+"號";
    else
      LAN = LAN+"-"+ROAD_NO2+"號";
       
    if (StringUtils.isEmpty(ADDR))
      ADDR = LAN;
  }

  String up_floor_no = Utils.convertToString(DBTools.dLookUp("substr(max(story_code),2,3)","bm_stair","INDEX_KEY='"+ikey+"'  and story_code not like 'V%' ", "SynctConn"));

  if (!StringUtils.isEmpty(up_floor_no)){
    up_floor_no = "005";
  }

  int LNO_cnt = Utils.convertToLong(DBTools.dLookUp("Count(*)","WKITEMLIST","INDEX_KEY='" + ikey + "'", "SynctConn")).intValue();

  if (!StringUtils.isEmpty(ikey) && LNO_cnt <= 0)
  {
    String Sql = "INSERT INTO WKITEMLIST (    WID,    WDESC,    ISMENU,     INDEX_KEY)  "+
      " SELECT WID,    WDESC,    '0','"+ikey+"'  FROM  WKCODE "+
      " where WDTYPE='1' AND length(wid)<=6  AND wid <='wk5' ||'"+ up_floor_no+"' "   ;//trim(to_char(to_number('" + up_floor_no + "'),'00'))";||'006'
    out.println(Sql);  
    Conn.executeUpdate(Sql);
  }





  Conn.closeConnection(); 
%>

<!DOCTYPE HTML>
<html>
<head>
<title>cm40102_man</title>
<meta name="GENERATOR" content="CodeCharge Studio 5.1.1.18990">
<link rel="stylesheet" type="text/css" href="Styles/Synct/jquery-ui.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<link rel="stylesheet" href="./bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="./dist/css/skins/_all-skins.min.css">

<script src="ClientI18N.jsp?file=Globalize.js&amp;locale=zh-TW" type="text/javascript" charset="utf-8"></script>

</head>
<body class="theme-default main-menu-animated">
<div id="main-wrapper">
  <jsp:include page="main_menu.jsp" flush="true" />
  <div id="content-wrapper">
    <ul class="breadcrumb breadcrumb-page">
      <li>申請人作業 </li>
      <li class="active">CM40102施工案件資料維護 </li>
    </ul>
    <section class="content">
    <!-- row -->
    <div class="row ">
    </div>
    <div class="row ">
      <div class="col-md-12">
        <div class="box box-solid">
          <div class="box-header with-border">
            <h1 class="box-title">勘驗申報流程</h1>

          </div>
          <div class="box-body">
            <div class="row">
              <!-- 左半 -->
              <div class="col-sm-3">
                <div class="row  ">
                  <h3 class="text-center  bg-success "><%=lno %></h3>
                </div>
        <div class="row  " >
          <a href="cm40102_man_2.jsp?INDEX_KEY=<%=ikey%>" id="" class="btn btn-primary">項目維護</a>
          <a href="cm40102_man_4.jsp?INDEX_KEY=<%=ikey%>" id="" class="btn btn-primary">合併維護</a>
        </div>
                <div class="row">
                  <div id="treeview5">
                  </div>
                </div>
              </div>
              <!-- 右半 -->
              <div class="col-sm-9">
                <h2>基本資料</h2>
                <table class="table table-striped table-bordered">
                  <tr>
                    <th class="text-warning text-right">起造人</th> 
                    <td><%=PNAME %></td>
                  </tr>
 
                  <tr>
                    <th class="text-warning text-right">建築位置</th> 
                    <td><%=ADDR %></td>
                  </tr>
 
 
                  <tr>
                    <th class="text-warning text-right">樓層資訊</th> 
                    <td><%=DONG %></td>
                  </tr>
 
                  <tr>
                    <th class="text-warning text-right">領照日期</th> 
                    <td><%=R_DATE %></td>
                  </tr>
 
                  <tr>
                    <th class="text-warning text-right">開工日期</th> 
                    <td><%=O_DATE %></td>
                  </tr>

                  <tr>
                    <th class="text-warning text-right">申報進度</th> 
                    <td class="text-danger"><%=now_wk %></td>
                  </tr>

                </table>
              </div>
              <div class="col-sm-9" >
                <div class="form-group">
                  <label class="col-lg-4 control-label" id="lvl_item"></label> 
                  <div class="col-lg-5">
                    <label class="text-warning text-left"></label>
                    <input type="hidden" name="ikey" value="<%=ikey%>" >
                    <input type="hidden" name="wid" id="wid"  >
                    <span style="display:none;" id="lvl_itemb"><a id="frz_btn" href=""class="btn btn-lg btn-danger" >送件</a></span>
                  </div>
                </div>
                <div id="wkform">

                </div>
              </div>
              <div class="col-sm-9" id="wkdocs">

              </div>

            </div>
            <!-- /.box-body -->
          </div>
          <!-- /. box -->
          <!-- /.col -->
        </div>
        <!-- /.row -->
      </div>
      <!-- row -->
      </section>
      <!-- /.content -->
    </div>
    <div id="main-menu-bg">
    </div>
  </div>
  <script type="text/javascript"> window.jQuery || document.write('<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.3/jquery.min.js">'+"<"+"/script>"); </script>
  <script src="assets/javascripts/bootstrap.min.js"></script>
  <script src="assets/javascripts/synctMenu.min.js"></script>
  <script type="text/javascript">
        init.push(function () {
                // Javascript code here
        })
        window.PixelAdmin.start(init);
</script>
  <!-- jQuery 2.2.3 -->
  <script src="./plugins/jQuery/jquery-2.2.3.min.js"></script>
  <!-- Bootstrap 3.3.6 -->
  <script src="./bootstrap/js/bootstrap.min.js"></script>
  <!-- Slimscroll -->
  <script src="./plugins/slimScroll/jquery.slimscroll.min.js"></script>
  <!-- FastClick -->
  <script src="./plugins/fastclick/fastclick.js"></script>
  <!-- AdminLTE App -->
  <script src="./dist/js/app.min.js"></script>
  <!-- AdminLTE for demo purposes -->
  <script src="./dist/js/demo.js"></script>
  <script src="./plugins/treeview/bootstrap-treeview.js"></script>
  <script type="text/javascript">

  var wid = getParameterByName('WID');


  function f_saveitem() {
    id_wid = document.getElementById("wid").value;
    if (id_wid == '') id_wid = wid;

    var item1="",item2="",item3="",item4="",item5 ="";
    var item6="",item7="",item8="",item9="",item10="";

    element1 = document.getElementById("item1");
    if(element1 != null) item1  = encodeURI(document.getElementById("item1").value);

    element1 = document.getElementById("item2");
    if(element1 != null) item2  = encodeURI(document.getElementById("item2").value);

    element1 = document.getElementById("item3");
    if(element1 != null) item3  = encodeURI(document.getElementById("item3").value);

    element1 = document.getElementById("item4");
    if(element1 != null) item4  = encodeURI(document.getElementById("item4").value);

    element1 = document.getElementById("item5");
    if(element1 != null) item5  = encodeURI(document.getElementById("item5").value);

    element1 = document.getElementById("item6");
    if(element1 != null) item6  = encodeURI(document.getElementById("item6").value);

    element1 = document.getElementById("item7");
    if(element1 != null) item7  = encodeURI(document.getElementById("item7").value);

    element1 = document.getElementById("item8");
    if(element1 != null) item8  = encodeURI(document.getElementById("item8").value);

    element1 = document.getElementById("item9");
    if(element1 != null) item9  = encodeURI(document.getElementById("item9").value);

    element1 = document.getElementById("item10");
    if(element1 != null) item10  = encodeURI(document.getElementById("item10").value);
    
    $.ajax({
      type: "POST",
      url: "cm40102_save_item.jsp?WID="+id_wid+"&IKEY=<%=ikey%>&ITEM1="+item1+"&ITEM2="+item2+"&ITEM3="+item3+"&ITEM4="+item4+"&ITEM5="+item5+"&ITEM6="+item6+"&ITEM7="+item7+"&ITEM8="+item8+"&ITEM9="+item9+"&ITEM10="+item10,
      async : false,
      //contentType : "application/x-www-form-urlencoded; charset=UTF-8",
      success : function(data) {
        console.log(data);
      },
      dataType: "text"
    });

  }

  function getParameterByName(name, url) {
      if (!url) {
        url = window.location.href;
      }
      name = name.replace(/[\[\]]/g, "\\$&");
      var regex = new RegExp("[?&]" + name + "(=([^&#]*)|&|#|$)"),
          results = regex.exec(url);
      if (!results) return null;
      if (!results[2]) return '';
      return decodeURIComponent(results[2].replace(/\+/g, " "));
  }
  
  var defaultData ;
    $.ajax({
    type: "POST",
    url: "cm40102_get_item.jsp?ikey=<%=ikey%>", //$("#BMSREGTIO_DATE")
    async : false,
    success : function(data) {
        console.log(data);
        //document.getElementById("BMSREGTPRE_END_DATE").value = data;
        defaultData = data ;//$.parseJSON(s_data);//parse JSON
      },
    dataType: "json"
    });

    //function getCookie(cookieName) {
    //  var name = cookieName + "=";
    //  var ca = document.cookie.split(';');
    //  for(var i=0; i<ca.length; i++) {
    //      var c = ca[i];
    //      while (c.charAt(0)==' ') c = c.substring(1);
    //      if (c.indexOf(name) == 0) return c.substring(name.length,c.length);
    //  }
    //  return "";
   // }

  if (wid != null){
    //var wkitem = getCookie('wkitem');
    //$("#lvl_item").empty(); 
    //$('#lvl_item').append('<p>' + wkitem + '</p>');
      $.ajax({
        type: "POST",
        url: "cm40102_get_freeze.jsp?WID="+wid+"&IKEY=<%=ikey%>", //$("#BMSREGTIO_DATE")
        async : false,
        success : function(data) {
        if (data.trim()=='Y')
        {
          $("#frz_btn").removeClass("btn-danger");
          $("#frz_btn").addClass("btn-success disabled ");
        }  
        else 
        {
          $("#frz_btn").removeClass("btn-success disabled");
          $("#frz_btn").addClass("btn-danger ");
        }

       },
      dataType: "text"
    });

    $.ajax({
      type: "POST",
      url: "cm40102_man_form.jsp?WID="+wid+"&IKEY=<%=ikey%>", //$("#BMSREGTIO_DATE")
      async : false,
      success : function(data) {
      console.log(data);
      $("#wkform").html(data);
     },
    dataType: "text"
    });

    $.ajax({
      type: "POST",
      url: "cm40102_get_wkdocs.jsp?wid="+wid+"&ikey=<%=ikey%>", //$("#BMSREGTIO_DATE")
      async : false,
      success : function(data) {
      console.log(data);
      $("#wkdocs").html(data);
     },
    dataType: "text"
    });

  }
  

  $(function() {
    var $expandibleTree = $('#treeview5').treeview({
            //color: "#428bca",
          expandIcon: 'glyphicon glyphicon-minus-sign',
          collapseIcon: 'glyphicon glyphicon-plus-sign',
          nodeIcon: 'glyphicon glyphicon-file',
          onNodeSelected: function(event, node) {

              //document.cookie = "wkitem="+ node.text;
              console.log('node.href:'+node.href);  
              var wid = node.href.split('_')[1];
              var end = node.href.split('_')[0];  
              document.getElementById("wid").value = wid; 
              if (end == '0'){
                $("#lvl_item").empty(); 
                $('#lvl_item').append('<td class="text-danger"><h4>目前項目：' + node.text + '</h4></td>');
                $("#lvl_itemb").show(); 
              }else{
                $("#lvl_item").empty(); 
                $("#lvl_itemb").hide(); 
              }

               // console.log('wid:' + wid );
               // console.log('ikey:' + <%=ikey%> );

              document.getElementById("frz_btn").href="cm40102_freeze_item.jsp?WID="+wid+"&IKEY=<%=ikey%>"; 
              $.ajax({
                type: "POST",
                url: "cm40102_get_freeze.jsp?WID="+wid+"&IKEY=<%=ikey%>", //
                async : false,
                success : function(data) {
                 if (data.trim()=='Y')
                {
                  $("#frz_btn").removeClass("btn-danger");
                  $("#frz_btn").addClass("btn-success disabled ");
                }  
                else 
                {
                  $("#frz_btn").removeClass("btn-success disabled");
                  $("#frz_btn").addClass("btn-danger ");
                }
               },
              dataType: "text"
            });
            if (end.trim()=='0')
            {
              $.ajax({
                type: "POST",
                url: "cm40102_man_form.jsp?WID="+wid+"&IKEY=<%=ikey%>", //$("#BMSREGTIO_DATE")
                async : false,
                success : function(data) {
                console.log(data);
                $("#wkform").html(data);
               },
              dataType: "text"
              });

              console.log('ikey:<%=ikey%>');   
              $.ajax({
                type: "POST",
                url: "cm40102_get_wkdocs.jsp?wid="+wid+"&ikey=<%=ikey%>", //$("#BMSREGTIO_DATE")
                async : false,
                success : function(data) {
                console.log(data);
                $("#wkdocs").html(data);
               },
              dataType: "text"
              });

            }
            else
            {
              $("#wkform").html("");
              $("#wkdocs").html("");
              $("#frz_btn").removeClass("btn-danger");
              $("#frz_btn").addClass("btn-success disabled ");
            }  

          },
          levels: 99,
          data: defaultData,
          color: "black",
          backColor: "#e6ffff",
          onhoverColor: "orange",
          borderColor: "#99e6ff"

        });
        
  })
        
</script>
</div>
</body>
</html>
