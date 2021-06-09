
$(function(){
let aberto = 0;
let transfAberto = 0;
var container = $("#actionmenu");
var audio = new Audio('click.ogg');
var nuiaberta = false
container.hide()
// ? MENSAGENS
var month = new Array();
month[0] = "JANEIRO";
month[1] = "FEVEREIRO";
month[2] = "MARÇO";
month[3] = "ABRIL";
month[4] = "MAIO";
month[5] = "JUNHO";
month[6] = "JULHO";
month[7] = "AGOSTO";
month[8] = "SETEMBRO";
month[9] = "OUTUBRO";
month[10] = "NOVEMBRO";
month[11] = "DEZEMBRO";
    var myVar = setInterval(myTimer ,1000);
    function myTimer() {
        if (nuiaberta == true){
        var d = new Date(), displayDate;
        document.getElementById("horario").innerHTML = `${(month[d.getMonth()])} | <span>${d.getHours()}:${d.getMinutes()}</span>`;
        }
    }
    window.addEventListener('message',function(event){
		var item = event.data;
        switch(item.acao){
            case 'open':
                // open
                myVar
                $("#valor").val("")
                $("#passaporte").val("")
                var phone = item.phone
                nuiaberta = true
                console.log(`${phone} -> ${phone.substr(0,1)}`)
                $("#card").html(`<z>**** **</z>${phone.substr(0,2)} ${phone.substr(2,5)}`)
                $("#card2").html(`<z>**** **</z>${phone.substr(0,2)} ${phone.substr(2,5)}`)
                $("#name").text(item.nome)
                $("#saldo").text(`R$ ${item.banco}`)
                $("#carteira").text(`R$ ${item.carteira}`)
                var historico = item.logs
                for(var i = 0;i<historico.length;i++){
                const c = document.createElement("div");
                $(c).html(`${historico[i]}`).prependTo($("#lista")) 
                }
                $("#valores").hide()
                $("#historico").hide()
                $("#multasamount").text(`$ ${item.multas}`)
                container.show()

            break;
            case 'close':
                nuiaberta = false
                container.hide()
            break;
            case 'update':
                $("#saldo").text(`R$ ${item.banco}`)
                $("#carteira").text(`R$ ${item.carteira}`)
                var historico = item.logs
                for(var i = 0;i<historico.length;i++){
                const c = document.createElement("div");
                $(c).html(`${historico[i]}`).prependTo($("#lista")) 
                }
                $("#multasamount").text(`$ ${item.multas}`)

                break;
        }

    });


    $('#logo').click(()=>{
        audio.play();
        if(aberto == 0){
            aberto = 1;
            $('#menuAberto').slideDown();
        }else if(aberto >= 1){
            aberto = 0;
            $('#menuAberto').slideUp();
        }
    });    
    
    $( ".botaoRapidos" ).on( "click", function() {
        fazerAcao($("#rapidos").data("action"),Number($(this).data('value')),Number($("#passaporte").val()))
        audio.play();

      }); 
    $( "#pagar" ).on( "click", function() {
        audio.play();
        fazerAcao($("#pagar").data("action"),Number($("#valor").val()),Number($("#passaporte").val()))
        $('#pagar').hide(1);
        $('#pagar').show(1);
    });




    $('#saque').click(()=>{
        $("#valor").val(""); $("#id").val("")
        $("#valores").show()
        $("#historico").show()
        $('#id').slideUp();
        $("#rapidos").data("action","saque")
        $("#pagar").data("action",'saque')
        $('#pagar').html('SACAR');  
        transfAberto = 0;
        $('#inserirTransf').css('position', 'static');
        audio.play();

    });
    $('#saque').hover(()=>{
        $('#saque img').attr('src','https://cdn.discordapp.com/attachments/712813091674390560/763525005765509170/sacar.png');
    });
    $('#saque').mouseover(()=>{
        $('#saque img').attr('src','https://cdn.discordapp.com/attachments/712813091674390560/763525906463457330/sacarhover.png');
    });
    $('#deposito').click(()=>{
        $("#valor").val(""); $("#id").val("")
        $("#rapidos").data("action","deposito")
        $("#pagar").data("action",'deposito')
        $("#valores").show()
        $("#historico").show()
        $('#pagar').html('DEPOSITAR');
        $('#id').slideUp();
        audio.play();

        $('#inserirTransf').css('position', 'static');
        transfAberto = 0;
    });
    $('#deposito').hover(()=>{
        $('#deposito img').attr('src','https://cdn.discordapp.com/attachments/712813091674390560/763525002934091776/depositar.png');
    });
    $('#deposito').mouseover(()=>{
        $('#deposito img').attr('src','https://cdn.discordapp.com/attachments/712813091674390560/763525904172318760/depositarhover.png');
    });
    $('#transferencia').click(()=>{
        $("#rapidos").data("action","transferencia")
        audio.play();

        $("#valor").val(""); $("#id").val("")
        $("#valores").show()
        $("#historico").show()
        $('#pagar').html('TRANSFERIR');
        $("#pagar").data("action",'transferencia')
        if(transfAberto == 0){
            $('#inserirTransf').css('position', 'relative');
            $('#inserirTransf').css('top', '-20px');
            transfAberto = 1;
            $('#id').slideDown();
        }else if(transfAberto >= 1){
            $('#inserirTransf').css('position', 'static');
            transfAberto = 0;
            $('#id').slideUp();
        }
    });
    $('#transferencia').hover(()=>{
        $('#transferencia img').attr('src','https://cdn.discordapp.com/attachments/712813091674390560/763525002175578142/trasnferir.png');
    });
    $('#transferencia').mouseover(()=>{
        $('#transferencia img').attr('src','https://cdn.discordapp.com/attachments/712813091674390560/763525910250127360/transferhover.png');
    });

    $('#multas').click(()=>{
        audio.play();
        $("#pagar").data("action",'multas')
        $("#rapidos").data("action","multas")
        $("#valor").val(""); $("#id").val("")
        $("#valores").show()
        $("#historico").show()
        $('#pagar').html('MULTAS');
        $('#id').slideUp();
        $('#inserirTransf').css('position', 'static');
        transfAberto = 0;

    });

    $('#multas').hover(()=>{
        $('#multas img').attr('src','https://cdn.discordapp.com/attachments/712813091674390560/763525004175605760/multas.png');
    });
    $('#multas').mouseover(()=>{
        $('#multas img').attr('src','https://cdn.discordapp.com/attachments/712813091674390560/763525905111973908/pagarhover.png');
    });

    function fazerAcao(tipo,valor,passaporte){
        if (valor > 0){
            switch(tipo){
                case "transferencia":
                    if(passaporte > 0){
                        $.post(
                            "http://rize_banco/transferencia",
                            JSON.stringify({
                              amount: valor,
                              nid: passaporte,
                            })
                          );
                    }
                    break;
                case "saque":
                    $.post(
                        "http://rize_banco/saque",
                        JSON.stringify({
                          amount: valor,
                        })
                      );
                    console.log("saque");
                    break;
                case "deposito":
                    $.post(
                        "http://rize_banco/deposito",
                        JSON.stringify({
                          amount: valor,
                        })
                      );
                    break; 
                case "multas":
                    $.post(
                        "http://rize_banco/multas",
                        JSON.stringify({
                          amount: valor,
                        })
                      );
                    break;
            }
        }
        $("#valor").val("")
        $("#passaporte").val("")

    }

    document.onkeyup = function(data) {
        if (data.which == 27) {
          $.post("http://rize_banco/close", JSON.stringify({}), function(datab) {});
        }
      };
});