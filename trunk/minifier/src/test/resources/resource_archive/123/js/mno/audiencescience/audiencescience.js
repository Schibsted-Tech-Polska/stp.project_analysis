var segQS = "";
(function() {
    var rsi_segs = [];
    var segs_beg=document.cookie.indexOf('rsi_segs=');
    if(segs_beg>=0){
        segs_beg=document.cookie.indexOf('=',segs_beg)+1;
        if(segs_beg>0){
            var segs_end=document.cookie.indexOf(';',segs_beg);
            if(segs_end==-1)segs_end=document.cookie.length;
            rsi_segs=document.cookie.substring(segs_beg,segs_end).split('|');
        }
    }
    var segLen=20;
    if (rsi_segs.length<segLen){segLen=rsi_segs.length}
    for (var i=0;i<segLen;i++){
        segQS+=(rsi_segs[i]+"+");
    }
}());
if (segQS != "+" && segQS != "") {
    document.write('<scr'+'ipt type="text/javascript" src="http://adserver.adtech.de/bind?ckey1=wtbt;cvalue1='+segQS+';expiresDays=14;adct=text/html;misc=123"></scr'+'ipt>');
}