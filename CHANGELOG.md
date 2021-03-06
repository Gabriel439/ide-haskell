## 1.3.9
* Add ide-haskell class to atom-workspace
* Grammar
* Update TODO

## 1.3.8
* Fix getEventType for Atom 1.3.x
* update contributors

## 1.3.7
* Might be no controller on close-tooplip

## 1.3.6
* Fix tooltip fail reporting

## 1.3.5
* Cleanup & Fix deprecation warnings

## 1.3.4
* Disable progress bar animation while invisible

## 1.3.3
* Even more robust tooltip hiding (amend 1.3.2)

## 1.3.2
* More robust tooltip hiding

## 1.3.1
* Drop linter styles

## 1.3.0
* Panel resizing for different positions
* Use simpler view API
* Initial support for setting output panel position

## 1.2.0
* Show cursor position on cursor move (#120)

## 1.1.0
* Handle controller-specific event disposal in controller dtor
* EditorController.onDidStopChanging

## 1.0.0
* UPI interface

## 0.8.0
* Build backend support
* Output panel revamped
* Add 'show info fallback to type' command/mouseover option
* Support for arbitrary message types
* Config cleaned up
* General code cleanup
* Proper disposal in views, using SubAtom for event listeners
* Filter based on current file
* State save
* Moved command registration to backend consumption
* Moved menu initialization to after backend consumption
* Renamed 'Linter' menu option to 'Lint'
* Activation logic revamped
* Removed autocomplete-haskell startup message

## 0.7.2
* Run `stylish-haskell` and `cabal format` in file directory to allow for more fine-grained control with `.stylish-haskell.yaml`

## 0.7.1
* Fix auto-switch to tab

## 0.7.0
* Go-to-next/prev error

## 0.6.2
* Pass-through `escape` keybinding for close-tooltip if there are no tooltips

## 0.6.1
* Make ide-backend commands optional (i.e. check if those exist before calling)

## 0.6.0
* Optional support for AtomLinter for showing project messages, support for haskell-ghc-mod 0.8.0

## 0.5.14
* Initial support for literate Haskell

## 0.5.13
* Fixes for Atom 0.209 API change w.r.t. mouse position
* Better error tooltips

## 0.5.12
* Fix #73

## 0.5.11
* Fix #67 (trying to get row length beyond last row)
* Initial implementation of insert-import

## 0.5.10
* Don't try to restore cursor positions on prettify if no cursor

## 0.5.9
* Run check and lint in onDidSave
* Limit max panel height to 50% viewport

## 0.5.8
* Fix an error when editor is closed while waiting
    for an operation to complete.

## 0.5.7
* Run context menu commands on last mouse position
* Version bump to haskell-ide-backend
* Version bump to backend-helper
* Deactivation cleanup
* Insert import stubs
* CSS hack to catch mouse events only on .scroll-view (specialized to atom-text-editor[data-grammar~="haskell"])
* Don't queue more than one type/info request (#63)
* Check if mouse is still in expression range before showing tooltip (#63)
* Cabal format (#24)

## 0.5.6
* Tooltip behavior updates (#62):
    - Don't hide tooltip unless new is
      ready, or none is expected
    - Show tooltip at the start of expression,
      and not at mouse position (only when invoked
      by mouse)
    - Set pointer-events:none on atom-overlay
    - Disable fade-in to reduce flicker

## 0.5.5
* Show warning state in outputView on fail to get info/type
* Bump to haskell-ide-backend-0.1.1

## 0.5.4
* Preserve cursor position on prettify (#58)

## 0.5.3
* Make closeTooltipsOnCursorMove matter
* More accurate fix for error on close (#56)

## 0.5.2
* Fix error on file close (#56)

## 0.5.1
* Fix error when hovering mouse over selection

## 0.5.0
* Specify Atom version according to docs
* Migration to haskell-ide-backend service
* Autocompletion delegated to autocomplete-haskell
* Stop backend menu option
* Hotkeys configurable from settings window
* Most commands are bound to haskell grammar editors
* Option to prettify file on save (some problems exist)
* Command to insert type
* Now works on standalone Haskell files!

## 0.4.2
* Allowing text selection in bottom pane (Daniel Beskin)
* Fixing a missing resize cursor on Windows (Daniel Beskin)

## 0.4.1
* Somewhat better error-reporting on ghc-mod errors
* Options descriptions

## 0.4.0
* Fixed main file deprecations
* Fixed #50

## 0.3.6
* Fixed #48

## 0.3.5
* Fixed ghc-mod newline compatibility on Windows (Luka Horvat)

## 0.3.4
* Fixed #44

## 0.3.3
* Fixed #26, #37, #40
* Added a hack, which should hopefully fix #29

## 0.3.2
* Fixed #16
* Fixed #25

## 0.3.1
* Fixed: Upgrade to atom 1.0 api.  Upgrade autocomplete (John Quigley)
* Fixed: Fix issue requiring package to be manually deactivated/reactivated (John Quigley)

## 0.3.0
* New: Code prettify by `stylish-haskell`.

## 0.2.0
* New: Autocompletion feature added (issue #4).
* Fixed: Types and errors tooltips were not showed if `Soft Wrap` was turned on.

## 0.1.2
* Fixed: #3, #8, #9, #10, #11, #13.
* Fixed: After multiple package enable-disable actions multiple `ghc-mod` utilities started in concurrent with the same task.

## 0.1.1
* Fixed: Package disable and uninstall works now.

## 0.1.0
* First release.
