;;; helm-autoloads.el --- automatically extracted autoloads
;;
;;; Code:


;;;### (autoloads nil "async" "async.el" (22129 42875 13153 0))
;;; Generated autoloads from async.el

(autoload 'async-start-process "async" "\
Start the executable PROGRAM asynchronously.  See `async-start'.
PROGRAM is passed PROGRAM-ARGS, calling FINISH-FUNC with the
process object when done.  If FINISH-FUNC is nil, the future
object will return the process object when the program is
finished.  Set DEFAULT-DIRECTORY to change PROGRAM's current
working directory.

\(fn NAME PROGRAM FINISH-FUNC &rest PROGRAM-ARGS)" nil nil)

(autoload 'async-start "async" "\
Execute START-FUNC (often a lambda) in a subordinate Emacs process.
When done, the return value is passed to FINISH-FUNC.  Example:

    (async-start
       ;; What to do in the child process
       (lambda ()
         (message \"This is a test\")
         (sleep-for 3)
         222)

       ;; What to do when it finishes
       (lambda (result)
         (message \"Async process done, result should be 222: %s\"
                  result)))

If FINISH-FUNC is nil or missing, a future is returned that can
be inspected using `async-get', blocking until the value is
ready.  Example:

    (let ((proc (async-start
                   ;; What to do in the child process
                   (lambda ()
                     (message \"This is a test\")
                     (sleep-for 3)
                     222))))

        (message \"I'm going to do some work here\") ;; ....

        (message \"Waiting on async process, result should be 222: %s\"
                 (async-get proc)))

If you don't want to use a callback, and you don't care about any
return value form the child process, pass the `ignore' symbol as
the second argument (if you don't, and never call `async-get', it
will leave *emacs* process buffers hanging around):

    (async-start
     (lambda ()
       (delete-file \"a remote file on a slow link\" nil))
     'ignore)

Note: Even when FINISH-FUNC is present, a future is still
returned except that it yields no value (since the value is
passed to FINISH-FUNC).  Call `async-get' on such a future always
returns nil.  It can still be useful, however, as an argument to
`async-ready' or `async-wait'.

\(fn START-FUNC &optional FINISH-FUNC)" nil t)

;;;***

;;;### (autoloads nil "async-bytecomp" "async-bytecomp.el" (22129
;;;;;;  42875 4153 0))
;;; Generated autoloads from async-bytecomp.el

(autoload 'async-byte-recompile-directory "async-bytecomp" "\
Compile all *.el files in DIRECTORY asynchronously.
All *.elc files are systematically deleted before proceeding.

\(fn DIRECTORY &optional QUIET)" nil nil)

(defvar async-bytecomp-package-mode nil "\
Non-nil if Async-Bytecomp-Package mode is enabled.
See the command `async-bytecomp-package-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `async-bytecomp-package-mode'.")

(custom-autoload 'async-bytecomp-package-mode "async-bytecomp" nil)

(autoload 'async-bytecomp-package-mode "async-bytecomp" "\
Byte compile asynchronously packages installed with package.el.
Async compilation of packages can be controlled by
`async-bytecomp-allowed-packages'.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "csharp-mode" "csharp-mode.el" (22011 8039
;;;;;;  700161 700000))
;;; Generated autoloads from csharp-mode.el

(defvar csharp-mode-hook nil "\
*Hook called by `csharp-mode'.")

(custom-autoload 'csharp-mode-hook "csharp-mode" t)

(defvar csharp-want-flymake-fixup t "\
*Whether to enable the builtin C# support for flymake. This is meaningful
only if flymake is loaded.")

(custom-autoload 'csharp-want-flymake-fixup "csharp-mode" t)

(defvar csharp-want-yasnippet-fixup t "\
*Whether to enable the builtin C# support for yasnippet. This is meaningful
only if flymake is loaded.")

(custom-autoload 'csharp-want-yasnippet-fixup "csharp-mode" t)

(defvar csharp-want-imenu t "\
*Whether to generate a buffer index via imenu for C# buffers.")

(custom-autoload 'csharp-want-imenu "csharp-mode" t)

(defvar csharp-make-tool "nmake.exe" "\
*The make tool to use. Defaults to nmake, found on path. Specify
a full path or alternative program name, to tell csharp-mode to use
a different make tool in compile commands.

See also, `csharp-msbuild-tool'.

")

(custom-autoload 'csharp-make-tool "csharp-mode" t)

(defvar csharp-msbuild-tool "msbuild.exe" "\
*The tool to use to build .csproj files. Defaults to msbuild, found on
path. Specify a full path or alternative program name, to tell csharp-mode
to use a different make tool in compile commands.

See also, `csharp-make-tool'.

")

(custom-autoload 'csharp-msbuild-tool "csharp-mode" t)

(defvar csharp-cmd-line-limit 28 "\
The number of lines at the top of the file to look in, to find
the command that csharp-mode will use to compile the current
buffer, or the command \"stub\" that csharp-mode will use to
check the syntax of the current buffer via flymake.

If the value of this variable is zero, then csharp-mode looks
everywhere in the file.  If the value is positive, then only in
the first N lines. If negative, then only in the final N lines.

The line should appear in a comment inside the C# buffer.


Compile
--------

In the case of compile, the compile command must be prefixed with
\"compile:\".  For example,

 // compile: csc.exe /r:Hallo.dll Arfie.cs


This command will be suggested as the compile command when the
user invokes `compile' for the first time.


Flymake
--------

In the case of flymake, the command \"stub\" string must be
prefixed with \"flymake:\".  For example,

 // flymake: DOTNETDIRcsc.exe /target:netmodule /r:foo.dll @@FILE@@

In the case of flymake, the string should NOT include the name of
the file for the buffer being checked. Instead, use the token
@@FILE@@ .  csharp-mode will replace this token with the name of
the source file to compile, before passing the command to flymake
to run it.

If for some reason the command is invalid or illegal, flymake
will report an error and disable itself.

It might be handy to run fxcop, for example, via flymake.

 // flymake: fxcopcmd.exe /c  /f:MyLibrary.dll



In all cases
------------

Be sure to specify the proper path for your csc.exe, whatever
version that might be, or no path if you want to use the system
PATH search.

If the buffer depends on external libraries, then you will want
to include /R arguments to that csc.exe command.

To be clear, this variable sets the number of lines to search for
the command.  This cariable is an integer.

If the marker string (either \"compile:\" or \"flymake:\"
is present in the given set of lines, csharp-mode will take
anything after the marker string as the command to run.

")

(custom-autoload 'csharp-cmd-line-limit "csharp-mode" t)

(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))

(autoload 'csharp-mode "csharp-mode" "\
Major mode for editing C# code. This mode is derived from CC Mode to
support C#.

Normally, you'd want to autoload this mode by setting `auto-mode-alist' with
an entry for csharp, in your .emacs file:

   (autoload 'csharp-mode \"csharp-mode\" \"Major mode for editing C# code.\" t)
   (setq auto-mode-alist
      (append '((\"\\.cs$\" . csharp-mode)) auto-mode-alist))

The mode provides fontification and indent for C# syntax, as well
as some other handy features.

At mode startup, there are two interesting hooks that run:
`c-mode-common-hook' is run with no args, then `csharp-mode-hook' is run after
that, also with no args.

To run your own logic after csharp-mode starts, do this:

  (defun my-csharp-mode-fn ()
    \"my function that runs when csharp-mode is initialized for a buffer.\"
    (turn-on-font-lock)
    (turn-on-auto-revert-mode) ;; helpful when also using Visual Studio
    (setq indent-tabs-mode nil) ;; tabs are evil
    (flymake-mode 1)
    (yas/minor-mode-on)
    (require 'rfringe)  ;; handy for flymake
    (require 'flymake-cursor) ;; also handy for flymake
    ....your own code here...
  )
  (add-hook  'csharp-mode-hook 'my-csharp-mode-fn t)


The function above is just a suggestion.


Compile integration:
========================

csharp-mode binds the function `csharp-invoke-compile-interactively' to
\"\" .  This function attempts to intellgently guess the format of the
compile command to use for a buffer.  It looks in the comments at the head of
the buffer for a line that begins with compile: .  For exammple:

  // compile: csc.exe /t:library /r:Mylib.dll Foo.cs

If csharp-mode finds a line like this, it will suggest the text that follows
as the compilation command when running `compile' for the first time.  If such
a line is not found, csharp-mode falls back to a msbuild or nmake command.
See the documentation on `csharp-cmd-line-limit' for further information. If
you don't want this magic, then you can just run `compile' directly, rather
than `csharp-invoke-compile-interactively' .

This mode will also automatically add a symbol and regexp to the
`compilation-error-regexp-alist' and`compilation-error-regexp-alist-alist'
respectively, for Csc.exe error and warning messages. If you invoke `compile',
then `next-error' should work properly for error messages produced by csc.exe.


Flymake Integraiton
========================

You can use flymake with csharp mode to automatically check the syntax of your
csharp code, and highlight errors.  To do so, add a comment line like this to
each .cs file that you use flymake with:

   //  flymake: csc.exe /t:module /R:Foo.dll @@FILE@@

csharp-mode replaces special tokens in the command with different values:

  @@ORIG@@ - gets replaced with the original filename
  @@FILE@@ - gets replaced with the name of the temporary file
      created by flymake. This is usually what you want in place of the
      name of the file to be compiled.

See the documentation on `csharp-cmd-line-limit' for further information.

You may also want to run a syntax checker, like fxcop:

   //  flymake: fxcopcmd.exe /c /F:MyLibrary.dll

In this case you don't need either of the tokens described above.

If the module has no external dependencies, then you need not specify any
flymake command at all. csharp-mode will implicitly act as if you had
specified the command:

     // flymake: csc.exe /t:module /nologo @@FILE@@

It looks for the EXE on the path.  You can specify a full path if you like.


YASnippet and IMenu Integraiton
===============================

Check the menubar for menu entries for YASnippet and Imenu; the latter
is labelled \"Index\".

The Imenu index gets computed when the file is .cs first opened and loaded.
This may take a moment or two.  If you don't like this delay and don't
use imenu, you can turn this off with the variable `csharp-want-imenu'.



Key bindings:
\\{csharp-mode-map}

\(fn)" t nil)

;;;***

;;;### (autoloads nil "desktop" "desktop.el" (22067 58674 157242
;;;;;;  100000))
;;; Generated autoloads from desktop.el

(defvar desktop-save-mode nil "\
Non-nil if Desktop-Save mode is enabled.
See the command `desktop-save-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `desktop-save-mode'.")

(custom-autoload 'desktop-save-mode "desktop" nil)

(autoload 'desktop-save-mode "desktop" "\
Toggle desktop saving (Desktop Save mode).
With a prefix argument ARG, enable Desktop Save mode if ARG is positive,
and disable it otherwise.  If called from Lisp, enable the mode if ARG
is omitted or nil.

When Desktop Save mode is enabled, the state of Emacs is saved from
one session to another.  In particular, Emacs will save the desktop when
it exits (this may prompt you; see the option `desktop-save').  The next
time Emacs starts, if this mode is active it will restore the desktop.

To manually save the desktop at any time, use the command `\\[desktop-save]'.
To load it, use `\\[desktop-read]'.

Once a desktop file exists, Emacs will auto-save it according to the
option `desktop-auto-save-timeout'.

To see all the options you can set, browse the `desktop' customization group.

For further details, see info node `(emacs)Saving Emacs Sessions'.

\(fn &optional ARG)" t nil)

(defvar desktop-locals-to-save '(desktop-locals-to-save truncate-lines case-fold-search case-replace fill-column overwrite-mode change-log-default-name line-number-mode column-number-mode size-indication-mode buffer-file-coding-system indent-tabs-mode tab-width indicate-buffer-boundaries indicate-empty-lines show-trailing-whitespace) "\
List of local variables to save for each buffer.
The variables are saved only when they really are local.  Conventional minor
modes are restored automatically; they should not be listed here.")

(custom-autoload 'desktop-locals-to-save "desktop" t)

(defvar-local desktop-save-buffer nil "\
When non-nil, save buffer status in desktop file.

If the value is a function, it is called by `desktop-save' with argument
DESKTOP-DIRNAME to obtain auxiliary information to save in the desktop
file along with the state of the buffer for which it was called.

When file names are returned, they should be formatted using the call
\"(desktop-file-name FILE-NAME DESKTOP-DIRNAME)\".

Later, when `desktop-read' evaluates the desktop file, auxiliary information
is passed as the argument DESKTOP-BUFFER-MISC to functions in
`desktop-buffer-mode-handlers'.")

(defvar desktop-buffer-mode-handlers nil "\
Alist of major mode specific functions to restore a desktop buffer.
Functions listed are called by `desktop-create-buffer' when `desktop-read'
evaluates the desktop file.  List elements must have the form

   (MAJOR-MODE . RESTORE-BUFFER-FUNCTION).

Buffers with a major mode not specified here, are restored by the default
handler `desktop-restore-file-buffer'.

Handlers are called with argument list

   (DESKTOP-BUFFER-FILE-NAME DESKTOP-BUFFER-NAME DESKTOP-BUFFER-MISC)

Furthermore, they may use the following variables:

   `desktop-file-version'
   `desktop-buffer-major-mode'
   `desktop-buffer-minor-modes'
   `desktop-buffer-point'
   `desktop-buffer-mark'
   `desktop-buffer-read-only'
   `desktop-buffer-locals'

If a handler returns a buffer, then the saved mode settings
and variable values for that buffer are copied into it.

Modules that define a major mode that needs a special handler should contain
code like

   (defun foo-restore-desktop-buffer
   ...
   (add-to-list 'desktop-buffer-mode-handlers
                '(foo-mode . foo-restore-desktop-buffer))

The major mode function must either be autoloaded, or of the form
\"foobar-mode\" and defined in library \"foobar\", so that desktop
can guess how to load the mode's definition.")

(put 'desktop-buffer-mode-handlers 'risky-local-variable t)

(defvar desktop-minor-mode-handlers nil "\
Alist of functions to restore non-standard minor modes.
Functions are called by `desktop-create-buffer' to restore minor modes.
List elements must have the form

   (MINOR-MODE . RESTORE-FUNCTION).

Minor modes not specified here, are restored by the standard minor mode
function.

Handlers are called with argument list

   (DESKTOP-BUFFER-LOCALS)

Furthermore, they may use the following variables:

   `desktop-file-version'
   `desktop-buffer-file-name'
   `desktop-buffer-name'
   `desktop-buffer-major-mode'
   `desktop-buffer-minor-modes'
   `desktop-buffer-point'
   `desktop-buffer-mark'
   `desktop-buffer-read-only'
   `desktop-buffer-misc'

When a handler is called, the buffer has been created and the major mode has
been set, but local variables listed in desktop-buffer-locals has not yet been
created and set.

Modules that define a minor mode that needs a special handler should contain
code like

   (defun foo-desktop-restore
   ...
   (add-to-list 'desktop-minor-mode-handlers
                '(foo-mode . foo-desktop-restore))

The minor mode function must either be autoloaded, or of the form
\"foobar-mode\" and defined in library \"foobar\", so that desktop
can guess how to load the mode's definition.

See also `desktop-minor-mode-table'.")

(put 'desktop-minor-mode-handlers 'risky-local-variable t)

(autoload 'desktop-clear "desktop" "\
Empty the Desktop.
This kills all buffers except for internal ones and those with names matched by
a regular expression in the list `desktop-clear-preserve-buffers'.
Furthermore, it clears the variables listed in `desktop-globals-to-clear'.
When called interactively and `desktop-restore-frames' is non-nil, it also
deletes all frames except the selected one (and its minibuffer frame,
if different).

\(fn)" t nil)

(autoload 'desktop-save "desktop" "\
Save the desktop in a desktop file.
Parameter DIRNAME specifies where to save the desktop file.
Optional parameter RELEASE says whether we're done with this desktop.
If ONLY-IF-CHANGED is non-nil, compare the current desktop information
to that in the desktop file, and if the desktop information has not
changed since it was last saved then do not rewrite the file.

\(fn DIRNAME &optional RELEASE ONLY-IF-CHANGED)" t nil)

(autoload 'desktop-remove "desktop" "\
Delete desktop file in `desktop-dirname'.
This function also sets `desktop-dirname' to nil.

\(fn)" t nil)

(autoload 'desktop-read "desktop" "\
Read and process the desktop file in directory DIRNAME.
Look for a desktop file in DIRNAME, or if DIRNAME is omitted, look in
directories listed in `desktop-path'.  If a desktop file is found, it
is processed and `desktop-after-read-hook' is run.  If no desktop file
is found, clear the desktop and run `desktop-no-desktop-file-hook'.
This function is a no-op when Emacs is running in batch mode.
It returns t if a desktop file was loaded, nil otherwise.

\(fn &optional DIRNAME)" t nil)

(autoload 'desktop-load-default "desktop" "\
Load the `default' start-up library manually.
Also inhibit further loading of it.

\(fn)" nil nil)

(make-obsolete 'desktop-load-default 'desktop-save-mode '"22.1")

(autoload 'desktop-change-dir "desktop" "\
Change to desktop saved in DIRNAME.
Kill the desktop as specified by variables `desktop-save-mode' and
`desktop-save', then clear the desktop and load the desktop file in
directory DIRNAME.

\(fn DIRNAME)" t nil)

(autoload 'desktop-save-in-desktop-dir "desktop" "\
Save the desktop in directory `desktop-dirname'.

\(fn)" t nil)

(autoload 'desktop-revert "desktop" "\
Revert to the last loaded desktop.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "dired-async" "dired-async.el" (22129 42875
;;;;;;  17153 0))
;;; Generated autoloads from dired-async.el

(defvar dired-async-mode nil "\
Non-nil if Dired-Async mode is enabled.
See the command `dired-async-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `dired-async-mode'.")

(custom-autoload 'dired-async-mode "dired-async" nil)

(autoload 'dired-async-mode "dired-async" "\
Do dired actions asynchronously.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "flymake" "flymake.el" (22063 55138 539016
;;;;;;  100000))
;;; Generated autoloads from flymake.el

(autoload 'flymake-mode "flymake" "\
Toggle on-the-fly syntax checking.
With a prefix argument ARG, enable the mode if ARG is positive,
and disable it otherwise.  If called from Lisp, enable the mode
if ARG is omitted or nil.

\(fn &optional ARG)" t nil)

(autoload 'flymake-mode-on "flymake" "\
Turn flymake mode on.

\(fn)" nil nil)

(autoload 'flymake-mode-off "flymake" "\
Turn flymake mode off.

\(fn)" nil nil)

(autoload 'flymake-find-file-hook "flymake" "\


\(fn)" nil nil)

;;;***

;;;### (autoloads nil "frameset" "frameset.el" (22067 58773 122137
;;;;;;  600000))
;;; Generated autoloads from frameset.el

(defvar frameset-session-filter-alist '((name . :never) (left . frameset-filter-iconified) (minibuffer . frameset-filter-minibuffer) (top . frameset-filter-iconified)) "\
Minimum set of parameters to filter for live (on-session) framesets.
DO NOT MODIFY.  See `frameset-filter-alist' for a full description.")

(defvar frameset-persistent-filter-alist (nconc '((background-color . frameset-filter-sanitize-color) (buffer-list . :never) (buffer-predicate . :never) (buried-buffer-list . :never) (font . frameset-filter-shelve-param) (foreground-color . frameset-filter-sanitize-color) (fullscreen . frameset-filter-shelve-param) (GUI:font . frameset-filter-unshelve-param) (GUI:fullscreen . frameset-filter-unshelve-param) (GUI:height . frameset-filter-unshelve-param) (GUI:width . frameset-filter-unshelve-param) (height . frameset-filter-shelve-param) (outer-window-id . :never) (parent-id . :never) (tty . frameset-filter-tty-to-GUI) (tty-type . frameset-filter-tty-to-GUI) (width . frameset-filter-shelve-param) (window-id . :never) (window-system . :never)) frameset-session-filter-alist) "\
Parameters to filter for persistent framesets.
DO NOT MODIFY.  See `frameset-filter-alist' for a full description.")

(defvar frameset-filter-alist frameset-persistent-filter-alist "\
Alist of frame parameters and filtering functions.
This alist is the default value of the FILTERS argument of
`frameset-save' and `frameset-restore' (which see).
Initially, `frameset-filter-alist' is set to, and shares the value of,
`frameset-persistent-filter-alist'.  You can override any item in
this alist by `push'ing a new item onto it.  If, for some reason, you
intend to modify existing values, do
  (setq frameset-filter-alist (copy-tree frameset-filter-alist))
before changing anything.
On saving, PARAMETERS is the parameter alist of each frame processed,
and FILTERED is the parameter alist that gets saved to the frameset.
On restoring, PARAMETERS is the parameter alist extracted from the
frameset, and FILTERED is the resulting frame parameter alist used
to restore the frame.
Elements of `frameset-filter-alist' are conses (PARAM . ACTION),
where PARAM is a parameter name (a symbol identifying a frame
parameter), and ACTION can be:
 nil       The parameter is copied to FILTERED.
 :never    The parameter is never copied to FILTERED.
 :save     The parameter is copied only when saving the frame.
 :restore  The parameter is copied only when restoring the frame.
 FILTER    A filter function.
FILTER can be a symbol FILTER-FUN, or a list (FILTER-FUN ARGS...).
FILTER-FUN is invoked with
  (apply FILTER-FUN CURRENT FILTERED PARAMETERS SAVING ARGS)
where
 CURRENT     A cons (PARAM . VALUE), where PARAM is the one being
	     filtered and VALUE is its current value.
 FILTERED    The resulting alist (so far).
 PARAMETERS  The complete alist of parameters being filtered,
 SAVING      Non-nil if filtering before saving state, nil if filtering
	       before restoring it.
 ARGS        Any additional arguments specified in the ACTION.
FILTER-FUN is allowed to modify items in FILTERED, but no other arguments.
It must return:
 nil                      Skip CURRENT (do not add it to FILTERED).
 t                        Add CURRENT to FILTERED as is.
 (NEW-PARAM . NEW-VALUE)  Add this to FILTERED instead of CURRENT.
Frame parameters not on this alist are passed intact, as if they were
defined with ACTION = nil.")

(autoload 'frameset-frame-id "frameset" "\
Return the frame id of FRAME, if it has one; else, return nil.
A frame id is a string that uniquely identifies a frame.
It is persistent across `frameset-save' / `frameset-restore'
invocations, and once assigned is never changed unless the same
frame is duplicated (via `frameset-restore'), in which case the
newest frame keeps the id and the old frame's is set to nil.

\(fn FRAME)" nil nil)

(autoload 'frameset-frame-id-equal-p "frameset" "\
Return non-nil if FRAME's id matches ID.

\(fn FRAME ID)" nil nil)

(autoload 'frameset-frame-with-id "frameset" "\
Return the live frame with id ID, if exists; else nil.
If FRAME-LIST is a list of frames, check these frames only.
If nil, check all live frames.

\(fn ID &optional FRAME-LIST)" nil nil)

(autoload 'frameset-save "frameset" "\
Return a frameset for FRAME-LIST, a list of frames.
Dead frames and non-frame objects are silently removed from the list.
If nil, FRAME-LIST defaults to the output of `frame-list' (all live frames).
APP, NAME and DESCRIPTION are optional data; see the docstring of the
`frameset' defstruct for details.
FILTERS is an alist of parameter filters; if nil, the value of the variable
`frameset-filter-alist' is used instead.
PREDICATE is a predicate function, which must return non-nil for frames that
should be saved; if PREDICATE is nil, all frames from FRAME-LIST are saved.
PROPERTIES is a user-defined property list to add to the frameset.

\(fn FRAME-LIST &key APP NAME DESCRIPTION FILTERS PREDICATE PROPERTIES)" nil nil)

(autoload 'frameset-restore "frameset" "\
Restore a FRAMESET into the current display(s).
PREDICATE is a function called with two arguments, the parameter alist
and the window-state of the frame being restored, in that order (see
the docstring of the `frameset' defstruct for additional details).
If PREDICATE returns nil, the frame described by that parameter alist
and window-state is not restored.
FILTERS is an alist of parameter filters; if nil, the value of
`frameset-filter-alist' is used instead.
REUSE-FRAMES selects the policy to reuse frames when restoring:
  t        All existing frames can be reused.
  nil      No existing frame can be reused.
  match    Only frames with matching frame ids can be reused.
  PRED     A predicate function; it receives as argument a live frame,
             and must return non-nil to allow reusing it, nil otherwise.
FORCE-DISPLAY can be:
  t        Frames are restored in the current display.
  nil      Frames are restored, if possible, in their original displays.
  delete   Frames in other displays are deleted instead of restored.
  PRED     A function called with two arguments, the parameter alist and
	     the window state (in that order).  It must return t, nil or
	     `delete', as above but affecting only the frame that will
	     be created from that parameter alist.
FORCE-ONSCREEN can be:
  t        Force onscreen only those frames that are fully offscreen.
  nil      Do not force any frame back onscreen.
  all      Force onscreen any frame fully or partially offscreen.
  PRED     A function called with three arguments,
	   - the live frame just restored,
	   - a list (LEFT TOP WIDTH HEIGHT), describing the frame,
	   - a list (LEFT TOP WIDTH HEIGHT), describing the workarea.
	   It must return non-nil to force the frame onscreen, nil otherwise.
CLEANUP-FRAMES allows to \"clean up\" the frame list after restoring a frameset:
  t        Delete all frames that were not created or restored upon.
  nil      Keep all frames.
  FUNC     A function called with two arguments:
           - FRAME, a live frame.
           - ACTION, which can be one of
             :rejected  Frame existed, but was not a candidate for reuse.
             :ignored   Frame existed, was a candidate, but wasn't reused.
             :reused    Frame existed, was a candidate, and restored upon.
             :created   Frame didn't exist, was created and restored upon.
           Return value is ignored.
Note the timing and scope of the operations described above: REUSE-FRAMES
affects existing frames; PREDICATE, FILTERS and FORCE-DISPLAY affect the frame
being restored before that happens; FORCE-ONSCREEN affects the frame once
it has been restored; and CLEANUP-FRAMES affects all frames alive after the
restoration, including those that have been reused or created anew.
All keyword parameters default to nil.

\(fn FRAMESET &key PREDICATE FILTERS REUSE-FRAMES FORCE-DISPLAY FORCE-ONSCREEN CLEANUP-FRAMES)" nil nil)

(autoload 'frameset--jump-to-register "frameset" "\
Restore frameset from DATA stored in register.
Called from `jump-to-register'.  Internal use only.

\(fn DATA)" nil nil)

(autoload 'frameset--print-register "frameset" "\
Print basic info about frameset stored in DATA.
Called from `list-registers' and `view-register'.  Internal use only.

\(fn DATA)" nil nil)

(autoload 'frameset-to-register "frameset" "\
Store the current frameset in register REGISTER.
Use \\[jump-to-register] to restore the frameset.
Argument is a character, naming the register.
Interactively, reads the register using `register-read-with-preview'.

\(fn REGISTER)" t nil)

;;;***

;;;### (autoloads nil "helm" "helm.el" (22129 42516 585153 0))
;;; Generated autoloads from helm.el

(autoload 'helm-define-multi-key "helm" "\
In KEYMAP, define key sequence KEY for function list FUNCTIONS.
Each function run sequentially each time the key KEY is pressed.
If DELAY is specified switch back to initial function of FUNCTIONS list
after DELAY seconds.
The functions in FUNCTIONS list are functions with no args.
e.g
  (defun foo ()
    (message \"Run foo\"))
  (defun bar ()
    (message \"Run bar\"))
  (defun baz ()
    (message \"Run baz\"))

\(helm-define-multi-key global-map \"<f5> q\" '(foo bar baz) 2)

Each time \"<f5> q\" is pressed the next function is executed, if you wait
More than 2 seconds, next hit will run again the first function and so on.

\(fn KEYMAP KEY FUNCTIONS &optional DELAY)" nil nil)

(autoload 'helm-multi-key-defun "helm" "\
Define NAME as a multi-key command running FUNS.
After DELAY seconds the FUNS list is reinitialised.
See `helm-define-multi-key'.

\(fn NAME DOCSTRING FUNS &optional DELAY)" nil t)

(put 'helm-multi-key-defun 'lisp-indent-function '2)

(autoload 'helm-define-key-with-subkeys "helm" "\
Allow defining in MAP a KEY and SUBKEY to COMMAND.

This allow typing KEY to call COMMAND the first time and
type only SUBKEY on subsequent calls.

Arg MAP is the keymap to use, SUBKEY is the initial short keybinding to
call COMMAND.

Arg OTHER-SUBKEYS is an alist specifying other short keybindings
to use once started.
e.g:

\(helm-define-key-with-subkeys global-map
   (kbd \"C-x v n\") ?n 'git-gutter:next-hunk '((?p . git-gutter:previous-hunk)))


In this example, `C-x v n' will run `git-gutter:next-hunk'
subsequent hits on \"n\" will run this command again
and subsequent hits on \"p\" will run `git-gutter:previous-hunk'.

Arg MENU is a string to display in minibuffer
to describe SUBKEY and OTHER-SUBKEYS.
Arg EXIT-FN specify a function to run on exit.

Any other keys pressed run their assigned command defined in MAP
and exit the loop running EXIT-FN if specified.

NOTE: SUBKEY and OTHER-SUBKEYS bindings support
only char syntax actually (e.g ?n)
so don't use strings, vectors or whatever to define them.

\(fn MAP KEY SUBKEY COMMAND &optional OTHER-SUBKEYS MENU EXIT-FN)" nil nil)

(put 'helm-define-key-with-subkeys 'lisp-indent-function '1)

(autoload 'helm-debug-open-last-log "helm" "\
Open helm log file of last helm session.
If `helm-last-log-file' is nil, switch to `helm-debug-buffer' .

\(fn)" t nil)

(autoload 'helm "helm" "\
Main function to execute helm sources.

Keywords supported:
:sources :input :prompt :resume :preselect
:buffer :keymap :default :history :allow-nest

Extra LOCAL-VARS keywords are supported, see below.

PLIST is a list like (:key1 val1 :key2 val2 ...) or
\(&optional sources input prompt resume
            preselect buffer keymap default history).

Basic keywords are the following:

:sources

A list of sources used for this session.  It also accepts a
symbol, interpreted as a variable of a helm source
i.e (a symbol can be passed instead of a list of sources).
It also accepts an alist representing a helm source, which is
detected by (assq 'name ANY-SOURCES).
NOTE: In this case the source is embedded in the helm command and
have no symbol name, so it is not reachable from outside.
It will be referenced in `helm-sources' as a whole alist.

:input

Temporary value of `helm-pattern', ie. initial input of minibuffer.

:prompt

Prompt other than \"pattern: \".

:resume

If t, Resurrect previously instance of `helm'.  Skip the initialization.
If 'noresume, this instance of `helm' cannot be resumed.

:preselect

Initially selected candidate.  Specified by exact candidate or a regexp.

:buffer

`helm-buffer' instead of *helm*.

:keymap

`helm-map' for current `helm' session.

:default

A default argument that will be inserted in minibuffer with \\<minibuffer-local-map>\\[next-history-element].
When nil or not present `thing-at-point' will be used instead.
If `helm--maybe-use-default-as-input' is non--nil display will be
updated using :default arg as input unless :input is specified,
which in this case will take precedence on :default
This is a string or a list, in this case the car of the list will
be used as initial default input, but you will be able to cycle in this
list with \\<minibuffer-local-map>\\[next-history-element].

:history

By default all minibuffer input is pushed to `minibuffer-history',
if an argument HISTORY is provided, input will be pushed to HISTORY.
History element should be a symbol.

:allow-nest

Allow running this helm command within a running helm session.

Of course, conventional arguments are supported, the two are same.

\(helm :sources sources :input input :prompt prompt :resume resume
       :preselect preselect :buffer buffer :keymap keymap :default default
       :history history)

and

\(helm sources input prompt resume preselect buffer keymap default history)

are the same.

However the use of non keyword args is deprecated and should not be used.

Other keywords are interpreted as local variables of this helm session.
The `helm-' prefix can be omitted.  For example,

\(helm :sources 'helm-source-buffers-list
       :buffer \"*buffers*\" :candidate-number-limit 10)

means starting helm session with `helm-source-buffers'
source in *buffers* buffer and set variable `helm-candidate-number-limit'
to 10 as session local variable.

\(fn &key SOURCES INPUT PROMPT RESUME PRESELECT BUFFER KEYMAP DEFAULT HISTORY ALLOW-NEST OTHER-LOCAL-VARS)" nil nil)

(autoload 'helm-other-buffer "helm" "\
Simplified interface of `helm' with other `helm-buffer'.
Call `helm' with only ANY-SOURCES and ANY-BUFFER as args.

\(fn ANY-SOURCES ANY-BUFFER)" nil nil)

(autoload 'helm-debug-toggle "helm" "\
Enable/disable helm debug from outside of helm session.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-adaptive" "helm-adaptive.el" (22129 42515
;;;;;;  728153 0))
;;; Generated autoloads from helm-adaptive.el

(defvar helm-adaptive-mode nil "\
Non-nil if Helm-Adaptive mode is enabled.
See the command `helm-adaptive-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `helm-adaptive-mode'.")

(custom-autoload 'helm-adaptive-mode "helm-adaptive" nil)

(autoload 'helm-adaptive-mode "helm-adaptive" "\
Toggle adaptive sorting in all sources.

\(fn &optional ARG)" t nil)

(autoload 'helm-reset-adaptive-history "helm-adaptive" "\
Delete all `helm-adaptive-history' and his file.
Useful when you have a old or corrupted `helm-adaptive-history-file'.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-apt" "helm-apt.el" (22129 42515 743153
;;;;;;  0))
;;; Generated autoloads from helm-apt.el

(autoload 'helm-apt "helm-apt" "\
Preconfigured `helm' : frontend of APT package manager.
With a prefix arg reload cache.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "helm-bookmark" "helm-bookmark.el" (22129 42515
;;;;;;  770153 0))
;;; Generated autoloads from helm-bookmark.el

(autoload 'helm-bookmarks "helm-bookmark" "\
Preconfigured `helm' for bookmarks.

\(fn)" t nil)

(autoload 'helm-filtered-bookmarks "helm-bookmark" "\
Preconfigured helm for bookmarks (filtered by category).
Optional source `helm-source-bookmark-addressbook' is loaded
only if external library addressbook-bookmark.el is available.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-buffers" "helm-buffers.el" (22129 42515
;;;;;;  796153 0))
;;; Generated autoloads from helm-buffers.el

(autoload 'helm-buffers-list "helm-buffers" "\
Preconfigured `helm' to list buffers.

\(fn)" t nil)

(autoload 'helm-mini "helm-buffers" "\
Preconfigured `helm' lightweight version (buffer -> recentf).

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-color" "helm-color.el" (22129 42515 814153
;;;;;;  0))
;;; Generated autoloads from helm-color.el

(autoload 'helm-colors "helm-color" "\
Preconfigured `helm' for color.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-command" "helm-command.el" (22129 42515
;;;;;;  834153 0))
;;; Generated autoloads from helm-command.el

(autoload 'helm-M-x "helm-command" "\
Preconfigured `helm' for Emacs commands.
It is `helm' replacement of regular `M-x' `execute-extended-command'.

Unlike regular `M-x' emacs vanilla `execute-extended-command' command,
the prefix args if needed, are passed AFTER starting `helm-M-x'.

You can get help on each command by persistent action.

\(fn ARG &optional COMMAND-NAME)" t nil)

;;;***

;;;### (autoloads nil "helm-config" "helm-config.el" (22129 42515
;;;;;;  848153 0))
;;; Generated autoloads from helm-config.el

(autoload 'helm-configuration "helm-config" "\
Customize `helm'.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-dabbrev" "helm-dabbrev.el" (22129 42515
;;;;;;  871153 0))
;;; Generated autoloads from helm-dabbrev.el

(autoload 'helm-dabbrev "helm-dabbrev" "\
Preconfigured helm for dynamic abbreviations.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-elisp" "helm-elisp.el" (22129 42515 921153
;;;;;;  0))
;;; Generated autoloads from helm-elisp.el

(autoload 'helm-lisp-completion-at-point "helm-elisp" "\
Preconfigured helm for lisp symbol completion at point.

\(fn)" t nil)

(autoload 'helm-complete-file-name-at-point "helm-elisp" "\
Preconfigured helm to complete file name at point.

\(fn &optional FORCE)" t nil)

(autoload 'helm-lisp-indent "helm-elisp" "\


\(fn)" t nil)

(autoload 'helm-lisp-completion-or-file-name-at-point "helm-elisp" "\
Preconfigured helm to complete lisp symbol or filename at point.
Filename completion happen if string start after or between a double quote.

\(fn)" t nil)

(autoload 'helm-apropos "helm-elisp" "\
Preconfigured helm to describe commands, functions, variables and faces.

\(fn)" t nil)

(autoload 'helm-manage-advice "helm-elisp" "\
Preconfigured `helm' to disable/enable function advices.

\(fn)" t nil)

(autoload 'helm-locate-library "helm-elisp" "\
Preconfigured helm to locate elisp libraries.

\(fn)" t nil)

(autoload 'helm-timers "helm-elisp" "\
Preconfigured `helm' for timers.

\(fn)" t nil)

(autoload 'helm-complex-command-history "helm-elisp" "\
Preconfigured helm for complex command history.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-elisp-package" "helm-elisp-package.el"
;;;;;;  (22129 42515 897153 0))
;;; Generated autoloads from helm-elisp-package.el

(autoload 'helm-list-elisp-packages "helm-elisp-package" "\
Preconfigured helm for listing and handling emacs packages.

\(fn ARG)" t nil)

(autoload 'helm-list-elisp-packages-no-fetch "helm-elisp-package" "\
Preconfigured helm for emacs packages.
Same as `helm-list-elisp-packages' but don't fetch packages on remote.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-elscreen" "helm-elscreen.el" (22129 42515
;;;;;;  933153 0))
;;; Generated autoloads from helm-elscreen.el

(autoload 'helm-elscreen "helm-elscreen" "\
Preconfigured helm to list elscreen.

\(fn)" t nil)

(autoload 'helm-elscreen-history "helm-elscreen" "\
Preconfigured helm to list elscreen in history order.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-eshell" "helm-eshell.el" (22129 42515
;;;;;;  949153 0))
;;; Generated autoloads from helm-eshell.el

(autoload 'helm-esh-pcomplete "helm-eshell" "\
Preconfigured helm to provide helm completion in eshell.

\(fn)" t nil)

(autoload 'helm-eshell-history "helm-eshell" "\
Preconfigured helm for eshell history.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-eval" "helm-eval.el" (22129 42515 962153
;;;;;;  0))
;;; Generated autoloads from helm-eval.el

(autoload 'helm-eval-expression "helm-eval" "\
Preconfigured helm for `helm-source-evaluation-result'.

\(fn ARG)" t nil)

(autoload 'helm-eval-expression-with-eldoc "helm-eval" "\
Preconfigured helm for `helm-source-evaluation-result' with `eldoc' support. 

\(fn)" t nil)

(autoload 'helm-calcul-expression "helm-eval" "\
Preconfigured helm for `helm-source-calculation-result'.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-external" "helm-external.el" (22129 42515
;;;;;;  978153 0))
;;; Generated autoloads from helm-external.el

(autoload 'helm-run-external-command "helm-external" "\
Preconfigured `helm' to run External PROGRAM asyncronously from Emacs.
If program is already running exit with error.
You can set your own list of commands with
`helm-external-commands-list'.

\(fn PROGRAM)" t nil)

;;;***

;;;### (autoloads nil "helm-files" "helm-files.el" (22129 42516 35153
;;;;;;  0))
;;; Generated autoloads from helm-files.el

(autoload 'helm-browse-project "helm-files" "\
Preconfigured helm to browse projects.
Browse files and see status of project with its vcs.
Only HG and GIT are supported for now.
Fall back to `helm-browse-project-find-files'
if current directory is not under control of one of those vcs.
With a prefix ARG browse files recursively, with two prefix ARG
rebuild the cache.
If the current directory is found in the cache, start
`helm-browse-project-find-files' even with no prefix ARG.
NOTE: The prefix ARG have no effect on the VCS controlled directories.

Needed dependencies for VCS:
<https://github.com/emacs-helm/helm-ls-git>
and
<https://github.com/emacs-helm/helm-ls-hg>
and
<http://melpa.org/#/helm-ls-svn>.

\(fn ARG)" t nil)

(autoload 'helm-find "helm-files" "\
Preconfigured `helm' for the find shell command.

\(fn ARG)" t nil)

(autoload 'helm-find-files "helm-files" "\
Preconfigured `helm' for helm implementation of `find-file'.
Called with a prefix arg show history if some.
Don't call it from programs, use `helm-find-files-1' instead.
This is the starting point for nearly all actions you can do on files.

\(fn ARG)" t nil)

(autoload 'helm-for-files "helm-files" "\
Preconfigured `helm' for opening files.
Run all sources defined in `helm-for-files-preferred-list'.

\(fn)" t nil)

(autoload 'helm-multi-files "helm-files" "\
Preconfigured helm similar to `helm-for-files' but that don't run locate.
Allow toggling from locate to others sources.
This allow seeing first if what you search is in other sources before launching
locate.

\(fn)" t nil)

(autoload 'helm-recentf "helm-files" "\
Preconfigured `helm' for `recentf'.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-font" "helm-font.el" (22129 42516 51153
;;;;;;  0))
;;; Generated autoloads from helm-font.el

(autoload 'helm-select-xfont "helm-font" "\
Preconfigured `helm' to select Xfont.

\(fn)" t nil)

(autoload 'helm-ucs "helm-font" "\
Preconfigured helm for `ucs-names' math symbols.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-grep" "helm-grep.el" (22129 42516 81153
;;;;;;  0))
;;; Generated autoloads from helm-grep.el

(autoload 'helm-goto-precedent-file "helm-grep" "\
Go to precedent file in helm grep/etags buffers.

\(fn)" t nil)

(autoload 'helm-goto-next-file "helm-grep" "\
Go to precedent file in helm grep/etags buffers.

\(fn)" t nil)

(autoload 'helm-grep-mode "helm-grep" "\
Major mode to provide actions in helm grep saved buffer.

Special commands:
\\{helm-grep-mode-map}

\(fn)" t nil)

(autoload 'helm-do-grep-ag "helm-grep" "\
Preconfigured helm for grepping with AG in `default-directory'.

\(fn)" t nil)

(autoload 'helm-grep-do-git-grep "helm-grep" "\
Preconfigured helm for git-grepping `default-directory'.
With a prefix arg ARG git-grep the whole repository.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "helm-help" "helm-help.el" (22129 42516 118153
;;;;;;  0))
;;; Generated autoloads from helm-help.el

(autoload 'helm-documentation "helm-help" "\
Preconfigured helm for helm documentation.
With a prefix arg refresh the documentation.

Find here the documentation of all sources actually documented.

\(fn ARG)" t nil)

(defvar helm-comp-read-mode-line "\\<helm-comp-read-map>C/\\[helm-cr-empty-string]:Empty \\<helm-map>\\[helm-help]:Help \\[helm-select-action]:Act \\[helm-maybe-exit-minibuffer]/f1/f2/f-n:NthAct \\[helm-toggle-suspend-update]:Tog.suspend")

(defvar helm-read-file-name-mode-line-string "\\<helm-read-file-map>\\[helm-help]:Help C/\\[helm-cr-empty-string]:Empty \\<helm-map>\\[helm-select-action]:Act \\[helm-maybe-exit-minibuffer]/f1/f2/f-n:NthAct \\[helm-toggle-suspend-update]:Tog.suspend" "\
String displayed in mode-line in `helm-source-find-files'.")

(defvar helm-top-mode-line "\\<helm-top-map>\\[helm-help]:Help \\<helm-map>\\[helm-select-action]:Act \\[helm-maybe-exit-minibuffer]/f1/f2/f-n:NthAct \\[helm-toggle-suspend-update]:Tog.suspend")

(autoload 'helm-describe-helm-attribute "helm-help" "\
Display the full documentation of HELM-ATTRIBUTE.
HELM-ATTRIBUTE should be a symbol.

\(fn HELM-ATTRIBUTE)" t nil)

;;;***

;;;### (autoloads nil "helm-id-utils" "helm-id-utils.el" (22129 42516
;;;;;;  130153 0))
;;; Generated autoloads from helm-id-utils.el

(autoload 'helm-gid "helm-id-utils" "\
Preconfigured helm for `gid' command line of `ID-Utils'.
Need A database created with the command `mkid'
above `default-directory'.
Need id-utils as dependency which provide `mkid', `gid' etc...
See <https://www.gnu.org/software/idutils/>.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-imenu" "helm-imenu.el" (22129 42516 150153
;;;;;;  0))
;;; Generated autoloads from helm-imenu.el

(autoload 'helm-imenu "helm-imenu" "\
Preconfigured `helm' for `imenu'.

\(fn)" t nil)

(autoload 'helm-imenu-in-all-buffers "helm-imenu" "\
Preconfigured helm for fetching imenu entries of all buffers.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-info" "helm-info.el" (22129 42516 163153
;;;;;;  0))
;;; Generated autoloads from helm-info.el

(autoload 'helm-info-at-point "helm-info" "\
Preconfigured `helm' for searching info at point.
With a prefix-arg insert symbol at point.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-locate" "helm-locate.el" (22129 42516
;;;;;;  200153 0))
;;; Generated autoloads from helm-locate.el

(autoload 'helm-projects-find-files "helm-locate" "\
Find files with locate in `helm-locate-project-list'.
With a prefix arg refresh the database in each project.

\(fn UPDATE)" t nil)

(autoload 'helm-locate-read-file-name "helm-locate" "\


\(fn PROMPT)" nil nil)

(autoload 'helm-locate "helm-locate" "\
Preconfigured `helm' for Locate.
Note: you can add locate options after entering pattern.
See 'man locate' for valid options and also `helm-locate-command'.

You can specify a local database with prefix argument ARG.
With two prefix arg, refresh the current local db or create it
if it doesn't exists.

To create a user specific db, use
\"updatedb -l 0 -o db_path -U directory\".
Where db_path is a filename matched by
`helm-locate-db-file-regexp'.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "helm-man" "helm-man.el" (22129 42516 212153
;;;;;;  0))
;;; Generated autoloads from helm-man.el

(autoload 'helm-man-woman "helm-man" "\
Preconfigured `helm' for Man and Woman pages.
With a prefix arg reinitialize the cache.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "helm-misc" "helm-misc.el" (22129 42516 236153
;;;;;;  0))
;;; Generated autoloads from helm-misc.el

(autoload 'helm-browse-menubar "helm-misc" "\
Preconfigured helm to the menubar using lacarte.el.

\(fn)" t nil)

(autoload 'helm-world-time "helm-misc" "\
Preconfigured `helm' to show world time.
Default action change TZ environment variable locally to emacs.

\(fn)" t nil)

(autoload 'helm-insert-latex-math "helm-misc" "\
Preconfigured helm for latex math symbols completion.

\(fn)" t nil)

(autoload 'helm-ratpoison-commands "helm-misc" "\
Preconfigured `helm' to execute ratpoison commands.

\(fn)" t nil)

(autoload 'helm-stumpwm-commands "helm-misc" "\
Preconfigured helm for stumpwm commands.

\(fn)" t nil)

(autoload 'helm-minibuffer-history "helm-misc" "\
Preconfigured `helm' for `minibuffer-history'.

\(fn)" t nil)

(autoload 'helm-comint-input-ring "helm-misc" "\
Preconfigured `helm' that provide completion of `comint' history.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-mode" "helm-mode.el" (22129 42516 268153
;;;;;;  0))
;;; Generated autoloads from helm-mode.el

(autoload 'helm-comp-read "helm-mode" "\
Read a string in the minibuffer, with helm completion.

It is helm `completing-read' equivalent.

- PROMPT is the prompt name to use.

- COLLECTION can be a list, vector, obarray or hash-table.
  It can be also a function that receives three arguments:
  the values string, predicate and t. See `all-completions' for more details.

Keys description:

- TEST: A predicate called with one arg i.e candidate.

- INITIAL-INPUT: Same as input arg in `helm'.

- PRESELECT: See preselect arg of `helm'.

- DEFAULT: This option is used only for compatibility with regular
  Emacs `completing-read' (Same as DEFAULT arg of `completing-read').

- BUFFER: Name of helm-buffer.

- MUST-MATCH: Candidate selected must be one of COLLECTION.

- FUZZY: Enable fuzzy matching.

- REVERSE-HISTORY: When non--nil display history source after current
  source completion.

- REQUIRES-PATTERN: Same as helm attribute, default is 0.

- HISTORY: A list containing specific history, default is nil.
  When it is non--nil, all elements of HISTORY are displayed in
  a special source before COLLECTION.

- INPUT-HISTORY: A symbol. the minibuffer input history will be
  stored there, if nil or not provided, `minibuffer-history'
  will be used instead.

- CASE-FOLD: Same as `helm-case-fold-search'.

- DEL-INPUT: Boolean, when non--nil (default) remove the partial
  minibuffer input from HISTORY is present.

- PERSISTENT-ACTION: A function called with one arg i.e candidate.

- PERSISTENT-HELP: A string to document PERSISTENT-ACTION.

- MODE-LINE: A string or list to display in mode line.
  Default is `helm-comp-read-mode-line'.

- KEYMAP: A keymap to use in this `helm-comp-read'.
  (the keymap will be shared with history source)

- NAME: The name related to this local source.

- EXEC-WHEN-ONLY-ONE: Bound `helm-execute-action-at-once-if-one'
  to non--nil. (possibles values are t or nil).

- VOLATILE: Use volatile attribute (enabled by default).

- SORT: A predicate to give to `sort' e.g `string-lessp'
  Use this only on small data as it is ineficient.
  If you want to sort faster add a sort function to
  FC-TRANSFORMER.
  Note that FUZZY when enabled is already providing a sort function.

- FC-TRANSFORMER: A `filtered-candidate-transformer' function
  or a list of functions.

- HIST-FC-TRANSFORMER: A `filtered-candidate-transformer'
  function for the history source.

- MARKED-CANDIDATES: If non--nil return candidate or marked candidates as a list.

- NOMARK: When non--nil don't allow marking candidates.

- ALISTP: (default is non--nil) See `helm-comp-read-get-candidates'.

- CANDIDATES-IN-BUFFER: when non--nil use a source build with
  `helm-source-in-buffer' which is much faster.
  Argument VOLATILE have no effect when CANDIDATES-IN-BUFFER is non--nil.

Any prefix args passed during `helm-comp-read' invocation will be recorded
in `helm-current-prefix-arg', otherwise if prefix args were given before
`helm-comp-read' invocation, the value of `current-prefix-arg' will be used.
That's mean you can pass prefix args before or after calling a command
that use `helm-comp-read' See `helm-M-x' for example.

\(fn PROMPT COLLECTION &key TEST INITIAL-INPUT DEFAULT PRESELECT (buffer \"*Helm Completions*\") MUST-MATCH FUZZY REVERSE-HISTORY (requires-pattern 0) HISTORY INPUT-HISTORY (case-fold helm-comp-read-case-fold-search) (del-input t) (persistent-action nil) (persistent-help \"DoNothing\") (mode-line helm-comp-read-mode-line) HELP-MESSAGE (keymap helm-comp-read-map) (name \"Helm Completions\") CANDIDATES-IN-BUFFER EXEC-WHEN-ONLY-ONE QUIT-WHEN-NO-CAND (volatile t) SORT (fc-transformer (quote helm-cr-default-transformer)) HIST-FC-TRANSFORMER MARKED-CANDIDATES NOMARK (alistp t) (candidate-number-limit helm-candidate-number-limit))" nil nil)

(autoload 'helm-read-file-name "helm-mode" "\
Read a file name with helm completion.
It is helm `read-file-name' emulation.

Argument PROMPT is the default prompt to use.

Keys description:

- NAME: Source name, default to \"Read File Name\".

- INITIAL-INPUT: Where to start read file name, default to `default-directory'.

- BUFFER: `helm-buffer' name default to \"*Helm Completions*\".

- TEST: A predicate called with one arg 'candidate'.

- CASE-FOLD: Same as `helm-case-fold-search'.

- PRESELECT: helm preselection.

- HISTORY: Display HISTORY in a special source.

- MUST-MATCH: Can be 'confirm, nil, or t.

- MARKED-CANDIDATES: When non--nil return a list of marked candidates.

- NOMARK: When non--nil don't allow marking candidates.

- ALISTP: Don't use `all-completions' in history (take effect only on history).

- PERSISTENT-ACTION: a persistent action function.

- PERSISTENT-HELP: persistent help message.

- MODE-LINE: A mode line message, default is `helm-read-file-name-mode-line-string'.

\(fn PROMPT &key (name \"Read File Name\") (initial-input default-directory) (buffer \"*Helm file completions*\") TEST (case-fold helm-file-name-case-fold-search) PRESELECT HISTORY MUST-MATCH DEFAULT MARKED-CANDIDATES (candidate-number-limit helm-ff-candidate-number-limit) NOMARK (alistp t) (persistent-action (quote helm-find-files-persistent-action)) (persistent-help \"Hit1 Expand Candidate, Hit2 or (C-u) Find file\") (mode-line helm-read-file-name-mode-line-string))" nil nil)

(defvar helm-mode nil "\
Non-nil if Helm mode is enabled.
See the command `helm-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `helm-mode'.")

(custom-autoload 'helm-mode "helm-mode" nil)

(autoload 'helm-mode "helm-mode" "\
Toggle generic helm completion.

All functions in Emacs that use `completing-read'
or `read-file-name' and friends will use helm interface
when this mode is turned on.
However you can modify this behavior for functions of your choice
with `helm-completing-read-handlers-alist'.

Called with a positive arg, turn on unconditionally, with a
negative arg turn off.
You can turn it on with `helm-mode'.

Some crap emacs functions may not be supported,
e.g `ffap-alternate-file' and maybe others
You can add such functions to `helm-completing-read-handlers-alist'
with a nil value.

Note: This mode is incompatible with Emacs23.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "helm-net" "helm-net.el" (22129 42516 300153
;;;;;;  0))
;;; Generated autoloads from helm-net.el

(autoload 'helm-surfraw "helm-net" "\
Preconfigured `helm' to search PATTERN with search ENGINE.

\(fn PATTERN ENGINE)" t nil)

(autoload 'helm-google-suggest "helm-net" "\
Preconfigured `helm' for google search with google suggest.

\(fn)" t nil)

(autoload 'helm-wikipedia-suggest "helm-net" "\
Preconfigured `helm' for Wikipedia lookup with Wikipedia suggest.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-org" "helm-org.el" (22129 42516 313153
;;;;;;  0))
;;; Generated autoloads from helm-org.el

(autoload 'helm-org-agenda-files-headings "helm-org" "\
Preconfigured helm for org files headings.

\(fn)" t nil)

(autoload 'helm-org-in-buffer-headings "helm-org" "\
Preconfigured helm for org buffer headings.

\(fn)" t nil)

(autoload 'helm-org-parent-headings "helm-org" "\
Preconfigured helm for org headings that are parents of the
current heading.

\(fn)" t nil)

(autoload 'helm-org-capture-templates "helm-org" "\
Preconfigured helm for org templates.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-regexp" "helm-regexp.el" (22129 42516
;;;;;;  356153 0))
;;; Generated autoloads from helm-regexp.el

(autoload 'helm-moccur-mode "helm-regexp" "\
Major mode to provide actions in helm moccur saved buffer.

Special commands:
\\{helm-moccur-mode-map}

\(fn)" t nil)

(autoload 'helm-regexp "helm-regexp" "\
Preconfigured helm to build regexps.
`query-replace-regexp' can be run from there against found regexp.

\(fn)" t nil)

(autoload 'helm-occur "helm-regexp" "\
Preconfigured helm for Occur.

\(fn)" t nil)

(autoload 'helm-occur-from-isearch "helm-regexp" "\
Invoke `helm-occur' from isearch.

\(fn)" t nil)

(autoload 'helm-multi-occur-from-isearch "helm-regexp" "\
Invoke `helm-multi-occur' from isearch.

With a prefix arg, reverse the behavior of
`helm-moccur-always-search-in-current'.
The prefix arg can be set before calling
`helm-multi-occur-from-isearch' or during the buffer selection.

\(fn &optional ARG)" t nil)

;;;***

;;;### (autoloads nil "helm-ring" "helm-ring.el" (22129 42516 377153
;;;;;;  0))
;;; Generated autoloads from helm-ring.el

(defvar helm-push-mark-mode nil "\
Non-nil if Helm-Push-Mark mode is enabled.
See the command `helm-push-mark-mode' for a description of this minor mode.
Setting this variable directly does not take effect;
either customize it (see the info node `Easy Customization')
or call the function `helm-push-mark-mode'.")

(custom-autoload 'helm-push-mark-mode "helm-ring" nil)

(autoload 'helm-push-mark-mode "helm-ring" "\
Provide an improved version of `push-mark'.
Modify the behavior of `push-mark' to update
the `global-mark-ring' after each new visit.

\(fn &optional ARG)" t nil)

(autoload 'helm-mark-ring "helm-ring" "\
Preconfigured `helm' for `helm-source-mark-ring'.

\(fn)" t nil)

(autoload 'helm-global-mark-ring "helm-ring" "\
Preconfigured `helm' for `helm-source-global-mark-ring'.

\(fn)" t nil)

(autoload 'helm-all-mark-rings "helm-ring" "\
Preconfigured `helm' for `helm-source-global-mark-ring' and `helm-source-mark-ring'.

\(fn)" t nil)

(autoload 'helm-register "helm-ring" "\
Preconfigured `helm' for Emacs registers.

\(fn)" t nil)

(autoload 'helm-show-kill-ring "helm-ring" "\
Preconfigured `helm' for `kill-ring'.
It is drop-in replacement of `yank-pop'.

First call open the kill-ring browser, next calls move to next line.

\(fn)" t nil)

(autoload 'helm-execute-kmacro "helm-ring" "\
Preconfigured helm for keyboard macros.
Define your macros with `f3' and `f4'.
See (info \"(emacs) Keyboard Macros\") for detailed infos.
This command is useful when used with persistent action.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-semantic" "helm-semantic.el" (22129 42516
;;;;;;  393153 0))
;;; Generated autoloads from helm-semantic.el

(autoload 'helm-semantic "helm-semantic" "\
Preconfigured `helm' for `semantic'.
If ARG is supplied, pre-select symbol at point instead of current

\(fn ARG)" t nil)

(autoload 'helm-semantic-or-imenu "helm-semantic" "\
Preconfigured helm for `semantic' or `imenu'.
If ARG is supplied, pre-select symbol at point instead of current
semantic tag in scope.

If `semantic-mode' is active in the current buffer, then use
semantic for generating tags, otherwise fall back to `imenu'.
Fill in the symbol at point by default.

\(fn ARG)" t nil)

;;;***

;;;### (autoloads nil "helm-sys" "helm-sys.el" (22129 42516 432153
;;;;;;  0))
;;; Generated autoloads from helm-sys.el

(autoload 'helm-top "helm-sys" "\
Preconfigured `helm' for top command.

\(fn)" t nil)

(autoload 'helm-list-emacs-process "helm-sys" "\
Preconfigured `helm' for emacs process.

\(fn)" t nil)

(autoload 'helm-xrandr-set "helm-sys" "\
Preconfigured helm for xrandr.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "helm-tags" "helm-tags.el" (22129 42516 449153
;;;;;;  0))
;;; Generated autoloads from helm-tags.el

(autoload 'helm-etags-select "helm-tags" "\
Preconfigured helm for etags.
If called with a prefix argument REINIT
or if any of the tag files have been modified, reinitialize cache.

This function aggregates three sources of tag files:

  1) An automatically located file in the parent directories,
     by `helm-etags-get-tag-file'.
  2) `tags-file-name', which is commonly set by `find-tag' command.
  3) `tags-table-list' which is commonly set by `visit-tags-table' command.

\(fn REINIT)" t nil)

;;;***

;;;### (autoloads nil "helm-utils" "helm-utils.el" (22129 42516 509153
;;;;;;  0))
;;; Generated autoloads from helm-utils.el

(autoload 'helm-show-all-in-this-source-only "helm-utils" "\
Show only current source of this helm session with all its candidates.
With a numeric prefix arg show only the ARG number of candidates.

\(fn ARG)" t nil)

(autoload 'helm-display-all-sources "helm-utils" "\
Display all sources previously hidden by `helm-set-source-filter'.

\(fn)" t nil)

(autoload 'helm-quit-and-find-file "helm-utils" "\
Drop into `helm-find-files' from `helm'.
If current selection is a buffer or a file, `helm-find-files'
from its directory.

\(fn)" t nil)

;;;***

;;;### (autoloads nil "session" "session.el" (22067 58881 795003
;;;;;;  800000))
;;; Generated autoloads from session.el

(defunx session-initialize (&rest dummies) "Initialize package session and read previous session file.\nSetup hooks and load `session-save-file', see `session-initialize'.  At\nbest, this function is called at the end of the Emacs startup, i.e., add\nthis function to `after-init-hook'." (interactive) (setq session-use-package t) (when (or (eq session-initialize t) (memq 'de-saveplace session-initialize)) (when (functionp 'eval-after-load) (eval-after-load "saveplace" '(progn (remove-hook 'find-file-hooks 'save-place-find-file-hook) (remove-hook 'kill-emacs-hook 'save-place-kill-emacs-hook) (remove-hook 'kill-buffer-hook 'save-place-to-alist))))) (when (or (eq session-initialize t) (memq 'places session-initialize)) (add-hook 'find-file-hooks 'session-find-file-hook t) (add-hook 'find-file-not-found-hooks 'session-find-file-not-found-hook t) (add-hook 'kill-buffer-hook 'session-kill-buffer-hook)) (when (or (eq session-initialize t) (memq 'keys session-initialize)) (condition-case nil (progn (define-key ctl-x-map [(undo)] 'session-jump-to-last-change) (define-key ctl-x-map [(control 47)] 'session-jump-to-last-change) (define-key minibuffer-local-map [(meta 63)] 'session-minibuffer-history-help) :XEMACS (define-key global-map [(control button3)] 'session-popup-yank-menu) :EMACS (define-key minibuffer-local-completion-map [(meta 63)] 'session-minibuffer-history-help) (define-key minibuffer-local-must-match-map [(meta 63)] 'session-minibuffer-history-help) (define-key minibuffer-local-ns-map [(meta 63)] 'session-minibuffer-history-help)) (error nil))) (when (or (eq session-initialize t) (memq 'menus session-initialize)) (add-hook 'find-file-hooks 'session-set-file-name-history) (session-add-submenu '("Open...recently visited" :included file-name-history :filter session-file-opened-menu-filter)) (session-add-submenu '("Open...recently changed" :included session-file-alist :filter session-file-changed-menu-filter ["%_* Toggle Permanent Flag of Current Buffer" session-toggle-permanent-flag :keys (session-toggle-permanent-flag nil t) :active buffer-file-name] "---")) :XEMACS (and (featurep 'menubar) (find-menu-item default-menubar '("Edit")) (let ((current-menubar default-menubar)) (add-submenu '("Edit") '("Select and Paste" :included kill-ring :filter session-yank-menu-filter) (cond ((find-menu-item default-menubar '("Edit" "Delete")) "Delete") ((find-menu-item default-menubar '("Edit" "Paste")) "Paste") ((find-menu-item default-menubar '("Edit" "Undo")) "Undo")))))) (when (or (eq session-initialize t) (memq 'session session-initialize)) (add-hook 'kill-emacs-hook 'session-save-session) (or session-successful-p (setq session-successful-p (and session-save-file (condition-case nil (progn (load session-save-file t nil t) (run-hooks 'session-after-load-save-file-hook) t) (error nil)))))))

;;;***

;;;### (autoloads nil nil ("async-pkg.el" "async-test.el" "helm-core-pkg.el"
;;;;;;  "helm-easymenu.el" "helm-lib.el" "helm-multi-match.el" "helm-pkg.el"
;;;;;;  "helm-plugin.el" "helm-source.el" "helm-types.el" "smtpmail-async.el"
;;;;;;  "subdirs.el") (22129 42936 399153 0))

;;;***

(provide 'helm-autoloads)
;; Local Variables:
;; version-control: never
;; no-byte-compile: t
;; no-update-autoloads: t
;; coding: utf-8
;; End:
;;; helm-autoloads.el ends here
