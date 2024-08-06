component displayname="db4oObject" hint="db4o wrapper component" output="false" {

	public any function init(string dsn=Application.Settings.DSN.System) output="false" {
		this.db4o = createObject("java","com.thixo.db.db4o").init(listFirst(Application.Settings.rootPath,":") & ":/db4o-data/" & Arguments.dsn & ".db4o");

		return(this);
	}

}