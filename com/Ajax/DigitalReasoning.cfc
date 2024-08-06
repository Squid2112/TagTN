component displayname='DigitalReasoning' hint='Ajax component for processing data for Digital Reasoning Puzzle' output="true" {

	remote string function putString(required string data) output="false" returnformat='plain' {
		var result = 'UNIQUE';

		var ws = createObject('webservice','http://10.1.10.222:9010/ws/DigitalReasoning.cfc?wsdl');
		result = ws.putString(data=Arguments.data);
		
		return(result);
	}

	remote string function putFile(required string data) output="false" returnformat='plain' {
		var result = 'UNIQUE';

		var dataFile = "C:\\websites\\thixo.com\\assets\\DigitalReasoning\\" & Arguments.data;
		var ws = createObject('webservice','http://10.1.10.222:9010/ws/DigitalReasoning.cfc?wsdl');
		result = ws.putFile(data=dataFile);
		
		return(result);
	}

	remote string function getData() output="false" returnformat='plain' {
		var ws = createObject('webservice','http://10.1.10.222:9010/ws/DigitalReasoning.cfc?wsdl');
		result = ws.getData();

		return(serializeJson(listToArray(result,chr(10))));
	}

	remote string function getEnumData() output="false" returnformat='plain' {
		var ws = createObject('webservice','http://10.1.10.222:9010/ws/DigitalReasoning.cfc?wsdl');
		result = ws.getEnumData();

		return(serializeJson(listToArray(result,chr(10))));
	}

	remote string function emptyData() output="false" returnformat='plain' {
		fileDelete("C:\\db4o-data\\digitalReasoning.db4o");
		return("success");
	}

	remote string function getInfo() output="false" returnformat='plain' {
		var info = fileRead(Application.Settings.rootPath & "views\\DigitalReasoning\\info.cfm");
		return(info);
	}

}