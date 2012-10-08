// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

//= require bootstrap

added = 0

addrow = function() {
  added += 1
  var table=document.getElementById("product_form_table");
  document.getElementById("added").value = added;
  var row=table.insertRow(1);
  
  var cell1=row.insertCell(0);
  var cell2=row.insertCell(1);
  var cell3=row.insertCell(2);
  var cell4=row.insertCell(3);
  var cell5=row.insertCell(4);
  
  var n = "name.new." + added
  var p = "price.new." + added
  var i = "inventory.new." + added
  var d = "description.new." + added
  
  cell1.innerHTML="<input type='text' size='10' value='' name="+ n + ">";
  cell2.innerHTML="<input type='text' size='5' value='' name="+ p + ">";
  cell3.innerHTML="";
  cell4.innerHTML="<input type='text' size='5' value='' name="+ i + ">";
  cell5.innerHTML="<input type='text' size='20' value='' name="+ d + ">";
}
