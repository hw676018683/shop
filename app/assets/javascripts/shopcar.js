$(function(){
	for(i=1;i<99;i++){
		$price="#mdprice"+i;
		$number="#mdnumber"+i;
		$pay="#mdpay"+i;
		if($($price).text()=="")
			break;
		else
			$($pay).text($($price).text()*$($number).text())
	}
	$(".number").keyup(function(){
		this.value=this.value.replace(/[^0-9-]+/,'');
		var number="#"+this.id;
		var mdnumber=number.replace("number","mdnumber");
		var price=mdnumber.replace("number","price");
		var pay=mdnumber.replace("number","pay");
		if(this.value!=""){
			$(mdnumber).text(this.value)
			$(pay).text($(mdnumber).text()*$(price).text());}
		else{
			$(mdnumber).text("0")
			$(pay).text("0")
		}
	})
	$(".absale").change(function(){
		var number="bsb#"+this.id;
		var price=number.replace("number","price");
		var pay=number.replace("number","pay");
		$(pay).text($(number).text()*$(price).text());
	})
	$(".wantpay").change(function(){
		var wantpay="#"+this.id
		var pay=wantpay.replace("wt","mdpay");
		if(this.checked)
			$("#needtopay").text(parseInt($(pay).text())+parseInt($("#needtopay").text()))
		else
			$("#needtopay").text(parseInt($("#needtopay").text())-parseInt($(pay).text()))	
	})
	$("#shopcaredit").click(function(){
		if ($("#shopcaredit").text()=="完成"){
			$("#shopcaredit").text("编辑")
			$(".summary").css("display","block")
			$(".number").css("display","none")
			$("#dip").css("display","block")
			$("#pay").css("display","block")
			$("#del").css("display","none")}
		else{
			$("#shopcaredit").text("完成")
			$(".summary").css("display","none")
			$(".number").css("display","block")
			$("#dip").css("display","none")
			$("#pay").css("display","none")
			$("#del").css("display","block")}
	})
})