" input.vim
" @Author:      Tom Link (micathom AT gmail com?subject=[vim])
" @Website:     http://www.vim.org/account/profile.php?user_id=4037
" @License:     GPL (see http://www.gnu.org/licenses/gpl.txt)
" @Created:     2007-06-30.
" @Last Change: 2013-09-25.
" @Revision:    0.0.1112


" :filedoc:
" Input-related, select from a list etc.

" If a list is bigger than this value, don't try to be smart when 
" selecting an item. Be slightly faster instead.
" See |tlib#input#List()|.
TLet g:tlib#input#sortprefs_threshold = 200


" If a list contains more items, |tlib#input#List()| does not perform an 
" incremental "live search" but uses |input()| to query the user for a 
" filter. This is useful on slower machines or with very long lists.
TLet g:tlib#input#livesearch_threshold = 1000


" Determine how |tlib#input#List()| and related functions work.
" Can be "cnf", "cnfd", "cnfx", "seq", or "fuzzy". See:
"   cnfx ... Like cnfd but |g:tlib#Filter_cnfx#expander| is interpreted 
"            as a wildcard (this is the default method)
"     - A plus character ("+") acts as a wildcard as if ".\{-}" (see 
"       |/\{-|) were entered.
"     - Examples:
"         - "f+o" matches "fo", "fxo", and "fxxxoo", but doesn't match 
"           "far".
"     - Otherwise it is a derivate of the cnf method (see below).
"     - See also |tlib#Filter_cnfx#New()|.
"   cnfd ... Like cnf but "." is interpreted as a wildcard, i.e. it is 
"            expanded to "\.\{-}"
"     - A period character (".") acts as a wildcard as if ".\{-}" (see 
"       |/\{-|) were entered.
"     - Examples:
"         - "f.o" matches "fo", "fxo", and "fxxxoo", but doesn't match 
"           "far".
"     - Otherwise it is a derivate of the cnf method (see below).
"     - See also |tlib#Filter_cnfd#New()|.
"   cnf .... Match substrings
"     - A blank creates an AND conjunction, i.e. the next pattern has to 
"       match too.
"     - A pipe character ("|") creates an OR conjunction, either this or 
"       the next next pattern has to match.
"     - Patterns are very 'nomagic' |regexp| with a |\V| prefix.
"     - A pattern starting with "-" makes the filter exclude items 
"       matching that pattern.
"     - Examples:
"         - "foo bar" matches items that contain the strings "foo" AND 
"           "bar".
"         - "foo|bar boo|far" matches items that contain either ("foo" OR 
"           "bar") AND ("boo" OR "far").
"     - See also |tlib#Filter_cnf#New()|.
"   seq .... Match sequences of characters
"     - |tlib#Filter_seq#New()|
"   fuzzy .. Match fuzzy character sequences
"     - |tlib#Filter_fuzzy#New()|
TLet g:tlib#input#filter_mode = 'cnfx'


" The highlight group to use for showing matches in the input list 
" window.
" See |tlib#input#List()|.
TLet g:tlib#input#higroup = 'IncSearch'

" When 1, automatically select the last remaining item only if the list 
" had only one item to begin with.
" When 2, automatically select a last remaining item after applying 
" any filters.
" See |tlib#input#List()|.
TLet g:tlib_pick_last_item = 1


" :doc:
" Keys for |tlib#input#List|~

TLet g:tlib#input#and = ' '
TLet g:tlib#input#or  = '|'
TLet g:tlib#input#not = '-'

" When editing a list with |tlib#input#List|, typing these numeric chars 
" (as returned by getchar()) will select an item based on its index, not 
" based on its name. I.e. in the default setting, typing a "4" will 
" select the fourth item, not the item called "4".
" In order to make keys 0-9 filter the items in the list and make 
" <m-[0-9]> select an item by its index, remove the keys 48 to 57 from 
" this dictionary.
" Format: [KEY] = BASE ... the number is calculated as KEY - BASE.
" :nodefault:
TLet g:tlib_numeric_chars = {
            \ 176: 176,
            \ 177: 176,
            \ 178: 176,
            \ 179: 176,
            \ 180: 176,
            \ 181: 176,
            \ 182: 176,
            \ 183: 176,
            \ 184: 176,
            \ 185: 176,
            \}
            " \ 48: 48,
            " \ 49: 48,
            " \ 50: 48,
            " \ 51: 48,
            " \ 52: 48,
            " \ 53: 48,
            " \ 54: 48,
            " \ 55: 48,
            " \ 56: 48,
            " \ 57: 48,


