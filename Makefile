LD = $(CC)
CCFLAGS = -c
MINIPERLMAIN = miniperlmain_bak.c
LDFLAGS =
LIBS = -lm -lcrypt
_O = .o
ENV = env
PERL = perl
_X =
RUN =

all:	plu

include common1.mak

plu:	$(O)
	$(LD) -o $@ perl_eval_main.c $(O) $(LDFLAGS) $(LIBS)

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
