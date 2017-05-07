<%@page pageEncoding="UTF-8"%><%--== Handlers ==--%> <%--cm40102_man Opening Initialization directive @1-A0E75F14--%><%!

// //Workaround for JRun 3.1 @1-F81417CB

//content type (workaround for Tomcat 6) @1-58BDD9BE
%><%@page contentType="text/html; charset=UTF-8"%><%!
//End content type (workaround for Tomcat 6)

//Feature checker Head @1-4E6FEF07
    public class cm40102_manServiceChecker implements com.codecharge.feature.IServiceChecker {
//End Feature checker Head

//feature binding @1-6DADF1A6
        public boolean check ( HttpServletRequest request, HttpServletResponse response, ServletContext context) {
            String attr = "" + request.getParameter("callbackControl");
            return false;
        }
//End feature binding

//Feature checker Tail @1-FCB6E20C
    }
//End Feature checker Tail

//cm40102_man Page Handler Head @1-D11295E5
    public class cm40102_manPageHandler implements PageListener {
//End cm40102_man Page Handler Head

//cm40102_man BeforeInitialize Method Head @1-4C73EADA
        public void beforeInitialize(Event e) {
//End cm40102_man BeforeInitialize Method Head

//cm40102_man CheckBox Values @1-6CF1B4A1
            ((com.codecharge.components.CheckBox) ((com.codecharge.components.EditableGrid) (e.getPage().getChild( "APROLE" ))).getChild( "CheckBox_Delete" )).setCheckedValue(true);
            ((com.codecharge.components.CheckBox) ((com.codecharge.components.EditableGrid) (e.getPage().getChild( "APROLE" ))).getChild( "CheckBox_Delete" )).setUncheckedValue(false);
//End cm40102_man CheckBox Values

//cm40102_man BeforeInitialize Method Tail @1-FCB6E20C
        }
//End cm40102_man BeforeInitialize Method Tail

//cm40102_man AfterInitialize Method Head @1-89E84600
        public void afterInitialize(Event e) {
//End cm40102_man AfterInitialize Method Head

//cm40102_man CheckBox Values @1-6CF1B4A1
            ((com.codecharge.components.CheckBox) ((com.codecharge.components.EditableGrid) (e.getPage().getChild( "APROLE" ))).getChild( "CheckBox_Delete" )).setCheckedValue(true);
            ((com.codecharge.components.CheckBox) ((com.codecharge.components.EditableGrid) (e.getPage().getChild( "APROLE" ))).getChild( "CheckBox_Delete" )).setUncheckedValue(false);
//End cm40102_man CheckBox Values

//Event AfterInitialize Action Validate onTimeout_Synct @132-4B8A4259
          if (SessionStorage.getInstance(e.getPage().getRequest()).getAttributeAsString("LoginPass") != "True")
            e.getPage().setRedirectString("timeout_err.jsp");
//End Event AfterInitialize Action Validate onTimeout_Synct

//Event AfterInitialize Action Custom Code @38-44795B7A
	String CurrentProgram_ID = "cm40102";
	String Program_ID = 
			Utils.convertToString(SessionStorage.getInstance(e.getPage().getRequest()).getAttribute("PROGRAM_ID"));
	
	if(!StringUtils.isEmpty(Program_ID)&&!Program_ID.equals(CurrentProgram_ID)){
		for(int i = 1; i <=15; i++)SessionStorage.getInstance(e.getPage().getRequest()).setAttribute("SearchParam_" + i,"");	
	}
	SessionStorage.getInstance(e.getPage().getRequest()).setAttribute("PROGRAM_ID",CurrentProgram_ID);
//End Event AfterInitialize Action Custom Code

//cm40102_man AfterInitialize Method Tail @1-FCB6E20C
        }
//End cm40102_man AfterInitialize Method Tail

//cm40102_man OnInitializeView Method Head @1-E3C15E0F
        public void onInitializeView(Event e) {
//End cm40102_man OnInitializeView Method Head

//cm40102_man OnInitializeView Method Tail @1-FCB6E20C
        }
//End cm40102_man OnInitializeView Method Tail

//cm40102_man BeforeShow Method Head @1-46046458
        public void beforeShow(Event e) {
//End cm40102_man BeforeShow Method Head

//cm40102_man BeforeShow Method Tail @1-FCB6E20C
        }
//End cm40102_man BeforeShow Method Tail

//cm40102_man BeforeOutput Method Head @1-BE3571C7
        public void beforeOutput(Event e) {
//End cm40102_man BeforeOutput Method Head

//cm40102_man BeforeOutput Method Tail @1-FCB6E20C
        }
//End cm40102_man BeforeOutput Method Tail

//cm40102_man BeforeUnload Method Head @1-1DDBA584
        public void beforeUnload(Event e) {
//End cm40102_man BeforeUnload Method Head

//cm40102_man BeforeUnload Method Tail @1-FCB6E20C
        }
//End cm40102_man BeforeUnload Method Tail

//cm40102_man onCache Method Head @1-7A88A4B8
        public void onCache(CacheEvent e) {
//End cm40102_man onCache Method Head

//get cachedItem @1-F7EFE9F6
            if (e.getCacheOperation() == ICache.OPERATION_GET) {
//End get cachedItem

//custom code before get cachedItem @1-E3CE2760
                /* Write your own code here */
//End custom code before get cachedItem

//put cachedItem @1-FD2D76DE
            } else if (e.getCacheOperation() == ICache.OPERATION_PUT) {
//End put cachedItem

//custom code before put cachedItem @1-E3CE2760
                /* Write your own code here */
//End custom code before put cachedItem

//if tail @1-FCB6E20C
            }
//End if tail

//cm40102_man onCache Method Tail @1-FCB6E20C
        }
//End cm40102_man onCache Method Tail

//cm40102_man Page Handler Tail @1-FCB6E20C
    }