" :nodefault:
" The default key bindings for single-item-select list views. If you 
" want to use <c-j>, <c-k> to move the cursor up and down, add these two 
" lines to after/plugin/02tlib.vim: >
"
"   let g:tlib#input#keyagents_InputList_s[10] = 'tlib#agent#Down'  " <c-j>
"   let g:tlib#input#keyagents_InputList_s[11] = 'tlib#agent#Up'    " <c-k>
TLet g:tlib#input#keyagents_InputList_s = {
            \ "\<PageUp>":   'tlib#agent#PageUp',
            \ "\<PageDown>": 'tlib#agent#PageDown',
            \ "\<Up>":       'tlib#agent#Up',
            \ "\<Down>":     'tlib#agent#Down',
            \ "\<c-Up>":     'tlib#agent#UpN',
            \ "\<c-Down>":   'tlib#agent#DownN',
            \ "\<Left>":     'tlib#agent#ShiftLeft',
            \ "\<Right>":    'tlib#agent#ShiftRight',
            \ 18:            'tlib#agent#Reset',
            \ 242:           'tlib#agent#Reset',
            \ 17:            'tlib#agent#Input',
            \ 241:           'tlib#agent#Input',
            \ 27:            'tlib#agent#Exit',
            \ 26:            'tlib#agent#Suspend',
            \ 250:           'tlib#agent#Suspend',
            \ 15:            'tlib#agent#SuspendToParentWindow',  
            \ 63:            'tlib#agent#Help',
            \ "\<F1>":       'tlib#agent#Help',
            \ "\<F10>":      'tlib#agent#ExecAgentByName',
            \ "\<S-Esc>":    'tlib#agent#ExecAgentByName',
            \ "\<bs>":       'tlib#agent#ReduceFilter',
            \ "\<del>":      'tlib#agent#ReduceFilter',
            \ "\<c-bs>":     'tlib#agent#PopFilter',
            \ "\<m-bs>":     'tlib#agent#PopFilter',
            \ "\<c-del>":    'tlib#agent#PopFilter',
            \ "\<m-del>":    'tlib#agent#PopFilter',
            \ "\<s-space>":  'tlib#agent#Wildcard',
            \ 191:           'tlib#agent#Debug',
            \ char2nr(g:tlib#input#or):  'tlib#agent#OR',
            \ char2nr(g:tlib#input#and): 'tlib#agent#AND',
            \ }


" :nodefault:
TLet g:tlib#input#keyagents_InputList_m = {
            \ 35:          'tlib#agent#Select',
            \ "\<s-up>":   'tlib#agent#SelectUp',
            \ "\<s-down>": 'tlib#agent#SelectDown',
            \ 1:           'tlib#agent#SelectAll',
            \ 225:         'tlib#agent#SelectAll',
            \ "\<F9>":     'tlib#agent#ToggleRestrictView',
            \ }
" "\<c-space>": 'tlib#agent#Select'


" :nodefault:
TLet g:tlib#input#handlers_EditList = [
            \ {'key': 5,  'agent': 'tlib#agent#EditItem',    'key_name': '<c-e>', 'help': 'Edit item'},
            \ {'key': 4,  'agent': 'tlib#agent#DeleteItems', 'key_name': '<c-d>', 'help': 'Delete item(s)'},
            \ {'key': 14, 'agent': 'tlib#agent#NewItem',     'key_name': '<c-n>', 'help': 'New item'},
            \ {'key': 24, 'agent': 'tlib#agent#Cut',         'key_name': '<c-x>', 'help': 'Cut item(s)'},
            \ {'key':  3, 'agent': 'tlib#agent#Copy',        'key_name': '<c-c>', 'help': 'Copy item(s)'},
            \ {'key': 22, 'agent': 'tlib#agent#Paste',       'key_name': '<c-v>', 'help': 'Paste item(s)'},
            \ {'pick_last_item': 0},
            \ {'return_agent': 'tlib#agent#EditReturnValue'},
            \ {'help_extra': [
            \      'Submit changes by pressing ENTER or <c-s> or <c-w><cr>',
            \      'Cancel editing by pressing <c-w>c'
            \ ]},
            \ ]


" If true, define a popup menu for |tlib#input#List()| and related 
" functions.
TLet g:tlib#input#use_popup = has('menu') && (has('gui_gtk') || has('gui_gtk2') || has('gui_win32'))


" How to format filenames:
"     l ... Show basenames on the left side, separated from the 
"           directory names
"     r ... Show basenames on the right side
TLet g:tlib#input#format_filename = 'l'


" If g:tlib#input#format_filename == 'r', how much space should be kept 
" free on the right side.
TLet g:tlib#input#filename_padding_r = '&co / 10'


" If g:tlib#input#format_filename == 'l', an expression that 
" |eval()|uates to the maximum display width of filenames.
TLet g:tlib#input#filename_max_width = '&co / 2'


