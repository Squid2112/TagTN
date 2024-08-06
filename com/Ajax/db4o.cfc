component displayname='db4oAjaxComponent' hint='Component for db4o ajax requests' output="false" {

	remote string function getUri(required string value) output="true" returnformat='plain' {
		var myDb = new "com.db.db4o"('test23');
		var key = "";
		var val = trim(Arguments.value);
		
		if(listLen(Arguments.value,'=') == 2) {
			key = trim(listFirst(Arguments.value,'='));
			val = trim(listLast(Arguments.value,'='));
		}

		try {
			var test = createObject('java','com.thixo.db.url').init();
			myDb.db4o.soda.constrain(test.class);

			if(!len(trim(Arguments.value))) return(serializeJson(myDb.db4o.soda.execute()));

			try {
				if(len(key)) {
					myDb.db4o.soda.descend(key).constrain(val).endsWith(false);
				} else {
					myDb.db4o.soda.descend('uri').constrain(lcase(val));
				}
			} catch(Any e) {
				myDb.db4o.soda.constrain(test.class);
				return(serializeJson(myDb.db4o.soda.execute()));
			}
			return(serializeJson(myDb.db4o.soda.execute()));

		} catch(Any e) {
			return(serializeJson(e));
		} finally {
			myDb.db4o.db.close();
		}
	}

	remote string function onMissingMethod() output="true" returnformat='plain' {
		return('');
	}

}