#include "EXTERN.h"
#include "perl.h"

#if EMSCRIPTEN
#include <emscripten.h>
#endif

static void xs_init (pTHX);

char * perl_eval(char * str) {
    PerlInterpreter *my_perl;
    char *embedding[] = { "", "-e", "0" };
    int argc = 3;
    char ** casted_embedded = (char **) embedding;
    PERL_SYS_INIT3(&argc,&casted_embedded,(char ***)NULL);
    my_perl = perl_alloc();
    perl_construct(my_perl);
    perl_parse(my_perl, xs_init, 3, embedding, (char **)NULL);
    PL_exit_flags |= PERL_EXIT_DESTRUCT_END;

    SV * ret = eval_pv(str, TRUE);
    char * ret_str = SvPV_nolen(ret);
    size_t len = strlen(ret_str);
    write (1, ret_str, len);
#if 0
    printf("%s", ret_str);
#endif

    perl_destruct(my_perl);
    perl_free(my_perl);
    PERL_SYS_TERM();

    return ret_str;
}

/* Register any extra external extensions */

EXTERN_C void boot_PerlIO__scalar (pTHX_ CV* cv);
EXTERN_C void boot_List__Util (pTHX_ CV* cv);
EXTERN_C void boot_Scalar__Util (pTHX_ CV* cv);

static void
xs_init(pTHX)
{
    static const char file[] = __FILE__;
    dXSUB_SYS;
    PERL_UNUSED_CONTEXT;

    newXS("PerlIO::scalar::bootstrap", boot_PerlIO__scalar, file);
    newXS("List::Util::bootstrap", boot_List__Util, file);
    newXS("Scalar::Util::bootstrap", boot_Scalar__Util, file);
}
