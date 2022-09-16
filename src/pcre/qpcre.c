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

#include "k.h"
#include <pcre.h>
#include <string.h>
#include <stdio.h>

#define ERR_ARG	 -100
#define ERR_PAT  -101

#define MEMERROR(S)	{ fprintf(stderr, "\r%s:%d: memory allocation failed: %s\r\n", __FILE__, __LINE__, (S)); exit(-1); }

typedef struct {
  int         rc;
  pcre*       re;
  pcre_extra* extra;
  int         ovcount;
  int*        ovector;
} pattern;

static K
build_match_retval(int ret, int pcreret, K matches, K offsets) {
  return (knk(4, kb(ret), ki(pcreret),
	      matches == NULL ? ktn(0, 0) : matches,
	      offsets == NULL ? ktn(0, 0) : offsets));
}

static K
build_matchall_retval(int ret, int pcreret, K mvector)
{
  return (knk(3, kb(ret), ki(pcreret),
	      mvector == NULL ? ktn(0, 0) : mvector));
}

static char*
makestring(K item) {
  int tp = item->t;
  int sz = item->n;
  char* string = NULL;
  switch (tp) {
  case 10:
    string = malloc(sz + 1);
    if (string == NULL) {
      MEMERROR("makestring: type 10h malloc");
      // notreached
    }	
    else {
      memcpy(string, item->G0, sz);
      string[sz] = '\0';
    }
    break;
  case -10:
    string = malloc(2);
    if (string == NULL) {
      MEMERROR("makestring: type -10h malloc");
      // notreached
    }
    else {
      string[0] = item->g;
      string[1] = '\0';
    }
    break;
  case -11:
    string = strdup(item->s);
    if (string == NULL) {
      MEMERROR("makestring: type -11h strdup");
      // NOTREACHED
    }
    break;
  }
  return (string);
}

static void
free_pattern(pattern presult) {
  if (presult.ovector != NULL) {
    free(presult.ovector);
    presult.ovector = NULL;
  }
  presult.ovcount = 0;
  if (presult.extra != NULL) {
    pcre_free(presult.extra);
    presult.extra = NULL;
  }
  if (presult.re != NULL) {
    pcre_free(presult.re);
    presult.re = NULL;
  }
}

static pattern
setup_pattern(K p, K o) {
  pattern presult;
  presult.re      = NULL;
  presult.extra   = NULL;
  presult.ovector = NULL;
  char* errptr;
  int erroffset;
  char* pattern = makestring(p);
  if (pattern == NULL) {
    presult.rc = ERR_ARG;
    return (presult);
  }
  char* options = makestring(o);
  if (options == NULL) {
    free(pattern);
    presult.rc = ERR_ARG;
    return (presult);
  }
  int opt = 0;
  int execopt = 0;
  char* cp;
  for (cp = options; *cp != '\0'; cp++) {
    switch (*cp) {
    case 'i':
    case 'I':
      opt |= PCRE_CASELESS;
      break;
    case 'm':
    case 'M':
      opt |= PCRE_MULTILINE;
      break;
    case 's':
    case 'S':
      opt |= PCRE_DOTALL;
      break;
    case 'x':
    case 'X':
      opt |= PCRE_EXTENDED;
      break;
    }
  }
  presult.re = pcre_compile(pattern, opt, (const char**) &errptr, &erroffset, NULL);
  free(pattern);
  free(options);
  if (presult.re == NULL) {
    presult.rc = ERR_PAT;
    return (presult);
  }
  presult.extra = pcre_study(presult.re, 0, (const char**) &errptr);
  presult.ovcount = 0;
  pcre_fullinfo(presult.re, presult.extra, PCRE_INFO_CAPTURECOUNT, &presult.ovcount);
  presult.ovcount++;
  presult.ovcount *= 3;
  presult.ovector = (int*) malloc((sizeof(int)) * presult.ovcount);
  if (presult.ovector == NULL) {
    MEMERROR("setup_pattern: ovector");
    // notreached
  }
  else {
    presult.rc = 0;
  }
  return (presult);
}

static K*
get_match_vectors(int mresult, int type, char* string, int* ovector)
{
  K matchresult  = knk(0);
  K offsetresult = knk(0);
  int n;
  int i;
  for (n = 0, i = 0; n < mresult; n++, i += 2) {
    int spos = ovector[i];
    int npos = ovector[i + 1];
    int len  = npos - spos;
#if 0
    if (len < 1) {
      continue;
    }
#endif
    char* item = malloc(len + 1);
    if (item == NULL) {
      MEMERROR("get_match_vectors: char malloc");
      // notreached
    }
    memcpy(item, string + spos, len);
    item[len] = '\0';
    if (type == -11) {
      // subject is a symbol, so we make the pattern
      // matches be symbols, also
      //      jk(&matchresult, ks(ss(item)));
      jk(&matchresult, ks(item));
    }
    else {
      // subject is a character or character list, so
      // we make the pattern matches be character lists,]
      // also
      jk(&matchresult, kp(item));
    }
    free(item);
    jk(&offsetresult, knk(2, ki(spos), ki(npos)));
  }
  K* kresults = (K*) malloc((sizeof (K)) * 2);
  if (kresults == NULL) {
    MEMERROR("get_match_vectors: K* malloc");
    // notreached
  }
  kresults[0] = matchresult;
  kresults[1] = offsetresult;
  return (kresults);  
}

