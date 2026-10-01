@echo off
title Computer Wrapped
echo Reading your Windows usage history...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=[IO.File]::ReadAllText('%~f0',[Text.Encoding]::UTF8); $i=$c.IndexOf('#PS'+'START'); Invoke-Expression $c.Substring($i)"
echo.
pause
exit /b
#PSSTART
$template = @'
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">
<title>Computer Wrapped</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bricolage+Grotesque:opsz,wght@12..96,400;12..96,600;12..96,800&display=swap" rel="stylesheet">
<style>
:root{
  --ink:#16112a; --paper:#fff6e8; --pink:#ff4f9a; --blue:#2c3bff; --lemon:#ffe84a; --mint:#35f0b0; --orange:#ff7a2f;
  --font:'Bricolage Grotesque','Segoe UI',system-ui,-apple-system,Helvetica,Arial,sans-serif;
  box-sizing:border-box;
  padding-top:env(safe-area-inset-top,0px);
  padding-bottom:env(safe-area-inset-bottom,0px);
}
html{height:100%;scroll-padding-top:env(safe-area-inset-top,0px)}
*,*::before,*::after{box-sizing:inherit}
body{margin:0;min-height:100%;background:var(--ink);color:var(--paper);font-family:var(--font);-webkit-font-smoothing:antialiased}
button,textarea,select,input{font:inherit;color:inherit}

/* ---------- setup ---------- */
#setup{max-width:560px;margin:0 auto;padding:28px 20px 48px}
#setup h1{font-size:clamp(40px,11vw,64px);line-height:.95;margin:8px 0 12px;font-weight:800;letter-spacing:-.03em}
#setup p.lead{font-size:18px;line-height:1.45;margin:0 0 24px;opacity:.85;max-width:44ch}
label.f{display:block;font-weight:600;margin:18px 0 8px}
textarea{width:100%;min-height:230px;border-radius:16px;border:2px solid rgba(255,246,232,.25);background:rgba(255,246,232,.06);padding:14px 16px;line-height:1.6;resize:vertical}
textarea:focus,select:focus,button:focus-visible,summary:focus-visible{outline:3px solid var(--lemon);outline-offset:2px}
select{border-radius:12px;border:2px solid rgba(255,246,232,.25);background:var(--ink);padding:10px 14px}
.hint{font-size:14px;opacity:.7;margin:8px 0 0}
.go{display:block;width:100%;margin-top:26px;border:0;border-radius:999px;background:var(--lemon);color:var(--ink);font-weight:800;font-size:20px;padding:18px 24px;cursor:pointer;transition:transform .15s}
.go:hover{transform:scale(1.02)}
.go:active{transform:scale(.98)}
.err{color:var(--pink);font-weight:600;margin-top:10px;min-height:1.4em}
details{margin-top:28px;border-top:1px solid rgba(255,246,232,.2);padding-top:16px}
summary{cursor:pointer;font-weight:600}
details ul{line-height:1.6;padding-left:20px;opacity:.85}

/* ---------- story ---------- */
#story{display:none;position:fixed;inset:0;background:var(--ink);justify-content:center;align-items:center}
#story.on{display:flex}
.phone{position:relative;width:100%;height:100%;max-width:440px;overflow:hidden;color:var(--ink);transition:background .4s,color .4s}
@media(min-width:600px){.phone{height:min(820px,94vh);border-radius:28px;box-shadow:0 20px 80px rgba(0,0,0,.5)}}
.bars{position:absolute;top:calc(env(safe-area-inset-top,0px) + 12px);left:14px;right:14px;display:flex;gap:5px;z-index:5}
.bars i{flex:1;height:4px;border-radius:2px;background:rgba(127,127,127,.35);overflow:hidden}
.bars i b{display:block;height:100%;width:0;background:currentColor}
.bars i.done b{width:100%}
.bars i.cur b{width:100%;animation:fill 7s linear forwards}
.paused .bars i.cur b{animation-play-state:paused}
@keyframes fill{from{width:0}to{width:100%}}
.slide{position:absolute;inset:0;padding:68px 28px calc(36px + env(safe-area-inset-bottom,0px));display:flex;flex-direction:column;justify-content:center}
.slide>*{margin:0}
.slide h1,.slide h2{font-weight:800;letter-spacing:-.035em;line-height:.92}
.slide h1{font-size:clamp(46px,14vw,66px)}
.slide h2{font-size:clamp(34px,10vw,46px)}
.big{font-size:clamp(110px,38vw,170px);font-weight:800;letter-spacing:-.06em;line-height:.85}
.name{font-size:clamp(48px,15vw,76px);font-weight:800;letter-spacing:-.04em;line-height:.9;overflow-wrap:anywhere}
.sub{font-size:20px;line-height:1.35;font-weight:600;margin-top:20px;max-width:30ch}
.quote{font-size:23px;line-height:1.3;font-weight:600;margin-top:26px;padding:18px 20px;background:var(--ink);color:var(--paper);border-radius:20px 20px 20px 4px}
.tiny{font-size:14px;font-weight:600;opacity:.7;margin-top:18px}
.rank{list-style:none;padding:0;margin:22px 0 0;display:grid;gap:14px}
.rank li{display:grid;grid-template-columns:1fr auto;gap:2px 10px;align-items:end;font-weight:800;font-size:22px;letter-spacing:-.02em}
.rank li span.h{font-weight:600;font-size:16px}
.rank li .bar{grid-column:1/-1;height:12px;border-radius:6px;background:rgba(127,127,127,.3);overflow:hidden}
.rank li .bar u{display:block;height:100%;border-radius:6px;background:currentColor;transform-origin:left;animation:grow 1s cubic-bezier(.2,.8,.2,1) both}
@keyframes grow{from{transform:scaleX(0)}}
.cast{display:grid;gap:18px;margin-top:22px}
.cast div{background:rgba(127,127,127,.18);border-radius:18px;padding:16px 18px}
.cast b{font-size:26px;letter-spacing:-.03em;display:block}
.cast span{font-size:17px;font-weight:600;line-height:1.3;display:block;margin-top:4px}
.stats{display:grid;gap:14px;margin-top:22px}
.stats div{border-top:3px solid currentColor;padding-top:8px}
.stats b{font-size:44px;letter-spacing:-.04em;line-height:1;display:block}
.stats span{font-size:16px;font-weight:600}
.share{background:var(--ink);color:var(--paper);border-radius:24px;padding:24px 22px}
.share h2{font-size:30px}
.share ol{padding:0;margin:16px 0 0;list-style:none;display:grid;gap:8px;font-size:20px;font-weight:600}
.share ol li{display:flex;justify-content:space-between;gap:12px}
.share .who{margin-top:18px;color:var(--lemon);font-weight:800;font-size:24px;letter-spacing:-.02em;line-height:1.1}
.share .tiny{color:var(--paper)}
.btns{display:flex;flex-wrap:wrap;gap:10px;margin-top:16px;position:relative;z-index:6}
.btns button.dl{flex:1 1 100%;background:var(--lemon);color:var(--ink);font-size:17px;padding:16px}
.btns button{flex:1;border:0;border-radius:999px;padding:14px;font-weight:800;cursor:pointer;background:var(--ink);color:var(--paper)}
.btns button.alt{background:transparent;border:2px solid var(--ink);color:var(--ink)}
.tap{position:absolute;top:0;bottom:0;z-index:4;width:34%;background:none;border:0;cursor:pointer}
.tap.l{left:0}.tap.r{right:0;width:66%}
.in{animation:rise .7s cubic-bezier(.2,.8,.2,1) both}
@keyframes rise{from{opacity:0;transform:translateY(24px)}}
.in2{animation-delay:.18s}.in3{animation-delay:.4s}
@media(prefers-reduced-motion:reduce){
  .in,.rank li .bar u{animation:none}
  .bars i.cur b{animation:none}
}
</style>
</head>
<body>

