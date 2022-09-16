#!q

//////////////////////////////////////////////////////////////
// pcre-based regular expression processing for q           //
//                                                          //
// principal functions:                                     //
// pmatch:    perform regular expression matching: returns  //
//            info for the first match found                //
// pmatchall: perform regular expression matching: returns  //
//            info for all matches found                    //
// psubst:    perform text substitution based on regular    //
//            expressions                                   //
//                                                          //
// Copyright (C) 2007, 2008, Lloyd Zusman <q.o@potam.us>    //
//                                                          //
// This program is free software; you can redistribute      //
// it and/or modify it under the terms of Version 2 of      //
// the GNU General Public License as published by the       //
// Free Software Foundation.                                //
//                                                          //
// This program is distributed in the hope that it will     //
// be useful, but WITHOUT ANY WARRANTY; without even the    //
// implied warranty of MERCHANTABILITY or FITNESS FOR A     //
// PARTICULAR PURPOSE.  See the GNU General Public License  //
// for more details: http://q.o.potam.us/license or         //
// http://www.gnu.org/copyleft/gpl.html                     //
//                                                          //
// You should have received a copy of the GNU General       //
// Public License along with this program; if not, write to //
// the Free Software Foundation, Inc., 51 Franklin Street,  //
// Fifth Floor, Boston, MA  02110-1301, USA.                //
//////////////////////////////////////////////////////////////

pmatch:`qpcre 2:(`q_pcre_match;3)
pmatchall:`qpcre 2:(`q_pcre_matchall;3)
vecrepl:{[v;p;r]
 $[(s:p[0])<e:p[1];raze v[key s],r,v[e _ key count v];v]
 }
psubst:{[t;p;o;r;n]
 apply:{[r;p]
   m:p[0];
   o:p[1][0];
   if[0~cm:count m;:1];
   while[0<count mf:pmatchall[r;"\\\\\\d+";`][2];
    .pcre.m:();
    each[{.pcre.m,:enlist(value 1_x[0][0];x[1])}]mf;
    f:m[.pcre.m[0][0]];
    p:.pcre.m[0][1][0];
    r:vecrepl[r;p;f]];
   .pcre.t:vecrepl[.pcre.t;o;r]
   };
 if[z:-11h~type t;t:string t];
 if[-11h~type r;r:string r];
 pf:pmatchall[t;p;o];
 if[0b~pf[0];:t];
 d:pf[2];
 if[n>0;d:d[key $[n>cd:count d;cd;n]]];
 .pcre.t:t;
 each[apply[r]] d idesc first each last each last each d; //reverse d;
 a:$[z;`$.pcre.t;.pcre.t];
 .pcre _`m;
 .pcre _`t;
 a
 }

