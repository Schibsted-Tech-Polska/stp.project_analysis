<!--
var xtpif="0",xtpim="0",xtpiq="",xtpir="0",xtpis="0";
var xtpos=0;
xn=navigator.plugins;
if (xn && xn.length) {xnok = true;}
else { xnok = false;
   document.write("<object id='xtRealObj' style='display: none' classid='clsid:CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA'></object>");
}
if (!xnok){
   chaine = '<SC'+'RIPT LANGUAGE="VBScript">\n';
   chaine += 'On error resume next\n';
   chaine += 'xtpir = xtRealObj.GetVersionInfo() \n';
   chaine += 'if xtpir = "" Then \n';
   chaine += 'set xtpirO = CreateObject("rmocx.RealPlayer G2 Control") \n';
   chaine += 'if IsObject(xtpirO) then \n';
   chaine += 'xtpir = xtpirO.GetVersionInfo() \n';
   chaine += 'End if \n';
   chaine += 'End if \n';
   chaine += 'set xtmpo = CreateObject("WMPlayer.OCX.7") \n';
   chaine += 'If IsObject(xtmpo) then \n';
   chaine += 'xtpim = xtmpo.versionInfo \n';
   chaine += 'End if \n';
   chaine += '</script> \n';
   document.write(chaine);
}
if (xnok) {
   for (var xi=0;xi<xn.length;xi++) {
   if ((xn[xi].name.indexOf('Flash Player')!=-1)||(xn[xi].name.indexOf('Shockwave Flash')!=-1)){
      xtpif = "1"; 
      if (xn[xi].description.split('Shockwave Flash ')[1].length){
         xtpos = xn[xi].description.split('Shockwave Flash ')[1].indexOf('.')+2;
         xtpif = xn[xi].description.split('Shockwave Flash ')[1].substring(0,(xtpos>1)?xtpos:3);
      }
   }
   if (xn[xi].name.indexOf('Windows Media Player')!=-1){ xtpim = "1";}
      if (xn[xi].name.indexOf('RealPlayer ')!=-1){
         if (xn[xi].description.length){
            xtpos = xn[xi].description.indexOf('.')+2;
            xtpir = xn[xi].description.substring(0,(xtpos>1)?xtpos:3);
         }
      }
   }
}
else if (window.ActiveXObject) {
   for (var xi=0;xi<20;xi++) {
      try {if (eval("new ActiveXObject('ShockwaveFlash.ShockwaveFlash."+xi+"');")) {xtpif = xi;} } catch(e) {};
   }
}
if(window.ActiveXObject){
   try{
      var control=new ActiveXObject('AgControl.AgControl');
      if(control){
         try{
            for(var i=1;i<=10;i++){
               if(control.IsVersionSupported(i+'.0')){xtpis=i+'.0';}
            }
         }
         catch(e){xtpis='1';}
      }
   }
   catch(e){}
} 
else if(navigator.plugins&&navigator.plugins.length){
   try{
      var plugin=navigator.plugins['Silverlight Plug-In'];
      if(plugin){
         try{
            if(plugin.description==='1.0.30226.2')xtpis='2.0';else{xtpis=parseInt(plugin.description[0]);
            if(xtpis.toString().length==1)xtpis+='.0';}
         }
         catch(e){xtpis='1';}
      }
   }
   catch(e){}
}
if (window.xtparam!=null){window.xtparam+="&pir="+xtpir+"&pim="+xtpim+"&pif="+xtpif+"&pis="+xtpis;}
else{window.xtparam = "&pir="+xtpir+"&pim="+xtpim+"&pif="+xtpif+"&pis="+xtpis;}
//-->
