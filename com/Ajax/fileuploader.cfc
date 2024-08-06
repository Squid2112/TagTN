component displayname='fileUploader' hint='Component for Ajax file uploading' output="false" {

	remote string function upload(required string path, required string qqfile) output="true" returnformat='plain' {
		var requestData = GetHttpRequestData();

		if(len(requestData.content) > 0) {
			fileWrite(Application.Settings.rootPath & replace(Arguments.path,'/','\','ALL') & '\' & Arguments.qqfile, requestData.content);
			var result = { success=true, type='xhr' };
		} else {
			fileUpload(Application.Settings.rootPath & Arguments.path, '', 'overwrite', Arguments.qqfile);
			var result = { success=true, type='form' };
		}
		return(serializeJSON(result));
	}

	private struct function uploadFileXhr(required string path, required string qqfile, required any content) output="false" {
		var result = { success=true, type='xhr' };

		fileWrite(Application.Settings.rootPath & replace(Arguments.path,'/','\','ALL') & '\' & Arguments.qqfile, Arguments.content);
		return(result);
	}

}