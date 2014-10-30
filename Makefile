LD = $(CC)
CCFLAGS = -c
MINIPERLMAIN = miniperlmain_bak.c
DEFINES = -DPERL_CORE -DPERL_MICRO -DSTANDARD_C -DPERL_USE_SAFE_PUTENV \
	  -DNO_MATHOMS
OPTIMIZE =
CFLAGS = $(DEFINES) $(OPTIMIZE)
LDFLAGS =
LIBS = -lm
_O = .o
ENV = env
PERL = perl
_X =
RUN =

all:	plu

O = uav$(_O) udeb$(_O) udoio$(_O) udoop$(_O) udump$(_O) \
	uglobals$(_O) ugv$(_O) uhv$(_O) umro$(_O)\
	umg$(_O) uperlmain$(_O) uop$(_O) ureentr$(_O) \
	upad$(_O) uperl$(_O) uperlio$(_O) uperly$(_O) upp$(_O) \
	upp_ctl$(_O) upp_hot$(_O) upp_sys$(_O) upp_pack$(_O) upp_sort$(_O) \
	uregcomp$(_O) uregexec$(_O) urun$(_O) \
	uscope$(_O) usv$(_O) utaint$(_O) utoke$(_O) \
	unumeric$(_O) ulocale$(_O) umathoms$(_O) \
	uuniversal$(_O) uutf8$(_O) uutil$(_O) uperlapi$(_O) ukeywords$(_O)

plu:	$(O)
	$(LD) -o $@ $(O) $(LDFLAGS) $(LIBS)

include common1.mak

ubitcount.h: ugenerate_uudmap$(_X)
	$(RUN) ./ugenerate_uudmap$(_X) $(generated_headers)

ugenerate_uudmap$(_O): generate_uudmap.c
	$(CC) $(CCFLAGS) -o $@ $(CFLAGS) generate_uudmap.c

ugenerate_uudmap$(_X): ugenerate_uudmap$(_O)
	$(LD) -o ugenerate_uudmap $(LDFLAGS) ugenerate_uudmap$(_O) $(LIBS)

plutest: plu
	- cd t && (rm -f perl; ln -s ../plu perl) \
	  && ./perl -I../lib TEST base/*.t cmd/*.t

# That's it, folks!
