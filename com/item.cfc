component displayname="item" hint="Fundraising item object" output="false"  {
	
	public any function init(required string title, string uri="") ouput="false" {
		this.title = Arguments.title;
		this.uri = Arguments.uri;
	}
}