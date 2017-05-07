<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, java.io.*,com.codecharge.*,com.codecharge.util.*,com.codecharge.db.* " %>


<% 
  String ikey = (String)request.getParameter("INDEX_KEY");  
  String lno = Utils.convertToString(DBTools.dLookUp("LICENSE_DESC","BM_BASE","INDEX_KEY='"+ikey+"'", "SynctConn"));

  //String up_floor_no = Utils.convertToString(DBTools.dLookUp("UP_FLOOR_NO","BM_BASE","INDEX_KEY='"+ikey+"'", "SynctConn")); 舊的抓法
  String up_floor_no = Utils.convertToString(DBTools.dLookUp("substr(max(story_code),2,3)","bm_stair","INDEX_KEY='"+ikey+"'  and story_code not like 'V%' ", "SynctConn"));

  if (!StringUtils.isEmpty(up_floor_no)){
    up_floor_no = "005";
  }

  int LNO_cnt = Utils.convertToLong(DBTools.dLookUp("Count(*)","WKITEMLIST","INDEX_KEY='" + ikey + "'", "SynctConn")).intValue();

  if (!StringUtils.isEmpty(ikey) && LNO_cnt <= 0)
  {

    JDBCConnection Conn = JDBCConnectionFactory.getJDBCConnection("SynctConn");
    String Sql = "INSERT INTO WKITEMLIST (    WID,    WDESC,    ISMENU,     INDEX_KEY)  "+
      " SELECT WID,    WDESC,    '0','"+ikey+"'  FROM  WKCODE "+
      " where WDTYPE='1' AND length(wid)<=6  AND wid <='wk5' ||'"+ up_floor_no+"' "   ;//trim(to_char(to_number('" + up_floor_no + "'),'00'))";||'006'
    out.println(Sql);  
    Conn.executeUpdate(Sql);
    Conn.closeConnection(); 
  }

 

%>

<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title></title>
<link rel="stylesheet" type="text/css" href="Styles/Synct/jquery-ui.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/ionicons/2.0.1/css/ionicons.min.css">
<link rel="stylesheet" href="./bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.5.0/css/font-awesome.min.css">
<link rel="stylesheet" href="./dist/css/skins/_all-skins.min.css">
<link rel="stylesheet" type="text/css" href="assets/stylesheets/multi-select.css">

</head>
<body class="theme-default main-menu-animated">
<div id="main-wrapper">
  <jsp:include page="main_menu.jsp" flush="true" />
  <div id="content-wrapper">
    <ul class="breadcrumb breadcrumb-page">
      <li>申請人作業 </li>
      <li class="active">CM40102施工勘驗申報流程建立 </li>
    </ul>
    <!-- Main content -->
    <div class="row ">
      <div class="col-md-10">
        <div class="box box-solid">
          <div class="box-header with-border">
            <h3 class="box-title">勘驗申報流程建立</h3>
          </div>
          <div class="box-body">
            <div class="row">
              <!-- 左半 -->
              <div class="col-sm-4">
                <div class="row  ">
                  <h3 class="text-center  bg-success "><%=lno %></h3>
                </div>
                <div class="row">
                  <div id="treeview5">
                  </div>
                </div>
              </div>
              <!-- 右半 -->
              <div class="col-sm-8">
                <div class="row"> 
                <h3>維護項目</h3>
                  <form class="form-horizontal" action="cm40102_man_3.jsp" type="POST">
                    <fieldset>
                      <div class="form-group">
                        <label class="col-lg-2 control-label" for="father_node">目前項目</label> 
                        <div class="col-lg-8">
                        <label class="col-lg-4 control-label" id="lvl_item" ></label>
                        <input type="hidden" name="ikey" value="<%=ikey %>" >
                        <input type="hidden" name="wid" id="wid"  >
                        </div>
                      </div>
                      <div class="form-group">
                        <label class="col-lg-2 control-label" for="father_node">子項目</label> 
                        <div class="col-lg-8">
                          <select onchange="getWorkItem(1)" id="select_item" class="form-control" name="levelb"></select>
                        </div>
                      </div>
                      <div class="form-group">
                        <div class="col-lg-10 col-lg-offset-2">
                              <button class="btn btn-primary" type="submit" name="button" value="new">新增</button>
                              <button class="btn btn-primary" type="submit" name="button" value="del">刪除</button>
                              <button class="btn btn-default" type="reset" name="cancel">取消</button> 
                              <a class="btn btn-default" href="cm40102_man.jsp?INDEX_KEY=<%=ikey   %>" >返回</a> 
                        </div>
                      </div>
                    </fieldset> 
                  </form>
                </div>
                
                </div>
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
          </div>
      
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
      <script src="assets/javascripts/jquery.multi-select.js"></script>

      <script type="text/javascript">

        $('#my-select1').multiSelect();

        $('#my-select2').multiSelect();


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
        
        var ikey = getParameterByName('INDEX_KEY');
        var msg = getParameterByName('msg');
        if (msg=='hasMore') 
          alert('此項目仍有子項目，不允許刪除');
        if (msg=='majorItem') 
          alert('此項目為主項目，不允許刪除');
        
        $('#carousel-example-generic').carousel({interval:false});
        
        var defaultData ;
        $.ajax({
          type: "POST",
          url: "cm40102_get_item.jsp?ikey="+ikey, //$("#BMSREGTIO_DATE")
          async : false,
          success : function(data) {
              console.log(data);
              //document.getElementById("BMSREGTPRE_END_DATE").value = data;
              defaultData = data ;//$.parseJSON(s_data);//parse JSON
                      },
          dataType: "json"
              });
                
        $(function() {
          var $expandibleTree = $('#treeview5').treeview({
            //color: "#428bca",
            expandIcon: 'glyphicon glyphicon-minus-sign',
            collapseIcon: 'glyphicon glyphicon-plus-sign',
            nodeIcon: 'glyphicon glyphicon-file',
            onNodeSelected: function(event, node) {
                $("#lvl_item").empty(); 
                $('#lvl_item').append('<p>' + node.text + '</p>');
                var list = document.getElementById("select_item");
                while (list.hasChildNodes()) {   
                    list.removeChild(list.firstChild);
                }           
                console.log(node.href);    
                var wid = node.href.split('_')[1];
                var end = node.href.split('_')[0];  
                if (wid =='wk5') return;
                document.getElementById("wid").value = wid;    
              $.ajax({
                type: "POST",
                url: "cm40102_get_wkitem2.jsp?wid="+wid, //$("#BMSREGTIO_DATE")
                async : false,
                success : function(data) {
                console.log(data);
                var json_obj = data ;//$.parseJSON(s_data);//parse JSON
                var _option = document.createElement("option");
                  _option.value = '';
                  _option.text = '選擇值';
                  for (var i in json_obj) 
                  {
                    //console.log(json_obj[i].CODE_SEQ + ",  " + json_obj[i].CODE_DESC );
                    var option = document.createElement("option");
                    option.value = json_obj[i].WID;
                    option.text = json_obj[i].WDESC;
                    document.getElementById("select_item").appendChild(option);
                  }
               },
              dataType: "json"
            });
          },
          levels: 99,
          data: defaultData,
          color: "black",
          backColor: "#e6ffff",
          onhoverColor: "orange",
          borderColor: "#99e6ff"

         })
        })
        
</script>
</div>
</body>
</html>                