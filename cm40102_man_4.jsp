<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*, java.util.*, java.io.*,com.codecharge.*,com.codecharge.util.*,com.codecharge.db.* " %>


<% 
  String ikey = (String)request.getParameter("INDEX_KEY");  
  String lno = Utils.convertToString(DBTools.dLookUp("LICENSE_DESC","BM_BASE","INDEX_KEY='"+ikey+"'", "SynctConn"));

  //String up_floor_no = Utils.convertToString(DBTools.dLookUp("UP_FLOOR_NO","BM_BASE","INDEX_KEY='"+ikey+"'", "SynctConn"));
  String up_floor_no = Utils.convertToString(DBTools.dLookUp("substr(max(story_code),2,3)","bm_stair","INDEX_KEY='"+ikey+"'  and story_code not like 'V%'", "SynctConn"));

  if (StringUtils.isEmpty(up_floor_no)){
    up_floor_no = "005";
  }

  int LNO_cnt = Utils.convertToLong(DBTools.dLookUp("Count(*)","WKITEMLIST","INDEX_KEY='" + ikey + "'", "SynctConn")).intValue();
  
  //out.println("LNO_cnt:"+LNO_cnt);
    JDBCConnection Conn = JDBCConnectionFactory.getJDBCConnection("SynctConn");

  if (!StringUtils.isEmpty(ikey) && LNO_cnt <= 0)
  {

    String Sql = "INSERT INTO WKITEMLIST (    WID,    WDESC,    ISMENU,     INDEX_KEY  )"+
      " SELECT WID,    WDESC,    '0','"+ikey+"'  FROM  WKCODE "+
      " where WDTYPE='1' AND length(wid)<=6 AND wid <='wk5' ||'"+up_floor_no+"' ";  //trim(to_char(to_number('" + up_floor_no + "'),'00'))
    //out.println(Sql);

    Conn.executeUpdate(Sql);

  }

  String html = "",html_2 = "<option value='xxxx'>請選擇樓版</option>";
  String  Sql = "select WID,WDESC　from wkitemlist where wid like 'wk5m%' and INDEX_KEY='"+ikey+"' order by 1";
    Enumeration rows_WDESC = Conn.getRows(Sql);
  while (rows_WDESC != null && rows_WDESC.hasMoreElements()) {
     DbRow row_01 = (DbRow) rows_WDESC.nextElement();
     String w01 = Utils.convertToString(row_01.get("WDESC"));
     String w02 = Utils.convertToString(row_01.get("WID"));
    html += "<button type='button' onclick='modifyMergeItem(this)'  class='list-group-item btn-success' data-ikey='"+w02+"' >"+w01+"</button><img src='img/edit.png' onclick='edtMergeItem(this)' data-ikey3='"+w02+"' alt='Smiley face' height='25' width='25'><img src='img/x.png' onclick='delMergeItem(this)' data-ikey2='"+w02+"' alt='Smiley face' height='25' width='25'>";
  }

    Sql = "select WID,WDESC　from wkitemlist where  length(wid) = 6  AND  merge is null and wid not like 'wk5m%' and INDEX_KEY='"+ikey+"' order by 1";

    rows_WDESC = Conn.getRows(Sql);
    while (rows_WDESC != null && rows_WDESC.hasMoreElements()) {
       DbRow row_01 = (DbRow) rows_WDESC.nextElement();
       String w01 = Utils.convertToString(row_01.get("WDESC"));
       String w02 = Utils.convertToString(row_01.get("WID"));
       html_2 += "<option value='"+w02+"'>"+w01+"</option>";
    } 

    Conn.closeConnection(); 

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
            <a class="btn btn-default" href="cm40102_man.jsp?INDEX_KEY=<%=ikey   %>" >返回</a> 
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
                  <div class="col-sm-3">
                    <h3>目前合併樓版</h3><!--直接挑 m 的那些秀出來，key值放在 hidden 文字秀在  -->  
                    <div id="merge_list" class="list-group"><!-- 點按 ，秀 merger = key值  ， key值當參數傳入-->
                    <%=html  %>
                    </div>
                   
                    <!-- m1 m2 m3 m4 m5 給定key值-->
                    <input class="form-control" type="text" placeholder="例:2+3+4 併" id="new_merge_item"  >
                    <button class="btn btn-primary"  id="button_new" onclick="createMergeItem()"  >新增</button>
                  </div>
                  <div class="col-sm-5"><!-- 下層分區有合併，沒有 ?  重覆再併嗎?--><!-- 已有的，沒merge的在左，有merge的在右，新加過去的? 新減回來的? 觸動的event -->
                    <select multiple="multiple" id="my-select1" style="width:225px; height:425px;" >
                    </select>
                    <button class="btn btn-primary"  id="button_new" onclick="saveMergeItems()" >儲存設定</button>
                  </div>
                </div>
                <div class="row"> <hr></div>
                <div class="row">
                    <h3>目前合併分區</h3>
                    <h4>所在樓板:</h4><!-- 沒有被合併的樓板，其下的分區可以再併  merge is　null-->
                    <select onchange="getFloor()" id="select_floor" class="form-control" name="levelb">
                    <%=html_2 %>
                    </select>
                </div>
                <div class="row"><hr></div>
                <div class="row">
                  <div class="col-sm-3">
                    <div id="loc_merge_list" class="list-group"><!-- 選擇目前合併分區 準備 -->
                    </div>                    
                    <input  class="form-control" type="text" name="wid" id="new_merge_loc"  placeholder="例:A+B+C 併" >
                    <button class="btn btn-primary" id="button_new_loc" onclick="createMergeLoc()" >新增</button>
                  </div>
                  <div class="col-sm-5">
                    <select multiple="multiple" id="my-select2" style="width:225px; height:120px;">
                          <option value='0001'>A區</option>
                          <option value='0002'>B區</option>
                          <option value='0003'>C區</option>
                          <option value='0004'>D區</option>
                          <option value='0005'>E區</option>
                          <option value='0006'>F區</option>
                    </select>
                    <button class="btn btn-primary"  id="button_new" onclick="saveLocMItems()" >儲存設定</button>
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

      <script type="text/javascript">

      //  $('#my-select1').multiSelect();

      //  $('#my-select2').multiSelect();


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
             

        function createMergeItem() {
          //alert($('#new_merge_item').val());
          var merge_name=encodeURI($('#new_merge_item').val());
          $.ajax({
                type: "POST",
                url: "cm40102_save_Mergeitem_name.jsp?ikey="+ikey+"&merge_name="+merge_name,
                async : false,
                success : function(data) {
                  console.log(data);
                   $("#merge_list").html(data);
                },
                dataType: "text"
              });          
        }


        var mid;
        function modifyMergeItem(sender) {
          mid=sender.dataset.ikey;
          //alert("modifyMergeItem");
          var option = null;
          $.ajax({
            type: "POST",
            url: "cm40102_ini_Mergeitem.jsp?ikey="+ikey+"&mid="+sender.dataset.ikey,
            async : false,
            success : function(data) {
              console.log(data);
              $("#my-select1").html(data);
            },
            dataType:"text"  // json
          });
        }

        var fid;
        function uptMlocItem(sender) {
          fid=sender.dataset.ikey;
          //alert(fid);
          
          $.ajax({
            type: "POST",
            url: "cm40102_ini_LocMitem.jsp?ikey="+ikey+"&fid="+fid,
            async : false,
            success : function(data) {
              console.log(data);
              $("#my-select2").html(data);
            },
            dataType:"text"  // json
          });
        }

        function saveMergeItems(sender) {
          //alert(mid);
          var sel = document.getElementById("my-select1") ;//$("#my-select1");
          var fidarray = "";  
            for(i=0; i < sel.length; i++){
                if(sel.options[i].selected){
                  if (fidarray == "")
                    fidarray = sel.options[i].value;
                  else
                    fidarray += "," + sel.options[i].value;
                }
            }          
          //alert(fidarray); 
           
          $.ajax({
            type: "POST",
            url: "cm40102_saveItemsByMid.jsp?ikey="+ikey+"&mid="+mid+"&items="+fidarray,
            async : false,
            success : function(data) {
              console.log(data);
              $("#my-select1").html(data);
            },
            dataType:"text"  // json
          });
        }

        function saveLocMItems(sender) {
          //alert(fid);
          var sel = document.getElementById("my-select2") ;//$("#my-select1");
          var fidarray = "";  
            for(i=0; i < sel.length; i++){
                if(sel.options[i].selected){
                  if (fidarray == "")
                    fidarray = sel.options[i].value;
                  else
                    fidarray += "," + sel.options[i].value;
                }
            }          
          //alert(fidarray); 
           
          $.ajax({
            type: "POST",
            url: "cm40102_saveLocItemsByFid.jsp?ikey="+ikey+"&fid="+fid+"&items="+fidarray,
            async : false,
            success : function(data) {
              console.log(data);
              $("#my-select2").html(data);
            },
            dataType:"text"  // json
          });
        }


        function delMergeItem(sender) {
         // alert(sender.dataset.ikey2);
          $.ajax({
                type: "POST",
                url: "cm40102_del_Mergeitem_name.jsp?ikey="+ikey+"&mid="+sender.dataset.ikey2,
                async : false,
                success : function(data) {
                  console.log(data);
                  $("#merge_list").html(data);
                  //return false;                  
                },
                dataType: "text"
              });          

        }
        var floor;
        function getFloor() {
          var sel = document.getElementById("select_floor");
          
          //alert(sel[sel.selectedIndex].value);
          floor = sel[sel.selectedIndex].value;
          $.ajax({
                type: "POST",
                url: "cm40102_loc_Mitem.jsp?ikey="+ikey+"&floor="+sel[sel.selectedIndex].value,
                async : false,
                success : function(data) {
                  console.log(data);
                  $("#loc_merge_list").html(data);
                  //return false;                  
                },
                dataType: "text"
              });          
        }

        function createMergeLoc() {
          if (floor==undefined)
          {
            alert("請選擇樓層");
            return;
          }
           else alert(floor);
          //alert($('#new_merge_loc').val());
          var merge_name=encodeURI($('#new_merge_loc').val());
          $.ajax({
                type: "POST",
                url: "cm40102_newMergeLocName.jsp?ikey="+ikey+"&merge_name="+merge_name+"&floor="+floor,
                async : false,
                success : function(data) {
                  console.log(data);
                   $("#loc_merge_list").html(data);
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
                $("#lvl_item").empty(); 
                $('#lvl_item').append('<p>' + node.text + '</p>');
                var list = document.getElementById("select_item");
                while (list.hasChildNodes()) {   
                    list.removeChild(list.firstChild);
                }           
                console.log(node.href);    
                var wid = node.href.split('_')[1];
                var end = node.href.split('_')[0];  
                
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