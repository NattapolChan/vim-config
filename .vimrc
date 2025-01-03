let mapleader = " "
noremap <C-,> :<C-U>tabprev<CR>
noremap <C-.> :<C-U>tabnext<CR>
noremap <leader>nf :<C-U>tabnew

set number
set relativenumber

call plug#begin()

" List your plugins here
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'williamboman/mason.nvim'
Plug 'lambdalisue/fern.vim'
Plug 'Donaldttt/fuzzyy'

call plug#end()

noremap <leader>ff :Fern %:h -drawer -reveal=m%:p -toggle -width=50 <CR>
noremap <leader>pf :FuzzyFiles <CR>

color dracula
set termguicolors
hi Normal ctermbg=NONE guibg=NONE

if executable('ccls')
    au User lsp_setup call lsp#register_server({
	\ 'name': 'ccls',
	\ 'cmd': {server_info->['ccls']},
	\ 'root_uri': {server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'compile_commands.json'))},
	\ 'initialization_options': {'cache': {'directory': expand('~/.cache/ccls') }},
	\ 'allowlist': ['c', 'cpp', 'objc', 'objcpp', 'cc'],
	\ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

noremap <C-j> 10j
noremap <C-k> 10k


set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'davidhalter/jedi-vim'
call vundle#end()
filetype plugin indent on