<main id="setup">
  <h1>Computer Wrapped</h1>
  <p class="lead">Built from the app time your computer actually logged. Edit any line if you want to lie to yourself.</p>

  <label class="f" for="data">Your tracked apps and hours</label>
  <textarea id="data" spellcheck="false" data-auto="1">{{DATA}}</textarea>
  <p class="hint">One app per line, like "Chrome: 112".</p>



  <div class="err" id="err" role="alert"></div>
  <button class="go" id="go">Roast my computer</button>


</main>

<section id="story" aria-label="Your Computer Wrapped">
  <div class="phone" id="phone">
    <div class="bars" id="bars"></div>
    <button class="tap l" id="prev" aria-label="Previous slide"></button>
    <button class="tap r" id="next" aria-label="Next slide"></button>
    <div id="slide"></div>
  </div>
</section>

<script>window.__DAYS__={{DAYS}};window.__LABEL__="{{LABEL}}";</script>
<script>
(function(){
  var $=function(s){return document.querySelector(s)};
  var esc=function(s){return String(s).replace(/[&<>"']/g,function(c){return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]})};
  var fmt=function(h){return (Math.round(h*10)/10).toString()};
  var hash=function(s){var x=0;for(var i=0;i<s.length;i++){x=(x*31+s.charCodeAt(i))>>>0}return x};
  var pick=function(arr,seed){return arr[hash(seed)%arr.length]};

  /* ---------- roast database ---------- */
  var DB=[
    {re:/valorant/i,cat:'games',q:[function(n,h){return h+' hours of Valorant. Your teammates were the problem every single game. Statistically, no.'}]},
    {re:/league of legends|leagueclient/i,cat:'games',q:[function(n,h){return h+' hours of League of Legends. Friendships ended. The keyboard survived.'}]},
    {re:/fortnite/i,cat:'games',q:[function(n,h){return h+' hours of Fortnite. Dancing counts as cardio, we guess.'}]},
    {re:/minecraft/i,cat:'games',q:[function(n,h){return h+' hours of Minecraft. You built a dirt house and called it a mansion.'}]},
    {re:/roblox/i,cat:'games',q:[function(n,h){return h+' hours of Roblox. Bold of you to say you have "stuff to do".'}]},
    {re:/cs2|counter-strike|csgo/i,cat:'games',q:[function(n,h){return h+' hours of Counter-Strike. "One more round" is the biggest lie in gaming.'}]},
    {re:/firefox/i,cat:'browser',q:[function(n,h){return h+' hours in Firefox. You have mentioned this at every party. We know.'}]},
    {re:/code|cursor|intellij|pycharm|webstorm|sublime|vim|emacs|xcode|android studio/i,cat:'code',q:[
      function(n,h){return h+' hours in '+n+'. Bold of you to call it "work" when a third of it was picking a color theme.'},
      function(n,h){return h+' hours in '+n+' and the bug was a missing semicolon. We both knew it.'},
      function(n,h){return 'You spent '+h+' hours in '+n+'. Somewhere, a "quick fix" is still not fixed.'}]},
    {re:/\b(chrome|firefox|safari|edge|brave|opera|vivaldi|arc)\b|browser/i,cat:'browser',q:[
      function(n,h){return h+' hours in '+n+'. Zero of your 63 open tabs were read. We counted.'},
      function(n,h){return h+' hours in '+n+', and "just one quick search" has been going since Tuesday.'},
      function(n,h){return n+' for '+h+' hours. You opened a tab to check one thing and never came back.'}]},
    {re:/discord|slack|teams|telegram|whatsapp|signal|messenger|zoom|meet|skype/i,cat:'chat',q:[
      function(n,h){return h+' hours in '+n+'. This could have been an email. Several times.'},
      function(n,h){return h+' hours in '+n+'. Half of it was typing, deleting, and typing again.'},
      function(n,h){return n+' ate '+h+' hours. You said "quick call" and meant it every single time.'}]},
    {re:/spotify|music|itunes|apple music|tidal|youtube music|deezer/i,cat:'media',q:[
      function(n,h){return h+' hours of '+n+'. Your "focus playlist" has never once helped you focus.'},
      function(n,h){return n+' ran for '+h+' hours. Impressive commitment to background noise.'}]},
    {re:/youtube|netflix|twitch|prime video|disney|hulu|vlc|plex|tiktok|reddit|twitter|instagram|facebook|x\.com/i,cat:'media',q:[
      function(n,h){return h+' hours of '+n+'. Research, obviously.'},
      function(n,h){return h+' hours in '+n+'. "Just one more" is the most expensive lie you tell.'},
      function(n,h){return n+': '+h+' hours. Your future self has questions.'}]},
    {re:/steam|epic|game|minecraft|valorant|league|fortnite|battle\.net|riot|roblox|gta|cs2|counter/i,cat:'games',q:[
      function(n,h){return h+' hours in '+n+'. Your chair has taken the shape of a person who "just wanted to relax".'},
      function(n,h){return n+' for '+h+' hours. That is a part-time job with no salary and worse management.'}]},
    {re:/excel|sheets|numbers|word|docs|powerpoint|slides|outlook|mail|onenote|access/i,cat:'office',q:[
      function(n,h){return h+' hours in '+n+'. Thrilling. Truly the stuff of legends.'},
      function(n,h){return n+' for '+h+' hours. Someone out there has no idea how much work you do. Or how little they pay for it.'}]},
    {re:/terminal|iterm|powershell|cmd|bash|zsh|warp|console|ssh|putty/i,cat:'code',q:[
      function(n,h){return h+' hours in '+n+'. You typed "ls" 400 times and felt powerful.'},
      function(n,h){return h+' hours in '+n+'. Half of it was Googling how to exit vim.'}]},
    {re:/figma|photoshop|illustrator|canva|sketch|blender|premiere|after effects|davinci|lightroom|procreate/i,cat:'creative',q:[
      function(n,h){return h+' hours in '+n+'. Moving things 1 pixel left, then 1 pixel right. Art.'},
      function(n,h){return n+' for '+h+' hours, and the client still said "can you make the logo bigger?"'}]},
    {re:/notion|obsidian|evernote|todoist|trello|jira|asana|linear|calendar/i,cat:'office',q:[
      function(n,h){return h+' hours in '+n+'. Organizing your to-do list instead of doing the to-do list. A classic.'},
      function(n,h){return n+' for '+h+' hours. Your system is flawless. Your output, less so.'}]},
    {re:/chatgpt|claude|gemini|copilot|perplexity|\bai\b/i,cat:'ai',q:[
      function(n,h){return h+' hours in '+n+'. At this point it is basically your coworker. Maybe say thanks.'}]},
    {re:/notepad|textedit|notes|sticky/i,cat:'office',q:[
      function(n,h){return h+' hours in '+n+'. A single note titled "ideas" with nothing in it.'}]}
  ];
  var GENERIC=[
    function(n,h){return h+' hours in '+n+'. We are not going to ask. We are just going to remember.'},
    function(n,h){return n+' for '+h+' hours. Nobody can say you lack commitment.'},
    function(n,h){return h+' hours in '+n+'. That is a lot of dedication to something you probably cannot explain at dinner.'},
    function(n,h){return n+'? '+h+' hours? Okay, champ.'}];

  function find(name){for(var i=0;i<DB.length;i++){if(DB[i].re.test(name))return DB[i]}return null}
  function roast(a){
    var e=find(a.name),h=fmt(a.hours);
    var arr=e?e.q:GENERIC;
    return pick(arr,a.name)(esc(a.name),h);
  }

  var PERSONA={
    code:['The Bug Farmer','You write code, you break code, you blame the compiler. Beautiful cycle.'],
    browser:['The Tab Hoarder','Your browser is not a tool. It is a hoard. A digital attic of unread articles.'],
    chat:['The Notification Victim','Your day belongs to whoever pinged you last.'],
    games:['The "Just One Match" Liar','Productivity is a rumor. You have a ranked ladder to climb.'],
    media:['The Desktop Couch Potato','You have a perfectly good computer and you use it as a very small TV.'],
    office:['The Spreadsheet Goblin','You can make a pivot table cry, and nobody has ever thanked you.'],
    creative:['The Pixel Perfectionist','Nothing ships. Everything is "almost done". It looks great, though.'],
    system:['The Folder Rearranger','You are not working, you are reorganizing. The desktop will still be a mess.'],
    ai:['The Prompt Whisperer','You talk to robots more than people. To be fair, they are more polite.'],
    other:['The Mysterious Enigma','We cannot categorize you. That is either impressive or concerning.']
  };

  var CATS={browser:'Browsers',code:'Coding & terminals',chat:'Chat & meetings',media:'Music & video',games:'Games',office:'Office & notes',creative:'Design & editing',system:'System & files',ai:'AI tools',other:'Everything else'};
  var CATQ={
    browser:function(p){return p+'% of your time is just a browser. Tabs are not a personality, but yours is close.'},
    code:function(p){return p+'% coding. You are the reason "works on my machine" exists.'},
    chat:function(p){return p+'% in chat apps. You are not busy. You are just available.'},
    media:function(p){return p+'% music and video. Your computer is a very expensive jukebox.'},
    games:function(p){return p+'% gaming. Productivity called and left a voicemail.'},
    office:function(p){return p+'% in office apps. Thrilling. A dream life.'},
    creative:function(p){return p+'% creating. Impressive. Now finish one thing.'},
    system:function(p){return p+'% in system stuff and folders. You are not working, you are rearranging.'},
    ai:function(p){return p+'% talking to AI. They never interrupt, to be fair.'},
    other:function(p){return p+'% in apps we cannot even name. Mysterious. Slightly alarming.'}
  };
  function catOf(a){return CATS[a.cat]?a.cat:((find(a.name)||{}).cat||'other')}

  function totalRoast(pct){
    if(pct<5)return 'Suspiciously low. Do you own a computer, or a very expensive paperweight?';
    if(pct<20)return 'Respectable. Healthy, even. We are slightly suspicious.';
    if(pct<40)return 'That is basically a full-time job. Unpaid. Without benefits.';
    if(pct<70)return 'At this point the computer should be paying you rent.';
    return 'Touch grass. Legally we have to say it. Seriously, go outside.';
  }

  /* ---------- parsing ---------- */
  function parse(t){
    var seen={},out=[];
    t.split(/\n/).forEach(function(l){
      l=l.trim();if(!l)return;
      var m=l.match(/^(.*?)[\s:,=\-\u2013\u2014\t]+(\d+(?:[.,]\d+)?)\s*(?:h|hr|hrs|hours?)?\s*$/i);
      if(!m)return;
      var name=m[1].replace(/[\s:,=\-\u2013\u2014]+$/,'').trim();
      var hours=parseFloat(m[2].replace(',','.'));
      var cat=null,cm=name.match(/^(.*?)\s*\[([^\]]+)\]$/);
      if(cm){name=cm[1].trim();cat=cm[2].trim().toLowerCase()}
      if(!name||!(hours>0))return;
      var k=name.toLowerCase();
      if(seen[k]!==undefined){out[seen[k]].hours+=hours}else{seen[k]=out.length;out.push({name:name,hours:hours,cat:cat})}
    });
    out.sort(function(a,b){return b.hours-a.hours});
    return out;
  }

  /* ---------- slides ---------- */
  var slides=[],idx=0,timer=null,countAnims=[];

  function build(apps,period){
    var days=window.__DAYS__||30;
    var label=window.__LABEL__||'month';
    var total=apps.reduce(function(s,a){return s+a.hours},0);
    var top=apps[0];
    var pct=total/(days*16)*100;
    var avg=total/days;
    var ct={};
    apps.forEach(function(a){var c=catOf(a);ct[c]=(ct[c]||0)+a.hours});
    var cl=Object.keys(ct).map(function(k){return {id:k,h:ct[k]}}).sort(function(a,b){return b.h-a.h});
    var persona=PERSONA[cl[0].id]||PERSONA.other;
    var S=[];

    S.push({bg:'var(--lemon)',html:
      '<p class="tiny in">Computer Wrapped</p>'+
      '<h1 class="in in2">Your '+label+' on this machine.</h1>'+
      '<p class="sub in in3">We counted. We judged. You cannot un-know this.</p>'});

    var fun=total>=11.4
      ? 'That is '+fmt(total/11.4)+' extended Lord of the Rings trilogies. Frodo walked less.'
      : 'That is '+Math.round(total*60/22)+' episodes of The Office. Michael Scott would be proud.';
    S.push({bg:'var(--pink)',html:
      '<p class="sub in" style="margin:0 0 12px">You spent a total of</p>'+
      '<div class="big in in2" data-count="'+total+'">0</div>'+
      '<h2 class="in in2" style="margin-top:8px">hours on your computer.</h2>'+
      '<p class="sub in in3">'+esc(fun)+'</p>'});

    S.push({bg:'var(--blue)',light:true,html:
      '<p class="sub in" style="margin:0 0 14px">Your number one app was</p>'+
      '<div class="name in in2">'+esc(top.name)+'</div>'+
      '<p class="sub in in2" style="margin-top:12px"><span data-count="'+top.hours+'">0</span> hours, which is '+Math.round(top.hours/total*100)+'% of everything you did.</p>'+
      '<div class="quote in in3">'+roast(top)+'</div>'});

    var top5=apps.slice(0,5),mx=top5[0].hours;
    var li=top5.map(function(a,i){
      return '<li><span>'+(i+1)+'. '+esc(a.name)+'</span><span class="h">'+fmt(a.hours)+' h</span><span class="bar"><u style="width:'+Math.max(4,a.hours/mx*100)+'%;animation-delay:'+(.15*i)+'s"></u></span></li>';
    }).join('');
    S.push({bg:'var(--mint)',html:
      '<h2 class="in">Your top '+top5.length+'.</h2>'+
      '<ul class="rank in in2">'+li+'</ul>'});

    if(apps.length>1){
      var cast=apps.slice(1,3).map(function(a,i){
        return '<div><b>#'+(i+2)+': '+esc(a.name)+'</b><span>'+roast(a)+'</span></div>';
      }).join('');
      S.push({bg:'var(--orange)',html:
        '<h2 class="in">The supporting cast.</h2>'+
        '<div class="cast in in2">'+cast+'</div>'});
    }

    var crow=cl.slice(0,5).map(function(c,i){
      var p=Math.round(c.h/total*100);
      return '<li><span>'+esc(CATS[c.id])+'</span><span class="h">'+p+'%</span><span class="bar"><u style="width:'+Math.max(4,c.h/cl[0].h*100)+'%;animation-delay:'+(.15*i)+'s"></u></span></li>';
    }).join('');
    S.push({bg:'var(--blue)',light:true,html:
      '<h2 class="in">Where your time really went.</h2>'+
      '<ul class="rank in in2">'+crow+'</ul>'+
      '<p class="sub in in3">'+CATQ[cl[0].id](Math.round(cl[0].h/total*100))+'</p>'});

    STATS={label:label,total:total,top:apps.slice(0,5),
      catLabel:CATS[cl[0].id],catPct:Math.round(cl[0].h/total*100),
      persona:persona[0],blurb:persona[1]};

    var daily=avg>=1?fmt(avg)+' hours':Math.round(avg*60)+' minutes';
    S.push({bg:'var(--paper)',html:
      '<h2 class="in">The damage report.</h2>'+
      '<div class="stats in in2">'+
        '<div><b>'+daily+'</b><span>per day, on average</span></div>'+
        '<div><b>'+Math.round(pct)+'%</b><span>of your waking hours, assuming you sleep 8</span></div>'+
        '<div><b>'+apps.length+'</b><span>apps you chose over sunlight</span></div>'+
      '</div>'+
      '<p class="sub in in3">'+totalRoast(pct)+'</p>'});

    S.push({bg:'var(--lemon)',html:
      '<p class="sub in" style="margin:0 0 12px">Your computer personality is</p>'+
      '<h1 class="in in2">'+esc(persona[0])+'</h1>'+
      '<p class="sub in in3">'+esc(persona[1])+'</p>'});

    var t3=apps.slice(0,3).map(function(a){return '<li><span>'+esc(a.name)+'</span><span>'+fmt(a.hours)+' h</span></li>'}).join('');
    S.push({bg:'var(--pink)',final:true,html:
      '<div class="share in">'+
        '<h2>My '+label+' on this machine</h2>'+
        '<ol>'+t3+'</ol>'+
        '<div class="who">'+esc(persona[0])+'</div>'+
        '<p class="tiny">'+fmt(total)+' hours total. No regrets (some regrets).</p>'+
      '</div>'+
      '<div class="btns"><button id="dl" class="dl">Download image for Instagram</button><button id="again" class="">Replay</button><button id="edit" class="alt">Edit my data</button></div>'+
      '<p class="tiny in in3" style="text-align:center">Screenshot this and ruin someone\'s day.</p>'});
    return S;
  }

  /* ---------- shareable image (1080x1920, Instagram story size) ---------- */
  var REPO='https://github.com/Crashed-Again/computer-wrapped';
  var STATS=null;
  function wrapText(ctx,text,maxW){
    var words=text.split(' '),lines=[],cur='';
    words.forEach(function(w){
      var t=cur?cur+' '+w:w;
      if(ctx.measureText(t).width>maxW&&cur){lines.push(cur);cur=w}else{cur=t}
    });
    if(cur)lines.push(cur);
    return lines;
  }
  function fitText(ctx,text,maxW){
    if(ctx.measureText(text).width<=maxW)return text;
    while(text.length>1&&ctx.measureText(text+'...').width>maxW)text=text.slice(0,-1);
    return text+'...';
  }
  function rrect(ctx,x,y,w,h,r){
    r=Math.min(r,w/2,h/2);
    ctx.beginPath();ctx.moveTo(x+r,y);
    ctx.arcTo(x+w,y,x+w,y+h,r);ctx.arcTo(x+w,y+h,x,y+h,r);
    ctx.arcTo(x,y+h,x,y,r);ctx.arcTo(x,y,x+w,y,r);ctx.closePath();
  }
  function drawCard(st){
    var W=1080,H=1920,c=document.createElement('canvas');
    c.width=W;c.height=H;
    var x=c.getContext('2d');
    var F='"Bricolage Grotesque","Segoe UI",system-ui,Helvetica,Arial,sans-serif';
    var L=120,R=W-120,y;
    x.fillStyle='#ff4f9a';x.fillRect(0,0,W,H);
    x.fillStyle='#16112a';rrect(x,60,60,W-120,H-120,56);x.fill();
    x.textBaseline='alphabetic';x.textAlign='left';

    x.globalAlpha=.7;x.fillStyle='#fff6e8';x.font='600 40px '+F;
    x.fillText('Computer Wrapped',L,170);x.globalAlpha=1;

    x.font='800 84px '+F;x.fillStyle='#fff6e8';
    y=270;
    var hl=wrapText(x,'My '+st.label+' on this machine',R-L);
    hl.forEach(function(l,i){x.fillText(l,L,y);if(i<hl.length-1)y+=86});

    var big=fmt(st.total),fs=240,tw;
    do{x.font='800 '+fs+'px '+F;tw=x.measureText(big).width;fs-=10}while(tw>R-L-230&&fs>90);
    y+=220;
    x.fillStyle='#ffe84a';x.fillText(big,L,y);
    x.font='800 64px '+F;x.fillStyle='#fff6e8';x.fillText('hours',L+tw+28,y);

    y+=120;
    var mx=st.top[0].hours,cols=['#ff4f9a','#35f0b0','#ffe84a','#ff7a2f','#8f98ff'];
    st.top.forEach(function(a,i){
      x.textAlign='left';x.font='800 48px '+F;x.fillStyle='#fff6e8';
      x.fillText(fitText(x,a.name,600),L,y);
      x.textAlign='right';x.font='600 42px '+F;x.fillText(fmt(a.hours)+' h',R,y);
      x.textAlign='left';
      rrect(x,L,y+20,R-L,16,8);x.fillStyle='rgba(255,246,232,.16)';x.fill();
      rrect(x,L,y+20,Math.max(16,(R-L)*a.hours/mx),16,8);x.fillStyle=cols[i%cols.length];x.fill();
      y+=100;
    });

    y+=40;
    x.font='600 38px '+F;x.fillStyle='#fff6e8';x.globalAlpha=.7;
    x.fillText('Most time went to',L,y);x.globalAlpha=1;
    y+=76;
    x.font='800 68px '+F;x.fillStyle='#35f0b0';
    x.fillText(fitText(x,st.catLabel+' ('+st.catPct+'%)',R-L),L,y);

    y+=110;
    x.font='600 38px '+F;x.fillStyle='#fff6e8';x.globalAlpha=.7;
    x.fillText('My computer personality',L,y);x.globalAlpha=1;
    y+=84;
    x.font='800 78px '+F;x.fillStyle='#ffe84a';
    wrapText(x,st.persona,R-L).forEach(function(l){x.fillText(l,L,y);y+=84});

    x.font='600 34px '+F;x.fillStyle='#fff6e8';x.globalAlpha=.7;
    x.fillText('Get your own:',L,1735);x.globalAlpha=1;
    var us=40;
    do{x.font='700 '+us+'px '+F;us-=2}while(x.measureText(REPO).width>R-L&&us>16);
    x.fillStyle='#fff6e8';x.fillText(REPO,L,1790);
    return c;
  }
  function downloadCard(){
    if(!STATS)return;
    var go=function(){
      var c=drawCard(STATS);
      c.toBlob(function(b){
        var a=document.createElement('a');
        a.href=URL.createObjectURL(b);
        a.download='computer-wrapped.png';
        document.body.appendChild(a);a.click();a.remove();
        setTimeout(function(){URL.revokeObjectURL(a.href)},3000);
      },'image/png');
    };
    if(document.fonts&&document.fonts.load){
      Promise.all([document.fonts.load('800 80px "Bricolage Grotesque"'),document.fonts.load('600 40px "Bricolage Grotesque"')]).then(go,go);
    }else{go()}
  }

  function stopCounts(){countAnims.forEach(cancelAnimationFrame);countAnims=[]}
  function runCounts(){
    var reduce=window.matchMedia&&window.matchMedia('(prefers-reduced-motion: reduce)').matches;
    document.querySelectorAll('[data-count]').forEach(function(el){
      var target=parseFloat(el.getAttribute('data-count')),t0=null,dur=1100;
      if(reduce){el.textContent=fmt(target);return}
      function step(ts){
        if(!t0)t0=ts;
        var p=Math.min(1,(ts-t0)/dur),e=1-Math.pow(1-p,3);
        el.textContent=target>=20?Math.round(target*e):fmt(target*e);
        if(p<1)countAnims.push(requestAnimationFrame(step));else el.textContent=fmt(target);
      }
      countAnims.push(requestAnimationFrame(step));
    });
  }

  function render(){
    stopCounts();
    var s=slides[idx],phone=$('#phone');
    phone.style.background=s.bg;phone.style.color=s.light?'var(--paper)':'var(--ink)';
    $('#slide').innerHTML='<div class="slide">'+s.html+'</div>';
    var bars=$('#bars');bars.innerHTML='';
    slides.forEach(function(_,i){
      var el=document.createElement('i');
      el.className=i<idx?'done':(i===idx?'cur':'');
      el.innerHTML='<b></b>';
      bars.appendChild(el);
    });
    var cur=bars.querySelector('.cur b');
    clearTimeout(timer);
    if(!s.final){
      timer=setTimeout(function(){go(1)},7000);
      if(cur)cur.addEventListener('animationend',function(){});
    }else if(cur){cur.style.animation='none';cur.style.width='100%'}
    runCounts();
    var again=$('#again'),edit=$('#edit'),dl=$('#dl');
    if(dl)dl.onclick=function(e){e.stopPropagation();downloadCard()};
    if(again)again.onclick=function(e){e.stopPropagation();idx=0;render()};
    if(edit)edit.onclick=function(e){e.stopPropagation();closeStory()};
  }
  function go(d){
    var n=idx+d;
    if(n<0)n=0;
    if(n>=slides.length)n=slides.length-1;
    if(n!==idx||d===0){idx=n;render()}
  }
  function closeStory(){
    clearTimeout(timer);stopCounts();
    $('#story').classList.remove('on');
    $('#setup').style.display='block';
    window.scrollTo(0,0);
  }

  $('#next').onclick=function(){go(1)};
  $('#prev').onclick=function(){go(-1)};
  document.addEventListener('keydown',function(e){
    if(!$('#story').classList.contains('on'))return;
    if(e.key==='ArrowRight'||e.key===' ')go(1);
    else if(e.key==='ArrowLeft')go(-1);
    else if(e.key==='Escape')closeStory();
  });
  var hold=function(on){return function(){$('#phone').classList.toggle('paused',on);if(on)clearTimeout(timer);else if(!slides[idx].final){timer=setTimeout(function(){go(1)},4000)}}};

  $('#go').onclick=function(){
    var apps=parse($('#data').value);
    if(!apps.length){$('#err').textContent='Add at least one line like "Chrome: 40" and try again.';return}
    $('#err').textContent='';
    slides=build(apps,'month');
    idx=0;
    $('#setup').style.display='none';
    $('#story').classList.add('on');
    render();
  };
if($('#data').getAttribute('data-auto')==='1'){$('#go').click()}
})();
</script>
</body>
</html>
'@

$ErrorActionPreference = 'Stop'
$inv = [Globalization.CultureInfo]::InvariantCulture

# lowercase exe/app name -> 'Real Name|category'
$map = @{
 '308046b0af4a39cb'='Firefox|browser'; 'nmrih'='No More Room in Hell|games'
 'chrome'='Chrome|browser'; 'google chrome'='Chrome|browser'; 'msedge'='Edge|browser' 
 'microsoft edge'='Edge|browser'; 'firefox'='Firefox|browser'; 'brave'='Brave|browser' 
 'brave browser'='Brave|browser'; 'opera'='Opera|browser'; 'opera gx'='Opera GX|browser' 
 'operagx'='Opera GX|browser'; 'vivaldi'='Vivaldi|browser'; 'arc'='Arc|browser' 
 'valorant'='Valorant|games'; 'valorant-win64-shipping'='Valorant|games'; 'riotclientservices'='Riot Client|games' 
 'riot client'='Riot Client|games'; 'league of legends'='League of Legends|games'; 'leagueclient'='League of Legends|games' 
 'leagueclientux'='League of Legends|games'; 'league of legends (tm) client'='League of Legends|games'; 'fortniteclient-win64-shipping'='Fortnite|games' 
 'fortnitelauncher'='Fortnite|games'; 'fortnite'='Fortnite|games'; 'minecraft'='Minecraft|games' 
 'minecraftlauncher'='Minecraft|games'; 'minecraft launcher'='Minecraft|games'; 'steam'='Steam|games' 
 'epicgameslauncher'='Epic Games|games'; 'epic games launcher'='Epic Games|games'; 'cs2'='Counter-Strike 2|games' 
 'csgo'='Counter-Strike|games'; 'dota2'='Dota 2|games'; 'overwatch'='Overwatch|games' 
 'r5apex'='Apex Legends|games'; 'rocketleague'='Rocket League|games'; 'robloxplayerbeta'='Roblox|games' 
 'robloxplayerlauncher'='Roblox|games'; 'roblox'='Roblox|games'; 'gta5'='GTA V|games' 
 'gtav'='GTA V|games'; 'genshinimpact'='Genshin Impact|games'; 'yuanshen'='Genshin Impact|games' 
 'eldenring'='Elden Ring|games'; 'cyberpunk2077'='Cyberpunk 2077|games'; 'witcher3'='The Witcher 3|games' 
 'destiny2'='Destiny 2|games'; 'battle.net'='Battle.net|games'; 'eadesktop'='EA app|games' 
 'origin'='EA Origin|games'; 'ubisoftconnect'='Ubisoft Connect|games'; 'upc'='Ubisoft Connect|games' 
 'galaxyclient'='GOG Galaxy|games'; 'warframe.x64'='Warframe|games'; 'tslgame'='PUBG|games' 
 'xbox'='Xbox|games'; 'gamingapp'='Xbox|games'; 'wow'='World of Warcraft|games' 
 'hogwartslegacy'='Hogwarts Legacy|games'; 'discord'='Discord|chat'; 'slack'='Slack|chat' 
 'teams'='Teams|chat'; 'ms-teams'='Teams|chat'; 'msteams'='Teams|chat' 
 'zoom'='Zoom|chat'; 'telegram'='Telegram|chat'; 'whatsapp'='WhatsApp|chat' 
 'whatsappdesktop'='WhatsApp|chat'; 'signal'='Signal|chat'; 'skype'='Skype|chat' 
 'webex'='Webex|chat'; 'outlook'='Outlook|chat'; 'olk'='Outlook|chat' 
 'spotify'='Spotify|media'; 'spotifymusic'='Spotify|media'; 'vlc'='VLC|media' 
 'netflix'='Netflix|media'; 'itunes'='iTunes|media'; 'applemusic'='Apple Music|media' 
 'plex'='Plex|media'; 'tidal'='Tidal|media'; 'zunemusic'='Media Player|media' 
 'mediaplayer'='Media Player|media'; 'wmplayer'='Media Player|media'; 'code'='VS Code|code' 
 'code - insiders'='VS Code|code'; 'visual studio code'='VS Code|code'; 'cursor'='Cursor|code' 
 'devenv'='Visual Studio|code'; 'pycharm64'='PyCharm|code'; 'idea64'='IntelliJ|code' 
 'webstorm64'='WebStorm|code'; 'studio64'='Android Studio|code'; 'sublime_text'='Sublime Text|code' 
 'windowsterminal'='Terminal|code'; 'wt'='Terminal|code'; 'powershell'='PowerShell|code' 
 'pwsh'='PowerShell|code'; 'cmd'='Command Prompt|code'; 'githubdesktop'='GitHub Desktop|code' 
 'docker desktop'='Docker|code'; 'postman'='Postman|code'; 'claude'='Claude|ai' 
 'chatgpt'='ChatGPT|ai'; 'copilot'='Copilot|ai'; 'excel'='Excel|office' 
 'winword'='Word|office'; 'powerpnt'='PowerPoint|office'; 'onenote'='OneNote|office' 
 'notepad'='Notepad|office'; 'windowsnotepad'='Notepad|office'; 'notepad++'='Notepad++|office' 
 'notion'='Notion|office'; 'obsidian'='Obsidian|office'; 'acrord32'='Acrobat Reader|office' 
 'acrobat'='Acrobat|office'; 'foxitreader'='Foxit Reader|office'; 'sumatrapdf'='SumatraPDF|office' 
 'msaccess'='Access|office'; 'mspub'='Publisher|office'; 'photoshop'='Photoshop|creative' 
 'illustrator'='Illustrator|creative'; 'adobe premiere pro'='Premiere Pro|creative'; 'afterfx'='After Effects|creative' 
 'figma'='Figma|creative'; 'canva'='Canva|creative'; 'blender'='Blender|creative' 
 'resolve'='DaVinci Resolve|creative'; 'davinciresolve'='DaVinci Resolve|creative'; 'obs64'='OBS Studio|creative' 
 'obs'='OBS Studio|creative'; 'lightroom'='Lightroom|creative'; 'mspaint'='Paint|creative' 
 'paint'='Paint|creative'; 'audacity'='Audacity|creative'; 'fl64'='FL Studio|creative' 
 'fl'='FL Studio|creative'; 'gimp-2.10'='GIMP|creative'; 'capcut'='CapCut|creative' 
 'explorer'='File Explorer|system'; 'microsoft.windows.explorer'='File Explorer|system'; 'systemsettings'='Settings|system' 
 'taskmgr'='Task Manager|system'; 'applicationframehost'='Windows App|system'; 'windowscalculator'='Calculator|system' 
 'calculator'='Calculator|system'; 'mmc'='Management Console|system'; 'regedit'='Registry Editor|system' 
 'snippingtool'='Snipping Tool|system'; 'screensketch'='Snipping Tool|system'; '7zfm'='7-Zip|system' 
 'winrar'='WinRAR|system'; 'control'='Control Panel|system'
}

function Rot13($s) {
  $out = New-Object System.Text.StringBuilder
  foreach ($ch in $s.ToCharArray()) {
    $c = [int]$ch
    if ($c -ge 65 -and $c -le 90) { [void]$out.Append([char]((($c - 65 + 13) % 26) + 65)) }
    elseif ($c -ge 97 -and $c -le 122) { [void]$out.Append([char]((($c - 97 + 13) % 26) + 97)) }
    else { [void]$out.Append($ch) }
  }
  return $out.ToString()
}

# folders that UserAssist writes as {GUID}\path
$kf = @{
 '6D809377-6AF0-444B-8957-A3773F02200E' = $env:ProgramFiles
 '905E63B6-C1BF-494E-B29C-65B732D3D21A' = $env:ProgramFiles
 '7C5A40EF-A0FB-4BFC-874A-C0F2E0B9FA8E' = ${env:ProgramFiles(x86)}
 '1AC14E77-02E7-4E5D-B744-2EB1AE5198B7' = (Join-Path $env:SystemRoot 'System32')
 'F38BF404-1D43-42F2-9305-67DE0B28FC23' = $env:SystemRoot
 'D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27' = (Join-Path $env:SystemRoot 'SysWOW64')
 'F1B32785-6FBA-4FCF-9D55-7B8E7F157091' = $env:LOCALAPPDATA
 '3EB685DB-65F9-4CF6-A03A-E3EF65729F3D' = $env:APPDATA
 '5E6C858F-0E22-4760-9AFE-EA3317B67173' = $env:USERPROFILE
}

# the program's own display name, read from the .exe if it still exists
function Get-ProductName($raw) {
  try {
    $p = $raw.Replace('/', '\')
    if ($p -match '^\{([0-9A-Fa-f-]{36})\}\\(.*)$') {
      $g = $matches[1].ToUpper()
      if (-not $kf.ContainsKey($g)) { return $null }
      $p = Join-Path $kf[$g] $matches[2]
    }
    if (($p -notmatch '^[A-Za-z]:\\') -or -not (Test-Path -LiteralPath $p)) { return $null }
    $vi = (Get-Item -LiteralPath $p).VersionInfo
    $name = $vi.ProductName
    if (-not $name) { $name = $vi.FileDescription }
    if (-not $name) { return $null }
    $name = ($name -replace '[\u00AE\u2122\u00A9\|\[\]]', '').Trim()
    if ($name -match '(?i)microsoft|windows|unreal|unity|electron|chromium|java|python|crash|setup|install|update') { return $null }
    if ($name.Length -gt 28 -or $name.Length -lt 2) { return $null }
    return $name
  } catch { return $null }
}

# returns 'Name|category' or $null to skip
function Resolve-App($raw) {
  $raw = $raw.Trim()
  $low = $raw.ToLower()
  if (-not $raw -or $raw.StartsWith('UEME_')) { return $null }
  if ($low.StartsWith('microsoft.windows.') -and $low -ne 'microsoft.windows.explorer') { return $null }
  if ($raw.Contains('!') -and -not $raw.Contains('\')) {
    $base = (($raw.Split('!')[0]).Split('_')[0]).Split('.')[-1]
  } else {
    $base = ($raw.Replace('/', '\')).Split('\')[-1]
  }
  if ($base.ToLower().EndsWith('.lnk') -or $base.ToLower().EndsWith('.exe')) { $base = $base.Substring(0, $base.Length - 4) }
  if (-not $base) { return $null }
  $key = $base.ToLower()
  if (@('uninstall', 'setup', 'update', 'updater', 'installer') -contains $key) { return $null }
  if ($map.ContainsKey($key)) { return $map[$key] }
  $clean = $base -replace '(?i)[-_ ]?win(64|32)([-_ ]shipping)?$', ''
  $clean = $clean -replace '(?i)[-_ ]?(x64|x86)$', ''
  $ck = $clean.ToLower()
  if ($ck -and $map.ContainsKey($ck)) { return $map[$ck] }
  if ($key -match '^[0-9a-f]{12,}$') { return 'Mystery App|other' }
  $cat = 'other'
  if ($low -match 'steamapps|\\games\\|epic games|riot games') { $cat = 'games' }
  $pn = Get-ProductName $raw
  if ($pn) { return ($pn + '|' + $cat) }
  $clean = $clean.Replace('_', ' ').Replace('-', ' ').Replace('[', '').Replace(']', '').Trim()
  if (-not $clean) { return $null }
  if (($clean -ceq $clean.ToUpper()) -or ($clean -ceq $clean.ToLower())) {
    $clean = (Get-Culture).TextInfo.ToTitleCase($clean.ToLower())
  }
  return ($clean + '|' + $cat)
}

# --- read Windows' own per-app focus time (UserAssist) ---
$root = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\UserAssist'
$hours = @{}
$cats = @{}
foreach ($g in Get-ChildItem -LiteralPath $root) {
  $count = Get-Item -LiteralPath ($g.PSPath + '\Count') -ErrorAction SilentlyContinue
  if (-not $count) { continue }
  $per = @{}
  foreach ($n in $count.GetValueNames()) {
    $data = $count.GetValue($n)
    if (($data -isnot [byte[]]) -or $data.Length -lt 16) { continue }
    $ms = [BitConverter]::ToUInt32($data, 12)
    if ($ms -eq 0) { continue }
    $res = Resolve-App (Rot13 $n)
    if ($res) {
      $parts = $res.Split('|')
      $app = $parts[0]
      $cats[$app] = $parts[1]
      $per[$app] = [double]$per[$app] + $ms / 3600000.0
    }
  }
  foreach ($k in $per.Keys) {
    if ((-not $hours.ContainsKey($k)) -or ($hours[$k] -lt $per[$k])) { $hours[$k] = $per[$k] }
  }
}

$sorted = @($hours.GetEnumerator() | Where-Object { $_.Value -ge (1.0 / 60) } | Sort-Object Value -Descending)
if ($sorted.Count -eq 0) {
  Write-Host 'No usage history found on this account.' -ForegroundColor Yellow
} else {
  $born = (Get-Item -LiteralPath $env:USERPROFILE).CreationTime
  $days = [Math]::Max(1, [int][Math]::Round(((Get-Date) - $born).TotalDays))
  $lines = $sorted | ForEach-Object { '{0} [{1}]: {2}' -f $_.Key, $cats[$_.Key], $_.Value.ToString('0.00', $inv) }
  $data = $lines -join "`n"

  $html = $template.Replace('{{DATA}}', [Net.WebUtility]::HtmlEncode($data)).Replace('{{DAYS}}', [string]$days).Replace('{{LABEL}}', 'entire Windows life')
  $out = Join-Path ([Environment]::GetFolderPath('Desktop')) 'My Computer Wrapped.html'
  [IO.File]::WriteAllText($out, $html, (New-Object Text.UTF8Encoding $false))

  Write-Host ''
  Write-Host ('Account is about {0} days old. Your top apps:' -f $days) -ForegroundColor Cyan
  $sorted | Select-Object -First 5 | ForEach-Object { Write-Host ('  {0,-22} {1,8:N1} h   ({2})' -f $_.Key, $_.Value, $cats[$_.Key]) }
  Write-Host ''
  Write-Host ('Saved to your Desktop: ' + $out)
  Start-Process $out
}
