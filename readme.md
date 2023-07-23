<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html><!-- Created by GNU Texinfo 6.8, https://www.gnu.org/software/texinfo/ --><head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>Communication Coding (GNU Emacs Manual)</title>

<meta name="description" content="Communication Coding (GNU Emacs Manual)">
<meta name="keywords" content="Communication Coding (GNU Emacs Manual)">
<meta name="resource-type" content="document">
<meta name="distribution" content="global">
<meta name="Generator" content="makeinfo">
<meta name="viewport" content="width=device-width,initial-scale=1">

<link rev="made" href="mailto:bug-gnu-emacs@gnu.org">
<link rel="icon" type="image/png" href="https://www.gnu.org/graphics/gnu-head-mini.png">
<meta name="ICBM" content="42.256233,-71.006581">
<meta name="DC.title" content="gnu.org">
<style type="text/css">
@import url('/software/emacs/manual.css');
</style>
</head>

<body lang="en">
<div class="section" id="Communication-Coding">
<div class="header" style="background-color:#DDDDFF">
<p>
Next: <a href="https://www.gnu.org/software/emacs/manual/html_node/emacs/File-Name-Coding.html" accesskey="n" rel="next">Coding Systems for File Names</a>, Previous: <a href="https://www.gnu.org/software/emacs/manual/html_node/emacs/Text-Coding.html" accesskey="p" rel="prev">Specifying a Coding System for File Text</a>, Up: <a href="https://www.gnu.org/software/emacs/manual/html_node/emacs/International.html" accesskey="u" rel="up">International Character Set Support</a> &nbsp; [<a href="https://www.gnu.org/software/emacs/manual/html_node/emacs/index.html#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="https://www.gnu.org/software/emacs/manual/html_node/emacs/Key-Index.html" title="Index" rel="index">Index</a>]</p>
</div>

<span id="Coding-Systems-for-Interprocess-Communication"></span><h3 class="section">22.10 Coding Systems for Interprocess Communication</h3>

<p>This section explains how to specify coding systems for use
in communication with other processes.
</p>
<dl compact="compact">
<dt><span><kbd>C-x <span class="key">RET</span> x <var>coding</var> <span class="key">RET</span></kbd></span></dt>
<dd><p>Use coding system <var>coding</var> for transferring selections to and from
other graphical applications (<code>set-selection-coding-system</code>).
</p>
</dd>
<dt><span><kbd>C-x <span class="key">RET</span> X <var>coding</var> <span class="key">RET</span></kbd></span></dt>
<dd><p>Use coding system <var>coding</var> for transferring <em>one</em>
selection—the next one—to or from another graphical application
(<code>set-next-selection-coding-system</code>).
</p>
</dd>
<dt><span><kbd>C-x <span class="key">RET</span> p <var>input-coding</var> <span class="key">RET</span> <var>output-coding</var> <span class="key">RET</span></kbd></span></dt>
<dd><p>Use coding systems <var>input-coding</var> and <var>output-coding</var> for
subprocess input and output in the current buffer
(<code>set-buffer-process-coding-system</code>).
</p></dd>
</dl>

<span id="index-C_002dx-RET-x"></span>
<span id="index-C_002dx-RET-X"></span>
<span id="index-set_002dselection_002dcoding_002dsystem"></span>
<span id="index-set_002dnext_002dselection_002dcoding_002dsystem"></span>
<p>The command <kbd>C-x <span class="key">RET</span> x</kbd> (<code>set-selection-coding-system</code>)
specifies the coding system for sending selected text to other windowing
applications, and for receiving the text of selections made in other
applications.  This command applies to all subsequent selections, until
you override it by using the command again.  The command <kbd>C-x
<span class="key">RET</span> X</kbd> (<code>set-next-selection-coding-system</code>) specifies the
coding system for the next selection made in Emacs or read by Emacs.
</p>
<span id="index-x_002dselect_002drequest_002dtype"></span>
<p>The variable <code>x-select-request-type</code> specifies the data type to
request from the X Window System for receiving text selections from
other applications.  If the value is <code>nil</code> (the default), Emacs
tries <code>UTF8_STRING</code> and <code>COMPOUND_TEXT</code>, in this order, and
uses various heuristics to choose the more appropriate of the two
results; if none of these succeed, Emacs falls back on <code>STRING</code>.
If the value of <code>x-select-request-type</code> is one of the symbols
<code>COMPOUND_TEXT</code>, <code>UTF8_STRING</code>, <code>STRING</code>, or
<code>TEXT</code>, Emacs uses only that request type.  If the value is a
list of some of these symbols, Emacs tries only the request types in
the list, in order, until one of them succeeds, or until the list is
exhausted.
</p>
<span id="index-C_002dx-RET-p"></span>
<span id="index-set_002dbuffer_002dprocess_002dcoding_002dsystem"></span>
<p>The command <kbd>C-x <span class="key">RET</span> p</kbd> (<code>set-buffer-process-coding-system</code>)
specifies the coding system for input and output to a subprocess.  This
command applies to the current buffer; normally, each subprocess has its
own buffer, and thus you can use this command to specify translation to
and from a particular subprocess by giving the command in the
corresponding buffer.
</p>
<p>You can also use <kbd>C-x <span class="key">RET</span> c</kbd>
(<code>universal-coding-system-argument</code>) just before the command that
runs or starts a subprocess, to specify the coding system for
communicating with that subprocess.  See <a href="https://www.gnu.org/software/emacs/manual/html_node/emacs/Text-Coding.html">Specifying a Coding System for File Text</a>.
</p>
<p>The default for translation of process input and output depends on the
current language environment.
</p>
<span id="index-locale_002dcoding_002dsystem"></span>
<span id="index-decoding-non_002dASCII-keyboard-input-on-X"></span>
<p>The variable <code>locale-coding-system</code> specifies a coding system
to use when encoding and decoding system strings such as system error
messages and <code>format-time-string</code> formats and time stamps.  That
coding system is also used for decoding non-<acronym>ASCII</acronym> keyboard
input on the X Window System and for encoding text sent to the
standard output and error streams when in batch mode.  You should
choose a coding system that is compatible
with the underlying system’s text representation, which is normally
specified by one of the environment variables <code>LC_ALL</code>,
<code>LC_CTYPE</code>, and <code>LANG</code>.  (The first one, in the order
specified above, whose value is nonempty is the one that determines
the text representation.)
</p>
</div>

<div class="header" style="background-color:#DDDDFF">
<p>
Next: <a href="https://www.gnu.org/software/emacs/manual/html_node/emacs/File-Name-Coding.html">Coding Systems for File Names</a>, Previous: <a href="https://www.gnu.org/software/emacs/manual/html_node/emacs/Text-Coding.html">Specifying a Coding System for File Text</a>, Up: <a href="https://www.gnu.org/software/emacs/manual/html_node/emacs/International.html">International Character Set Support</a> &nbsp; [<a href="https://www.gnu.org/software/emacs/manual/html_node/emacs/index.html#SEC_Contents" title="Table of contents" rel="contents">Contents</a>][<a href="https://www.gnu.org/software/emacs/manual/html_node/emacs/Key-Index.html" title="Index" rel="index">Index</a>]</p>
</div>





</body></html>