; =============================================================================
; nanoAxel (2019-10-16)
; =============================================================================

; =============================================================================
; application
; =============================================================================

(define (nanoAxel_initialize)
  (setq nanoAxel_CursorChar       '\|)
  (setq nanoAxel_FormOf           nil)
  (setq nanoAxel_EntryLabelsCount 10 )
  (setq nanoAxel_isActivated      nil)
) ; nanoAxel_initialize

; -----------------------------------------------------------------------------

(define (nanoAxel_finalize)
  (nanoAxel_deactivate)

  (setq nanoAxel_CursorChar       'unbound)
  (setq nanoAxel_FormOf           'unbound)
  (setq nanoAxel_EntryLabelsCount 'unbound)
  (setq nanoAxel_isActivated      'unbound)
) ; define finalize_nanoAxel

; -----------------------------------------------------------------------------

(define (nanoAxel_Recover)
  (unless nanoAxel_sessionWindow
    (setq nanoAxel_sessionWindow (hiGetSessionWindow (hiGetCurrentWindow)))
  ) ; unless
  (hiSetBindKeys nanoAxel_appName nanoAxel_keyBindingsAtActivated)
) ; define nanoAxel_Recover

; =============================================================================
; utililty functions
; =============================================================================

(define (nanoAxel_GetAppName window)
  (getq (deGetAppInfo (dbGetq (geGetEditCellView window) cellViewType)) appName)
) ; define nanoAxel_GetAppName

; =============================================================================
; activity state procedures
; =============================================================================

(define (nanoAxel_activate)
  (when nanoAxel_isActivated
    (nanoAxel_deactivate)
  ) ; when
  
  (setq nanoAxel_isActivated t)
  
  (letseq ((window (hiGetCurrentWindow)))
    (setq nanoAxel_sessionWindow (hiGetSessionWindow window))
    (setq nanoAxel_appName (nanoAxel_GetAppName window))
    
    (unless (assq nanoAxel_sessionWindow nanoAxel_FormOf)
      (setq nanoAxel_FormOf
        (cons (list nanoAxel_sessionWindow (nanoAxel_createForm))
          nanoAxel_FormOf
        ) ; cons
      ) ; setq
    ) ; unless
    
    (setq nanoAxel_command nil)
    
    ;; -----------------------------------------------------------------------
    ;; key binding
    ;; -----------------------------------------------------------------------
    
    (setq nanoAxel_keyBindingsAtActivated (hiGetBindKeys nanoAxel_appName))
    
    (foreach keyStroke (mapcar 'car nanoAxel_keyBindingsAtActivated)
      (hiSetBindKey nanoAxel_appName keyStroke)
    ) ; foreach keyStroke

    (hiSetBindKeys nanoAxel_appName
     '(
      ("<Key>Escape"    "(nanoAxel_onKeyTyped_Escape)"   )
      ("<Key>Return"    "(nanoAxel_onKeyTyped_Enter)"    )
      ("<Key>BackSpace" "(nanoAxel_onKeyTyped_BackSpace)")
      ("<Key>Tab"       "(nanoAxel_onKeyTyped_Tab)"      )
      ("Shift<Key>Tab"  "(nanoAxel_onKeyTyped_ShiftTab)" )
      ("<Key>Space"     "(nanoAxel_onKeyTyped_Space)"    )
      
      ("<Key>0" "(nanoAxel_onKeyTyped '\\0)")
      ("<Key>1" "(nanoAxel_onKeyTyped '\\1)")
      ("<Key>2" "(nanoAxel_onKeyTyped '\\2)")
      ("<Key>3" "(nanoAxel_onKeyTyped '\\3)")
      ("<Key>4" "(nanoAxel_onKeyTyped '\\4)")
      ("<Key>5" "(nanoAxel_onKeyTyped '\\5)")
      ("<Key>6" "(nanoAxel_onKeyTyped '\\6)")
      ("<Key>7" "(nanoAxel_onKeyTyped '\\7)")
      ("<Key>8" "(nanoAxel_onKeyTyped '\\8)")
      ("<Key>9" "(nanoAxel_onKeyTyped '\\9)")
      
      ("<Key>KP_0" "(nanoAxel_onKeyTyped '\\0)")
      ("<Key>KP_1" "(nanoAxel_onKeyTyped '\\1)")
      ("<Key>KP_2" "(nanoAxel_onKeyTyped '\\2)")
      ("<Key>KP_3" "(nanoAxel_onKeyTyped '\\3)")
      ("<Key>KP_4" "(nanoAxel_onKeyTyped '\\4)")
      ("<Key>KP_5" "(nanoAxel_onKeyTyped '\\5)")
      ("<Key>KP_6" "(nanoAxel_onKeyTyped '\\6)")
      ("<Key>KP_7" "(nanoAxel_onKeyTyped '\\7)")
      ("<Key>KP_8" "(nanoAxel_onKeyTyped '\\8)")
      ("<Key>KP_9" "(nanoAxel_onKeyTyped '\\9)")
      
      ("<Key>A" "(nanoAxel_onKeyTyped 'a)")
      ("<Key>B" "(nanoAxel_onKeyTyped 'b)")
      ("<Key>C" "(nanoAxel_onKeyTyped 'c)")
      ("<Key>D" "(nanoAxel_onKeyTyped 'd)")
      ("<Key>E" "(nanoAxel_onKeyTyped 'e)")
      ("<Key>F" "(nanoAxel_onKeyTyped 'f)")
      ("<Key>G" "(nanoAxel_onKeyTyped 'g)")
      ("<Key>H" "(nanoAxel_onKeyTyped 'h)")
      ("<Key>I" "(nanoAxel_onKeyTyped 'i)")
      ("<Key>J" "(nanoAxel_onKeyTyped 'j)")
      ("<Key>K" "(nanoAxel_onKeyTyped 'k)")
      ("<Key>L" "(nanoAxel_onKeyTyped 'l)")
      ("<Key>M" "(nanoAxel_onKeyTyped 'm)")
      ("<Key>N" "(nanoAxel_onKeyTyped 'n)")
      ("<Key>O" "(nanoAxel_onKeyTyped 'o)")
      ("<Key>P" "(nanoAxel_onKeyTyped 'p)")
      ("<Key>Q" "(nanoAxel_onKeyTyped 'q)")
      ("<Key>R" "(nanoAxel_onKeyTyped 'r)")
      ("<Key>S" "(nanoAxel_onKeyTyped 's)")
      ("<Key>T" "(nanoAxel_onKeyTyped 't)")
      ("<Key>U" "(nanoAxel_onKeyTyped 'u)")
      ("<Key>V" "(nanoAxel_onKeyTyped 'v)")
      ("<Key>W" "(nanoAxel_onKeyTyped 'w)")
      ("<Key>X" "(nanoAxel_onKeyTyped 'x)")
      ("<Key>Y" "(nanoAxel_onKeyTyped 'y)")
      ("<Key>Z" "(nanoAxel_onKeyTyped 'z)")
      
      ("Shift<Key>A" "(nanoAxel_onKeyTyped 'A)")
      ("Shift<Key>B" "(nanoAxel_onKeyTyped 'B)")
      ("Shift<Key>C" "(nanoAxel_onKeyTyped 'C)")
      ("Shift<Key>D" "(nanoAxel_onKeyTyped 'D)")
      ("Shift<Key>E" "(nanoAxel_onKeyTyped 'E)")
      ("Shift<Key>F" "(nanoAxel_onKeyTyped 'F)")
      ("Shift<Key>G" "(nanoAxel_onKeyTyped 'G)")
      ("Shift<Key>H" "(nanoAxel_onKeyTyped 'H)")
      ("Shift<Key>I" "(nanoAxel_onKeyTyped 'I)")
      ("Shift<Key>J" "(nanoAxel_onKeyTyped 'J)")
      ("Shift<Key>K" "(nanoAxel_onKeyTyped 'K)")
      ("Shift<Key>L" "(nanoAxel_onKeyTyped 'L)")
      ("Shift<Key>M" "(nanoAxel_onKeyTyped 'M)")
      ("Shift<Key>N" "(nanoAxel_onKeyTyped 'N)")
      ("Shift<Key>O" "(nanoAxel_onKeyTyped 'O)")
      ("Shift<Key>P" "(nanoAxel_onKeyTyped 'P)")
      ("Shift<Key>Q" "(nanoAxel_onKeyTyped 'Q)")
      ("Shift<Key>R" "(nanoAxel_onKeyTyped 'R)")
      ("Shift<Key>S" "(nanoAxel_onKeyTyped 'S)")
      ("Shift<Key>T" "(nanoAxel_onKeyTyped 'T)")
      ("Shift<Key>U" "(nanoAxel_onKeyTyped 'U)")
      ("Shift<Key>V" "(nanoAxel_onKeyTyped 'V)")
      ("Shift<Key>W" "(nanoAxel_onKeyTyped 'W)")
      ("Shift<Key>X" "(nanoAxel_onKeyTyped 'X)")
      ("Shift<Key>Y" "(nanoAxel_onKeyTyped 'Y)")
      ("Shift<Key>Z" "(nanoAxel_onKeyTyped 'Z)")
      )
    ) ; hiSetBindKeys
    ;; -----------------------------------------------------------------------
    
    (setq nanoAxel_lppAll
      (mapcar (lambda (lpp) (buildString lpp ""))
        (sort
          (mapcan (lambda (lp) (list (list (dbGetq (dbGetq lp layer) name) (dbGetq lp purpose))))
            (dbGetq (techGetTechFile (geGetEditCellView window)) lps)
          ) ; mapcan
          (lambda (former latter)
            (let ((strcmp_car (strcmp (car former) (car latter))))
              (or (minusp strcmp_car)
                (and (zerop strcmp_car)
                  (minusp (strcmp (cadr former) (cadr latter)))
                ) ; and
              ) ; or
            ) ; let strcmp_car
          ) ; lambda
        ) ; sort
      ) ; mapcar
    ) ; setq nanoAxel_lppAll
    
    (setq nanoAxel_entries       nanoAxel_lppAll)
    (setq nanoAxel_entries_index 0  )
  ) ; letseq
) ; define nanoAxel_activate

; -----------------------------------------------------------------------------

(define (nanoAxel_deactivate)
  (when nanoAxel_isActivated
    (setq nanoAxel_isActivated nil)
    
    (foreach keyStroke (mapcar 'car (hiGetBindKeys nanoAxel_appName))
      (hiSetBindKey nanoAxel_appName keyStroke)
    ) ; foreach keyStroke
    (hiSetBindKeys nanoAxel_appName nanoAxel_keyBindingsAtActivated)
    
    (setq nanoAxel_command nil)
    (nanoAxel_updateCommandLabel)
    (setq nanoAxel_entries nil)
    (setq nanoAxel_entries_index 0)
    (nanoAxel_updateEntryLabels)
    
    (setq nanoAxel_keyBindingsAtActivated 'unbound)
    (setq nanoAxel_sessionWindow  'unbound)
    (setq nanoAxel_appName        'unbound)
    (setq nanoAxel_command        'unbound)
    (setq nanoAxel_entries        'unbound)
    (setq nanoAxel_entries_length 'unbound)
    (setq nanoAxel_entries_index  'unbound)
    (setq nanoAxel_lppAll         'unbound)
  ) ; when
) ; define nanoAxel_deactivate

; =============================================================================
; keyboard event handlers
; =============================================================================

(define (nanoAxel_onKeyTyped__isContinuable)
  (or (eq nanoAxel_sessionWindow (hiGetSessionWindow (hiGetCurrentWindow)))
    (begin
      (nanoAxel_deactivate)
      (hiDisplayAppDBox
        ?name         'nanoAxelDeactivated
        ?dboxBanner   "nanoAxel"
        ?dboxText     "nanoAxel is deactivated because editing window switched."
        ?dialogStyle  'modeless
        ?dialogType   hicErrorDialog
        ?buttonLayout 'Close
      ) ; hiDisplayAppDBox
      nil
    ) ; begin
  ) ; unless
) ; define nanoAxel_onKeyTyped__isContinuable

; -----------------------------------------------------------------------------

(define (nanoAxel_onKeyTyped_Escape)
  (nanoAxel_deactivate)
) ; define nanoAxel_onKeyTyped_Escape

; -----------------------------------------------------------------------------

(define (nanoAxel_onKeyTyped_Enter)
  (when (nanoAxel_onKeyTyped__isContinuable)
    (let ((els_length (min nanoAxel_entries_length nanoAxel_EntryLabelsCount)))
      (when (lessp nanoAxel_entries_index els_length)
        (leSetEntryLayer (parseString (nth nanoAxel_entries_index nanoAxel_entries) " "))
      ) ; when
    ) ; let els_length
    (nanoAxel_deactivate)
  ) ; unless
) ; define nanoAxel_onKeyTyped_Enter

; -----------------------------------------------------------------------------

(define (nanoAxel_onKeyTyped_BackSpace)
  (when (nanoAxel_onKeyTyped__isContinuable)
    (when nanoAxel_command
      (setq nanoAxel_command (cdr nanoAxel_command))
      (nanoAxel_updateCommandLabel)
      
      (setq nanoAxel_entries (setof lpp nanoAxel_lppAll (rexMatchp (buildString (reverse nanoAxel_command) "") lpp)))
      (setq nanoAxel_entries_length (length nanoAxel_entries))
      (setq nanoAxel_entries_index 0)
      (nanoAxel_updateEntryLabels)
    ) ; when
  ) ; unless
) ; define nanoAxel_onKeyTyped_BackSpace

; -----------------------------------------------------------------------------

(define (nanoAxel_onKeyTyped_Tab)
  (when (nanoAxel_onKeyTyped__isContinuable)
    (let ((els_length (min nanoAxel_entries_length nanoAxel_EntryLabelsCount)))
      (setq nanoAxel_entries_index
        (remainder (add1 nanoAxel_entries_index) els_length)
      ) ; setq
    ) ; let els_length
    (nanoAxel_updateEntryLabels)
  ) ; unless
) ; define nanoAxel_onKeyTyped_Tab

; -----------------------------------------------------------------------------

(define (nanoAxel_onKeyTyped_ShiftTab)
  (when (nanoAxel_onKeyTyped__isContinuable)
    (let ((els_length (min nanoAxel_entries_length nanoAxel_EntryLabelsCount)))
      (setq nanoAxel_entries_index
        (remainder (plus (sub1 nanoAxel_entries_index) els_length) els_length)
      ) ; setq
    ) ; let els_length
    (nanoAxel_updateEntryLabels)
  ) ; unless
) ; define nanoAxel_onKeyTyped_Tab

; -----------------------------------------------------------------------------

(define (nanoAxel_onKeyTyped_Space)
  (when (nanoAxel_onKeyTyped__isContinuable)
    (when (and nanoAxel_command (nequal (car nanoAxel_command) '\ ))
      (setq nanoAxel_command (cons '\  nanoAxel_command))
      (nanoAxel_updateCommandLabel)
      
      (setq nanoAxel_entries (setof lpp nanoAxel_lppAll (rexMatchp (buildString (reverse nanoAxel_command) "") lpp)))
      (setq nanoAxel_entries_length (length nanoAxel_entries))
      (setq nanoAxel_entries_index 0)
      (nanoAxel_updateEntryLabels)
    ) ; when
  ) ; unless
) ; define nanoAxel_select

; -----------------------------------------------------------------------------

(define (nanoAxel_onKeyTyped char)
  (when (nanoAxel_onKeyTyped__isContinuable)
    (setq nanoAxel_command (cons char nanoAxel_command))
    (nanoAxel_updateCommandLabel)
    
    (setq nanoAxel_entries (setof lpp nanoAxel_lppAll (rexMatchp (buildString (reverse nanoAxel_command) "") lpp)))
    (setq nanoAxel_entries_length (length nanoAxel_entries))
    (setq nanoAxel_entries_index 0)
    (nanoAxel_updateEntryLabels)
  ) ; unless
) ; define nanoAxel_select

; =============================================================================
; GUI procedures
; =============================================================================

(define (nanoAxel_createForm)
  (letseq
    (
    (uniqTag (sprintf nil "_%d_%d" (length nanoAxel_FormOf) (stringToTime (getCurrentTime))))
    
    (nanoAxelForm
      (hiCreateAppForm
        ?name (stringToSymbol (strcat "nanoAxelForm" uniqTag))
        ?fields
          (cons
            (hiCreateLabel ?name 'commandLabel ?labelText " ")
            (let ((els nil) (eli nanoAxel_EntryLabelsCount))
              (while (plusp eli)
                (setq els (cons (hiCreateLabel ?labelText " " ?name (stringToSymbol (sprintf nil "entryLabel_%d" (predecrement eli)))) els))
              ) ; while
              els
            ) ; let els, eli
          ) ; cons
      ) ; hiCreateAppForm
    ) ; nanoAxel
    
    (nanoAxelDockWindow
      (hiCreateDockWindow
        ?appType    "layout"
        ?widgetType "form"
        ?handle     (stringToSymbol (strcat "nanoAxelDockWindow" uniqTag))
        ?form       nanoAxelForm
        ?scrollBar  t
        ?title      "nanoAxel"
      ) ; hiCreateDockWindow
    ) ; nanoAxelDockWindow
    
    (sessionWindow (hiGetSessionWindow (hiGetCurrentWindow)))
    )
    
    (hiDockWindow ?window nanoAxelDockWindow ?session sessionWindow ?side 'bottom)
    (setq nanoAxel_FormOf (cons (list sessionWindow nanoAxelForm) nanoAxel_FormOf))
    nanoAxelForm
  ) ; letseq
) ; define nanoAxel_createForm

; -----------------------------------------------------------------------------

(define (nanoAxel_updateCommandLabel)
  (let ((nanoAxelForm (assq nanoAxel_sessionWindow nanoAxel_FormOf)))
    (putpropq (getq nanoAxelForm commandLabel)
      (buildString (reverse (cons nanoAxel_CursorChar nanoAxel_command)) " "")
      value
    ) ; putpropq
  ) ; let nanoAxelForm
) ; define nanoAxel_updateCommandLabel

; -----------------------------------------------------------------------------

(define (nanoAxel_updateEntryLabels)
  (prog ()
    (let
      (
      (nanoAxelForm (cadr (assq nanoAxel_sessionWindow nanoAxel_FormOf)))
      (es nanoAxel_entries)
      (eli 0)
      (el nil)
      )
      (while (and es (lessp eli nanoAxel_EntryLabelsCount))
        (unless (setq el (get nanoAxelForm (sprintf nil "entryLabel_%d" eli)))
          (return nil)
        ) ; unless
        (putpropq el (car es) value)
        (putpropq el (eqv eli nanoAxel_entries_index) enabled)
        (preincrement eli)
        (setq es (cdr es))
      ) ; while
      (while (lessp eli nanoAxel_EntryLabelsCount)
        (unless (setq el (get nanoAxelForm (sprintf nil "entryLabel_%d" eli)))
          (return nil)
        ) ; unless
        (putpropq el "" value)
        (putpropq el nil enabled)
        (preincrement eli)
      ) ; while
    ) ; let
  ) ; prop
) ; define nanoAxel_updateEntryLabels

; =============================================================================

(nanoAxel_initialize)

(hiSetBindKey "Layout" "<Key>:" "(nanoAxel_activate)")
