component displayname='SmartyCamAjaxComponent' hint='Component for SmartyCam ajax requests' output="false" {

	remote string function getFileList() output="true" returnformat='plain' {
		var result = { status='ok' };
		var dir = directoryList(Application.Settings.rootPath & 'assets\SmartyCam',false,'name','*.csv','datelastmodified desc');
		var result = "";

		for(var i=1; i <= arrayLen(dir); i++) result &= '<a class="fileLink" href="/assets/SmartyCam/' & dir[i] & '">' & dir[i] & '</a><br />';
		return(result);
	}

	remote string function processFile(required string filename) output="true" returnformat='plain' {
		var test = createObject('java','com.thixo.util.BinaryFile').init(Application.Settings.rootPath & 'assets\SmartyCam\' & Arguments.filename,'r');
		test.setSigned(true);

		var blockSize = 66;
		var header = {
			Sync = javaCast('double',0),
			Version = javaCast('byte',0),
			FileVer = javaCast('byte',0),
			Channel = javaCast('byte',0),
			EventType = javaCast('byte',0),
			MediaType = javaCast('byte',0),
			Code = javaCast('byte',0),
			FrameTotal = javaCast('double',0),
			Reserved1 = javaCast('int',0),
			Reserved2 = javaCast('int',0),
			Reserved3 = javaCast('int',0),
			Reserved4 = javaCast('int',0)
		};

		var sSensorVal = {
			sx = javaCast('int',0),
			sy = javaCast('int',0),
			sz = javaCast('int',0)
		};

		var sGpsVal = {
			yValid = javaCast('byte',0),
			Latitude = javaCast('double',0),
			Longitude = javaCast('double',0),
			Speed = javaCast('int',0),
			Hmsl = javaCast('int',0),
			Heading =  javaCast('int',0)
		};
	
		var frameInfoVideo = {
			Sync = javaCast('int',0),
			Version = javaCast('byte',0),
			Offset = javaCast('int',0),
			Size = javaCast('int',0),
			Capture = javaCast('int',0),
			FrameType = javaCast('byte',0),
			RecFileType = javaCast('byte',0),
			SensorVal = sSensorVal,  //  .. 6 bytes?
			GpsVal = sGpsVal,  // 33 bytes?
			Reserved1 = javaCast('int',0),
			Reserved2 = javaCast('byte',0)
		};

		var vdx = fileReadBinary(Application.Settings.rootPath & 'assets\SmartyCam\' & Arguments.filename);
		if(listLen(Arguments.filename,',')) Arguments.filename = listDeleteAt(Arguments.filename,1,',');
		if(listLen(Arguments.filename,'.')) Arguments.filename = listDeleteAt(Arguments.filename,listLen(Arguments.filename,'.'),'.');
		var outFile = fileOpen(Application.Settings.rootPath & 'assets\SmartyCam\out-' & replace(Arguments.filename,',','-','ALL') & '.csv','write');
		fileWriteLine(outFile,'Frame,Speed,sX,sY,sZ');

		var vdxLen = arrayLen(vdx);
		var vdxHeaderStart = 66 * (vdxLen \ 66);
		var frame = 0;

		for(var idx=0; idx < vdxHeaderStart-1; idx += 66) {
			frame++;
	
			frameInfoVideo.Sync = test.readDWord();
			frameInfoVideo.Version = test.readByte();
			frameInfoVideo.Offset = test.readDWord();
			frameInfoVideo.Size = test.readDWord();
	
			frameInfoVideo.Capture = test.readFixedString(16);
	
			frameInfoVideo.FrameType = test.readByte();
			frameInfoVideo.RecFileType = test.readByte();
	
			frameInfoVideo.SensorVal.sx = javaCast('int',test.readWord());
			frameInfoVideo.SensorVal.sy = javaCast('int',test.readWord());
			frameInfoVideo.SensorVal.sz = javaCast('int',test.readWord());
	
			frameInfoVideo.GpsVal.yValid = test.readByte();
			frameInfoVideo.GpsVal.Latitude = test.readDouble();
			frameInfoVideo.GpsVal.Longitude = test.readDouble();
			frameInfoVideo.GpsVal.Speed = test.readWord();
			frameInfoVideo.GpsVal.Hmsl = test.readWord();
			frameInfoVideo.GpsVal.Heading = test.readWord();
	
			frameInfoVideo.Reserved1 = test.readWord();
			frameInfoVideo.Reserved2 = test.readDWord();
	
			dataLine = frame&','&frameInfoVideo.GpsVal.Speed&','&frameInfoVideo.SensorVal.sX&','&frameInfoVideo.SensorVal.sY&','&frameInfoVideo.SensorVal.sZ;
			fileWriteLine(outFile,dataLine);
		}
		fileClose(outFile);
		test.fileClose();
		
		var result = { status='ok' };
		return(serializeJson(result));
	}

	remote string function ping() output="true" returnformat='plain' {
		var result = { status='ok' };
		return(serializeJson(result));
	}

}