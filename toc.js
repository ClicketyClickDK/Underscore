
// http://www.siteforinfotech.com/2015/02/how-to-create-table-of-contents-using-javascript.html

//window.onload=function(){
function toc() {

	function getSelectedText(){
	if (window.getSelection)
		return window.getSelection().toString()+"<br/>"+document.URL;
	else if (document.selection)
		return document.selection.createRange().text+"<br/>"+document.URL;
	}

var toc=document.getElementById("TOC");
if(!toc) {
 toc=document.createElement("div");
 toc.id="TOC";
 document.body.insertBefore(toc, document.body.firstChild);
}
var headings;
if (document.querySelectorAll) 
headings=document.querySelectorAll("h1, h2, h3, h4, h5, h6");
else
headings=findHeadings(document.body, []);

	function findHeadings(root, sects){
	 for(var c=root.firstChild; c!=null; c=c.nextSibling){
	if (c.nodeType!==1) continue;
	if (c.tagName.length==2 && c.tagName.charAt(0)=="H")
	sects.push(c);
	else
	findHeadings(c, sects);
	}
	return sects;
	}

var sectionNumbers=[0,0,0,0,0,0];

for(var h=0; h<headings.length; h++) {
 var heading=headings[h];

if(heading.parentNode==toc) continue;

var level=parseInt(heading.tagName.charAt(1));
if (isNaN(level)||level<1||level>6) continue;

sectionNumbers[level-1]++;
for(var i=level; i<6; i++) sectionNumbers[i]=0;

var sectionNumber=sectionNumbers.slice(0, level).join(".");


var span=document.createElement("span");
span.className="TOCSectNum";
span.innerHTML= "<a href='#TOC1'>" + sectionNumber + "</a>";
heading.insertBefore(span, heading.firstChild);

/*
var anchor0=document.createElement("a");
heading.parentNode.insertBefore(anchor0, heading);
anchor0.appendChild(heading);

var link0=document.createElement("a");
link0.href="#TOC1"; 
link0.innerHTML="xxx";

entry.appendChild(link0);
*/



heading.id="TOC"+sectionNumber;


var anchor=document.createElement("a");
heading.parentNode.insertBefore(anchor, heading);
anchor.appendChild(heading);

var link=document.createElement("a");
link.href="#TOC"+sectionNumber; 
link.innerHTML=heading.innerHTML;


/*
var anchor0=document.createElement("a");
heading.parentNode.insertBefore(anchor0, heading);
anchor0.appendChild(heading);

var link0=document.createElement("a");
link0.href="#TOC1"; 
link0.innerHTML="xxx";
*/


var entry=document.createElement("div");
entry.className="TOCEntry TOCLevel" + level;
entry.appendChild(link);
/*
entry.appendChild(link0);
*/
toc.appendChild(entry);
}
};