//End cm40102_man Page Handler Tail

//APROLE EditableGrid Handler Head @2-523D3253
    public class cm40102_manAPROLEEditableGridHandler implements EditableGridListener, EditableGridDataObjectListener {
//End APROLE EditableGrid Handler Head

//APROLE afterInitialize Method Head @2-89E84600
        public void afterInitialize(Event e) {
//End APROLE afterInitialize Method Head

//APROLE afterInitialize Method Tail @2-FCB6E20C
        }
//End APROLE afterInitialize Method Tail

//APROLE BeforeShow Method Head @2-46046458
        public void beforeShow(Event e) {
//End APROLE BeforeShow Method Head

//APROLE Default value @2-D33B0AB5
            e.getComponent().getControl("CheckBox_Delete").setDefaultValue(false);
            for (Iterator i = e.getComponent().getChildRows().iterator(); i.hasNext();) {
                HashMap row = (HashMap)i.next();
                if ((Control)row.get("CheckBox_Delete") != null)
                    ((Control)row.get("CheckBox_Delete")).setDefaultValue(false);
            }
//End APROLE Default value

//Event BeforeShow Action Custom Code @131-44795B7A


 String userMessage = Utils.convertToString(SessionStorage.getInstance(e.getPage().getRequest()).getAttribute("UserMessage"));
  		  //第一碼為 1 顯示在表頭、 2顯示在表身
  		  if (!StringUtils.isEmpty(userMessage) && userMessage.substring(0,1).equals("2")) {
  			// reset message
  			SessionStorage.getInstance(e.getPage().getRequest()).setAttribute("UserMessage", "");
  		  	// print message
  			e.getEditableGrid().addError(userMessage.substring(1,userMessage.length()));
  		  }
  		  // --------------------  END UserMessage  --------------------

//End Event BeforeShow Action Custom Code

//APROLE BeforeShow Method Tail @2-FCB6E20C
        }
//End APROLE BeforeShow Method Tail

//APROLE BeforeShowRow Method Head @2-BDFD38FC
        public void beforeShowRow(Event e) {
//End APROLE BeforeShowRow Method Head

//Event BeforeShowRow Action Custom Code @50-44795B7A
	String link = Utils.convertToString(e.getGrid().getControl("ROLEID").getValue());
	
	if(StringUtils.isEmpty(link)){
		e.getGrid().getControl("ROLEID").setVisible(true);
		e.getGrid().getLink("Link1").setVisible(false);	
	}else{
		e.getGrid().getControl("ROLEID").setVisible(false);
		e.getGrid().getControl("Link1").setVisible(true);
	}
//End Event BeforeShowRow Action Custom Code


//APROLE BeforeShowRow Method Tail @2-FCB6E20C
        }
//End APROLE BeforeShowRow Method Tail

//APROLE OnValidate Method Head @2-5F430F8E
        public void onValidate(Event e) {
//End APROLE OnValidate Method Head

//APROLE OnValidate Method Tail @2-FCB6E20C
        }
//End APROLE OnValidate Method Tail

//APROLE OnValidateRow Method Head @2-5A481738
        public void onValidateRow(Event e) {
//End APROLE OnValidateRow Method Head

//APROLE OnValidateRow Method Tail @2-FCB6E20C
        }
//End APROLE OnValidateRow Method Tail

//APROLE BeforeSelect Method Head @2-E5EC9AD3
        public void beforeSelect(Event e) {
//End APROLE BeforeSelect Method Head

//APROLE BeforeSelect Method Tail @2-FCB6E20C
        }
//End APROLE BeforeSelect Method Tail

//APROLE BeforeBuildSelect Method Head @2-3041BA14
        public void beforeBuildSelect(DataObjectEvent e) {
//End APROLE BeforeBuildSelect Method Head

//APROLE BeforeBuildSelect Method Tail @2-FCB6E20C
        }
//End APROLE BeforeBuildSelect Method Tail

//APROLE BeforeExecuteSelect Method Head @2-8391D9D6
        public void beforeExecuteSelect(DataObjectEvent e) {
//End APROLE BeforeExecuteSelect Method Head

//APROLE BeforeExecuteSelect Method Tail @2-FCB6E20C
        }
//End APROLE BeforeExecuteSelect Method Tail

//APROLE AfterExecuteSelect Method Head @2-0972E7FA
        public void afterExecuteSelect(DataObjectEvent e) {
//End APROLE AfterExecuteSelect Method Head

//APROLE AfterExecuteSelect Method Tail @2-FCB6E20C
        }
//End APROLE AfterExecuteSelect Method Tail

//APROLE BeforeInsert Method Head @2-75B62B83
        public void beforeInsert(Event e) {
//End APROLE BeforeInsert Method Head

//APROLE BeforeInsert Method Tail @2-FCB6E20C
        }
//End APROLE BeforeInsert Method Tail

//APROLE BeforeBuildInsert Method Head @2-FD6471B0
        public void beforeBuildInsert(DataObjectEvent e) {
//End APROLE BeforeBuildInsert Method Head

//APROLE BeforeBuildInsert Method Tail @2-FCB6E20C
        }
//End APROLE BeforeBuildInsert Method Tail

//APROLE BeforeExecuteInsert Method Head @2-4EB41272
        public void beforeExecuteInsert(DataObjectEvent e) {
//End APROLE BeforeExecuteInsert Method Head

//APROLE BeforeExecuteInsert Method Tail @2-FCB6E20C
        }
//End APROLE BeforeExecuteInsert Method Tail

//APROLE AfterExecuteInsert Method Head @2-C4572C5E
        public void afterExecuteInsert(DataObjectEvent e) {
//End APROLE AfterExecuteInsert Method Head

//APROLE AfterExecuteInsert Method Tail @2-FCB6E20C
        }
//End APROLE AfterExecuteInsert Method Tail

//APROLE AfterInsert Method Head @2-767A9165
        public void afterInsert(Event e) {
//End APROLE AfterInsert Method Head

//APROLE AfterInsert Method Tail @2-FCB6E20C
        }
//End APROLE AfterInsert Method Tail

//APROLE BeforeSubmit Method Head @2-9D1B8475
        public void beforeSubmit(Event e) {
//End APROLE BeforeSubmit Method Head

//APROLE BeforeSubmit Method Tail @2-FCB6E20C
        }
//End APROLE BeforeSubmit Method Tail

//APROLE BeforeBuildUpdate Method Head @2-37688606
        public void beforeBuildUpdate(DataObjectEvent e) {
//End APROLE BeforeBuildUpdate Method Head

//APROLE BeforeBuildUpdate Method Tail @2-FCB6E20C
        }
//End APROLE BeforeBuildUpdate Method Tail

//APROLE BeforeExecuteUpdate Method Head @2-84B8E5C4
        public void beforeExecuteUpdate(DataObjectEvent e) {
//End APROLE BeforeExecuteUpdate Method Head

//APROLE BeforeExecuteUpdate Method Tail @2-FCB6E20C
        }
//End APROLE BeforeExecuteUpdate Method Tail

//APROLE AfterExecuteUpdate Method Head @2-0E5BDBE8
        public void afterExecuteUpdate(DataObjectEvent e) {
//End APROLE AfterExecuteUpdate Method Head

//APROLE AfterExecuteUpdate Method Tail @2-FCB6E20C
        }
//End APROLE AfterExecuteUpdate Method Tail

//APROLE AfterSubmit Method Head @2-9ED73E93
        public void afterSubmit(Event e) {
//End APROLE AfterSubmit Method Head

//Event AfterSubmit Action Custom Code @130-44795B7A

//異動後顯示訊息
SessionStorage.getInstance(e.getPage().getRequest()).setAttribute("UserMessage","2資料異動成功.");

//End Event AfterSubmit Action Custom Code

//APROLE AfterSubmit Method Tail @2-FCB6E20C
        }
//End APROLE AfterSubmit Method Tail

//APROLE BeforeDelete Method Head @2-752E3118
        public void beforeDelete(Event e) {
//End APROLE BeforeDelete Method Head

//APROLE BeforeDelete Method Tail @2-FCB6E20C
        }
//End APROLE BeforeDelete Method Tail

//APROLE BeforeBuildDelete Method Head @2-01A46505
        public void beforeBuildDelete(DataObjectEvent e) {
//End APROLE BeforeBuildDelete Method Head

//APROLE BeforeBuildDelete Method Tail @2-FCB6E20C
        }
//End APROLE BeforeBuildDelete Method Tail

//APROLE BeforeExecuteDelete Method Head @2-B27406C7
        public void beforeExecuteDelete(DataObjectEvent e) {
//End APROLE BeforeExecuteDelete Method Head

//APROLE BeforeExecuteDelete Method Tail @2-FCB6E20C
        }
//End APROLE BeforeExecuteDelete Method Tail

//APROLE AfterExecuteDelete Method Head @2-389738EB
        public void afterExecuteDelete(DataObjectEvent e) {
//End APROLE AfterExecuteDelete Method Head

//APROLE AfterExecuteDelete Method Tail @2-FCB6E20C
        }
//End APROLE AfterExecuteDelete Method Tail

//APROLE AfterDelete Method Head @2-76E28BFE
        public void afterDelete(Event e) {
//End APROLE AfterDelete Method Head

//APROLE AfterDelete Method Tail @2-FCB6E20C
        }
//End APROLE AfterDelete Method Tail

//APROLE EditableGrid Handler Tail @2-FCB6E20C
    }