" Functions related to tlib#input#List(type, ...) "{{{2

" :def: function! tlib#input#List(type. ?query='', ?list=[], ?handlers=[], ?default="", ?timeout=0)
" Select a single or multiple items from a list. Return either the list 
" of selected elements or its indexes.
"
" By default, typing numbers will select an item by its index. See 
" |g:tlib_numeric_chars| to find out how to change this.
"
" The item is automatically selected if the numbers typed equals the 
" number of digits of the list length. I.e. if a list contains 20 items, 
" typing 1 will first highlight item 1 but it won't select/use it 
" because 1 is an ambiguous input in this context. If you press enter, 
" the first item will be selected. If you press another digit (e.g. 0), 
" item 10 will be selected. Another way to select item 1 would be to 
" type 01. If the list contains only 9 items, typing 1 would select the 
" first item right away.
"
" type can be:
"     s  ... Return one selected element
"     si ... Return the index of the selected element
"     m  ... Return a list of selected elements
"     mi ... Return a list of indexes
"
" Several pattern matching styles are supported. See 
" |g:tlib#input#filter_mode|.
"
" EXAMPLES: >
"   echo tlib#input#List('s', 'Select one item', [100,200,300])
"   echo tlib#input#List('si', 'Select one item', [100,200,300])
"   echo tlib#input#List('m', 'Select one or more item(s)', [100,200,300])
"   echo tlib#input#List('mi', 'Select one or more item(s)', [100,200,300])
"
" See ../samples/tlib/input/tlib_input_list.vim (move the cursor over 
" the filename and press gf) for a more elaborated example.
function! tlib#input#List(type, ...) "{{{3
    exec tlib#arg#Let([
        \ ['query', ''],
        \ ['list', []],
        \ ['handlers', []],
        \ ['rv', ''],
        \ ['timeout', 0],
        \ ])
    " let handlers = a:0 >= 1 ? a:1 : []
    " let rv       = a:0 >= 2 ? a:2 : ''
    " let timeout  = a:0 >= 3 ? a:3 : 0
    " let backchar = ["\<bs>", "\<del>"]

    if a:type =~ '^resume'
        let world = b:tlib_{matchstr(a:type, ' \zs.\+')}
    else
        let world = tlib#World#New({
                    \ 'type': a:type,
                    \ 'base': list,
                    \ 'query': query,
                    \ 'timeout': timeout,
                    \ 'rv': rv,
                    \ 'handlers': handlers,
                    \ })
        let scratch_name     = tlib#list#Find(handlers, 'has_key(v:val, "scratch_name")', '', 'v:val.scratch_name')
        if !empty(scratch_name)
            let world.scratch = scratch_name
        endif
        let world.scratch_vertical = tlib#list#Find(handlers, 'has_key(v:val, "scratch_vertical")', 0, 'v:val.scratch_vertical')
        call world.Set_display_format(tlib#list#Find(handlers, 'has_key(v:val, "display_format")', '', 'v:val.display_format'))
        let world.initial_index    = tlib#list#Find(handlers, 'has_key(v:val, "initial_index")', 1, 'v:val.initial_index')
        let world.index_table      = tlib#list#Find(handlers, 'has_key(v:val, "index_table")', [], 'v:val.index_table')
        let world.state_handlers   = filter(copy(handlers),   'has_key(v:val, "state")')
        let world.post_handlers    = filter(copy(handlers),   'has_key(v:val, "postprocess")')
        let world.filter_format    = tlib#list#Find(handlers, 'has_key(v:val, "filter_format")', '', 'v:val.filter_format')
        let world.return_agent     = tlib#list#Find(handlers, 'has_key(v:val, "return_agent")', '', 'v:val.return_agent')
        let world.help_extra       = tlib#list#Find(handlers, 'has_key(v:val, "help_extra")', '', 'v:val.help_extra')
        let world.resize           = tlib#list#Find(handlers, 'has_key(v:val, "resize")', '', 'v:val.resize')
        let world.show_empty       = tlib#list#Find(handlers, 'has_key(v:val, "show_empty")', 0, 'v:val.show_empty')
        let world.pick_last_item   = tlib#list#Find(handlers, 'has_key(v:val, "pick_last_item")', 
                    \ tlib#var#Get('tlib_pick_last_item', 'bg'), 'v:val.pick_last_item')
        let world.numeric_chars    = tlib#list#Find(handlers, 'has_key(v:val, "numeric_chars")', 
                    \ tlib#var#Get('tlib_numeric_chars', 'bg'), 'v:val.numeric_chars')
        let world.key_handlers     = filter(copy(handlers), 'has_key(v:val, "key")')
        let filter                 = tlib#list#Find(handlers, 'has_key(v:val, "filter")', '', 'v:val.filter')
        if !empty(filter)
            " let world.initial_filter = [[''], [filter]]
            " let world.initial_filter = [[filter]]
            " TLogVAR world.initial_filter
            call world.SetInitialFilter(filter)
        endif
    endif
    return tlib#input#ListW(world)
endf


" A wrapper for |tlib#input#ListW()| that builds |tlib#World#New| from 
" dict.
function! tlib#input#ListD(dict) "{{{3
    return tlib#input#ListW(tlib#World#New(a:dict))
endf


" :def: function! tlib#input#ListW(world, ?command='')
" The second argument (command) is meant for internal use only.
" The same as |tlib#input#List| but the arguments are packed into world 
" (an instance of tlib#World as returned by |tlib#World#New|).
function! tlib#input#ListW(world, ...) "{{{3
    TVarArg 'cmd'
    " let time0 = str2float(reltimestr(reltime()))  " DBG
    " TLogVAR time0
    let world = a:world
    if world.pick_last_item >= 1 && stridx(world.type, 'e') == -1 && len(world.base) <= 1
        let rv = get(world.base, 0, world.rv)
        if stridx(world.type, 'm') != -1
            return [rv]
        else
            return rv
        endif
    endif
    call s:Init(world, cmd)
    " TLogVAR world.state, world.sticky, world.initial_index
    " let statusline  = &l:statusline
    " let laststatus  = &laststatus
    let lastsearch  = @/
    let scrolloff = &l:scrolloff
    let &l:scrolloff = 0
    let @/ = ''
    let dlist = []
    let post_keys = ''
    " let &laststatus = 2

    try
        while !empty(world.state) && world.state !~ '^exit' && (world.show_empty || !empty(world.base))
            let post_keys = ''
            " TLogDBG 'while'
            " TLogVAR world.state
            " let time01 = str2float(reltimestr(reltime()))  " DBG
            " TLogVAR time01, time01 - time0
            try
                call s:RunStateHandlers(world)

                " let time02 = str2float(reltimestr(reltime()))  " DBG
                " TLogVAR time02, time02 - time0
                if world.state =~ '\<reset\>'
                    " TLogDBG 'reset'
                    " call world.Reset(world.state =~ '\<initial\>')
                    call world.Reset()
                    continue
                endif

                call s:SetOffset(world)

                " let time02 = str2float(reltimestr(reltime()))  " DBG
                " TLogVAR time02, time02 - time0
                " TLogDBG 1
                " TLogVAR world.state
                if world.state == 'scroll'
                    let world.prefidx = world.offset
                    let world.state = 'redisplay'
                endif

                if world.state =~ '\<sticky\>'
                    let world.sticky = 1
                endif

                " TLogVAR world.filter
                " TLogVAR world.sticky
                if world.state =~ '\<pick\>'
                    let world.rv = world.CurrentItem()
                    " TLogVAR world.rv
                    throw 'pick'
                elseif world.state =~ 'display'
                    if world.state =~ '^display'
                        " let time03 = str2float(reltimestr(reltime()))  " DBG
                        " TLogVAR time03, time03 - time0
                        if world.IsValidFilter()

                            " let time1 = str2float(reltimestr(reltime()))  " DBG
                            " TLogVAR time1, time1 - time0
                            call world.BuildTableList()
                            " let time2 = str2float(reltimestr(reltime()))  " DBG
                            " TLogVAR time2, time2 - time0
                            " TLogDBG 2
                            " TLogDBG len(world.table)
                            " TLogVAR world.table
                            " let world.list  = map(copy(world.table), 'world.GetBaseItem(v:val)')
                            " TLogDBG 3
                            let world.llen = len(world.list)
                            " TLogVAR world.index_table
                            if empty(world.index_table)
                                let dindex = range(1, world.llen)
                                let world.index_width = len(world.llen)
                            else
                                let dindex = world.index_table
                                let world.index_width = len(max(dindex))
                            endif
                            " let time3 = str2float(reltimestr(reltime()))  " DBG
                            " TLogVAR time3, time3 - time0
                            if world.llen == 0 && !world.show_empty
                                call world.ReduceFilter()
                                let world.offset = 1
                                " TLogDBG 'ReduceFilter'
                                continue
                            else
                                if world.llen == 1
                                    let world.last_item = world.list[0]
                                    if world.pick_last_item >= 2
                                        " echom 'Pick last item: '. world.list[0]
                                        let world.prefidx = '1'
                                        " TLogDBG 'pick last item'
                                        throw 'pick'
                                    endif
                                else
                                    let world.last_item = ''
                                endif
                            endif
                            " let time4 = str2float(reltimestr(reltime()))  " DBG
                            " TLogVAR time4, time4 - time0
                            " TLogDBG 4
                            " TLogVAR world.idx, world.llen, world.state
                            " TLogDBG world.FilterIsEmpty()
                            if world.state == 'display'
                                if world.idx == '' && world.llen < g:tlib#input#sortprefs_threshold && !world.FilterIsEmpty()
                                    call world.SetPrefIdx()
                                else
                                    let world.prefidx = world.idx == '' ? world.initial_index : world.idx
                                endif
                                if world.prefidx > world.llen
                                    let world.prefidx = world.llen
                                elseif world.prefidx < 1
                                    let world.prefidx = 1
                                endif
                            endif
                            " let time5 = str2float(reltimestr(reltime()))  " DBG
                            " TLogVAR time5, time5 - time0
                            " TLogVAR world.initial_index, world.prefidx
                            " TLogDBG 5
                            " TLogDBG len(world.list)
                            " TLogVAR world.list
                            let dlist = copy(world.list)
                            " TLogVAR world.display_format
                            if !empty(world.display_format)
                                let display_format = world.display_format
                                let cache = world.fmt_display
                                " TLogVAR display_format, fmt_entries
                                call map(dlist, 'world.FormatName(cache, display_format, v:val)')
                            endif
                            " TLogVAR world.prefidx
                            " TLogDBG 6
                            " let time6 = str2float(reltimestr(reltime()))  " DBG
                            " TLogVAR time6, time6 - time0
                            if world.offset_horizontal > 0
                                call map(dlist, 'v:val[world.offset_horizontal:-1]')
                            endif
                            " let time7 = str2float(reltimestr(reltime()))  " DBG
                            " TLogVAR time7, time7 - time0
                            " TLogVAR dindex
                            let dlist = map(range(0, world.llen - 1), 'printf("%0'. world.index_width .'d", dindex[v:val]) .": ". dlist[v:val]')
                            " TLogVAR dlist
                            " let time8 = str2float(reltimestr(reltime()))  " DBG
                            " TLogVAR time8, time8 - time0

                        else

                            let dlist = ['Malformed filter']

                        endif
                    else
                        if world.prefidx == 0
                            let world.prefidx = 1
                        endif
                    endif
                    " TLogVAR world.idx, world.prefidx

                    " TLogDBG 7
                    " TLogVAR world.prefidx, world.offset
                    " TLogDBG (world.prefidx > world.offset + winheight(0) - 1)
                    " if world.prefidx > world.offset + winheight(0) - 1
                    "     let listtop = world.llen - winheight(0) + 1
                    "     let listoff = world.prefidx - winheight(0) + 1
                    "     let world.offset = min([listtop, listoff])
                    "     TLogVAR world.prefidx
                    "     TLogDBG len(list)
                    "     TLogDBG winheight(0)
                    "     TLogVAR listtop, listoff, world.offset
                    " elseif world.prefidx < world.offset
                    "     let world.offset = world.prefidx
                    " endif
                    " TLogDBG 8
                    if world.initial_display || !tlib#char#IsAvailable()
                        " TLogDBG len(dlist)
                        call world.DisplayList(world.Query(), dlist)
                        call world.FollowCursor()
                        let world.initial_display = 0
                        " TLogDBG 9
                    endif
                    if world.state =~ '\<hibernate\>'
                        let world.state = 'suspend'
                    else
                        let world.state = ''
                    endif
                else
                    " if world.state == 'scroll'
                    "     let world.prefidx = world.offset
                    " endif
                    call world.DisplayList()
                    if world.state == 'help' || world.state == 'printlines'
                        let world.state = 'display'
                    else
                        let world.state = ''
                        call world.FollowCursor()
                    endif
                endif
                " TAssert IsNotEmpty(world.scratch)
                let world.list_wnr = winnr()

                " TLogVAR world.next_state, world.state
                if !empty(world.next_state)
                    let world.state = world.next_state
                    let world.next_state = ''
                endif

                if world.state =~ '\<suspend\>'
                    let world = tlib#agent#SuspendToParentWindow(world, world.rv)
                    continue
                endif

                " TLogVAR world.timeout
                let c = tlib#char#Get(world.timeout, world.timeout_resolution)
                " TLogVAR c, has_key(world.key_map[world.key_mode],c)
                let cmod = getcharmod()
                if c !~ '\D' && c > 0 && cmod != 0
                    let c = printf("<%s-%s>", cmod, c)
                endif
                " TLogVAR c, cmod
                " TLogDBG string(sort(keys(world.key_map[world.key_mode])))

                " TLogVAR world.next_agent, world.next_eval
                if !empty(world.next_agent)
                    let nagent = world.next_agent
                    let world.next_agent = ''
                    let world = call(nagent, [world, world.GetSelectedItems(world.CurrentItem())])
                    call s:CheckAgentReturnValue(nagent, world)
                elseif !empty(world.next_eval)
                    let selected = world.GetSelectedItems(world.CurrentItem())
                    let neval = world.next_eval
                    let world.next_eval = ''
                    exec neval
                    call s:CheckAgentReturnValue(neval, world)
                elseif world.state != ''
                    " continue
                elseif has_key(world.key_map[world.key_mode], c)
                    let sr = @/
                    silent! let @/ = lastsearch
                    " TLogVAR c, world.key_map[world.key_mode][c]
                    " TLog "Agent: ". string(world.key_map[world.key_mode][c])
                    let handler = world.key_map[world.key_mode][c]
                    " TLogVAR handler
                    let world = call(handler.agent, [world, world.GetSelectedItems(world.CurrentItem())])
                    call s:CheckAgentReturnValue(c, world)
                    silent! let @/ = sr
                    " continue
                elseif c == 13
                    throw 'pick'
                elseif c == 27
                    " TLogVAR c, world.key_mode
                    if world.key_mode != 'default'
                        let world.key_mode = 'default'
                        let world.state = 'redisplay'
                    else
                        let world.state = 'exit empty'
                    endif
                elseif c == "\<LeftMouse>"
                    if v:mouse_win == world.list_wnr
                        let world.prefidx = world.GetLineIdx(v:mouse_lnum)
                        " let world.offset  = world.prefidx
                        if empty(world.prefidx)
                            " call feedkeys(c, 't')
                            let c = tlib#char#Get(world.timeout)
                            let world.state = 'help'
                            continue
                        endif
                        throw 'pick'
                    else
                        let post_keys = v:mouse_lnum .'gg'. v:mouse_col .'|'. c
                        if world.allow_suspend
                            let world = tlib#agent#SuspendToParentWindow(world, world.rv)
                        else
                            let world.state = 'exit empty'
                        endif
                    endif
                elseif c == "\<RightMouse>"
                    if v:mouse_win == world.list_wnr
                        call s:BuildMenu(world)
                        if s:PopupmenuExists() == 1
                            " if v:mouse_lnum != line('.')
                            " endif
                            let world.prefidx = world.GetLineIdx(v:mouse_lnum)
                            let world.state = 'redisplay'
                            call world.DisplayList()
                            let s:popup_world = world
                            let s:popup_selected = world.GetSelectedItems(world.CurrentItem())
                            if line('w$') - v:mouse_lnum < 6
                                popup ]TLibInputListPopupMenu
                            else
                                popup! ]TLibInputListPopupMenu
                            endif
                        else
                            let world.state = 'redisplay'
                        endif
                    else
                        let post_keys = v:mouse_lnum .'gg'. v:mouse_col .'|'. c
                        if world.allow_suspend
                            let world = tlib#agent#SuspendToParentWindow(world, world.rv)
                        else
                            let world.state = 'exit empty'
                        endif
                    endif
                    " TLogVAR world.prefidx, world.state
                elseif has_key(world.key_map[world.key_mode], 'unknown_key')
                    let agent = world.key_map[world.key_mode].unknown_key.agent
                    let world = call(agent, [world, c])
                    call s:CheckAgentReturnValue(agent, world)
                elseif c >= 32
                    let world.state = 'display'
                    let numbase = get(world.numeric_chars, c, -99999)
                    " TLogVAR numbase, world.numeric_chars, c
                    if numbase != -99999
                        let world.idx .= (c - numbase)
                        if len(world.idx) == world.index_width
                            let world.prefidx = world.idx
                            " TLogVAR world.prefidx
                            throw 'pick'
                        endif
                    else
                        let world.idx = ''
                        " TLogVAR world.filter
                        if world.llen > g:tlib#input#livesearch_threshold
                            let pattern = input('Filter: ', world.CleanFilter(world.filter[0][0]) . nr2char(c))
                            if empty(pattern)
                                let world.state = 'exit empty'
                            else
                                call world.SetFrontFilter(pattern)
                                echo
                            endif
                        elseif c == 124
                            call insert(world.filter[0], [])
                        else
                            call world.PushFrontFilter(c)
                        endif
                        " continue
                        if c == 45 && world.filter[0][0] == '-'
                            let world.state = 'redisplay'
                        end
                    endif
                else
                    let world.state = 'redisplay'
                    " let world.state = 'continue'
                endif

            catch /^pick$/
                call world.ClearAllMarks()
                call world.MarkCurrent(world.prefidx)
                let world.state = ''
                " TLogDBG 'Pick item #'. world.prefidx

            finally
                " TLogDBG 'finally 1'
                if world.state =~ '\<suspend\>'
                    " if !world.allow_suspend
                    "     echom "Cannot be suspended"
                    "     let world.state = 'redisplay'
                    " endif
                elseif !empty(world.list) && !empty(world.base)
                    " TLogVAR world.list
                    if empty(world.state)
                        " TLogVAR world.state
                        let world.rv = world.CurrentItem()
                    endif
                    " TLog "postprocess"
                    for handler in world.post_handlers
                        let state = get(handler, 'postprocess', '')
                        " TLogVAR handler
                        " TLogVAR state
                        " TLogVAR world.state
                        if state == world.state
                            let agent = handler.agent
                            let [world, world.rv] = call(agent, [world, world.rv])
                            " TLogVAR world.state, world.rv
                            call s:CheckAgentReturnValue(agent, world)
                        endif
                    endfor
                endif
                " TLogDBG 'state0='. world.state
            endtry
            " TLogDBG 'state1='. world.state
        endwh

        " TLogVAR world.state
        " TLogDBG string(tlib#win#List())
        " TLogDBG 'exit while loop'
        " TLogVAR world.list
        " TLogVAR world.sel_idx
        " TLogVAR world.idx
        " TLogVAR world.prefidx
        " TLogVAR world.rv
        " TLogVAR world.type, world.state, world.return_agent, world.index_table, world.rv
        if world.state =~ '\<\(empty\|escape\)\>'
            let world.sticky = 0
        endif
        if world.state =~ '\<suspend\>'
            " TLogDBG 'return suspended'
            " TLogVAR world.prefidx
            " exec world.prefidx
            return
        elseif world.state =~ '\<empty\>'
            " TLog "empty"
            " TLogDBG 'return empty'
            " TLogVAR world.type
            if stridx(world.type, 'm') != -1
                return []
            elseif stridx(world.type, 'i') != -1
                return 0
            else
                return ''
            endif
        elseif !empty(world.return_agent)
            " TLog "return_agent"
            " TLogDBG 'return agent'
            " TLogVAR world.return_agent
            call world.CloseScratch()
            " TLogDBG "return_agent ". string(tlib#win#List())
            " TAssert IsNotEmpty(world.scratch)
            return call(world.return_agent, [world, world.GetSelectedItems(world.rv)])
        elseif stridx(world.type, 'w') != -1
            " TLog "return_world"
            " TLogDBG 'return world'
            return world
        elseif stridx(world.type, 'm') != -1
            " TLog "return_multi"
            " TLogDBG 'return multi'
            return world.GetSelectedItems(world.rv)
        elseif stridx(world.type, 'i') != -1
            " TLog "return_index"
            " TLogDBG 'return index'
            if empty(world.index_table)
                return world.rv
            else
                return world.index_table[world.rv - 1]
            endif
        else
            " TLog "return_else"
            " TLogDBG 'return normal'
            return world.rv
        endif

    finally
        call world.Leave()

        " TLogVAR statusline
        " let &l:statusline = statusline
        " let &laststatus = laststatus
        silent! let @/  = lastsearch
        let &l:scrolloff = scrolloff
        if s:PopupmenuExists() == 1
            silent! aunmenu ]TLibInputListPopupMenu
        endif

        " TLogDBG 'finally 2'
        " TLogDBG string(world.Methods())
        " TLogVAR world.state
        " TLogDBG string(tlib#win#List())
        if world.state !~ '\<suspend\>'
            " redraw
            " TLogVAR world.sticky, bufnr("%")
            if world.sticky
                " TLogDBG "sticky"
                " TLogVAR world.bufnr
                " TLogDBG bufwinnr(world.bufnr)
                if world.scratch_split > 0
                    if bufwinnr(world.bufnr) == -1
                        " TLogDBG "UseScratch"
                        call world.UseScratch()
                    endif
                    let world = tlib#agent#SuspendToParentWindow(world, world.GetSelectedItems(world.rv))
                endif
            else
                " TLogDBG "non sticky"
                " TLogVAR world.state, world.win_wnr, world.bufnr
                if world.CloseScratch()
                    " TLogVAR world.winview
                    call tlib#win#SetLayout(world.winview)
                endif
            endif
        endif
        " for i in range(0,5)
        "     call getchar(0)
        " endfor
        echo
        redraw!
        if !empty(post_keys)
            " TLogVAR post_keys
            call feedkeys(post_keys)
        endif
    endtry
