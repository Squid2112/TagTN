component displayname="VisitorAjaxComponent" hint="Component for visitor ajax requests" output="false" {

	remote json function encodedJsonTest(required string data) output="true" returnformat="JSON" {
		var result = { status="ok" };

//		Application.Mail.send(to="hostmaster@thixo.net",subject="visitor Ajax test",obj=deserializeJson(Application.System.fromHexTrig(Arguments.data)));
return(Arguments);
		return(serializeJson(result));
	}

	remote string function dispatch(required string command) output="true" returnformat="plain" {
		var result = { status="ok", args=Arguments, directive="", option="", content="" };

		if(lCase(Arguments.command) EQ "recec1") {
			var q = new Query(dataSource=Application.Settings.DSN.System);
			q.addParam(name="Name",value=trim(Arguments.Name),cfSqlType="VARCHAR");
			q.addParam(name="Phone",value=trim(Arguments.Phone),cfSqlType="VARCHAR");
			q.addParam(name="eMail",value=trim(Arguments.eMail),cfSqlType="VARCHAR");
			var qResult = q.execute(sql="INSERT INTO EC1 (Name,Phone,eMail) VALUES (:Name,:Phone,:eMail)");

			return(serializeJson(result));
		}

		if(lCase(Arguments.command) EQ "recec2") {
			var q = new Query(dataSource=Application.Settings.DSN.System);
			q.addParam(name="Name",value=trim(Arguments.Name),cfSqlType="VARCHAR");
			q.addParam(name="Phone",value=trim(Arguments.Phone),cfSqlType="VARCHAR");
			q.addParam(name="eMail",value=trim(Arguments.eMail),cfSqlType="VARCHAR");
			var qResult = q.execute(sql="INSERT INTO EC2 (Name,Phone,eMail) VALUES (:Name,:Phone,:eMail)");

			return(serializeJson(result));
		}

		var directive = lcase(left(Arguments.command,3));
		var option = lcase(right(Arguments.command,len(Arguments.command)-3));
		var obj = "";

		switch(directive) {
			case "mnu" :
				switch(option) {
					case "home" :
						result.directive = directive;
						result.option = option;
						break;
					case "registration" :
						result.directive = directive;
						result.option = option;
						break;
					case "about" :
						result.directive = directive;
						result.option = option;
						break;
					case "contact" :
						result.directive = directive;
						result.option = option;
						break;
					
					default : break;
				}
				break;
				
			case "cop" :
				switch(option) {
					case "ec1" :
						result.directive = directive;
						result.option = option;
						break;
						
					case "ec2" :
						result.directive = directive;
						result.option = option;
						break;

					default : break;
				}
				break;
				
			default : break;
		}
		
		if((result.option != "") && fileExists(Application.Settings.rootPath & "contentObjects/pages/" & result.option & "/index.cfm")) {
			saveContent variable="result.content" {
				Application.System.include("/contentObjects/pages/" & result.option & "/index.cfm");
			}
		}
		return(serializeJson(result));
	}

	remote string function register() output="true" returnformat="plain" {
		var result = { status="error", args=Arguments, content="" };
		var regMsg = "";

		try {
			var name = "Greetings " & (structKeyExists(Arguments,"name") ? Arguments.name : "") & ", ";
		} catch(Any e) {
			if(Application.Settings.isMailAvailable) Application.Mail.send(to=Application.Settings.emailLists.Error,subject="TAGTN.com, ERROR processing registration",obj=e);
			result.status = "error";
			result.content = '<div style="color:##900;margin:5px 3px 0px 5px;line-height:14px;">We are sorry, there was an error processing your request!<br /><br />Please contact one of our representives found on our Contact Us page, or try again later.</div>';
			return(serializeJson(result));
		}

		try {
			saveContent variable="regMsg" {
				writeOutput("Full Name: " & Arguments.name & "<br />");
				writeOutput("Facebook Name: " & Arguments.fbname & "<br />");
				writeOutput("eMail: " & Arguments.email & "<br />");
				writeOutput("Telephone: " & Arguments.telephone & "<br />");
				writeOutput("Comment: " & Arguments.comment & "<br />");
			}
		} catch(Any e) {
			if(Application.Settings.isMailAvailable) Application.Mail.send(to=Application.Settings.emailLists.Error,subject="TAGTN.com, ERROR processing registration",obj=e);
			result.status = "error";
			result.content = '<div style="color:##900;margin:5px 3px 0px 5px;line-height:14px;">We are sorry, there was an error processing your request!<br /><br />Please contact one of our representives found on our Contact Us page, or try again later.</div>';
			return(serializeJson(result));
		}
		if(Application.Settings.isMailAvailable) Application.Mail.send(to=Application.Settings.emailLists.Info,subject="The ARK Global Team Network Registration",msg=regMsg);

		result.content = '<div style="color:##000;margin:5px 3px 0px 5px;line-height:14px;">' & name & "thank you for submitting your registration.<br /><br />An ARK Global Team Network representative will contact you as soon as possible</div>";
		return(serializeJson(result));
	}

	remote string function ping() output="true" returnformat="plain" {
		var result = { status="ok", args=Arguments };
		return(serializeJson(result));
	}

	public string function OnMissingMethod(required string MissingMethodName, required struct MissingMethodArguments) output="true" returnformat="plain" {
		if(Application.Settings.isMailAvailable) Application.Mail.send(to=Application.Settings.emailLists.Errors,subject="[#Application.Settings.serverId#] Missing Method Error",msg="There was a Missing Method error [#cgi.SERVER_NAME#]",obj=Arguments);
	}

}