//濮语研究资料汇编
\l pcre.q
\l gcloud.q

curl:{system "curl -o /tmp/curl.tmp \"",x,"\"";`char$read1 `:/tmp/curl.tmp};

inline:{[x;y;z;c]u:md5s raze z;v:(string x),"_",(string y),"_",u;w:`$":/q/",string[.z.o],"/",v,".so";if[()~key w;s:` sv `:/tmp,`$v,".c";s 0: (enlist "#include\"kcomm.h\""),$[0<count hdrs:c`h;"#include ",/: hdrs;""],(enlist "K",(string y),"(",(string x),"){"),$[0=type z;z;enlist z],enlist enlist "}";system "/usr/bin/gcc -fPIC -shared -DJ64 -DKXVER=3 -I/q/c -lpthread ",$[0<count libs:c`l;" " sv "-l",/: string libs;""]," ",(1_string s)," -o ",(1_string w);];(`$v) 2: (x;y)}; /[fun;argc;fundef;`h`l!(headers;libs)]
osiconv:inline[`osiconv;4;"size_t n,n0=z->n,n1=w->n;S s1=z->G0,s2=w->G0;iconv_t cd=iconv_open(xs,y->s);n=iconv(cd,&s1,&n0,&s2,&n1);iconv_close(cd);R ki(n1);";`h`l!(enlist "<iconv.h>";())];
iconv:{[t;f;x]y:#[3*count[x];"\000"];n:osiconv[t;f;x;y];neg[n]_y};
gbk2utf8:iconv[`UTF8;`GB18030];utf82gbk:iconv[`GB18030;`UTF8];u162utf8:iconv[`$"UTF-16";`UTF8];u322utf8:iconv[`$"UTF-32";`UTF8];

//张明友(濮鲁):http://blog.sina.cn/dpool/blog/u/3924112648,https://blog.sina.com.cn/s/articlelist_3924112648_0_1.html
//张小蓉(费力妈):https://independent.academia.edu/xiaozhang17(http://m.chinapoesy.com/Poesy/Author/louise)
//https://www.ageeye.cn/
//因新浪博客关闭，相关资料下载于”动力实体能“先生在360个人图书馆的转载:http://www.360doc.com/userhome/49834448
/
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=1&pagenum=50&cid=33&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=26A115BD01E354C8416EDD49FA42F2E4E067CBDD
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=2&pagenum=50&cid=33&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=27AA8A47163DC1C29AE3D244C0565A05F81A3C34
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=3&pagenum=50&cid=33&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=F0EAF68CF1D87E9046C5732410E021C1175F2C21
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=4&pagenum=50&cid=33&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=F317DFA767893BCF016CCA676ED3B11C4B8A90AC
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=5&pagenum=50&cid=33&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=75B2C99CC04EBF7BC991AC60BE80B9D0D6C53349
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=6&pagenum=50&cid=33&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=4F0B410CF70835EACA6C70A2C2BA8220322137D0
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=7&pagenum=50&cid=33&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=A4BE5979A5D4A18F5A17F62B866116BCE6D11423
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=8&pagenum=50&cid=33&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=73AFD97D8E4E15E0146649E45F44F0BD562D52BC
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=9&pagenum=50&cid=33&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=D362FC232AC3B0EBAEF0E92A4BE3C78E9F9B7B7A

https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=1&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=96403DB8B6E1516AFC3D14C8B60D1F032EAF22F8
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=2&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=85DD092B29CFB4007845BA7F08AED80DB1270B8F
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=3&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=9BCA5A3957729458D6048F20A96D8DAF855D3667
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=4&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=F2C78B75851159198EC51B03C435C83DAB753D2D
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=5&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=45C95572250AAB41B579EB8C8ED66D8E32053537
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=6&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=87F50E4AA8D36067526217AA8C88E4D95597F066
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=7&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=F04B81CDA14401A6A3D70BD915E78F8DDD594C91
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=8&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=3D49BDD3B2FCB5973B360D416D847AB3E8C6CBD1
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=9&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=29B57E299623EECDC46CB40214B7056C322F57EC
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=10&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=180AE70B5DDE9C3F0C8BF48E4007B46677EF236D
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=11&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=9C63CB0847026738BED5A54C657A63CD63BD1AC1
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=12&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=F5E35CC5AE11AD6438FEF1817677A8FFBD0F7C21
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=13&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=284B876353BF9A103391D8A9188E21CC81AAC38A
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=14&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=606C38C19BA3051725A16172792F8A06CD9AD179
https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=15&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=F32E72C5D80FA6FF25F796C9F1B411CED1EBD924
\

SignMap1:(1+til[9])!("26A115BD01E354C8416EDD49FA42F2E4E067CBDD";"27AA8A47163DC1C29AE3D244C0565A05F81A3C34";"F0EAF68CF1D87E9046C5732410E021C1175F2C21";"F317DFA767893BCF016CCA676ED3B11C4B8A90AC";"75B2C99CC04EBF7BC991AC60BE80B9D0D6C53349";"4F0B410CF70835EACA6C70A2C2BA8220322137D0";"A4BE5979A5D4A18F5A17F62B866116BCE6D11423";"73AFD97D8E4E15E0146649E45F44F0BD562D52BC";"D362FC232AC3B0EBAEF0E92A4BE3C78E9F9B7B7A");

SignMap2:(1+til[15])!("96403DB8B6E1516AFC3D14C8B60D1F032EAF22F8";"85DD092B29CFB4007845BA7F08AED80DB1270B8F";"9BCA5A3957729458D6048F20A96D8DAF855D3667";"F2C78B75851159198EC51B03C435C83DAB753D2D";"45C95572250AAB41B579EB8C8ED66D8E32053537";"87F50E4AA8D36067526217AA8C88E4D95597F066";"F04B81CDA14401A6A3D70BD915E78F8DDD594C91";"3D49BDD3B2FCB5973B360D416D847AB3E8C6CBD1";"29B57E299623EECDC46CB40214B7056C322F57EC";"180AE70B5DDE9C3F0C8BF48E4007B46677EF236D";"9C63CB0847026738BED5A54C657A63CD63BD1AC1";"F5E35CC5AE11AD6438FEF1817677A8FFBD0F7C21";"284B876353BF9A103391D8A9188E21CC81AAC38A";"606C38C19BA3051725A16172792F8A06CD9AD179";"F32E72C5D80FA6FF25F796C9F1B411CED1EBD924");

data1url:{[x]"https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=",string[x],"&pagenum=50&cid=33&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=",SignMap1[x]};
data2url:{[x]"https://api.360doc.com/Ajax/ArticleHandler.ashx?op=getothersuserarticle&curnum=",string[x],"&pagenum=50&cid=34&isoriginal=0&userid=49834448&sortarttype=1&arttype=&sign=",SignMap2[x]};
data1pnum:9;
data2pnum:15;

findr:{count[x]-1+reverse[x]?y};

//山海经地点google map静态图片生成
imgplace:{[l;x;y;z].gcp.imgll[l] exec first lat(,)' lon from SP where bid=x,cid=y,pid=z,not null lat,not null lon}; /[zoom level;bid;cid;pid] imgplace[10;1;1;1]
imgseries:{[l;s;x;y].gcp.imgpath[s] exec lat(,)' lon from SP where bid=x,cid=y,not null lat,not null lon}; /[style;bid;cid] imgseries[0N;"";1;1]
imgbook:{[l;s;x].gcp.imgpathx[s] value exec lat(,)' lon by cid from SP where bid=x,not null lat,not null lon}; /[style;bid] imgbook[0N;(("weight:3|color:blue|";"size:tiny|color:purple|");("weight:3|color:red|";"size:tiny|color:green|");("weight:3|color:yellow|";"size:tiny|color:orange|"));1]

\

d1:raze {select articleid,arturl,gbktitle:('[utf82gbk;.h.uh]) each articletitle,gbkabs:('[utf82gbk;.h.uh]) each abstract,.h.uh each articletitle,.h.uh each abstract from @[;`listitem].j.k curl data1url x} each 1+til data1pnum; /360图书馆目录1
d2:raze {select articleid,arturl,gbktitle:('[utf82gbk;.h.uh]) each articletitle,gbkabs:('[utf82gbk;.h.uh]) each abstract,.h.uh each articletitle,.h.uh each abstract from @[;`listitem].j.k curl data2url x} each 1+til data2pnum; /360图书馆目录2
d:d1,d2; /汇总文章索引
update text:curl each arturl from `d; /下载文章全文
update body:{{first[ss[x;"\n</td>"]]#x} {(7+first ss[x;"</div>\n"])_x} {(46+first ss[x;"<td id=\"artContent\" style=\"max-width: 656px\">"])_x}x} each text from `d; /提取文章正文

update "J"$articleid from `d;1!`d;update gbkbody:utf82gbk each body,seq:i,seq0:0N from `d;

d:update seq0:0N from (d lj select seq0:first seq by articletitle,abstract from d) where seq0=seq; /文章去重
dh:53 54 59 64 65 67 70 72 73 75 76 79 80 87 88 93 99 120!52 52 48 44 43 41 37 34 33 31 30 27 26 19 16 9 3 119;update seq0:dh seq from `d where seq in key dh; /手工去重

save `:/kdb/puyu/d;

`:/sdc/pu.txt 0: exec {[x;y;z;w;s]"## (",string[x],")[",y,"](",w,")",$[null s;"\n",z;" ==>(",string[s],")"],"\n\n***\n"} '[i;gbktitle;gbkbody;arturl;seq0] from d; /文章以markdown格式汇编

`:/sdc/pu.md 0: psubst[;"<[^>]+>";`si;"";0] each psubst[;"<img doc360img-src='http://image109.360doc.com/DownloadImg/(.+?)/([^/]+?)'[^>]+>";`si;"![](https://itfin.f3322.org/pub/puyu/img/\\2.jpeg)";0] each ssr[;"</div><div>";"\n\n"] each  ssr[;"<br>";"\n\n"] each  ssr[;"</p>";"\n\n"] each  psubst[;"<span>热门文章.+?在浏览器中打开</span>";`si;"";0] each ssr[;"<wbr>";""] each ssr[;"&nbsp;";""] each read0 `:/sdc/pu.txt; /格式整理与化简,360图书馆文章内图片为javascript阅读时动态加载,改写为引用静态图片以便后续转pdf文件

`:/sdc/pu.md 0: psubst[;"<[^>]+>";`si;"";0] each psubst[;"<img doc360img-src='http://image109.360doc.com/DownloadImg/(.+?)/([^/]+?)'[^>]+>";`si;"![](http://127.0.0.1/pub/puyu/img/\\2.jpeg)";0] each ssr[;"</div><div>";"\n\n"] each  ssr[;"<br>";"\n\n"] each  ssr[;"</p>";"\n\n"] each  psubst[;"<span>热门文章.+?在浏览器中打开</span>";`si;"";0] each ssr[;"<wbr>";""] each ssr[;"&nbsp;";""] each read0 `:/sdc/pu.txt; /替换为引用本地网址以加速转pdf文件

iconv -f GB18030 -t UTF-8 pu.md >pu.utf8 /转utf8以便调用pandoc进行格式转换

pandoc -s --metadata title="PuYu" -f markdown -t html pu.utf8 -o pu.html /先转为网页

pandoc --pdf-engine=wkhtmltopdf -f html pu.html -o pu.pdf /再转为pdf

d1:update imgpath:{[x]y:last vs["/";x];"/kdb/puyu/img/",y,".jpeg"} each imgurl,url:{[x]y:last vs["/";x];"https://itfin.f3322.org/pub/puyu/img/",y,".jpeg"} each imgurl from flip `articleid`imgurl!flip raze exec articleid {enlist[x],/:(1_) each first each last pmatchall[;"<img doc360img-src='([^']+?)'[^>]+?>";`s] y}' gbkbody from d; /提取文章嵌入的图片信息
update end:{0<count key `$":",x} each imgpath from `d1; /更新图片下载成功标志
`:/sdc/imgdn.pl 0: ("use PUYU;";"puyuhi();"),raze {[x]enlist["puyugo('",d[x;`arturl],"');"],exec imgurl {[x;y]"puyudn('",x,"','",y,"');"}' imgpath from d1 where articleid=x,not end} each exec distinct articleid from d1 where not end; /生成下载perl脚本,因图片为动态生成，无法实现全自动下载，需由程序控制浏览器打开相应页面后由人工滚动页面确认动态图片均加载完成后回车后由程序继续完成图片保存到本地(经实际使用Chrome版本问题较多,更换为Firefox版本后解决)

{[x]y:string x;if[like[;"*HTML*"]first system "file ",y;system "mv ",y," ../bak/ "];} each key `:/kdb/puyu/img; /清理Chrome版本下载失败的错误图片文件
update sig:{`$-33!read1 `$":",x} each imgpath from `d1;d1:d1 lj 1!`imgpath xcols ungroup select imgpath,seq:til count i by articleid,sig from d1;select {system "rm -rf ",x} each imgpath from d1 where seq>0; /清理Chrome版本下载错误图片文件

save `:/kdb/puyu/d1;

//山海经地点位置数据库生成及相应kml文件生成,源数据提取自张小蓉女士在线论文
SP:delete bl,cl,pl from update bid:"J"$(1_)each first each bl,bname:`$last each bl,cid:"J"$(1_)each first each cl,cname:`$last each cl,pid:first each pl,name:@[;1] each pl,mname:`$@[;2] each pl,lon:"F"$ssr[;",";"."] each except[;"(E"] each @[;3] each pl,lat:"F"$ssr[;",";"."] each except[;";N"] each @[;4] each pl from update bl:vs[":"] each string book,cl:vs[":"] each string ch,pl:{[x]y:(except[;count[x]]0 2,x?":")cut x;z:1_y[2];w:5#((except[;-1]0,findr[z;"(;)"])cut z),3#enlist "";("J"$y[0];`$y[1]),w} each string place from flip `book`ch`place!flip raze {(2#x),/: 2_x} each raze {(`$x[0]),/:`${(where like[;"C*"] each x)cut x} x[1]} each {(x[0];1_x)} each {(where like[;"B*"] each x)cut x} except[;enlist""] vs["\n"] except[;" \r"]  (('[;]/)("；";"：";"（";"）";"，";"　";"【";"】"){ssr[;x;y]}' ";:(), []") `char$read1 `:/kdb/puyu/jingwei.txt;

save `:/kdb/puyu/SP;

`:/sdc/shj.pl 0: ("use Geo::GoogleEarth::Pluggable;";"my $d=Geo::GoogleEarth::Pluggable->new;"),({"$d->Point(name=>'",gbk2utf8[string x`name],sv["-";string[x`bid`cid`pid]],"', lat=>",string[x`lat],", lon=>",string[x`lon],");"} each select from SP where not null lat,not null lon),enlist "print $d->render;"; 