endf


function! s:Init(world, cmd) "{{{3
    " TLogVAR a:cmd
    let a:world.initial_display = 1
    if a:cmd =~ '\<sticky\>'
        let a:world.sticky = 1
    endif
    if a:cmd =~ '^resume'
        call a:world.UseInputListScratch()
        let a:world.initial_index = line('.')
        if a:cmd =~ '\<pick\>'
            let a:world.state = 'pick'
            let a:world.prefidx = a:world.initial_index
        else
            call a:world.Retrieve(1)
        endif
    elseif !a:world.initialized
        " TLogVAR a:world.initialized, a:world.win_wnr, a:world.bufnr
        let a:world.filetype = &filetype
        let a:world.fileencoding = &fileencoding
        call a:world.SetMatchMode(tlib#var#Get('tlib#input#filter_mode', 'wb'))
        call a:world.Initialize()
        if !has_key(a:world, 'key_mode')
            let a:world.key_mode = 'default'
        endif
        " TLogVAR has_key(a:world,'key_map')
        if has_key(a:world, 'key_map')
            " TLogVAR has_key(a:world.key_map,a:world.key_mode)
            if has_key(a:world.key_map, a:world.key_mode)
                let a:world.key_map[a:world.key_mode] = extend(
                            \ a:world.key_map[a:world.key_mode],
                            \ copy(g:tlib#input#keyagents_InputList_s),
                            \ 'keep')
            else
                let a:world.key_map[a:world.key_mode] = copy(g:tlib#input#keyagents_InputList_s)
            endif
        else
            let a:world.key_map = {
                        \ a:world.key_mode : copy(g:tlib#input#keyagents_InputList_s)
                        \ }
        endif
        " TLogVAR a:world.type
        if stridx(a:world.type, 'm') != -1
            call extend(a:world.key_map[a:world.key_mode], g:tlib#input#keyagents_InputList_m, 'force')
        endif
        for key_mode in keys(a:world.key_map)
            let a:world.key_map[key_mode] = map(a:world.key_map[key_mode], 'type(v:val) == 4 ? v:val : {"agent": v:val}')
        endfor
        if type(a:world.key_handlers) == 3
            call s:ExtendKeyMap(a:world, a:world.key_mode, a:world.key_handlers)
        elseif type(a:world.key_handlers) == 4
            for [world_key_mode, world_key_handlers] in items(a:world.key_handlers)
                call s:ExtendKeyMap(a:world, world_key_mode, world_key_handlers)
            endfor
        else
            throw "tlib#input#ListW: key_handlers must be either a list or a dictionary"
        endif
        if !empty(a:cmd)
            let a:world.state .= ' '. a:cmd
        endif
    endif
    " TLogVAR a:world.state, a:world.sticky
endf


function! s:ExtendKeyMap(world, key_mode, key_handlers) "{{{3
    for handler in a:key_handlers
        let k = get(handler, 'key', '')
        if !empty(k)
            let a:world.key_map[a:key_mode][k] = handler
        endif
    endfor
endf


function s:PopupmenuExists()
    if g:tlib#input#use_popup && exists(':popup') != 2
        let rv = -1
    else
        try
            let rv = 1
            silent amenu ]TLibInputListPopupMenu
        catch
            let rv = 0
        endtry
    endif
    " TLogVAR rv
    return rv
endf


function! s:BuildMenu(world) "{{{3
    if g:tlib#input#use_popup && s:PopupmenuExists() == 0
        amenu ]TLibInputListPopupMenu.Pick\ selected\ item <cr>
        amenu ]TLibInputListPopupMenu.Cancel <esc>
        amenu ]TLibInputListPopupMenu.Selection.Select #
        amenu ]TLibInputListPopupMenu.Selection.Select\ all <c-a>
        amenu ]TLibInputListPopupMenu.Selection.Reset\ list <c-r>
        amenu ]TLibInputListPopupMenu.-StandardEntries- :
        for [key_mode, key_handlers] in items(a:world.key_map)
            let keys = sort(keys(key_handlers))
            let mitems = {}
            for key in keys
                let handler = key_handlers[key]
                let k = get(handler, 'key', '')
                if !empty(k) && has_key(handler, 'help') && !empty(handler.help)
                    if empty(key_mode) || key_mode == 'default'
                        let mname = ''
                    else
                        let mname = escape(key_mode, ' .\') .'.'
                    endif
                    if has_key(handler, 'submenu')
                        let submenu = escape(handler.submenu, ' .\')
                    else
                        let submenu = '~'
                    endif
                    for mfield in ['menu', 'help', 'key_name', 'agent']
                        if has_key(handler, mfield)
                            let mname .= escape(handler[mfield], ' .\')
                            break
                        endif
                    endfor
                    if !has_key(mitems, submenu)
                        let mitems[submenu] = {}
                    endif
                    let cmd = handler.key_name
                    " let cmd = ':call feedkeys('. string(handler.key) .', "t")<cr>'
                    let mitems[submenu][mname] = {'cmd': cmd}
                endif
            endfor
            for msubname in sort(keys(mitems))
                let msubitems = mitems[msubname]
                if msubname == '~'
                    let msubmname = ''
                else
                    let msubmname = msubname .'.'
                endif
                for mname in sort(keys(msubitems))
                    let mitem = msubitems[mname]
                    " echom 'DBG amenu ]TLibInputListPopupMenu.'. msubmname . mname .' '. mitem.cmd
                    exec 'amenu ]TLibInputListPopupMenu.'. msubmname . mname .' '. mitem.cmd
                endfor
            endfor
        endfor
    endif
endf


function! s:RunStateHandlers(world) "{{{3
    " Provide the variable "world" in the environment of an "exec" 
    " handler (ea).
    let world = a:world
    for handler in a:world.state_handlers
        let eh = get(handler, 'state', '')
        if !empty(eh) && a:world.state =~ eh
            let ea = get(handler, 'exec', '')
            if !empty(ea)
                exec ea
            else
                let agent = get(handler, 'agent', '')
                let a:world = call(agent, [a:world, a:world.GetSelectedItems(a:world.CurrentItem())])
                call s:CheckAgentReturnValue(agent, a:world)
            endif
        endif
    endfor
endf


function! s:CheckAgentReturnValue(name, value) "{{{3
    if type(a:value) != 4 && !has_key(a:value, 'state')
        echoerr 'Malformed agent: '. a:name
    endif
    return a:value
endf


function! s:SetOffset(world) "{{{3
    let llenw = len(a:world.base) - winheight(0) + 1
    if a:world.offset > llenw
        let a:world.offset = llenw
    endif
    if a:world.offset < 1
        let a:world.offset = 1
    endif
endf


" Functions related to tlib#input#EditList(type, ...) "{{{2

" :def: function! tlib#input#EditList(query, list, ?timeout=0)
" Edit a list.
"
" EXAMPLES: >
"   echo tlib#input#EditList('Edit:', [100,200,300])
function! tlib#input#EditList(query, list, ...) "{{{3
    let handlers = a:0 >= 1 && !empty(a:1) ? a:1 : g:tlib#input#handlers_EditList
    let default  = a:0 >= 2 ? a:2 : []
    let timeout  = a:0 >= 3 ? a:3 : 0
    " TLogVAR handlers
    let rv = tlib#input#List('me', a:query, copy(a:list), handlers, default, timeout)
    " TLogVAR rv
    if empty(rv)
        return a:list
    else
        let [success, list] = rv
        return success ? list : a:list
    endif
endf


function! tlib#input#Resume(name, pick, bufnr) "{{{3
    " TLogVAR a:name, a:pick
    echo
    if bufnr('%') != a:bufnr
        if g:tlib#debug
            echohl WarningMsg
            echom "tlib#input#Resume: Internal error: Not in scratch buffer:" bufname('%')
            echohl NONE
        endif
        let br = tlib#buffer#Set(a:bufnr)
    endif
    if !exists('b:tlib_'. a:name)
        if g:tlib#debug
            echohl WarningMsg
            echom "tlib#input#Resume: Internal error: b:tlib_". a:name ." does not exist:" bufname('%')
            echohl NONE
            redir => varss
            silent let b:
            redir END
            let vars = split(varss, '\n')
            call filter(vars, 'v:val =~ "^b:tlib_"')
            echom "DEBUG tlib#input#Resume" string(vars)
        endif
    else
        call tlib#autocmdgroup#Init()
        autocmd! TLib BufEnter <buffer>
        if b:tlib_{a:name}.state =~ '\<suspend\>'
            let b:tlib_{a:name}.state = 'redisplay'
        else
            let b:tlib_{a:name}.state .= ' redisplay'
        endif
        " call tlib#input#List('resume '. a:name)
        let cmd = 'resume '. a:name
        if a:pick >= 1
            let cmd .= ' pick'
            if a:pick >= 2
                let cmd .= ' sticky'
            end
        endif
        call tlib#input#ListW(b:tlib_{a:name}, cmd)
    endif
endf


" :def: function! tlib#input#CommandSelect(command, ?keyargs={})
" Take a command, view the output, and let the user select an item from 
" its output.
"
" EXAMPLE: >
"     command! TMarks exec 'norm! `'. matchstr(tlib#input#CommandSelect('marks'), '^ \+\zs.')
"     command! TAbbrevs exec 'norm i'. matchstr(tlib#input#CommandSelect('abbrev'), '^\S\+\s\+\zs\S\+')
function! tlib#input#CommandSelect(command, ...) "{{{3
    TVarArg ['args', {}]
    if has_key(args, 'retrieve')
        let list = call(args.retrieve)
    elseif has_key(args, 'list')
        let list = args.list
    else
        let list = tlib#cmd#OutputAsList(a:command)
    endif
    if has_key(args, 'filter')
        call map(list, args.filter)
    endif
    let type     = has_key(args, 'type') ? args.type : 's'
    let handlers = has_key(args, 'handlers') ? args.handlers : []
    let rv = tlib#input#List(type, 'Select', list, handlers)
    if !empty(rv)
        if has_key(args, 'process')
            let rv = call(args.process, [rv])
        endif
    endif
    return rv
endf


" :def: function! tlib#input#Edit(name, value, callback, ?cb_args=[])
"
" Edit a value (asynchronously) in a scratch buffer. Use name for 
" identification. Call callback when done (or on cancel).
" In the scratch buffer:
" Press <c-s> or <c-w><cr> to enter the new value, <c-w>c to cancel 
" editing.
" EXAMPLES: >
"   fun! FooContinue(success, text)
"       if a:success
"           let b:var = a:text
"       endif
"   endf
"   call tlib#input#Edit('foo', b:var, 'FooContinue')
function! tlib#input#Edit(name, value, callback, ...) "{{{3
    " TLogVAR a:value
    TVarArg ['args', []]
    let sargs = {'scratch': '__EDIT__'. a:name .'__', 'win_wnr': winnr()}
    let scr = tlib#scratch#UseScratch(sargs)

    " :nodoc:
    map <buffer> <c-w>c :call <SID>EditCallback(0)<cr>
    " :nodoc:
    imap <buffer> <c-w>c <c-o>call <SID>EditCallback(0)<cr>
    " :nodoc:
    map <buffer> <c-s> :call <SID>EditCallback(1)<cr>
    " :nodoc:
    imap <buffer> <c-s> <c-o>call <SID>EditCallback(1)<cr>
    " :nodoc:
    map <buffer> <c-w><cr> :call <SID>EditCallback(1)<cr>
    " :nodoc:
    imap <buffer> <c-w><cr> <c-o>call <SID>EditCallback(1)<cr>
    
    call tlib#normal#WithRegister('gg"tdG', 't')
    call append(1, split(a:value, "\<c-j>", 1))
    " let hrm = 'DON''T DELETE THIS HEADER'
    " let hr3 = repeat('"', (tlib#win#Width(0) - len(hrm)) / 2)
    let s:horizontal_line = repeat('`', tlib#win#Width(0))
    " hr3.hrm.hr3
    let hd  = ['Keys: <c-s>, <c-w><cr> ... save/accept; <c-w>c ... cancel', s:horizontal_line]
    call append(1, hd)
    call tlib#normal#WithRegister('gg"tdd', 't')
    syntax match TlibEditComment /^\%1l.*/
    syntax match TlibEditComment /^```.*/
    hi link TlibEditComment Comment
    exec len(hd) + 1
    if type(a:callback) == 4
        let b:tlib_scratch_edit_callback = get(a:callback, 'submit', '')
        call call(get(a:callback, 'init', ''), [])
    else
        let b:tlib_scratch_edit_callback = a:callback
    endif
    let b:tlib_scratch_edit_args     = args
    let b:tlib_scratch_edit_scratch  = sargs
    " exec 'autocmd BufDelete,BufHidden,BufUnload <buffer> call s:EditCallback('. string(a:name) .')'
    " echohl MoreMsg
    " echom 'Press <c-s> to enter, <c-w>c to cancel editing.'
    " echohl NONE
endf


function! s:EditCallback(...) "{{{3
    TVarArg ['ok', -1]
    " , ['bufnr', -1]
    " autocmd! BufDelete,BufHidden,BufUnload <buffer>
    if ok == -1
        let ok = confirm('Use value')
    endif
    let start = getline(2) == s:horizontal_line ? 3 : 1
    let text = ok ? join(getline(start, '$'), "\n") : ''
    let cb   = b:tlib_scratch_edit_callback
    let args = b:tlib_scratch_edit_args
    let sargs = b:tlib_scratch_edit_scratch
    " TLogVAR cb, args, sargs
    call tlib#scratch#CloseScratch(b:tlib_scratch_edit_scratch)
    call tlib#win#Set(sargs.win_wnr)
    call call(cb, args + [ok, text])
endf


function! tlib#input#Dialog(text, options, default) "{{{3
    if has('dialog_con') || has('dialog_gui')
        let opts = join(map(a:options, '"&". v:val'), "\n")
        let val = confirm(a:text, opts)
        if val
            let yn = a:options[val - 1]
        else
            let yn = a:default
        endif
    else
        let oi = index(a:options, a:default)
        if oi == -1
            let opts = printf("(%s|%s)", join(a:options, '/'), a:default)
        else
            let options = copy(a:options)
            let options[oi] = toupper(options[oi])
            let opts = printf("(%s)", join(a:options, '/'))
        endif
        let yn = inputdialog(a:text .' '. opts)
    endif
    return yn
endf

