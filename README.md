# jspTreeView
workflow, step by step , tree view item.  dynamically add item/delete item By ajax.  

樹狀結構用bootstrap-treeview套件，
將結點(node)資訊，以符合原作者規範的格式以json型式傳入。
ajax的呼叫方式，回傳type可為json及text(在後端拼好html)傳回前端。

jsp 網頁裏放select/update sql。透過simple json 套件，將jdbc 拉回來的data，
塞進三層(迴圈)的物件。再呼叫simple json 轉成json格式字串傳回前端。
用list，map，這些java基本容器對應json的階層。

jdbc非原生的官方函數，而是code charge 簡化過的。

為了減少畫面閃動，主要是ajax 呼叫，jquery更新局部 div，table 的內容。
節點的table，以3碼為第一層，6碼為第二層，10碼為第三層。

cookie保留頁面資訊，但在tomcat6 版會異常。
須tomcat7版及以上。

css框架是用bootstrap。

整個admin 管理後台，是購買付費的調適好的bootstrap樣板。



![Image of wk1](https://github.com/timloo0710/jspTreeView/blob/master/wf1.JPG)

![Image of wk2](https://github.com/timloo0710/jspTreeView/blob/master/wf2.JPG)

![Image of wk3](https://github.com/timloo0710/jspTreeView/blob/master/wf3.JPG)

![Image of wk4](https://github.com/timloo0710/jspTreeView/blob/master/wk4.JPG)
