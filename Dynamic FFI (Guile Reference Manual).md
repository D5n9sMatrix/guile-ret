<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><!-- This manual documents Guile version 3.0.5.

Copyright (C) 1996-1997, 2000-2005, 2009-2020 Free Software Foundation,
Inc.

Permission is granted to copy, distribute and/or modify this document
under the terms of the GNU Free Documentation License, Version 1.3 or
any later version published by the Free Software Foundation; with no
Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.  A
copy of the license is included in the section entitled "GNU Free
Documentation License." --><!-- Created by GNU Texinfo 6.7, http://www.gnu.org/software/texinfo/ --><head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Dynamic FFI (Guile Reference Manual)</title>

<meta name="description" content="Dynamic FFI (Guile Reference Manual)">
<meta name="keywords" content="Dynamic FFI (Guile Reference Manual)">
<meta name="resource-type" content="document">
<meta name="distribution" content="global">
<meta name="Generator" content="makeinfo">
<link href="https://www.gnu.org/software/guile/manual/html_node/index.html" rel="start" title="Top">
<link href="https://www.gnu.org/software/guile/manual/html_node/Concept-Index.html" rel="index" title="Concept Index">
<link href="https://www.gnu.org/software/guile/manual/html_node/index.html#SEC_Contents" rel="contents" title="Table of Contents">
<link href="https://www.gnu.org/software/guile/manual/html_node/Foreign-Function-Interface.html" rel="up" title="Foreign Function Interface">
<link href="https://www.gnu.org/software/guile/manual/html_node/Scheduling.html" rel="next" title="Scheduling">
<link href="https://www.gnu.org/software/guile/manual/html_node/Foreign-Structs.html" rel="prev" title="Foreign Structs">
<style type="text/css">
<!--
a.summary-letter {text-decoration: none}
blockquote.indentedblock {margin-right: 0em}
div.display {margin-left: 3.2em}
div.example {margin-left: 3.2em}
div.lisp {margin-left: 3.2em}
kbd {font-style: oblique}
pre.display {font-family: inherit}
pre.format {font-family: inherit}
pre.menu-comment {font-family: serif}
pre.menu-preformatted {font-family: serif}
span.nolinebreak {white-space: nowrap}
span.roman {font-family: initial; font-weight: normal}
span.sansserif {font-family: sans-serif; font-weight: normal}
ul.no-bullet {list-style: none}
-->
</style>
<link rel="stylesheet" type="text/css" href="Dynamic%20FFI%20(Guile%20Reference%20Manual)_files/manual.css">


</head>

