$(function(){
	$(document).click(function(){
		$("#spanel").css("display","none");
		$("#epanel").css("display","none");
		$("#apanel").css("display","none");
	})
	$("#sort").click(function(e){
		if($("#spanel").is(":visible"))
			$("#spanel").css("display","none");
		else{
			$("#spanel").css("display","block");
			$("#epanel").css("display","none");
			$("#apanel").css("display","none");
			stopPropagation(e); 
		}
	});
	$("#event").click(function(e){
		if($("#epanel").is(":visible"))
			$("#epanel").css("display","none");
		else{
			$("#epanel").css("display","block");
			$("#spanel").css("display","none");
			$("#apanel").css("display","none");
			stopPropagation(e); 
		}
	});
	$("#abus").click(function(e){
		if($("#apanel").is(":visible"))
			$("#apanel").css("display","none");
		else{
			$("#apanel").css("display","block");
			$("#spanel").css("display","none");
			$("#epanel").css("display","none");
			stopPropagation(e); 
		}
	});
	$("#shopc").click(function(){
		window.location.href="shopcar.html";
	});
	$("#shopr").click(function(){
		window.location.href="record.html";
	});
	$("#messg").click(function(){
		window.location.href="message.html";
	});
	$("#search").click(function(){
		window.location.href="search.html";
	});
	$("#sort1").click(function(){
		window.location.href="sort1.html";
	});
	$("#s1").click(function(){
		window.location.href="s1.html";
	});
	$("#account").click(function(){
		window.location.href="myinfo.html";
	});
	$("#login").click(function(){
		window.location.href="login.html";
	});
	$("#signup").click(function(){
		window.location.href="signup.html";
	});
	$("#index").click(function(){
    		window.location.href="index.html"
    });
    $("#back").click(function(){
    		history.back()
    });
	$("#eva").click(function(){
		window.location.href="eva1.html";
	});
	
	$("#adc").click(function(){
		// $("#nc").show(500)
	 //    setTimeout("$('#nc').css('display','none')","2000"); 
    var value1 = $("input[name='value1']:checked").val();
    var value2 = $("input[name='value2']:checked").val();  
    var quantity = $("#unitnumber").attr("value");
    var form = $('<form></form>');  
    form.attr('action', '/cars');  
    form.attr('method', 'post');  
    // form的target属性决定form在哪个页面提交  
    // _self -> 当前页面 _blank -> 新页面  
    form.attr('target', '_self');  
    var input1 = $('<input type="text" name="value1" />');  
    input1.attr('value', value1); 
    var input2 = $('<input type="text" name="value2" />');  
    input2.attr('value', value2); 
    var input3 = $('<input type="text" name="quantity" />');  
    input3.attr('value', quantity); 
    form.append(input1); 
    form.append(input2); 
    form.append(input3)
    form.appendTo(document.body);
    form.submit();  
    return false; 
	});
	$("#dip").click(function(){
		window.location.href="trans.html"
	});
	$(".chsh").click(function(){
		$id="#"+this.id+"b";
		$img="#"+this.id+"i";
		if($($id).is(":visible")){
			$($id).css("display","none");
			$($img).attr("src","/assets/down.jpg");}
		else{
			$($id).css("display","block");
			$($img).attr("src","/assets/up.jpg");
		}
	});
	$("#su").click(function(){
    		$(".dialog").show();
    		$(".mask").show();
    });
	$("#close").click(function(){
		$(".dialog").hide();
		$(".mask").hide();
	});
	$("#se").click(function(){
		$(".dialog").hide();
		$(".mask").hide();
	})
	$("#ero").click(function(){
    		$("#dero").show();
    });
});
//