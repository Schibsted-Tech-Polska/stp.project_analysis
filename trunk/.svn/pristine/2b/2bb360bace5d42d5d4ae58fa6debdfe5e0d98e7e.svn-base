/*! A fix for the iOS orientationchange zoom bug.Script by @scottjehl, rebound by @wilto. MIT License.*/
var ua = navigator.userAgent.toLowerCase();
var isAndroid = ua.indexOf("android") > -1;
if (!isAndroid) {
    (function (j) {
        var i = j.document;
        if (!i.querySelectorAll) {
            return
        }
        var l = i.querySelectorAll("meta[name=viewport]")[0], a = l && l.getAttribute("content"), h = a + ", maximum-scale=1.0", d = a + ", maximum-scale=2.0", g = true, c = j.orientation, k = 0;
        if (!l) {
            return
        }
        function f() {
            l.setAttribute("content", d);
            g = true
        }

        function b() {
            l.setAttribute("content", h);
            g = false
        }

        function e(m) {
            c = Math.abs(j.orientation);
            k = Math.abs(m.gamma);
            if (k > 8 && c === 0) {
                if (g) {
                    b()
                }
            } else {
                if (!g) {
                    f()
                }
            }
        }

        j.addEventListener("orientationchange", f, false);
        j.addEventListener("deviceorientation", e, false)
    })(this);
}