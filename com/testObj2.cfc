component displayname="Obj2" hint="Test Obj2 Class" output="false" extends="com.testObj" {
	this.metaData = getMetaData(this);

	public any function init(required string title) output="false" {
		super.init(argumentCollection=Arguments);
		return(this);
	}
}