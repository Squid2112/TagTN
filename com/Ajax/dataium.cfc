component displayname='DataiumAjaxComponent' hint='Component for dataium ajax requests' output="false" {

	remote string function exercise() output="true" returnformat='plain' {
		Application.mail.send(to='hostmaster@thixo.net',subject='Dataium Exercise Executed',msg='The Dataium exercise was executed',obj=session);
		var dataium = createObject('java','com.thixo.dataium.exercise').init('c:\websites\thixo.com\assets\dataium\CurrentTestInput.txt','c:\websites\thixo.com\assets\dataium\CurrentTestOutput.txt');
		return(fileRead('c:\websites\thixo.com\assets\dataium\CurrentTestOutput.txt','utf-8'));
	}

	remote string function getSource() output="true" returnformat='plain' {
		return(fileRead('c:\websites\thixo.com\assets\dataium\DataiumTest.java','utf-8'));
	}

}