//End APROLE EditableGrid Handler Tail

//CheckBox_Delete CheckBox Handler Head @20-2FDC8857
    public class APROLECheckBox_DeleteCheckBoxHandler implements ValidationListener {
//End CheckBox_Delete CheckBox Handler Head

//CheckBox_Delete BeforeShow Method Head @20-46046458
        public void beforeShow(Event e) {
//End CheckBox_Delete BeforeShow Method Head

//CheckBox_Delete BeforeShow Method Tail @20-FCB6E20C
        }
//End CheckBox_Delete BeforeShow Method Tail

//CheckBox_Delete OnValidate Method Head @20-5F430F8E
        public void onValidate(Event e) {
//End CheckBox_Delete OnValidate Method Head

//CheckBox_Delete OnValidate Method Tail @20-FCB6E20C
        }
//End CheckBox_Delete OnValidate Method Tail

//CheckBox_Delete CheckBox Handler Tail @20-FCB6E20C
    }
//End CheckBox_Delete CheckBox Handler Tail

//BMSREGT_TotalRecords Label Handler Head @4-C4D48B5C
    public class APROLEBMSREGT_TotalRecordsLabelHandler implements ControlListener {
        public void beforeShow(Event e) {
//End BMSREGT_TotalRecords Label Handler Head

//Event BeforeShow Action Retrieve number of records @5-42EFC3DF
        ((Control) e.getSource()).setValue( ((EditableGrid) e.getParent()).getAmountOfRows());
//End Event BeforeShow Action Retrieve number of records

//BMSREGT_TotalRecords Label Handler Tail @4-F5FC18C5
        }
    }
