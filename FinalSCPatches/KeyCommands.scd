(
var doc, txt;
doc = Document.current;
doc.keyDownAction_({arg doc, key, modifiers, num;
	var mykey;
	mykey= num;
   if(mykey == 49,          // is the number '1'
	 { ~audiovisual1.value; }); 
   if(mykey == 50,          // is the number '2'
	 { ~audiovisual2.value; });
   if(mykey == 51,          // is the number '3'
	 { ~audiovisual3.value; });
   if(mykey == 52,          // is the number '4'
	 { ~audiovisual4.value; });
   if(mykey == 53,          // is the number '5'
	 { ~audiovisual5.value; });
});
)

