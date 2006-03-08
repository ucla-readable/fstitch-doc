var YAHOO=function(){
return{
util:{},
widget:{},
example:{},
namespace: function(sNameSpace){
if(!sNameSpace || !sNameSpace.length){
return null}
var levels=sNameSpace.split(".")
var currentNS=YAHOO
for(var i=(levels[0]=="YAHOO")? 1 : 0;i<levels.length;++i){
currentNS[levels[i]]=currentNS[levels[i]] ||{}
currentNS=currentNS[levels[i]]}
return currentNS}}
}()
YAHOO.util.Connect={}
YAHOO.util.Connect={
_msxml_progid:[
'MSXML2.XMLHTTP.5.0',
'MSXML2.XMLHTTP.4.0',
'MSXML2.XMLHTTP.3.0',
'MSXML2.XMLHTTP',
'Microsoft.XMLHTTP'
],
_http_header:[],
_isFormPost:false,
_sFormData:null,
_polling_interval:300,
_transaction_id:0,
setProgId:function(id){
this.msxml_progid.unshift(id)
},
createXhrObject:function(transactionId){
var obj,http
try{
http=new XMLHttpRequest()
obj={conn:http,tId:transactionId}}
catch(e){
for(var i=0;i<this._msxml_progid.length;++i){
try{
http=new ActiveXObject(this._msxml_progid[i])
obj={conn:http,tId:transactionId}}
catch(e){}}}
finally{
return obj}
},
getConnectionObject:function(){
var o
var tId=this._transaction_id
try{
o=this.createXhrObject(tId)
if(o){
this._transaction_id++}}
catch(e){}
finally{
return o}
},
asyncRequest:function(method,uri,callback,postData){
var errorObj
var o=this.getConnectionObject()
if(!o){
return null}
else{
var oConn=this
o.conn.open(method,uri,true)
this.handleReadyState(o,callback)
if(this._isFormPost){
postData=this._sFormData
this._isFormPost=false}
else if(postData){
this.initHeader('Content-Type','application/x-www-form-urlencoded')}
if(this._http_header.length>0){
this.setHeader(o)}
postData?o.conn.send(postData):o.conn.send(null)
return o}
},
handleReadyState:function(o,callback){
var oConn=this
var poll=window.setInterval(
function(){
if(o.conn.readyState==4){
oConn.handleTransactionResponse(o,callback)
window.clearInterval(poll)}}
,this._polling_interval)
},
handleTransactionResponse:function(o,callback){
var httpStatus
var responseObject
try{
httpStatus=o.conn.status}
catch(e){
httpStatus=13030}
if(httpStatus==200){
responseObject=this.createResponseObject(o,callback.argument)
if(callback.success){
if(!callback.scope){
callback.success(responseObject)}
else{
callback.success.apply(callback.scope,[responseObject])}}}
else{
switch(httpStatus){
case 12002:
case 12029:
case 12030:
case 12031:
case 12152:
case 13030:
responseObject=this.createExceptionObject(o,callback.argument)
if(callback.failure){
if(!callback.scope){
callback.failure(responseObject)}
else{
callback.failure.apply(callback.scope,[responseObject])}}
break
default:
responseObject=this.createResponseObject(o,callback.argument)
if(callback.failure){
if(!callback.scope){
callback.failure(responseObject)}
else{
callback.failure.apply(callback.scope,[responseObject])}}}}
this.releaseObject(o)
},
createResponseObject:function(o,callbackArg){
var obj={}
obj.tId=o.tId
obj.status=o.conn.status
obj.statusText=o.conn.statusText
obj.allResponseHeaders=o.conn.getAllResponseHeaders()
obj.responseText=o.conn.responseText
obj.responseXML=o.conn.responseXML
if(callbackArg){
obj.argument=callbackArg}
return obj
},
createExceptionObject:function(tId,callbackArg){
var COMM_CODE=0
var COMM_ERROR='communication failure'
var obj={}
obj.tId=tId
obj.status=COMM_CODE
obj.statusText=COMM_ERROR
if(callbackArg){
obj.argument=callbackArg}
return obj
},
initHeader:function(label,value){
var oHeader=[label,value]
this._http_header.push(oHeader)
},
setHeader:function(o){
var oHeader=this._http_header
for(var i=0;i<oHeader.length;i++){
o.conn.setRequestHeader(oHeader[i][0],oHeader[i][1])}
oHeader.splice(0,oHeader.length)
},
setForm:function(formName){
this._sFormData=''
var oForm=document.forms[formName]
var oElement,elName,elValue
for(var i=0;i<oForm.elements.length;i++){
oElement=oForm.elements[i]
elName=oForm.elements[i].name
elValue=oForm.elements[i].value
switch(oElement.type){
case 'select-multiple':
for(var j=0;j<oElement.options.length;j++){
if(oElement.options[j].selected){
this._sFormData+=encodeURIComponent(elName)+'='+encodeURIComponent(oElement.options[j].value)+'&'}}
break
case 'radio':
case 'checkbox':
if(oElement.checked){
this._sFormData+=encodeURIComponent(elName)+'='+encodeURIComponent(elValue)+'&'}
break
case 'file':
break
case undefined:
break
default:
this._sFormData+=encodeURIComponent(elName)+'='+encodeURIComponent(elValue)+'&'
break}}
this._sFormData=this._sFormData.substr(0,this._sFormData.length-1)
this._isFormPost=true
this.initHeader('Content-Type','application/x-www-form-urlencoded')
},
abort:function(o){
if(this.isCallInProgress(o)){
o.conn.abort()
this.releaseObject(o)}
},
isCallInProgress:function(o){
if(o){
return o.conn.readyState !=4&&o.conn.readyState !=0}
},
releaseObject:function(o){
o.conn=null
o=null}}
YAHOO.util.Dom=new function(){
this.get=function(el){
if(typeof el=='string'){
el=document.getElementById(el)}
return el}
this.getStyle=function(el,property){
var value=null
var dv=document.defaultView
el=this.get(el)
if(property=='opacity'&&el.filters){
value=1
try{
value=el.filters.item('DXImageTransform.Microsoft.Alpha').opacity/100
}catch(e){
try{
value=el.filters.item('alpha').opacity/100
}catch(e){}}}
else if(el.style[property]){
value=el.style[property]}
else if(el.currentStyle&&el.currentStyle[property]){
value=el.currentStyle[property]}
else if(dv&&dv.getComputedStyle){
var converted=''
for(i=0,len=property.length;i<len;++i){
if(property.charAt(i)==property.charAt(i).toUpperCase()){
converted=converted+'-'+property.charAt(i).toLowerCase()
}else{
converted=converted+property.charAt(i)}}
if(dv.getComputedStyle(el,'').getPropertyValue(converted)){
value=dv.getComputedStyle(el,'').getPropertyValue(converted)}}
return value}
this.setStyle=function(el,property,val){
el=this.get(el)
switch(property){
case 'opacity' :
if(el.filters){
el.style.filter='alpha(opacity='+val*100+')'
if(!el.currentStyle.hasLayout){
el.style.zoom=1}
}else{
el.style.opacity=val
el.style['-moz-opacity']=val
el.style['-khtml-opacity']=val}
break
default :
el.style[property]=val}}
this.getXY=function(el){
el=this.get(el)
if(el.parentNode===null || this.getStyle(el,'display')=='none'){
return false}
var parent=null
var pos=[]
var box
if(el.getBoundingClientRect){
box=el.getBoundingClientRect()
var scrollTop=document.documentElement.scrollTop || document.body.scrollTop
var scrollLeft=document.documentElement.scrollLeft || document.body.scrollLeft
return [box.left+scrollLeft,box.top+scrollTop]}
else if(document.getBoxObjectFor){
box=document.getBoxObjectFor(el)
pos=[box.x,box.y]}
else{
pos=[el.offsetLeft,el.offsetTop]
parent=el.offsetParent
if(parent !=el){
while(parent){
pos[0]+=parent.offsetLeft
pos[1]+=parent.offsetTop
parent=parent.offsetParent}}
var ua=navigator.userAgent.toLowerCase()
if(
ua.indexOf('opera')!=-1
||(ua.indexOf('safari')!=-1&&this.getStyle(el,'position')=='absolute')
){
pos[1]-=document.body.offsetTop}}
if(el.parentNode){parent=el.parentNode;}
else{parent=null;}
while(parent&&parent.tagName !='BODY'&&parent.tagName !='HTML'){
pos[0]-=parent.scrollLeft
pos[1]-=parent.scrollTop
if(parent.parentNode){parent=parent.parentNode;}
else{parent=null;}}
return pos}
this.getX=function(el){
return this.getXY(el)[0]}
this.getY=function(el){
return this.getXY(el)[1]}
this.setXY=function(el,pos,noRetry){
el=this.get(el)
var pageXY=YAHOO.util.Dom.getXY(el)
if(pageXY===false){return false;}
if(this.getStyle(el,'position')=='static'){
this.setStyle(el,'position','relative')}
var delta=[
parseInt(YAHOO.util.Dom.getStyle(el,'left'),10),
parseInt(YAHOO.util.Dom.getStyle(el,'top'),10)
]
if(isNaN(delta[0])){delta[0]=0;}
if(isNaN(delta[1])){delta[1]=0;}
if(pos[0] !==null){el.style.left=pos[0]-pageXY[0]+delta[0]+'px';}
if(pos[1] !==null){el.style.top=pos[1]-pageXY[1]+delta[1]+'px';}
var newXY=this.getXY(el)
if(!noRetry&&(newXY[0] !=pos[0] || newXY[1] !=pos[1])){
this.setXY(el,pos,true)}
return true}
this.setX=function(el,x){
return this.setXY(el,[x,null])}
this.setY=function(el,y){
return this.setXY(el,[null,y])}
this.getRegion=function(el){
el=this.get(el)
return new YAHOO.util.Region.getRegion(el)}
this.getClientWidth=function(){
return(
document.documentElement.offsetWidth
|| document.body.offsetWidth
)}
this.getClientHeight=function(){
return(
self.innerHeight
|| document.documentElement.clientHeight
|| document.body.clientHeight
)}}
YAHOO.util.Region=function(t,r,b,l){
this.top=t
this.right=r
this.bottom=b
this.left=l}
YAHOO.util.Region.prototype.contains=function(region){
return(region.left>=this.left&&
region.right<=this.right&&
region.top>=this.top&&
region.bottom<=this.bottom)}
YAHOO.util.Region.prototype.getArea=function(){
return((this.bottom-this.top)*(this.right-this.left))}
YAHOO.util.Region.prototype.intersect=function(region){
var t=Math.max(this.top,region.top)
var r=Math.min(this.right,region.right)
var b=Math.min(this.bottom,region.bottom)
var l=Math.max(this.left,region.left)
if(b>=t&&r>=l){
return new YAHOO.util.Region(t,r,b,l)
}else{
return null}}
YAHOO.util.Region.prototype.union=function(region){
var t=Math.min(this.top,region.top)
var r=Math.max(this.right,region.right)
var b=Math.max(this.bottom,region.bottom)
var l=Math.min(this.left,region.left)
return new YAHOO.util.Region(t,r,b,l)}
YAHOO.util.Region.prototype.toString=function(){
return("Region {"+
"  t: "+this.top+
", r: "+this.right+
", b: "+this.bottom+
", l: "+this.left+
"}")}
YAHOO.util.Region.getRegion=function(el){
var p=YAHOO.util.Dom.getXY(el)
var t=p[1]
var r=p[0]+el.offsetWidth
var b=p[1]+el.offsetHeight
var l=p[0]
return new YAHOO.util.Region(t,r,b,l)}
YAHOO.util.Point=function(x,y){
this.x=x
this.y=y
this.top=y
this.right=x
this.bottom=y
this.left=x}
YAHOO.util.Point.prototype=new YAHOO.util.Region()
YAHOO.util.CustomEvent=function(type,oScope){
this.type=type
this.scope=oScope || window
this.subscribers=[]
if(YAHOO.util["Event"]){
YAHOO.util.Event.regCE(this)}}
YAHOO.util.CustomEvent.prototype={
subscribe: function(fn,obj,bOverride){
this.subscribers.push(new YAHOO.util.Subscriber(fn,obj,bOverride))
},
unsubscribe: function(fn,obj){
var found=false
for(var i=0;i<this.subscribers.length;++i){
var s=this.subscribers[i]
if(s&&s.contains(fn,obj)){
this._delete(i)
found=true}}
return found
},
fire: function(){
for(var i=0;i<this.subscribers.length;++i){
var s=this.subscribers[i]
if(s){
var scope=(s.override)? s.obj : this.scope
s.fn.call(scope,this.type,arguments,s.obj)}}
},
unsubscribeAll: function(){
for(var i=0;i<this.subscribers.length;++i){
this._delete(i)}
},
_delete: function(index){
var s=this.subscribers[index]
if(s){
delete s.fn
delete s.obj}
delete this.subscribers[index]}}
YAHOO.util.Subscriber=function(fn,obj,bOverride){
this.fn=fn
this.obj=obj || null
this.override=(bOverride)}
YAHOO.util.Subscriber.prototype.contains=function(fn,obj){
return(this.fn==fn&&this.obj==obj)}
if(!YAHOO.util.Event){
YAHOO.util.Event=function(){
var loadComplete=false
var listeners=[]
var delayedListeners=[]
var unloadListeners=[]
var customEvents=[]
var legacyEvents=[]
var legacyHandlers=[]
return{
EL: 0,
TYPE: 1,
FN: 2,
WFN: 3,
SCOPE: 3,
ADJ_SCOPE: 4,
isSafari:(navigator.userAgent.match(/safari/gi)),
isIE:(!this.isSafari&&navigator.userAgent.match(/msie/gi)),
addListener: function(el,sType,fn,oScope,bOverride){
if(this._isValidCollection(el)){
var ok=true
for(var i=0;i<el.length;++i){
ok=(this.on(el[i],
sType,
fn,
oScope,
bOverride)&&ok)}
return ok
}else if(typeof el=="string"){
if(loadComplete){
el=this.getEl(el)
}else{
delayedListeners[delayedListeners.length]=
[el,sType,fn,oScope,bOverride]
return true}}
if(!el){
return false}
if("unload"==sType&&oScope !==this){
unloadListeners[unloadListeners.length]=
[el,sType,fn,oScope,bOverride]
return true}
var scope=(bOverride)? oScope : el
var wrappedFn=function(e){
return fn.call(scope,YAHOO.util.Event.getEvent(e),
oScope)}
var li=[el,sType,fn,wrappedFn,scope]
var index=listeners.length
listeners[index]=li
if(this.useLegacyEvent(el,sType)){
var legacyIndex=this.getLegacyIndex(el,sType)
if(legacyIndex==-1){
legacyIndex=legacyEvents.length
legacyEvents[legacyIndex]=
[el,sType,el["on"+sType]]
legacyHandlers[legacyIndex]=[]
el["on"+sType]=
function(e){
YAHOO.util.Event.fireLegacyEvent(
YAHOO.util.Event.getEvent(e),legacyIndex)}}
legacyHandlers[legacyIndex].push(index)
}else if(el.addEventListener){
el.addEventListener(sType,wrappedFn,false)
}else if(el.attachEvent){
el.attachEvent("on"+sType,wrappedFn)}
return true
},
fireLegacyEvent: function(e,legacyIndex){
var ok=true
var le=legacyHandlers[legacyIndex]
for(i=0;i<le.length;++i){
var index=le[i]
if(index){
var li=listeners[index]
var scope=li[this.ADJ_SCOPE]
var ret=li[this.WFN].call(scope,e)
ok=(ok&&ret)}}
return ok
},
getLegacyIndex: function(el,sType){
for(var i=0;i<legacyEvents.length;++i){
var le=legacyEvents[i]
if(le&&le[0]==el&&le[1]==sType){
return i}}
return-1
},
useLegacyEvent: function(el,sType){
return((!el.addEventListener&&!el.attachEvent)||
(sType=="click"&&this.isSafari))
},
removeListener: function(el,sType,fn){
if(typeof el=="string"){
el=this.getEl(el)
}else if(this._isValidCollection(el)){
var ok=true
for(var i=0;i<el.length;++i){
ok=(this.removeListener(el[i],sType,fn)&&ok)}
return ok}
var cacheItem=null
var index=this._getCacheIndex(el,sType,fn)
if(index>=0){
cacheItem=listeners[index]}
if(!el || !cacheItem){
return false}
if(el.removeEventListener){
el.removeEventListener(sType,cacheItem[this.WFN],false)
}else if(el.detachEvent){
el.detachEvent("on"+sType,cacheItem[this.WFN])}
delete listeners[index][this.WFN]
delete listeners[index][this.FN]
delete listeners[index]
return true
},
getTarget: function(ev,resolveTextNode){
var t=ev.target || ev.srcElement
if(resolveTextNode&&t&&"#text"==t.nodeName){
return t.parentNode
}else{
return t}
},
getPageX: function(ev){
var x=ev.pageX
if(!x&&0 !==x){
x=ev.clientX || 0
if(this.isIE){
x+=this._getScrollLeft()}}
return x
},
getPageY: function(ev){
var y=ev.pageY
if(!y&&0 !==y){
y=ev.clientY || 0
if(this.isIE){
y+=this._getScrollTop()}}
return y
},
getRelatedTarget: function(ev){
var t=ev.relatedTarget
if(!t){
if(ev.type=="mouseout"){
t=ev.toElement
}else if(ev.type=="mouseover"){
t=ev.fromElement}}
return t
},
getTime: function(ev){
if(!ev.time){
var t=new Date().getTime()
try{
ev.time=t
}catch(e){
return t}}
return ev.time
},
stopEvent: function(ev){
this.stopPropagation(ev)
this.preventDefault(ev)
},
stopPropagation: function(ev){
if(ev.stopPropagation){
ev.stopPropagation()
}else{
ev.cancelBubble=true}
},
preventDefault: function(ev){
if(ev.preventDefault){
ev.preventDefault()
}else{
ev.returnValue=false}
},
getEvent: function(e){
var ev=e || window.event
if(!ev){
var c=this.getEvent.caller
while(c){
ev=c.arguments[0]
if(ev&&Event==ev.constructor){
break}
c=c.caller}}
return ev
},
getCharCode: function(ev){
return ev.charCode ||(ev.type=="keypress")? ev.keyCode : 0
},
_getCacheIndex: function(el,sType,fn){
for(var i=0;i<listeners.length;++i){
var li=listeners[i]
if(li&&
li[this.FN]==fn&&
li[this.EL]==el&&
li[this.TYPE]==sType){
return i}}
return-1
},
_isValidCollection: function(o){
return(o&&
o.length&&
typeof o !="string"&&
!o.tagName&&
!o.alert&&
typeof o[0] !="undefined")
},
elCache:{},
getEl: function(id){
return document.getElementById(id)
},
clearCache: function(){
for(i in this.elCache){
delete this.elCache[i]}
},
regCE: function(ce){
customEvents.push(ce)
},
_load: function(e){
loadComplete=true
},
_tryPreloadAttach: function(){
var tryAgain=!loadComplete
for(var i=0;i<delayedListeners.length;++i){
var d=delayedListeners[i]
if(d){
var el=this.getEl(d[this.EL])
if(el){
this.on(el,d[this.TYPE],d[this.FN],
d[this.SCOPE],d[this.ADJ_SCOPE])
delete delayedListeners[i]}}}
if(tryAgain){
setTimeout("YAHOO.util.Event._tryPreloadAttach()",50)}
},
_unload: function(e,me){
for(var i=0;i<unloadListeners.length;++i){
var l=unloadListeners[i]
if(l){
var scope=(l[this.ADJ_SCOPE])? l[this.SCOPE]: window
l[this.FN].call(scope,this.getEvent(e),l[this.SCOPE])}}
if(listeners&&listeners.length>0){
for(i=0;i<listeners.length;++i){
l=listeners[i]
if(l){
this.removeListener(l[this.EL],l[this.TYPE],
l[this.FN])}}
this.clearCache()}
for(i=0;i<customEvents.length;++i){
customEvents[i].unsubscribeAll()
delete customEvents[i]}
for(i=0;i<legacyEvents.length;++i){
delete legacyEvents[i][0]
delete legacyEvents[i]}
},
_getScrollLeft: function(){
return this._getScroll()[1]
},
_getScrollTop: function(){
return this._getScroll()[0]
},
_getScroll: function(){
var dd=document.documentElement;db=document.body
if(dd&&dd.scrollTop){
return [dd.scrollTop,dd.scrollLeft]
}else if(db){
return [db.scrollTop,db.scrollLeft]
}else{
return [0,0]}}}
}()
YAHOO.util.Event.on=YAHOO.util.Event.addListener
if(document&&document.body){
YAHOO.util.Event._load()
}else{
YAHOO.util.Event.on(window,"load",YAHOO.util.Event._load,
YAHOO.util.Event,true)}
YAHOO.util.Event.on(window,"unload",YAHOO.util.Event._unload,
YAHOO.util.Event,true)
YAHOO.util.Event._tryPreloadAttach()}
YAHOO.util.DragDrop=function(id,sGroup){
if(id){
this.init(id,sGroup)}}
YAHOO.util.DragDrop.prototype={
id: null,
dragElId: null,
handleElId: null,
invalidHandleTypes: null,
startPageX: 0,
startPageY: 0,
groups: null,
locked: false,
lock: function(){this.locked=true;},
unlock: function(){this.locked=false;},
isTarget: true,
padding: null,
_domRef: null,
__ygDragDrop: true,
constrainX: false,
constrainY: false,
minX: 0,
maxX: 0,
minY: 0,
maxY: 0,
maintainOffset: false,
xTicks: null,
yTicks: null,
primaryButtonOnly: true,
b4StartDrag: function(x,y){},
startDrag: function(x,y){},
b4Drag: function(e){},
onDrag: function(e){},
onDragEnter: function(e,id){},
b4DragOver: function(e){},
onDragOver: function(e,id){},
b4DragOut: function(e){},
onDragOut: function(e,id){},
b4DragDrop: function(e){},
onDragDrop: function(e,id){},
b4EndDrag: function(e){},
endDrag: function(e){},
b4MouseDown: function(e){},
onMouseDown: function(e){},
onMouseUp: function(e){},
getEl: function(){
if(!this._domRef){
this._domRef=this.DDM.getElement(this.id)}
return this._domRef
},
getDragEl: function(){
return this.DDM.getElement(this.dragElId)
},
init: function(id,sGroup){
this.initTarget(id,sGroup)
YAHOO.util.Event.addListener(id,"mousedown",
this.handleMouseDown,this,true)
},
initTarget: function(id,sGroup){
this.DDM=YAHOO.util.DDM
this.padding=[0,0,0,0]
this.groups={}
this.id=id
this.setDragElId(id)
this.invalidHandleTypes={a : "a"}
this.handleElId=id
if(document&&document.body){
this.setInitPosition()}
this.addToGroup((sGroup)? sGroup : "default")
},
setPadding: function(iTop,iRight,iBot,iLeft){
if(!iRight&&0 !==iRight){
this.padding=[iTop,iTop,iTop,iTop]
}else if(!iBot&&0 !==iBot){
this.padding=[iTop,iRight,iTop,iRight]
}else{
this.padding=[iTop,iRight,iBot,iLeft]}
},
setInitPosition: function(diffX,diffY){
var el=this.getEl()
if(!this.DDM.verifyEl(el)){
return}
var dx=diffX || 0
var dy=diffY || 0
var p=YAHOO.util.Dom.getXY(el)
this.initPageX=p[0]-dx
this.initPageY=p[1]-dy
this.lastPageX=p[0]
this.lastPageY=p[1]
this.setStartPosition(p)
},
setStartPosition: function(pos){
var p=pos || YAHOO.util.Dom.getXY(this.getEl())
this.startPageX=p[0]
this.startPageY=p[1]
},
addToGroup: function(sGroup){
this.groups[sGroup]=true
this.DDM.regDragDrop(this,sGroup)
},
setDragElId: function(id){
this.dragElId=id
},
setHandleElId: function(id){
this.handleElId=id
this.DDM.regHandle(this.id,id)
},
setOuterHandleElId: function(id){
YAHOO.util.Event.addListener(id,"mousedown",
this.handleMouseDown,this,true)
this.setHandleElId(id)
},
unreg: function(){
YAHOO.util.Event.removeListener(this.id,"mousedown",
this.handleMouseDown)
this._domRef=null
this.DDM._remove(this)
},
isLocked: function(){
return(this.DDM.isLocked()|| this.locked)
},
handleMouseDown: function(e,oDD){
var EU=YAHOO.util.Event
var button=e.which || e.button
if(this.primaryButtonOnly&&button>1){
return}
if(this.isLocked()){
return}
this.DDM.refreshCache(this.groups)
var pt=new YAHOO.util.Point(EU.getPageX(e),EU.getPageY(e))
if(this.DDM.isOverTarget(pt,this)){
var srcEl=EU.getTarget(e)
if(this.isValidHandleChild(srcEl)&&
(this.id==this.handleElId ||
this.DDM.handleWasClicked(srcEl,this.id))){
this.setStartPosition()
this.b4MouseDown(e)
this.onMouseDown(e)
this.DDM.handleMouseDown(e,this)
this.DDM.stopEvent(e)}}
},
addInvalidHandleType: function(tagName){
var type=tagName.toUpperCase()
this.invalidHandleTypes[type]=type
},
removeInvalidHandleType: function(tagName){
var type=tagName.toUpperCase()
this.invalidHandleTypes[type]=null
},
isValidHandleChild: function(node){
var type=node.nodeName
if(type=="#text"){
type=node.parentNode.nodeName}
return(!this.invalidHandleTypes[type])
},
setXTicks: function(iStartX,iTickSize){
this.xTicks=[]
this.xTickSize=iTickSize
var tickMap={}
for(var i=this.initPageX;i>=this.minX;i=i-iTickSize){
if(!tickMap[i]){
this.xTicks[this.xTicks.length]=i
tickMap[i]=true}}
for(i=this.initPageX;i<=this.maxX;i=i+iTickSize){
if(!tickMap[i]){
this.xTicks[this.xTicks.length]=i
tickMap[i]=true}}
this.xTicks.sort(this.DDM.numericSort)
},
setYTicks: function(iStartY,iTickSize){
this.yTicks=[]
this.yTickSize=iTickSize
var tickMap={}
for(var i=this.initPageY;i>=this.minY;i=i-iTickSize){
if(!tickMap[i]){
this.yTicks[this.yTicks.length]=i
tickMap[i]=true}}
for(i=this.initPageY;i<=this.maxY;i=i+iTickSize){
if(!tickMap[i]){
this.yTicks[this.yTicks.length]=i
tickMap[i]=true}}
this.yTicks.sort(this.DDM.numericSort)
},
setXConstraint: function(iLeft,iRight,iTickSize){
this.leftConstraint=iLeft
this.rightConstraint=iRight
this.minX=this.initPageX-iLeft
this.maxX=this.initPageX+iRight
if(iTickSize){this.setXTicks(this.initPageX,iTickSize);}
this.constrainX=true
},
setYConstraint: function(iUp,iDown,iTickSize){
this.topConstraint=iUp
this.bottomConstraint=iDown
this.minY=this.initPageY-iUp
this.maxY=this.initPageY+iDown
if(iTickSize){this.setYTicks(this.initPageY,iTickSize);}
this.constrainY=true
},
resetConstraints: function(){
var dx=(this.maintainOffset)? this.lastPageX-this.initPageX : 0
var dy=(this.maintainOffset)? this.lastPageY-this.initPageY : 0
this.setInitPosition(dx,dy)
if(this.constrainX){
this.setXConstraint(this.leftConstraint,
this.rightConstraint,
this.xTickSize)}
if(this.constrainY){
this.setYConstraint(this.topConstraint,
this.bottomConstraint,
this.yTickSize)}
},
getTick: function(val,tickArray){
if(!tickArray){
return val
}else if(tickArray[0]>=val){
return tickArray[0]
}else{
for(var i=0;i<tickArray.length;++i){
var next=i+1
if(tickArray[next]&&tickArray[next]>=val){
var diff1=val-tickArray[i]
var diff2=tickArray[next]-val
return(diff2>diff1)? tickArray[i] : tickArray[next]}}
return tickArray[tickArray.length-1]}
},
toString: function(val,tickArray){
return("YAHOO.util.DragDrop {"+this.id+"}")}}
if(!YAHOO.util.DragDropMgr){
YAHOO.util.DragDropMgr=new function(){
var UTIL=YAHOO.util
this.ids={}
this.handleIds={}
this.dragCurrent=null
this.dragOvers={}
this.deltaX=0
this.deltaY=0
this.preventDefault=true
this.stopPropagation=true
this.initalized=false
this.locked=false
this.init=function(){}
this.POINT=0
this.INTERSECT=1
this.mode=this.POINT
this._execOnAll=function(sMethod,args){
for(var i in this.ids){
for(var j in this.ids[i]){
var oDD=this.ids[i][j]
if(! this.isTypeOfDD(oDD)){
continue}
oDD[sMethod].apply(oDD,args)}}}
this._onLoad=function(){
this._execOnAll("setInitPosition",[])
var EU=UTIL.Event
EU.addListener(document,"mouseup",this.handleMouseUp,this,true)
EU.addListener(document,"mousemove",this.handleMouseMove,this,true)
EU.addListener(window,"unload",this._onUnload,this,true)
EU.addListener(window,"resize",this._onResize,this,true)
this.initalized=true}
this._onResize=function(e){
this._execOnAll("resetConstraints",[])}
this.lock=function(){this.locked=true;}
this.unlock=function(){this.locked=false;}
this.isLocked=function(){return this.locked;}
this.locationCache={}
this.useCache=true
this.clickPixelThresh=3
this.clickTimeThresh=1000
this.dragThreshMet=false
this.clickTimeout=null
this.startX=0
this.startY=0
this.regDragDrop=function(oDD,sGroup){
if(!this.initialized){this.init();}
if(!this.ids[sGroup]){
this.ids[sGroup]={}}
this.ids[sGroup][oDD.id]=oDD}
this._remove=function(oDD){
for(var g in oDD.groups){
if(g&&this.ids[g][oDD.id]){
delete this.ids[g][oDD.id]}}
delete this.handleIds[oDD.id]}
this.regHandle=function(sDDId,sHandleId){
if(!this.handleIds[sDDId]){
this.handleIds[sDDId]={}}
this.handleIds[sDDId][sHandleId]=sHandleId}
this.isDragDrop=function(id){
return(this.getDDById(id))? true : false}
this.getRelated=function(p_oDD,bTargetsOnly){
var oDDs=[]
for(var i in p_oDD.groups){
for(j in this.ids[i]){
var dd=this.ids[i][j]
if(! this.isTypeOfDD(dd)){
continue}
if(!bTargetsOnly || dd.isTarget){
oDDs[oDDs.length]=dd}}}
return oDDs}
this.isLegalTarget=function(oDD,oTargetDD){
var targets=this.getRelated(oDD)
for(var i=0;i<targets.length;++i){
if(targets[i].id==oTargetDD.id){
return true}}
return false}
this.isTypeOfDD=function(oDD){
return(oDD&&oDD.__ygDragDrop)}
this.isHandle=function(sDDId,sHandleId){
return(this.handleIds[sDDId]&&
this.handleIds[sDDId][sHandleId])}
this.getDDById=function(id){
for(var i in this.ids){
if(this.ids[i][id]){
return this.ids[i][id]}}
return null}
this.handleMouseDown=function(e,oDD){
this.dragCurrent=oDD
var el=oDD.getEl()
this.startX=UTIL.Event.getPageX(e)
this.startY=UTIL.Event.getPageY(e)
this.deltaX=this.startX-el.offsetLeft
this.deltaY=this.startY-el.offsetTop
this.dragThreshMet=false
this.clickTimeout=setTimeout(
"var DDM=YAHOO.util.DDM;DDM.startDrag(DDM.startX, DDM.startY)",
this.clickTimeThresh)}
this.startDrag=function(x,y){
clearTimeout(this.clickTimeout)
if(this.dragCurrent){
this.dragCurrent.b4StartDrag(x,y)
this.dragCurrent.startDrag(x,y)}
this.dragThreshMet=true}
this.handleMouseUp=function(e){
if(! this.dragCurrent){
return}
clearTimeout(this.clickTimeout)
if(this.dragThreshMet){
this.fireEvents(e,true)
}else{}
this.stopDrag(e)
this.stopEvent(e)}
this.stopEvent=function(e){
if(this.stopPropagation){
UTIL.Event.stopPropagation(e)}
if(this.preventDefault){
UTIL.Event.preventDefault(e)}}
this.stopDrag=function(e){
if(this.dragCurrent){
if(this.dragThreshMet){
this.dragCurrent.b4EndDrag(e)
this.dragCurrent.endDrag(e)}
this.dragCurrent.onMouseUp(e)}
this.dragCurrent=null
this.dragOvers={}}
this.handleMouseMove=function(e){
if(! this.dragCurrent){
return}
if(UTIL.Event.isIE&&!e.button){
this.stopEvent(e)
return this.handleMouseUp(e)}
if(!this.dragThreshMet){
var diffX=Math.abs(this.startX-UTIL.Event.getPageX(e))
var diffY=Math.abs(this.startY-UTIL.Event.getPageY(e))
if(diffX>this.clickPixelThresh ||
diffY>this.clickPixelThresh){
this.startDrag(this.startX,this.startY)}}
if(this.dragThreshMet){
this.dragCurrent.b4Drag(e)
this.dragCurrent.onDrag(e)
this.fireEvents(e,false)}
this.stopEvent(e)}
this.fireEvents=function(e,isDrop){
var dc=this.dragCurrent
if(!dc || dc.isLocked()){
return}
var x=UTIL.Event.getPageX(e)
var y=UTIL.Event.getPageY(e)
var pt=new YAHOO.util.Point(x,y)
var oldOvers=[]
var outEvts=[]
var overEvts=[]
var dropEvts=[]
var enterEvts=[]
for(var i in this.dragOvers){
var ddo=this.dragOvers[i]
if(! this.isTypeOfDD(ddo)){
continue}
if(! this.isOverTarget(pt,ddo,this.mode)){
outEvts.push(ddo)}
oldOvers[i]=true
delete this.dragOvers[i]}
for(var sGroup in dc.groups){
if("string" !=typeof sGroup){
continue}
for(i in this.ids[sGroup]){
var oDD=this.ids[sGroup][i]
if(! this.isTypeOfDD(oDD)){
continue}
if(oDD.isTarget&&!oDD.isLocked()&&oDD !=dc){
if(this.isOverTarget(pt,oDD,this.mode)){
if(isDrop){
dropEvts.push(oDD)
}else{
if(!oldOvers[oDD.id]){
enterEvts.push(oDD)
}else{
overEvts.push(oDD)}
this.dragOvers[oDD.id]=oDD}}}}}
if(this.mode){
if(outEvts.length>0){
dc.b4DragOut(e,outEvts)
dc.onDragOut(e,outEvts)}
if(enterEvts.length>0){
dc.onDragEnter(e,enterEvts)}
if(overEvts.length>0){
dc.b4DragOver(e,overEvts)
dc.onDragOver(e,overEvts)}
if(dropEvts.length>0){
dc.b4DragDrop(e,dropEvts)
dc.onDragDrop(e,dropEvts)}
}else{
for(i=0;i<outEvts.length;++i){
dc.b4DragOut(e,outEvts[i].id)
dc.onDragOut(e,outEvts[i].id)}
for(i=0;i<enterEvts.length;++i){
dc.onDragEnter(e,enterEvts[i].id)}
for(i=0;i<overEvts.length;++i){
dc.b4DragOver(e,overEvts[i].id)
dc.onDragOver(e,overEvts[i].id)}
for(i=0;i<dropEvts.length;++i){
dc.b4DragDrop(e,dropEvts[i].id)
dc.onDragDrop(e,dropEvts[i].id)}}}
this.getBestMatch=function(dds){
var winner=null
if(dds.length==1){
winner=dds[0]
}else{
for(var i=0;i<dds.length;++i){
var dd=dds[i]
if(dd.cursorIsOver){
winner=dd
break
}else{
if(!winner ||
winner.overlap.getArea()<dd.overlap.getArea()){
winner=dd}}}}
return winner}
this.refreshCache=function(aGroups){
for(sGroup in aGroups){
if("string" !=typeof sGroup){
continue}
for(i in this.ids[sGroup]){
var oDD=this.ids[sGroup][i]
if(this.isTypeOfDD(oDD)){
var loc=this.getLocation(oDD)
if(loc){
this.locationCache[oDD.id]=loc
}else{
delete this.locationCache[oDD.id]
oDD.unreg()}}}}}
this.verifyEl=function(el){
try{
if(el){
var parent=el.offsetParent
if(parent){
return true}}
}catch(e){}
return false}
this.getLocation=function(oDD){
if(! this.isTypeOfDD(oDD)){
return null}
var el=oDD.getEl()
if(!this.verifyEl(el)){
return null}
var aPos=YAHOO.util.Dom.getXY(el)
x1=aPos[0]
x2=x1+el.offsetWidth
y1=aPos[1]
y2=y1+el.offsetHeight
var t=y1-oDD.padding[0]
var r=x2+oDD.padding[1]
var b=y2+oDD.padding[2]
var l=x1-oDD.padding[3]
return new YAHOO.util.Region(t,r,b,l)}
this.isOverTarget=function(pt,oDDTarget,intersect){
var loc=this.locationCache[oDDTarget.id]
if(!loc || !this.useCache){
loc=this.getLocation(oDDTarget)
this.locationCache[oDDTarget.id]=loc}
oDDTarget.cursorIsOver=loc.contains(pt)
oDDTarget.overlap=null
if(intersect){
var curRegion=
YAHOO.util.Region.getRegion(this.dragCurrent.getDragEl())
var overlap=curRegion.intersect(loc)
if(overlap){
oDDTarget.overlap=overlap
return true
}else{
return false}
}else{
return oDDTarget.cursorIsOver}}
this._onUnload=function(e,me){
this.unregAll()}
this.unregAll=function(){
if(this.dragCurrent){
this.stopDrag()
this.dragCurrent=null}
this._execOnAll("unreg",[])
for(i in this.elementCache){
delete this.elementCache[i]}
this.elementCache={}
this.ids={}}
this.elementCache={}
this.getElWrapper=function(id){
var oWrapper=this.elementCache[id]
if(!oWrapper || !oWrapper.el){
oWrapper=this.elementCache[id]=
new this.ElementWrapper(document.getElementById(id))}
return oWrapper}
this.getElement=function(id){
return document.getElementById(id)}
this.getCss=function(id){
var css=null
var el=document.getElementById(id)
if(el){
css=el.style}
return css}
this.ElementWrapper=function(el){
this.el=el || null
this.id=this.el&&el.id
this.css=this.el&&el.style}
this.getPosX=function(el){
return YAHOO.util.Dom.getX(el)}
this.getPosY=function(el){
return YAHOO.util.Dom.getY(el)}
this.swapNode=function(n1,n2){
if(n1.swapNode){
n1.swapNode(n2)
}else{
var p=n2.parentNode
var s=n2.nextSibling
n1.parentNode.replaceChild(n2,n1)
p.insertBefore(n1,s)}}
this.getScroll=function(){
var t,l
if(document.documentElement&&document.documentElement.scrollTop){
t=document.documentElement.scrollTop
l=document.documentElement.scrollLeft
}else if(document.body){
t=document.body.scrollTop
l=document.body.scrollLeft}
return{top: t,left: l}}
this.getStyle=function(el,styleProp){
if(el.style.styleProp){
return el.style.styleProp
}else if(el.currentStyle){
return el.currentStyle[styleProp]
}else if(document.defaultView){
return document.defaultView.getComputedStyle(el,null).
getPropertyValue(styleProp)}}
this.getScrollTop=function(){return this.getScroll().top;}
this.getScrollLeft=function(){return this.getScroll().left;}
this.moveToEl=function(moveEl,targetEl){
var aCoord=YAHOO.util.Dom.getXY(targetEl)
YAHOO.util.Dom.setXY(moveEl,aCoord)}
this.getClientHeight=function(){
return(window.innerHeight)? window.innerHeight :
(document.documentElement&&document.documentElement.clientHeight)?
document.documentElement.clientHeight : document.body.offsetHeight}
this.getClientWidth=function(){
return(window.innerWidth)? window.innerWidth :
(document.documentElement&&document.documentElement.clientWidth)?
document.documentElement.clientWidth : document.body.offsetWidth}
this.numericSort=function(a,b){return(a-b);}
this._timeoutCount=0
this._addListeners=function(){
if(UTIL.Event&&
document&&
document.body){
this._onLoad()
}else{
if(this._timeoutCount>500){
}else{
setTimeout("YAHOO.util.DDM._addListeners()",10)
this._timeoutCount+=1}}}
this.handleWasClicked=function(node,id){
if(this.isHandle(id,node.id)){
return true
}else{
var p=node.parentNode
while(p){
if(this.isHandle(id,p.id)){
return true
}else{
p=p.parentNode}}}
return false}}
YAHOO.util.DDM=YAHOO.util.DragDropMgr
YAHOO.util.DDM._addListeners()}
YAHOO.util.DD=function(id,sGroup){
if(id){
this.init(id,sGroup)}}
YAHOO.util.DD.prototype=new YAHOO.util.DragDrop()
YAHOO.util.DD.prototype.scroll=true
YAHOO.util.DD.prototype.autoOffset=function(iPageX,iPageY){
var el=this.getEl()
var aCoord=YAHOO.util.Dom.getXY(el)
var x=iPageX-aCoord[0]
var y=iPageY-aCoord[1]
this.setDelta(x,y)}
YAHOO.util.DD.prototype.setDelta=function(iDeltaX,iDeltaY){
this.deltaX=iDeltaX
this.deltaY=iDeltaY}
YAHOO.util.DD.prototype.setDragElPos=function(iPageX,iPageY){
this.alignElWithMouse(this.getDragEl(),iPageX,iPageY)}
YAHOO.util.DD.prototype.alignElWithMouse=function(el,iPageX,iPageY){
var oCoord=this.getTargetCoord(iPageX,iPageY)
var aCoord=[oCoord.x,oCoord.y]
YAHOO.util.Dom.setXY(el,aCoord)
this.cachePosition(oCoord.x,oCoord.y)
this.autoScroll(oCoord.x,oCoord.y,el.offsetHeight,el.offsetWidth)}
YAHOO.util.DD.prototype.cachePosition=function(iPageX,iPageY){
if(iPageX){
this.lastPageX=iPageX
this.lastPageY=iPageY
}else{
var aCoord=YAHOO.util.Dom.getXY(this.getEl())
this.lastPageX=aCoord[0]
this.lastPageY=aCoord[1]}}
YAHOO.util.DD.prototype.autoScroll=function(x,y,h,w){
if(this.scroll){
var clientH=this.DDM.getClientHeight()
var clientW=this.DDM.getClientWidth()
var st=this.DDM.getScrollTop()
var sl=this.DDM.getScrollLeft()
var bot=h+y
var right=w+x
var toBot=(clientH+st-y-this.deltaY)
var toRight=(clientW+sl-x-this.deltaX)
var thresh=40
var scrAmt=(document.all)? 80 : 30
if(bot>clientH&&toBot<thresh){
window.scrollTo(sl,st+scrAmt)}
if(y<st&&st>0&&y-st<thresh){
window.scrollTo(sl,st-scrAmt)}
if(right>clientW&&toRight<thresh){
window.scrollTo(sl+scrAmt,st)}
if(x<sl&&sl>0&&x-sl<thresh){
window.scrollTo(sl-scrAmt,st)}}}
YAHOO.util.DD.prototype.getTargetCoord=function(iPageX,iPageY){
var x=iPageX-this.deltaX
var y=iPageY-this.deltaY
if(this.constrainX){
if(x<this.minX){x=this.minX;}
if(x>this.maxX){x=this.maxX;}}
if(this.constrainY){
if(y<this.minY){y=this.minY;}
if(y>this.maxY){y=this.maxY;}}
x=this.getTick(x,this.xTicks)
y=this.getTick(y,this.yTicks)
return{x:x,y:y}}
YAHOO.util.DD.prototype.b4MouseDown=function(e){
this.autoOffset(YAHOO.util.Event.getPageX(e),
YAHOO.util.Event.getPageY(e))}
YAHOO.util.DD.prototype.b4Drag=function(e){
this.setDragElPos(YAHOO.util.Event.getPageX(e),
YAHOO.util.Event.getPageY(e))}
YAHOO.util.DDProxy=function(id,sGroup){
if(id){
this.init(id,sGroup)
this.initFrame()}}
YAHOO.util.DDProxy.prototype=new YAHOO.util.DD()
YAHOO.util.DDProxy.frameDiv=null
YAHOO.util.DDProxy.dragElId="ygddfdiv"
YAHOO.util.DDProxy.prototype.borderWidth=2
YAHOO.util.DDProxy.prototype.resizeFrame=true
YAHOO.util.DDProxy.prototype.centerFrame=false
YAHOO.util.DDProxy.createFrame=function(){
var THIS=YAHOO.util.DDProxy
if(!document || !document.body){
setTimeout(THIS.createFrame,50)
return}
if(!THIS.frameDiv){
THIS.frameDiv=document.createElement("div")
THIS.frameDiv.id=THIS.dragElId
var s=THIS.frameDiv.style
s.position="absolute"
s.visibility="hidden"
s.cursor="move"
s.border="2px solid #aaa"
s.zIndex=999
document.body.appendChild(THIS.frameDiv)}}
YAHOO.util.DDProxy.prototype.initFrame=function(){
YAHOO.util.DDProxy.createFrame()
this.setDragElId(YAHOO.util.DDProxy.dragElId)
this.useAbsMath=true}
YAHOO.util.DDProxy.prototype.showFrame=function(iPageX,iPageY){
var el=this.getEl()
var s=this.getDragEl().style
if(this.resizeFrame){
s.width=(parseInt(el.offsetWidth)-(2*this.borderWidth))+"px"
s.height=(parseInt(el.offsetHeight)-(2*this.borderWidth))+"px"}
if(this.centerFrame){
this.setDelta(Math.round(parseInt(s.width)/2),
Math.round(parseInt(s.width)/2))}
this.setDragElPos(iPageX,iPageY)
s.visibility=""}
YAHOO.util.DDProxy.prototype.b4MouseDown=function(e){
var x=YAHOO.util.Event.getPageX(e)
var y=YAHOO.util.Event.getPageY(e)
this.autoOffset(x,y)
this.setDragElPos(x,y)}
YAHOO.util.DDProxy.prototype.b4StartDrag=function(x,y){
this.showFrame(x,y)}
YAHOO.util.DDProxy.prototype.b4EndDrag=function(e){
var s=this.getDragEl().style
s.visibility="hidden"}
YAHOO.util.DDProxy.prototype.endDrag=function(e){
var lel=this.getEl()
var del=this.getDragEl()
del.style.visibility=""
lel.style.visibility="hidden"
YAHOO.util.DDM.moveToEl(lel,del)
del.style.visibility="hidden"
lel.style.visibility=""}
YAHOO.util.DDTarget=function(id,sGroup){
if(id){
this.initTarget(id,sGroup)}}
YAHOO.util.DDTarget.prototype=new YAHOO.util.DragDrop()
