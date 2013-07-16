mno.core.register({
    id:'widget.code.template.common.code.bmiCalculator.jsp',
    creator: function (sandbox) {
        return {
            init: function() {
                sandbox.container.each(function(i, element){

                       $('#bmiCalculator .calculate').live('click',function () {
                           var height = stripBlanks($('#bmiCalculator .height').val());
                           height = height.replace(",",".");
                           if (height == '') {
							   $('#bmiCalculator .userMessage').text("Du må oppgi høyde");
                               $('#bmiCalculator .height').focus();
                               return false;
                           }
                           if (height != Number(height) || (height = Number(height/100)) < 1 || height > 2.5) {
							   $('#bmiCalculator .userMessage').text("Ugyldig verdi for høyde");
                               $('#bmiCalculator .height').focus();
                               return false;
                           }

                           var weight = stripBlanks($('#bmiCalculator .weight').val());

                            weight = weight.replace(",",".");
                            if (weight == '') {
							   $('#bmiCalculator .userMessage').text("Du må oppgi vekt");
                                $('#bmiCalculator .weight').focus();
                                return false;
                            }
                            if (weight != Number(weight) || (weight = Number(weight)) < 25 || weight > 250) {
							   $('#bmiCalculator .userMessage').text("Ugyldig verdi for vekt");
                                $('#bmiCalculator .weight').focus();
                                return false;
                            }

                           $('#bmiCalculator .userMessage').text("Din BMI er " + Math.round(weight / (height * height)*100)/100 + ".");

                        });

                });

                function stripBlanks(fld) {
                        var result = "";var c = 0;for (i=0; i < fld.length; i++) {
                            if (fld.charAt(i) != " " || c > 0) {
                                result += fld.charAt(i);
                                if (fld.charAt(i) != " ") c = result.length;
                                }
                        }
                        return result.substr(0,c);
                }
            },

            destroy: function() {
                $ = null;
            }
        };
    }
});