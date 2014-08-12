// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

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
    $("#sort1").click(function(){
      window.location.href="sort1.html";
    });
    $("#s1").click(function(){
      window.location.href="s1.html";
    });
    $("#account").click(function(){
      window.location.href="myinfo.html";
    });
  })

$(function(){
        $("#back").click(function(){
          history.back();
        });
        $("#save").click(function(){
          window.location.href="index.html"
        })
      })