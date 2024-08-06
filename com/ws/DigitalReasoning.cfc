component displayname='DigitalReasoning' bindingname='myns:DigitalReasoning' namespace='http://127.0.0.1:9010/ws/DigitalReasoning' style='document' hint='Web service for processing puzzle by Digital Reasoning' output="false" {

	remote string function putString(required string data) output="false" {
		var result = 'WEB SERVICE';

		return(result);
	}

}