K
q_pcre_match(K s, K p, K o) {

  pattern presult = setup_pattern(p, o);
  if (presult.rc != 0) {
    // nothing needs to be deallocated
    return (build_match_retval(0, presult.rc, NULL, NULL));
  }

  char* string = makestring(s);

  int mresult = pcre_exec(presult.re, presult.extra, string, strlen(string), 0, 0,
			  presult.ovector, presult.ovcount);

  K kresult;
  if (mresult > 0) {
    K* matchvectors = get_match_vectors(mresult, s->t, string, presult.ovector);
    kresult = build_match_retval(1, mresult, matchvectors[0], matchvectors[1]);
    free(matchvectors);
  }
  else {
    kresult = build_match_retval(0, mresult, NULL, NULL);
  }

  free_pattern(presult);
  free(string);
  if (kresult == NULL) {
    MEMERROR("q_pcre_match: get_match_vectors");
    // notreached
  }
  else {
    return (kresult);
  }
}

static int
kcomp(const void* v0, const void* v1) {
  K* k0 = *((K**) v0);
  K* k1 = *((K**) v1);
  int s0 = (kK(*kK(k0[1]))[0])->i;
  int e0 = (kK(*kK(k0[1]))[1])->i;
  int s1 = (kK(*kK(k1[1]))[0])->i;
  int e1 = (kK(*kK(k1[1]))[1])->i;
  int l0 = e0 - s0;
  int l1 = e1 - s1;
  return (l1 - l0);
}

K q_pcre_matchall(K s, K p, K o) {

  pattern presult = setup_pattern(p, o);
  if (presult.rc != 0) {
    // nothing needs to be deallocated
    return (build_matchall_retval(0, presult.rc, NULL));
  }

  K**   mstuff   = NULL;
  int   nmstuff  = 0;
  char* string   = makestring(s);
  int   slen     = strlen(string);
  int   offset   = 0;
  int   opt      = 0;
  int   mcount   = 0;
  int   notempty = 0;
  K     kvector  = knk(0);

  for (;;) {

    int mresult = pcre_exec(presult.re, presult.extra,
			    string, slen, offset, (opt | notempty),
			    presult.ovector, presult.ovcount);

    if (mresult == 0) {
      mresult = presult.ovcount / 3;
    }

    if (mresult >= 0) {
      K* matchvectors = get_match_vectors(mresult, s->t, string, presult.ovector);
      if (mstuff == NULL) {
	mstuff = (K**) malloc(sizeof (K*));
	if (mstuff == NULL) {
	  MEMERROR("q_pcre_matchall: malloc K*");
	  // notreached
	}
      }
      else {
	mstuff = (K**) realloc(mstuff, (sizeof (K*)) * (nmstuff + 1));
	if (mstuff == NULL) {
	  MEMERROR("q_pcre_matchall: malloc K*");
	  // notreached
	}
      }
      mstuff[nmstuff++] = matchvectors;
      mcount++;
    }
    else {
      if (notempty != 0 && offset < slen) {
	presult.ovector[0] = offset;
	presult.ovector[1] = offset + 1;
      }
      else {
	break;
      }
    }

    if (presult.ovector[1] <= presult.ovector[0]) {
      notempty = (PCRE_NOTEMPTY | PCRE_ANCHORED);
    }
    else {
      notempty = 0;
    }

    offset = presult.ovector[1];
  }

  if (mstuff != NULL) {
    // make sure that the longest match is the first
    // one (handles corner cases)
    qsort((void*) mstuff, nmstuff, sizeof (K*), kcomp);
    int m;
    for (m = 0; m < nmstuff; m++) {
      K* mv = mstuff[m];
      jk(&kvector, knk(2, mv[0], mv[1]));
      free(mv);
    }
    free(mstuff);
  }

  K kresult;
  if (mcount > 0) {
    kresult = build_matchall_retval(1, mcount, kvector);
  }
  else {
    kresult = build_matchall_retval(0, -1, NULL);
  }

  free_pattern(presult);
  free(string);
  if (kresult == NULL) {
    MEMERROR("q_pcre_matchall: get_match_vectors");
    // notreached
  }
  else {
    return (kresult);
  }
}
