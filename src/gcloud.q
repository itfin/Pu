//Google Cloud Platform API:https://console.cloud.google.com/
//https://developers.google.com/maps/documentation/maps-static/overview

\d .gcp
apikey:"......";
mapstatic:"https://maps.googleapis.com/maps/api/staticmap?";
imgll:{[l;x]mapstatic,"center=",sv[",";string x],"&zoom=",string[l],"&maptype=hybrid&size=640x640&scale=2&key=",apikey}; /[zoom level;(latitude,longitude)] ���ݸ�����γ������ͼƬ
imgpath:{[l;s;x]y:sv["|";sv[","] each string x];mapstatic,"path=",except[raze first[s];" "],y,"&markers=",except[raze last[s];" "],y,$[null l;"";"&zoom=",string l],"&maptype=hybrid&size=640x640&scale=2&key=",apikey}; /[(path style;markers style);(latitude,longitude) list] ���ݸ�����γ��·������ͼƬ
imgpathx:{[l;s;x]y:{sv["|";sv[","] each string x]} each x;z:sv["&"] (count[y]#s) {[s;y]"path=",except[raze first[s];" "],y,"&markers=",except[raze last[s];" "],y}' y;mapstatic,z,$[null l;"";"&zoom=",string l],"&maptype=hybrid&size=640x640&scale=2&key=",apikey}; /[(path style;markers style) list;(latitude,longitude) list] ���ݸ�����γ��·��������ͼƬ
\d .

