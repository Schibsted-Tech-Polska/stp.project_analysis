mno.core.register({
    id:'widget.currencyCalc.calculator',
    creator: function (sandbox) {

        function getCurrency ($this) {
            var from = $this.find(' .fromC').val().split('_'),
                to = $this.find('.toC').val().split('_'),
                fromName = from[1] !== 'Ikketilgjengelig' ? from[1] : false,
                fromRate = from.length > 3 ? from[2] + '.' + from[3] : from[2],
                toName = to[1] !== 'Ikketilgjengelig' ? to[1] : false,
                toRate = to.length > 3 ? to[2] + '.' + to[3] : to[2]

            if (fromName > 1 ) {
                fromRate = fromRate/fromName;
            }

            if (toName > 1) {
                toRate = toRate/toName;
            }


            return {
                fromRate: fromRate,
                toRate: toRate
            }
        }

        function calcCurrency(val, fromRate, toRate) {
            return (Math.round(((val*fromRate)/toRate)*100)/100).toString().replace(".", ",");
        }

        return {
            init: function() {},

            helper:function(sandbox){
                var $ = sandbox.$;
                sandbox.container.each(function(i, element){
                    var calcDiv = $(this);

                    calcDiv.find('input, select').bind('keyup change', function () {
                        var $this = $(this).hasClass('currency') ? $(this) : $(this).parent().find('input.currency'),
                            input = jQuery.trim($this.val().replace(',','.')) ,
                            currency = getCurrency(calcDiv);

                        if ($this.hasClass('from')) {
                            $('.currency.to').val( calcCurrency(input,currency.fromRate,currency.toRate));
                        } else {
                            $('.currency.from').val( calcCurrency(input,currency.toRate,currency.fromRate) );
                        }
                    });


                        var calcBtn = $(calcDiv).find('.calculate');
                           $(calcBtn).live('click',function () {
                           var amountInput = $(calcDiv).find('.amount');
                           var amount = stripBlanks($(amountInput).val());
                           amount = amount.replace(",",".");
                           if (amount == '') {
							   $(this).find('.userMessage').text("Du må oppgi beløp");
                               $(this).find('.amount').focus();
                               return false;
                           }

                           var fromC = $(calcDiv).find(' .fromC').val();
                           var toC = $(calcDiv).find('.toC').val();

                           var fromC_enhet = fromC.split('_')[1];
                           var fromC_kurs = fromC.split('_')[2];
                           if(fromC.split('_').length>3){
                               fromC_kurs = fromC_kurs+'.'+fromC.split('_')[3];
                           }
                           var toC_enhet = toC.split('_')[1];
                           var toC_kurs = ttoC.split('_')[1];
                           if(toC.split('_').length>3){
                               toC_kurs = toC_kurs+'.'+toC.split('_')[3];
                           }

                           if(fromC_kurs=='Ikketilgjengelig' || toC_kurs=='Ikketilgjengelig'){
                                $(calcDiv).find('.userMessage').text("Kurs ikke tilgjengelig");
                           }else{
                               if(fromC_enhet>1){fromC_kurs = fromC_kurs/fromC_enhet;}
                               if(toC_enhet>1){toC_kurs = toC_kurs/toC_enhet;}

                               var exchangedAmount = (Math.round(((amount*fromC_kurs)/toC_kurs)*100)/100).toString().replace(".", ",");

                               $(calcDiv).find('.userMessage').text("Vekslet beløp: " + exchangedAmount + " " +toC.split('_')[0]);
                           }

                        });

                       $(calcDiv).find('.empty').live('click', function(){
                           $(calcDiv).find('.userMessage').text('');
                           $(calcDiv).find('.amount').val('');
                       })

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