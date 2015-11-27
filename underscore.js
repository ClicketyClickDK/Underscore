//window.onload=function(){


function latestUpdate() {
	var fdate	= new Date(document.lastModified);
	document.getElementById("latestUpdate").innerHTML = fdate.toISOString();
}
