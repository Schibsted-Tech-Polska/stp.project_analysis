/**
 * Created by IntelliJ IDEA.
 * User: torill
 * Date: Feb 3, 2011
 * Time: 3:18:39 PM
 * To change this template use File | Settings | File Templates.
 */

function xt_med(type,section,page,x1,x2,x3,x4,x5){
    xt_img = new Image();
    xtdate = new Date();
    xts = screen;
    xt_ajout = (type=='F') ? '' : (type=='M') ? '&a='+x1+'&m1='+x2+'&m2='+x3+'&m3='+x4+'&m4='+x5 : '&clic='+x1;
    Xt_im = 'http://logc142.xiti.com/hit.xiti?s=413806&s2='+section;
    Xt_im += '&p='+page+xt_ajout+'&hl=' + xtdate.getHours() + 'x' + xtdate.getMinutes() + 'x' + xtdate.getSeconds();
    if(parseFloat(navigator.appVersion)>=4)
        {
                Xt_im += '&r=' + xts.width + 'x' + xts.height + 'x' + xts.pixelDepth + 'x' + xts.colorDepth;
        }
    xt_img.src = Xt_im;
    if ((x2 != null)&&(x2!=undefined)&&(type=='C')){
        if ((x3=='')||(x3==null)) {
            document.location = x2
        }
    else {
         xfen = window.open(x2,'xfen',''); xfen.focus();
        }
    }
else
{return;}
}
