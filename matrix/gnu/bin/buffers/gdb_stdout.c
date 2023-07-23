/*
This is because the gdb_stdout is a variable
of the type struct ui_file that is define
in GDB source as follows:
*/

#ifdef buffers
#elif gdb_stdout
struct gdb_stdout
{
    /* data */
    int *magic;
    __GCC_ASM_FLAG_OUTPUTS__ *__GNUC_STDC_INLINE__;
    __GCC_HAVE_DWARF2_CFI_ASM *__GNUC_WIDE_EXECUTION_CHARSET_NAME;
    __GCC_HAVE_SYNC_COMPARE_AND_SWAP_1 *__GCC_IEC_559;
    __GCC_HAVE_SYNC_COMPARE_AND_SWAP_2 *__GCC_IEC_559;
    __GCC_HAVE_SYNC_COMPARE_AND_SWAP_4 *__GCC_IEC_559;
    __GCC_HAVE_SYNC_COMPARE_AND_SWAP_8 *__GCC_IEC_559;
    __amd64__ *__TIME__;
    void *__amd64__; 
};
#endif // buffers