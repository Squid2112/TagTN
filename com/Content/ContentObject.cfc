component displayname="ContentObjectComponent" hint="Core Content Object Component" output="false" {

	public any function init(string dsn=Application.Settings.DSN.System) output="false" {
		this.DSN = Arguments.dsn;
		return(this);
	}

	public void function childView(required struct Request, string name) output="true" {
		var notFound = false;

		if(!structKeyExists(Arguments,'name')) Arguments.name = Arguments.Request.virtualInfo.ChildViewName;
		Arguments.name = trim(Arguments.name);

		if(!len(Arguments.name)) Arguments.name = trim(listLast(Arguments.Request.virtualInfo.virtualPath,'/'));
		if(!len(Arguments.name)) notFound = true;

		if(fileExists(Application.Settings.rootPath & 'childViews\' & Arguments.name & '\index.cfm')) {
			Application.System.css(Request=Arguments.Request,filename='childViews/' & Arguments.name & '/css/index.css');
			Application.System.js(Request=Arguments.Request,filename='childViews/' & Arguments.name & '/js/index.js');
			Application.System.Wrappers.include('/childViews/' & Arguments.name & '/index.cfm');
		} else {
			notFound = true;
			Arguments.name = 'default';
			if(fileExists(Application.Settings.rootPath & 'childViews\' & Arguments.name & '\index.cfm')) {
				Application.System.css(Request=Arguments.Request,filename='childViews/' & Arguments.name & '/css/index.css');
				Application.System.js(Request=Arguments.Request,filename='childViews/' & Arguments.name & '/js/index.js');
				Application.System.Wrappers.include('/childViews/' & Arguments.name & '/index.cfm');
			} else {
				notFound = true;
				//if(len(Arguments.name) && Application.Settings.isMailAvailable) Application.Mail.send(to=Application.Settings.emailLists.Errors,subject='[#Application.Settings.serverId#] childView[' & Arguments.name & '] not found',msg='childView was missing[' & Arguments.name & '] in ContentObject module : function childView()',obj=Arguments);
			}
		}
	}

	public void function object(required struct Request, required string name, struct params) output="true" {
		Arguments.name = trim(Arguments.name);

		if(!structKeyExists(Arguments.Request,'objectParams')) Arguments.Request.objectParams = structNew();
		Arguments.Request.objectParams[Arguments.name] = structNew();

		if(structKeyExists(Arguments,'params')) {
			var item = "";
			for(item IN Arguments.params) Arguments.Request.params[name][item] = Arguments.params[item];
		}

		if(fileExists(Application.Settings.rootPath & 'contentObjects\' & Arguments.name & '\index.cfm')) {
			Application.System.css(Request=Arguments.Request,filename='contentObjects/' & Arguments.name & '/css/index.css');
			Application.System.js(Request=Arguments.Request,filename='contentObjects/' & Arguments.name & '/js/index.js');
			Application.System.Wrappers.include('/contentObjects/' & Arguments.name & '/index.cfm');
		} else {
			if(Application.Settings.isMailAvailable) Application.Mail.send(to=Application.Settings.emailLists.Errors,subject='[#Application.Settings.serverId#] contentObject not found',msg='contentObject was missing',obj=Arguments);
		}
	}

	public void function onMissingMethod(string methodName, any methodArguments) output="false" {
		if(Application.Settings.isMailAvailable) Application.Mail.send(to=Application.Settings.emailLists.Errors,subject='[#Application.Settings.serverId#] Missing Method Error',msg='There was a Missing Method error [#cgi.SERVER_NAME#]',obj=Arguments);
		return;
	}
}