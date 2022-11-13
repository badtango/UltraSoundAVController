
(
a = Buffer.read(s,"/Users/williamrailton/Desktop/dissertation/UltraSoundBox/SCsensorAudio/120myloop1.wav", bufnum: 0);
b = AtsFile.new("/Users/williamrailton/Desktop/dissertation/UltraSoundBox/SCsensorAudio/myloop1.ats").load(1);

~combined1 = ({
SynthDef(\Buffoveride, {  arg sens0 = 0, sens1 = 0, sens2 = 0, 
                              sens3 = 0, sens4 = 0, sens5 = 0;
                          var imp, buf, woo, rev, env, com, hpf; 
                     
                     imp = Impulse.kr(sens1);            	  	 	         
		     buf = PlayBuf.ar(1, 0, sens0, BufRateScale.kr(0), trigger: imp, loop: 1);
	             woo = Pan2.ar(buf, 0, 0.5);      
	             rev = FreeVerb.ar(woo, sens2, sens2, 0.2, 0.5);       	                 
		     env = EnvGen.kr(Env.perc(0.01, sens4, 0.5, -4), 1.0, doneAction: 2);
	             com = CombN.ar(rev, 0.01, sens5, mul: env);  
	             hpf = RHPF.ar(com, sens3, 0.3.wrap2(1) * 0.3);
	                      
	                       Out.ar(0, hpf)}).send(s);

g.action = { 
| ... msg | 
       
Synth(\Buffoveride, [  \sens0, msg[5].linexp(3, 48, 0.1, 20000.0), 
                       \sens1, msg[1].linexp(3, 48, 500.0, 1.0), 
                       \sens2, msg[3].linlin(3, 48, 1.0, 0.0), 
                       \sens3, msg[4].linlin(3, 48, 10000, 80), 
                       \sens4, msg[2].linlin(3, 48, 0.0, 0.5), 
                       \sens5, msg[0].linlin(3, 48, 0.01, 0.0); ]);
                       
 ~equal1 = msg[4].linlin(4, 48, 0.0, 350.0);
 ~equal2 = msg[2].linlin(4, 48, 0.0, 1.5); 
  ~width = msg[0].linlin(4, 48, 20.0, 0.7); 
    ~red = msg[1].linlin(4, 48, 0.0, 1.0);
  ~green = msg[3].linlin(4, 48, 0.0, 1.0);
   ~blue = msg[5].linlin(4, 48, 0.0, 1.0);
~matrix1 = msg[5].linlin(4, 48, 50.0, 0.0);
~matrix2 = msg[1].explin(4, 48, 10.0, 0.0);
~matrix3 = msg[5].explin(4, 48, 0.0, 1.0);
~matrix4 = msg[5].explin(4, 48, 1.0, 0.0);
                      
};
});

~combined2 = ({
var w, run = true, 
ln = 600, ln2 = 152;
w = Window(border: false);
w.view.background = Color.black;
w.onClose = { run = false; };
w.front;
w.fullScreen;
w.drawHook = {
       Pen.use { 
		Pen.translate(640, 380);
		Pen.color = Color.new(~red, ~green, ~blue);
		Pen.width = ~width;
		Pen.matrix = [ ~matrix3, ~matrix4, ~matrix2, ~matrix3, ~matrix1, ~matrix1 ];
		40.do {		
        Pen.beginPath;     
        Pen.addAnnularWedge(Point(0,0), a = ~equal1, a + 70.rand2, 
        2pi.rand + (0.1 * 2.0.rand2), ~equal2);											
	    Pen.stroke;
			
}; // end do
}; // end use
}; // end drawhook

{ while { run } { w.refresh; 0.01pi.wait; } }.fork(AppClock)

});

~audiovisual1 = ({
~combined1.value;
~combined2.value;
});

~twinkle1 = ({
SynthDef(\twinkle, { arg carfreq = 0, modfreq = 0,  index = 0, 
	                      attack = 0,  panner = 0, cutoff = 0,
	                   delaytime = 0, freqmod = 0; 
                     var env, mod, pmo, pan, rlpf, out;

 env = EnvGen.kr(Env.perc((attack/1000), 0.02, 0.5, -5), 1.0, doneAction: 2);
 mod = LFTri.kr(freqmod, 3) * 200 + 400;
 pmo = PMOsc.ar(carfreq + mod, modfreq, index, 0, 0.3);
 pan = Pan2.ar(env * pmo, panner, 0.3);
rlpf = RHPF.ar(pan, cutoff, 0.1, 0.3);

 out = Out.ar(0, rlpf); 

}).send(s);

g.action = { 
| ... msg | 
       
Synth(\twinkle, [\carfreq, msg[5].linlin(3, 48, 10.midicps, 110.midicps), 
                 \modfreq, msg[4].linlin(3, 48, 0.0, 1000.0), 
                   \index, msg[3].linlin(3, 48, 1.0, 30.0), 
                  \attack, msg[2].linlin(3, 48, 0.0, 100.0), 
                  \cutoff, msg[0].linlin(3, 48, 11000, 80.0),
                 \freqmod, msg[1].linlin(3, 48, 10.0, 0.0), 
               \delaytime, msg[0].linlin(3, 48, 0.005, 0.0); ]);

~point1 = msg[3].linlin(4, 48, 9.0, 0.0); 
~point2 = msg[5].linlin(4, 48, 9.0, 0.0); 
 ~width = msg[0].explin(4, 48, 10.0, 0.7); 

   ~red = msg[3].linlin(4, 48, 0.0, 1.0);
 ~green = msg[5].linlin(4, 48, 0.0, 1.0);
  ~blue = msg[1].linlin(4, 48, 0.0, 1.0);
 ~alpha = msg[0].linlin(4, 48, 0.0, 1.0);
 
~rotate = msg[2].linlin(4, 48, 0.03, 0.0); 
 ~angle = msg[2].linlin(4, 48, 750, 385);
~angle2 = msg[4].linlin(4, 48, -385, 0);
~angle3 = msg[1].linlin(4, 48, 500, 0);
~height = msg[1].linlin(4, 48, 630, 150);
 
~matrix1 = msg[4].linlin(4, 48, 50.0, 0.0);
~matrix2 = msg[4].explin(4, 48, 3.0, 0.0);
~matrix3 = msg[4].explin(4, 48, 0.0, 1.0);
~matrix4 = msg[4].explin(4, 48, 1.0, 0.0);
~matrix5 = msg[1].linlin(4, 48, -1.97, 0.0);
};
});

~twinkle2 = ({
var w, run = true;
w = Window(border: false);
w.view.background = Color.black;
w.onClose = { run = false; };
w.front;
w.fullScreen;
w.drawHook = {
	Pen.use {
		Pen.translate(~angle + ~angle2 + ~angle3, ~height);
		Pen.color = Color.new(~red, ~green, ~blue, ~alpha); 
		Pen.width = ~width;
		Pen.matrix = [ ~matrix3 + ~matrix5, ~matrix4, ~matrix2, 
		               ~matrix3 + ~matrix5, ~matrix1, ~matrix1 ];
		100.do {
       Pen.beginPath;
       Pen.moveTo(Point(~point1 * 50 + 25, 10.rand * 50 + 25));
       Pen.lineTo(Point(10.rand * 50 + 25, ~point2 * 50 + 25));
       Pen.rotate(~rotate);
       Pen.stroke;
		};
	};
};

{ while { run } { w.refresh; 0.01pi.wait; } }.fork(AppClock)

});

~audiovisual2 = ({
~twinkle1.value;
~twinkle2.value;
});

~spy1 = ({
SynthDef(\noise, {  arg wh0 = 0, wh1 = 0, wh2 = 0, 
                        wh3 = 0, wh4 = 0, wh5 = 0;
                    var imp, whn, env, com, bpf, rev, pan, hpf; 
                     
                     	 imp = Impulse.kr(wh0, 0, 0.5);
                     	 whn = WhiteNoise.ar(imp, 5.0);
                         env = EnvGen.kr(Env.perc((wh5/1000), 0.2, 0.5, -5), 1.0, doneAction: 2);
	                 com = CombN.ar(whn, 0.01, wh3, mul: env);
	                 bpf = BPF.ar(com, wh2, 0.5.wrap2(1) * 0.5);
	                 rev = FreeVerb.ar(bpf, wh1, wh1, 0.8, 0.9); 
	                 pan = Pan2.ar(rev, 0, 0.5);      	                 
			 hpf = RHPF.ar(pan, wh4, 0.3.wrap2(1) * 0.3, 0.4);     
	                       Out.ar(0, hpf)}).send(s);

g.action = { 
| ... msg | 
       
Synth(\noise, [      \wh0, msg[5].linlin(3, 48, 1000.0, 1.0), 
                     \wh1, msg[1].linlin(3, 48, 1.0, 0.0), 
                     \wh2, msg[3].linlin(3, 48, 80.0, 10000.0), 
                     \wh3, msg[4].linlin(3, 48, 0.001, 0.01), 
                     \wh4, msg[0].linlin(3, 48, 7000, 80), 
                     \wh5, msg[2].linlin(3, 48, 0.0, 100.0); ]);

~param1 = msg[3].linlin(4, 45, 0.9, 1.07);        
~param2 = msg[0].linlin(4, 45, 2** -0.1, 2**0.1); 
~param3 = msg[1].linlin(4, 45, 1.03, 0.9);        
~param4 = msg[4].linlin(4, 45, 0.0, 3.0);        
~param5 = msg[2].linlin(4, 45, 0.0, 2.0);         
~param6 = msg[4].linlin(4, 45, 0.0, 19.7);        
~param7 = msg[2].linlin(4, 45, 0.0, 20.0);       
~param8 = msg[5].explin(4, 45, 2.1, 0.7);      

   ~red = msg[1].linlin(4, 45, 1.0, 0.5);         
 ~green = msg[3].linlin(4, 45, 1.0, 0.5);      
  ~blue = msg[5].linlin(4, 45, 1.0, 0.5);   

 ~angle = msg[5].linlin(4, 48, 750, 630);
~angle2 = msg[5].linlin(4, 48, -385, 0);
~angle3 = msg[1].linlin(4, 48, 500, 0);
~height = msg[1].linlin(4, 48, 630, 330);

~matrix1 = msg[5].linlin(4, 48, 50.0, 0.0);
~matrix2 = msg[5].explin(4, 48, 3.0, 0.0);
~matrix3 = msg[5].explin(4, 48, 0.0, 1.0);
~matrix4 = msg[5].explin(4, 48, 1.0, 0.0);
~matrix5 = msg[1].linlin(4, 48, -1.97, 0.0);

};
});

~spy2 = ({
var w, seed = Date.seed, phase = 0, 
    zoom = 0.7, zoomf = 1, run = true;
w = Window(border: false);
w.view.background = Color.black;
w.onClose = { run = false };
w.front;
w.fullScreen;
w.drawHook = {
	
	thisThread.randSeed = Date.seed;
	thisThread.randSeed = seed;
	Pen.use {
		var p1 = Point(~param6 + (800/~param5), ~param6 + (600/~param5)); //
		var p2 = Point(~param7 + (800/~param4), ~param7 + (600/~param4));
		var xscales = { ~param2 } ! 2; //
		var yscales = { ~param2 } ! 2; //
		var xlates = { 8 } ! 2;
		var ylates = { 8 } ! 2;
		var rots = { ~param2 + phase } ! 2; //
		var xform;
		xscales = (xscales ++ (1/xscales)) * ~param3;
		yscales = (yscales ++ (1/yscales)) * ~param1;
		xlates = xlates ++ xlates.neg;
		ylates = ylates ++ xlates.neg;
		rots = rots ++ rots.neg;
		xform = {|i| [xlates[i], ylates[i], rots[i], xscales[i], yscales[i]] } ! 2;
		Pen.strokeColor = Color.new(~red, ~green, ~blue);
		Pen.width = 8;
		Pen.translate(~angle + ~angle2 + ~angle3, ~height);
		Pen.scale(zoom, zoom);
		Pen.translate(-400, -400);
		Pen.matrix = [ ~matrix3 + ~matrix5, ~matrix4, ~matrix2, 
		               ~matrix3 + ~matrix5, ~matrix1, ~matrix1 ];
		100.do {
			var p, rot, xlate, ylate, xscale, yscale;
			Pen.width = ~param8;
			Pen.beginPath;
			#rot, xlate, ylate, xscale, yscale = xform.choose;
			Pen.translate(xlate, ylate);
			Pen.rotate(rot, 800/2, 800/2);
			Pen.scale(xscale, yscale);
			Pen.moveTo(p1);
			Pen.lineTo(p2);
			Pen.stroke;
		};
	};
};

{ while { run } { w.refresh; 0.001pi.wait; } }.fork(AppClock)

});

~audiovisual3 = ({
~spy1.value;
~spy2.value;
});

~bad1 = ({
SynthDef(\blip, { arg b1 = 0, b2 = 0, b3 = 0, 
                      b4 = 0, b5 = 0, b6 = 0; 
                  var env, mod, blip, pan, bpf, out;

 env = EnvGen.kr(Env.perc((b3/1000), 0.02, 0.5, -5), 1.0, doneAction: 2);
 mod = LFTri.kr(b5, 3) * 200 + 400;
blip = Blip.ar(b1 + mod, b2, env); 
 pan = Pan2.ar(blip, LFTri.kr(b6, 2), 0.9);
 bpf = BPF.ar(pan, b4, 0.5.fold2(1) * 0.5, 0.5 + LFTri.kr(b6, 2));
 out = Out.ar(0, bpf); 

}).send(s);

g.action = { 
| ... msg |         

Synth(\blip,  [  \b1, msg[5].linlin(3, 48, 10.midicps, 80.midicps), 
                 \b2, msg[4].linlin(3, 48, 0.0, 15.0), 
                 \b3, msg[3].linlin(3, 48, 0.0, 100.0), 
                 \b4, msg[2].linlin(3, 48, 80.0, 10000.0), 
                 \b5, msg[1].linlin(3, 48, 10.0, 0.0), 
                 \b6, msg[0].explin(3, 48, 100.0, 0.0); ]);

~rotate = msg[2].linlin(4, 48, 0.02, 0.0); 
~trans1 = msg[3].linlin(4, 48, 100.0, 0.0);
~trans2 = msg[4].linlin(4, 48, -20.0, 0.0);
~trans3 = msg[3].linlin(4, 48, -500.0, -130.0);
~trans4 = msg[4].linlin(4, 48, 500.0, 100.0);
~apart1 = msg[1].linlin(4, 48, 1000.0, 400.0);
~apart2 = msg[5].linlin(4, 48, 0.0, 200.0);
~apart3 = msg[5].linlin(4, 48, 0.0, 300.0);
~apart4 = msg[1].linlin(4, 48, 1000.0, 467.0);
~apart5 = msg[1].linlin(4, 48, 0.0, 1115.0);
~apart6 = msg[5].linlin(4, 48, 500.0, 150.0);
~apart7 = msg[5].linlin(4, 48, 400.0, 867.0);
~apart8 = msg[1].linlin(4, 48, 0.0, 992.0);
~apart9 = msg[5].linlin(4, 48, 1000.0, 325.0);
~apart0 = msg[5].linlin(4, 48, 0.0, 450.0);
~width1 = msg[0].linlin(4, 48, 30.0, 2.5);
   ~red = msg[3].linlin(2, 62, 0.0, 1.0);
 ~green = msg[5].linlin(2, 62, 0.0, 1.0);
  ~blue = msg[1].linlin(2, 62, 0.0, 1.0);
 ~alpha = msg[0].linlin(3, 28, 0.0, 1.0);

};
});

~bad2 = ({
var w, run = true, 
b1 = 200, b2 = 325, b3 = 400;
w = Window(border: false);
w.view.background = Color.black;
w.onClose = { run = false; };
w.front;
w.fullScreen;
w.drawHook = {
       Pen.use { 
		Pen.translate(~trans3, ~trans4);
		
		Pen.width = ~width1;
		40.do {		
           Pen.beginPath;     
			// B
			// left line
			Pen.moveTo(Point(~apart3, ~apart1));
			Pen.lineTo(Point(~apart3, ~apart2));	
			// right line
			Pen.moveTo(Point(~apart2, ~apart2));
			Pen.lineTo(Point(~apart2, ~apart1));
			// bottom line
			Pen.moveTo(Point(~apart2, ~apart2));
			Pen.lineTo(Point(~apart3, ~apart2));
			// middle line
			Pen.moveTo(Point(~apart4, ~apart9));
			Pen.lineTo(Point(~apart2, ~apart9));							
			// middle line continued
			Pen.moveTo(Point(834, ~apart9));
			Pen.lineTo(Point(565, ~apart9));	
			// bottom line?
			Pen.moveTo(Point(~apart2, ~apart1));
			Pen.lineTo(Point(~apart3, ~apart1));	
			// A
			// left line
			Pen.moveTo(Point(~apart3, ~apart1));
			Pen.lineTo(Point(380, ~apart2));
			// right line
			Pen.moveTo(Point(~apart4, ~apart1));
			Pen.lineTo(Point(380, ~apart2));
			// D
			// left line		
			Pen.moveTo(Point(~apart4, ~apart1));
			Pen.lineTo(Point(~apart4, ~apart2));					
			// curve
			Pen.moveTo(~apart4@~apart1);
			Pen.arcTo(900@290, ~apart4@~apart2, 96, pi);
			Pen.lineTo(~apart4@~apart2);
			
			// T
			// middle line
			Pen.moveTo(Point(700, ~apart1));
			Pen.lineTo(Point(700, ~apart6));	
			// top line
			Pen.moveTo(Point(1340, ~apart6));
			Pen.lineTo(Point(465, ~apart6));
			// A
			// left line 
			Pen.moveTo(Point(699.5, ~apart1));
			Pen.lineTo(Point(780, ~apart2));
			// right line
			Pen.moveTo(Point(867.5, ~apart1));
			Pen.lineTo(Point(780, ~apart2));
			// N 
			// left line 
			Pen.moveTo(Point(~apart7, ~apart1));
			Pen.lineTo(Point(~apart7, ~apart2));
			// right line
			Pen.moveTo(Point(~apart8, ~apart1));
			Pen.lineTo(Point(~apart8, ~apart2));		
			// diagonal line
			Pen.moveTo(Point(~apart8, ~apart1));
			Pen.lineTo(Point(~apart7, ~apart2));
			// G
			// vertical line
			Pen.moveTo(Point(~apart5, ~apart0));
			Pen.lineTo(Point(~apart5, ~apart2));					
			// horizontal line
			Pen.moveTo(Point(~apart5, ~apart0));
			Pen.lineTo(Point(~apart2, ~apart0));	
			// curve
			Pen.moveTo(~apart5@~apart1);
			Pen.arcTo(600@~apart3, ~apart5@~apart2, 97, pi);
			Pen.lineTo(~apart5@~apart2);
			Pen.stroke;
			// O
			// circle
			Pen.addWedge(1240@~apart3, 100, 2pi, 2pi);
			Pen.fill;
			Pen.translate(~trans1, ~trans2);
			Pen.rotate(~rotate);	
			Pen.color = Color.new(~red, ~green, ~blue, ~alpha);		
						
}; // end do
}; // end use
}; // end drawhook

{ while { run } { w.refresh; 0.01pi.wait; } }.fork(AppClock)

});

~audiovisual4 = ({
~bad1.value;
~bad2.value;
});

~atsaction = ({
SynthDef(\ATSsynth, 	
        { arg fm, rate, reverb, pany, cutoff, add, attack;
          var env, ats, pan, rlpf, rev, out;

 env = EnvGen.kr(Env.perc((attack/1000), 0.02, 0.5, -5), 1.0, doneAction: 2);
 ats = AtsSynth.ar(b.bufnum, b.numPartials, 0, 1, 
		filePointer: LFSaw.kr(b.sndDur.reciprocal, 1, rate, add), 
		    freqMul: fm,
		    freqAdd: 50.0, 
		        mul: env);   

 pan = Pan2.ar(ats, pany, 0.5);
rlpf = RLPF.ar(pan, cutoff, 0, 0.5);
 out = Out.ar(0, rlpf);
  	
}).send(s);

g.action = { 
| ... msg | 

Synth(\ATSsynth, [    \fm, msg[3].linlin(4, 48, 1.0, 46.0), 
                    \rate, msg[1].explin(4, 48, 0.0001, 1.0), 
                  \attack, msg[4].linlin(4, 48, 0.0, 150.0), 
                  \cutoff, msg[5].linlin(4, 48, 80, 10000), 
                     \add, msg[2].linlin(2, 62, 0.6, 0.0); ]);

~param1 = msg[3].linlin(4, 48, 1.07, 0.9);      
~param2 = msg[0].linlin(4, 48, 2** -0.1, 2**0.1);
~param3 = msg[1].linlin(4, 48, 1.03, 0.9);       
~param4 = msg[4].linlin(4, 48, 0.0, 2.0);        
~param5 = msg[2].linlin(4, 48, 0.0, 2.0);       
~param6 = msg[4].linlin(4, 48, 0.0, 19.0);       
~param7 = msg[2].linlin(4, 48, 0.0, 20.0);        
~param8 = msg[5].linlin(4, 48, 40.0, 1.0);      
~param9 = msg[5].explin(4, 48, 50.0, 1.0);      
   ~red = msg[1].linlin(4, 45, 0.0, 0.6);       
 ~green = msg[3].linlin(4, 45, 0.0, 0.6);       
  ~blue = msg[4].linlin(4, 45, 0.0, 0.6);         

};
});

~atsvisual = ({
var w, seed = Date.seed, phase = 0, 
    zoom = 0.7, zoomf = 1, run = true;
w = Window(border: false);
w.view.background = Color.black;
w.onClose = { run = false };
w.front;
w.fullScreen;
w.drawHook = {
	
	thisThread.randSeed = Date.seed;
	thisThread.randSeed = seed;
	Pen.use {
		var p1 = Point(~param6 + (800/~param5), ~param6 + (600/~param5)); 
		var p2 = Point(~param7 + (800/~param4), ~param7 + (600/~param4));
		var xscales = { ~param2 } ! 2; 
		var yscales = { ~param2 } ! 2; 
		var xlates = { 16 } ! 4;
		var ylates = { 16 } ! 4;
		var rots = { ~param2 + phase } ! 2; 
		var xform;
		    xscales = (xscales ++ (1/xscales)) * ~param3;
		    yscales = (yscales ++ (1/yscales)) * ~param1;
		    xlates = xlates ++ xlates.neg;
		    ylates = ylates ++ xlates.neg;
		    rots = rots ++ rots.neg;
		    xform = {|i| [ xlates[i], ylates[i], rots[i], xscales[i], yscales[i] ] } ! 2;
		Pen.strokeColor = Color.new(~red, ~green, ~blue);
		Pen.width = ~param9;
		Pen.translate(630, 373);
		Pen.scale(zoom, zoom);
		Pen.translate(-400, -400);
500.do {
		var p, rot, xlate, ylate, xscale, yscale;
		Pen.width = ~param8;
		Pen.beginPath;
		    #rot, xlate, ylate, xscale, yscale = xform.choose;
		Pen.translate(xlate, ylate);
		Pen.rotate(rot, 800/2, 800/2);
		Pen.scale(xscale, yscale);
		Pen.moveTo(p1);
		Pen.lineTo(p2);
		Pen.stroke;
		};
	};
};

{ while { run } { w.refresh; 0.005pi.wait; } }.fork(AppClock)

});

~audiovisual5 = ({
~atsaction.value;
~atsvisual.value;
});

)

