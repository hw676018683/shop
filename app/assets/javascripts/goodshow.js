$(function(){
	var unitprice=0;
	if($("#unitprice").text()=="")
		$("#unitprice").text(unitprice*parseInt($("#unitnumber").val()));
	$("#unitnumber").keyup(function(){
		this.value=this.value.replace(/[^0-9-]+/,'');
		if(this.value!="")
			$("#unitprice").text(unitprice*parseInt(this.value));
		else
			$("#unitprice").text("0");
	});
	$("input[name='value1']").change(function(){
		// unitprice1=parseInt($("input[name='sort1']:checked").val());
		// unitprice=unitprice1+unitprice2;
		// $("#unitprice").text(unitprice*parseInt($("#unitnumber").val()));

		$.ajax({
		  type: "POST",
		  url: "/query",
		  data: {value1:$("input[name='value1']:checked").val(),value2:$("input[name='value2']:checked").val()},
		  dataType: "json",
		  success: function(msg){
		    if(!msg){
		    	$("#unitprice").text(0);
			    $("#quantity").text(0);
			    $("#oldprice").text(0);
			    unitprice=0
		     }
		    else{
		    	$("#unitprice").text(msg["price"]);
			    $("#quantity").text(msg["quantity"]);
			    $("#oldprice").text(msg["oldprice"]);
			    unitprice=msg["price"]
		    }
		    $("#unitprice").text(parseInt(unitprice)*parseInt($("#unitnumber").val()));
		  }
		});
	})
	$("input[name='value2']").change(function(){
		// unitprice2=parseInt($("input[name='sort2']:checked").val());
		// unitprice=unitprice1+unitprice2;
		// $("#unitprice").text(unitprice*parseInt($("#unitnumber").val()));
		
		$.ajax({
		  type: "POST",
		  url: "/query",
		  data: {value1:$("input[name='value1']:checked").val(),value2:$("input[name='value2']:checked").val()},
		  dataType: "json",
		  success: function(msg){
		    if(!msg){
		    	$("#unitprice").text(0);
			    $("#quantity").text(0);
			    $("#oldprice").text(0);
			    unitprice=0
		     }
		    else{
		    	$("#unitprice").text(msg["price"]);
			    $("#quantity").text(msg["quantity"]);
			    $("#oldprice").text(msg["oldprice"]);
			    unitprice=msg["price"];
		    }
		    $("#unitprice").text(parseInt(unitprice)*parseInt($("#unitnumber").val()));
		  }
		});
	})
	$("#cut").click(function(){
		if($("#unitnumber").val()=="0")
			alert("抱歉，数值不能小于零！")
		else{
			var temp=parseInt($("#unitnumber").val())-1;
			$("#unitnumber").val(temp);
			$("#unitprice").text(unitprice*parseInt($("#unitnumber").val()));
		}
	})
	$("#add").click(function(){
		var temp=parseInt($("#unitnumber").val())+1;
		$("#unitnumber").val(temp);
		$("#unitprice").text(unitprice*parseInt($("#unitnumber").val()));
	})
})