//End BMSREGT_TotalRecords Label Handler Tail

//APROLESearch Record Handler Head @23-8E1AD31F
    public class cm40102_manAPROLESearchRecordHandler implements RecordListener, RecordDataObjectListener {
//End APROLESearch Record Handler Head

//APROLESearch afterInitialize Method Head @23-89E84600
        public void afterInitialize(Event e) {
//End APROLESearch afterInitialize Method Head

//APROLESearch afterInitialize Method Tail @23-FCB6E20C
        }
//End APROLESearch afterInitialize Method Tail

//APROLESearch OnSetDataSource Method Head @23-9B7FBFCF
        public void onSetDataSource(DataObjectEvent e) {
//End APROLESearch OnSetDataSource Method Head

//APROLESearch OnSetDataSource Method Tail @23-FCB6E20C
        }
//End APROLESearch OnSetDataSource Method Tail

//APROLESearch BeforeShow Method Head @23-46046458
        public void beforeShow(Event e) {
//End APROLESearch BeforeShow Method Head

//Event BeforeShow Action Custom Code @39-44795B7A


 String userMessage = Utils.convertToString(SessionStorage.getInstance(e.getPage().getRequest()).getAttribute("UserMessage"));
  		  //第一碼為 1 顯示在表頭、 2顯示在表身
  		  if (!StringUtils.isEmpty(userMessage) && userMessage.substring(0,1).equals("1")) {
  			// reset message
  			SessionStorage.getInstance(e.getPage().getRequest()).setAttribute("UserMessage", "");
  		  	// print message
  			e.getRecord().addError(userMessage.substring(1,userMessage.length()));
  		  }
  		  // --------------------  END UserMessage  --------------------

	String SearchParam_1 = Utils.convertToString(SessionStorage.getInstance(e.getPage().getRequest()).getAttribute("SearchParam_1"));
	String SearchParam_2 = Utils.convertToString(SessionStorage.getInstance(e.getPage().getRequest()).getAttribute("SearchParam_2"));
	
	e.getRecord().getControl("s_ROLEID").setValue(SearchParam_1);
	e.getRecord().getControl("s_ROLENAME").setValue(SearchParam_2);
//End Event BeforeShow Action Custom Code

//APROLESearch BeforeShow Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeShow Method Tail

//APROLESearch OnValidate Method Head @23-5F430F8E
        public void onValidate(Event e) {
//End APROLESearch OnValidate Method Head

//Event OnValidate Action Custom Code @40-44795B7A
	String SearchParam_1 = Utils.convertToString(e.getRecord().getControl("s_ROLEID").getValue());
	String SearchParam_2 = Utils.convertToString(e.getRecord().getControl("s_ROLENAME").getValue());
	
	SessionStorage.getInstance(e.getPage().getRequest()).setAttribute("SearchParam_1", SearchParam_1);
	SessionStorage.getInstance(e.getPage().getRequest()).setAttribute("SearchParam_2", SearchParam_2);
//End Event OnValidate Action Custom Code

//APROLESearch OnValidate Method Tail @23-FCB6E20C
        }
//End APROLESearch OnValidate Method Tail

//APROLESearch BeforeSelect Method Head @23-E5EC9AD3
        public void beforeSelect(Event e) {
//End APROLESearch BeforeSelect Method Head

//APROLESearch BeforeSelect Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeSelect Method Tail

//APROLESearch BeforeBuildSelect Method Head @23-3041BA14
        public void beforeBuildSelect(DataObjectEvent e) {
//End APROLESearch BeforeBuildSelect Method Head

//APROLESearch BeforeBuildSelect Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeBuildSelect Method Tail

//APROLESearch BeforeExecuteSelect Method Head @23-8391D9D6
        public void beforeExecuteSelect(DataObjectEvent e) {
//End APROLESearch BeforeExecuteSelect Method Head

//APROLESearch BeforeExecuteSelect Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeExecuteSelect Method Tail

//APROLESearch AfterExecuteSelect Method Head @23-0972E7FA
        public void afterExecuteSelect(DataObjectEvent e) {
//End APROLESearch AfterExecuteSelect Method Head

//APROLESearch AfterExecuteSelect Method Tail @23-FCB6E20C
        }
//End APROLESearch AfterExecuteSelect Method Tail

//APROLESearch BeforeInsert Method Head @23-75B62B83
        public void beforeInsert(Event e) {
//End APROLESearch BeforeInsert Method Head

//APROLESearch BeforeInsert Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeInsert Method Tail

//APROLESearch BeforeBuildInsert Method Head @23-FD6471B0
        public void beforeBuildInsert(DataObjectEvent e) {
//End APROLESearch BeforeBuildInsert Method Head

//APROLESearch BeforeBuildInsert Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeBuildInsert Method Tail

//APROLESearch BeforeExecuteInsert Method Head @23-4EB41272
        public void beforeExecuteInsert(DataObjectEvent e) {
//End APROLESearch BeforeExecuteInsert Method Head

//APROLESearch BeforeExecuteInsert Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeExecuteInsert Method Tail

//APROLESearch AfterExecuteInsert Method Head @23-C4572C5E
        public void afterExecuteInsert(DataObjectEvent e) {
//End APROLESearch AfterExecuteInsert Method Head

//APROLESearch AfterExecuteInsert Method Tail @23-FCB6E20C
        }
//End APROLESearch AfterExecuteInsert Method Tail

//APROLESearch AfterInsert Method Head @23-767A9165
        public void afterInsert(Event e) {
//End APROLESearch AfterInsert Method Head

//APROLESearch AfterInsert Method Tail @23-FCB6E20C
        }
//End APROLESearch AfterInsert Method Tail

//APROLESearch BeforeUpdate Method Head @23-33A3CFAC
        public void beforeUpdate(Event e) {
//End APROLESearch BeforeUpdate Method Head

//APROLESearch BeforeUpdate Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeUpdate Method Tail

//APROLESearch BeforeBuildUpdate Method Head @23-37688606
        public void beforeBuildUpdate(DataObjectEvent e) {
//End APROLESearch BeforeBuildUpdate Method Head

//APROLESearch BeforeBuildUpdate Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeBuildUpdate Method Tail

//APROLESearch BeforeExecuteUpdate Method Head @23-84B8E5C4
        public void beforeExecuteUpdate(DataObjectEvent e) {
//End APROLESearch BeforeExecuteUpdate Method Head

//APROLESearch BeforeExecuteUpdate Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeExecuteUpdate Method Tail

//APROLESearch AfterExecuteUpdate Method Head @23-0E5BDBE8
        public void afterExecuteUpdate(DataObjectEvent e) {
//End APROLESearch AfterExecuteUpdate Method Head

//APROLESearch AfterExecuteUpdate Method Tail @23-FCB6E20C
        }
//End APROLESearch AfterExecuteUpdate Method Tail

//APROLESearch AfterUpdate Method Head @23-306F754A
        public void afterUpdate(Event e) {
//End APROLESearch AfterUpdate Method Head

//APROLESearch AfterUpdate Method Tail @23-FCB6E20C
        }
//End APROLESearch AfterUpdate Method Tail

//APROLESearch BeforeDelete Method Head @23-752E3118
        public void beforeDelete(Event e) {
//End APROLESearch BeforeDelete Method Head

//APROLESearch BeforeDelete Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeDelete Method Tail

//APROLESearch BeforeBuildDelete Method Head @23-01A46505
        public void beforeBuildDelete(DataObjectEvent e) {
//End APROLESearch BeforeBuildDelete Method Head

//APROLESearch BeforeBuildDelete Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeBuildDelete Method Tail

//APROLESearch BeforeExecuteDelete Method Head @23-B27406C7
        public void beforeExecuteDelete(DataObjectEvent e) {
//End APROLESearch BeforeExecuteDelete Method Head

//APROLESearch BeforeExecuteDelete Method Tail @23-FCB6E20C
        }
//End APROLESearch BeforeExecuteDelete Method Tail

//APROLESearch AfterExecuteDelete Method Head @23-389738EB
        public void afterExecuteDelete(DataObjectEvent e) {
//End APROLESearch AfterExecuteDelete Method Head

//APROLESearch AfterExecuteDelete Method Tail @23-FCB6E20C
        }
//End APROLESearch AfterExecuteDelete Method Tail

//APROLESearch AfterDelete Method Head @23-76E28BFE
        public void afterDelete(Event e) {
//End APROLESearch AfterDelete Method Head

//APROLESearch AfterDelete Method Tail @23-FCB6E20C
        }
//End APROLESearch AfterDelete Method Tail

//APROLESearch Record Handler Tail @23-FCB6E20C
    }
//End APROLESearch Record Handler Tail

//DEL  	for(int i = 0; i <= 5; i++){
//DEL  		SessionStorage.getInstance(e.getPage().getRequest()).setAttribute("SearchParam_" + i, "");	
//DEL  	}

//Comment workaround @1-A0AAE532
%> <%
//End Comment workaround

//Processing @1-D680F080
    Page cm40102_manModel = (Page)request.getAttribute("cm40102_man_page");
    Page cm40102_manParent = (Page)request.getAttribute("cm40102_manParent");
    if (cm40102_manModel == null) {
        PageController cm40102_manCntr = new PageController(request, response, application, "/cm40102_man.xml" );
        cm40102_manModel = cm40102_manCntr.getPage();
        cm40102_manModel.setRelativePath("./");
        //if (cm40102_manParent != null) {
            //if (!cm40102_manParent.getChild(cm40102_manModel.getName()).isVisible()) return;
        //}
        cm40102_manModel.addPageListener(new cm40102_manPageHandler());
        ((EditableGrid)cm40102_manModel.getChild("APROLE")).addEditableGridListener(new cm40102_manAPROLEEditableGridHandler());
        ((CheckBox)((EditableGrid)cm40102_manModel.getChild("APROLE")).getChild("CheckBox_Delete")).addValidationListener(new APROLECheckBox_DeleteCheckBoxHandler());
        ((Label)((EditableGrid)cm40102_manModel.getChild("APROLE")).getChild("BMSREGT_TotalRecords")).addControlListener(new APROLEBMSREGT_TotalRecordsLabelHandler());
        ((Record)cm40102_manModel.getChild("APROLESearch")).addRecordListener(new cm40102_manAPROLESearchRecordHandler());
        cm40102_manCntr.process();
%>
<%
        if (cm40102_manParent == null) {
            cm40102_manModel.setCookies();
            if (cm40102_manModel.redirect()) return;
        } else {
            cm40102_manModel.redirect();
        }
    }
//End Processing

%>