<body lang="en">
<span id="Dynamic-FFI"></span><div class="header">
<p>
Previous: <a href="https://www.gnu.org/software/guile/manual/html_node/Foreign-Pointers.html" accesskey="p" rel="prev">Foreign Pointers</a>, Up: <a href="https://www.gnu.org/software/guile/manual/html_node/Foreign-Function-Interface.html" accesskey="u" rel="up">Foreign Function Interface</a> &nbsp; [<a href="https://www.gnu.org/software/guile/manual/html_node/index.html#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="https://www.gnu.org/software/guile/manual/html_node/Concept-Index.html" title="Index" rel="index">Index</a>]</p>
</div>
<hr>
<span id="Dynamic-FFI-1"></span><h4 class="subsection">6.21.6 Dynamic FFI</h4>

<p>Of course, the land of C is not all nouns and no verbs: there are
functions too, and Guile allows you to call them.
</p>
<dl>
<dt id="index-pointer_002d_003eprocedure">Scheme Procedure: <strong>pointer-&gt;procedure</strong> <em>return_type func_ptr arg_types                                              [#:return-errno?=#f]</em></dt>
<dt id="index-scm_005fpointer_005fto_005fprocedure">C Function: <strong>scm_pointer_to_procedure</strong> <em>(return_type, func_ptr, arg_types)</em></dt>
<dt id="index-scm_005fpointer_005fto_005fprocedure_005fwith_005ferrno">C Function: <strong>scm_pointer_to_procedure_with_errno</strong> <em>(return_type, func_ptr, arg_types)</em></dt>
<dd>
<p>Make a foreign function.
</p>
<p>Given the foreign void pointer <var>func_ptr</var>, its argument and
return types <var>arg_types</var> and <var>return_type</var>, return a
procedure that will pass arguments to the foreign function
and return appropriate values.
</p>
<p><var>arg_types</var> should be a list of foreign types.
<code>return_type</code> should be a foreign type. See <a href="https://www.gnu.org/software/guile/manual/html_node/Foreign-Types.html">Foreign Types</a>, for
more information on foreign types.
</p>
<p>If <var>return-errno?</var> is true, or when calling
<code>scm_pointer_to_procedure_with_errno</code>, the returned procedure will
return two values, with <code>errno</code> as the second value.
</p></dd></dl>

<p>Here is a better definition of <code>(math bessel)</code>:
</p>
<div class="example">
<pre class="example">(define-module (math bessel)
  #:use-module (system foreign)
  #:export (j0))

(define libm (dynamic-link "libm"))

(define j0
  (pointer-&gt;procedure double
                      (dynamic-func "j0" libm)
                      (list double)))
</pre></div>

<p>That’s it! No C at all.
</p>
<p>Numeric arguments and return values from foreign functions are
represented as Scheme values. For example, <code>j0</code> in the above
example takes a Scheme number as its argument, and returns a Scheme
number.
</p>
<p>Pointers may be passed to and returned from foreign functions as well.
In that case the type of the argument or return value should be the
symbol <code>*</code>, indicating a pointer. For example, the following
code makes <code>memcpy</code> available to Scheme:
</p>
<div class="example">
<pre class="example">(define memcpy
  (let ((this (dynamic-link)))
    (pointer-&gt;procedure '*
                        (dynamic-func "memcpy" this)
                        (list '* '* size_t))))
</pre></div>

<p>To invoke <code>memcpy</code>, one must pass it foreign pointers:
</p>
<div class="example">
<pre class="example">(use-modules (rnrs bytevectors))

(define src-bits
  (u8-list-&gt;bytevector '(0 1 2 3 4 5 6 7)))
(define src
  (bytevector-&gt;pointer src-bits))
(define dest
  (bytevector-&gt;pointer (make-bytevector 16 0)))

(memcpy dest src (bytevector-length src-bits))

(bytevector-&gt;u8-list (pointer-&gt;bytevector dest 16))
⇒ (0 1 2 3 4 5 6 7 0 0 0 0 0 0 0 0)
</pre></div>

<p>One may also pass structs as values, passing structs as foreign
pointers. See <a href="https://www.gnu.org/software/guile/manual/html_node/Foreign-Structs.html">Foreign Structs</a>, for more information on how to express
struct types and struct values.
</p>
<p>“Out” arguments are passed as foreign pointers. The memory pointed to
by the foreign pointer is mutated in place.
</p>
<div class="example">
<pre class="example">;; struct timeval {
;;      time_t      tv_sec;     /* seconds */
;;      suseconds_t tv_usec;    /* microseconds */
;; };
;; assuming fields are of type "long"

(define gettimeofday
  (let ((f (pointer-&gt;procedure
            int
            (dynamic-func "gettimeofday" (dynamic-link))
            (list '* '*)))
        (tv-type (list long long)))
    (lambda ()
      (let* ((timeval (make-c-struct tv-type (list 0 0)))
             (ret (f timeval %null-pointer)))
        (if (zero? ret)
            (apply values (parse-c-struct timeval tv-type))
            (error "gettimeofday returned an error" ret))))))

(gettimeofday)    
⇒ 1270587589
⇒ 499553
</pre></div>

<p>As you can see, this interface to foreign functions is at a very low,
somewhat dangerous level<a id="DOCF21" href="#FOOT21"><sup>21</sup></a>.
</p>
<span id="index-callbacks"></span>
<p>The FFI can also work in the opposite direction: making Scheme
procedures callable from C.  This makes it possible to use Scheme
procedures as “callbacks” expected by C function.
</p>
<dl>
<dt id="index-procedure_002d_003epointer">Scheme Procedure: <strong>procedure-&gt;pointer</strong> <em>return-type proc arg-types</em></dt>
<dt id="index-scm_005fprocedure_005fto_005fpointer">C Function: <strong>scm_procedure_to_pointer</strong> <em>(return_type, proc, arg_types)</em></dt>
<dd><p>Return a pointer to a C function of type <var>return-type</var>
taking arguments of types <var>arg-types</var> (a list) and
behaving as a proxy to procedure <var>proc</var>.  Thus
<var>proc</var>’s arity, supported argument types, and return
type should match <var>return-type</var> and <var>arg-types</var>.
</p></dd></dl>

<p>As an example, here’s how the C library’s <code>qsort</code> array sorting
function can be made accessible to Scheme (see <a href="https://www.gnu.org/software/libc/manual/html_node/Array-Sort-Function.html#Array-Sort-Function"><code>qsort</code></a> in <cite>The GNU C Library Reference Manual</cite>):
</p>
<div class="example">
<pre class="example">(define qsort!
  (let ((qsort (pointer-&gt;procedure void
                                   (dynamic-func "qsort"
                                                 (dynamic-link))
                                   (list '* size_t size_t '*))))
    (lambda (bv compare)
      ;; Sort bytevector BV in-place according to comparison
      ;; procedure COMPARE.
      (let ((ptr (procedure-&gt;pointer int
                                     (lambda (x y)
                                       ;; X and Y are pointers so,
                                       ;; for convenience, dereference
                                       ;; them before calling COMPARE.
                                       (compare (dereference-uint8* x)
                                                (dereference-uint8* y)))
                                     (list '* '*))))
        (qsort (bytevector-&gt;pointer bv)
               (bytevector-length bv) 1 ;; we're sorting bytes
               ptr)))))

(define (dereference-uint8* ptr)
  ;; Helper function: dereference the byte pointed to by PTR.
  (let ((b (pointer-&gt;bytevector ptr 1)))
    (bytevector-u8-ref b 0)))

(define bv
  ;; An unsorted array of bytes.
  (u8-list-&gt;bytevector '(7 1 127 3 5 4 77 2 9 0)))

;; Sort BV.
(qsort! bv (lambda (x y) (- x y)))

;; Let's see what the sorted array looks like:
(bytevector-&gt;u8-list bv)
⇒ (0 1 2 3 4 5 7 9 77 127)
</pre></div>

<p>And voilà!
</p>
<p>Note that <code>procedure-&gt;pointer</code> is not supported (and not defined)
on a few exotic architectures.  Thus, user code may need to check
<code>(defined? 'procedure-&gt;pointer)</code>.  Nevertheless, it is available on
many architectures, including (as of libffi 3.0.9) x86, ia64, SPARC,
PowerPC, ARM, and MIPS, to name a few.
</p>

<div class="footnote">
<hr>
<h4 class="footnotes-heading">Footnotes</h4>

<h5><a id="FOOT21" href="#DOCF21">(21)</a></h5>
<p>A contribution to Guile in the form of
a high-level FFI would be most welcome.</p>
</div>
<hr>
<div class="header">
<p>
Previous: <a href="https://www.gnu.org/software/guile/manual/html_node/Foreign-Pointers.html" accesskey="p" rel="prev">Foreign Pointers</a>, Up: <a href="https://www.gnu.org/software/guile/manual/html_node/Foreign-Function-Interface.html" accesskey="u" rel="up">Foreign Function Interface</a> &nbsp; [<a href="https://www.gnu.org/software/guile/manual/html_node/index.html#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="https://www.gnu.org/software/guile/manual/html_node/Concept-Index.html" title="Index" rel="index">Index</a>]</p>
</div>





</body></html>