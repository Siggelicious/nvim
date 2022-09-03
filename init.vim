" For exiting to normal mode with 'jk'.
inoremap jk <esc>

" For navigating windows with ctrl-(h/j/k/l).
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j

" For navigating tabs with shift-(h/j/k/l).
nnoremap <S-h> :tabprevious<CR>
nnoremap <S-l> :tabnext<CR>
nnoremap <S-k> :tabfirst<CR>
nnoremap <S-j> :tablast<CR>

" For navigating buffers with alt-(h/j/k/l). 
nnoremap <A-h> :bp<CR>
nnoremap <A-l> :bn<CR>
nnoremap <A-k> :bf<CR>
nnoremap <A-j> :bl<CR>

" For navigating in insert mode with ctrl-(h/j/k/l).
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-k> <Up>
inoremap <C-j> <Down>

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'jiangmiao/auto-pairs'
Plug 'neovim/nvim-lspconfig'
Plug 'lifepillar/vim-mucomplete'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" Editing preferences.
set relativenumber
set number
set splitbelow
set splitright
set clipboard=unnamedplus

" Autocompletion preferences.
set completeopt-=preview 
set completeopt+=menuone,longest

" Lua.
lua << EOF
-- On-attach function for buffers with active language servers.
local on_attach = function(client, bufnr)
	-- Enable LSP autocompletion.
	vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')	
	
	-- Keybindings.
	local bufopts = { noremap=true, silent=true, buffer=bufnr }
	vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
end

-- LSP's.
require('lspconfig')['pyright'].setup{ on_attach=on_attach }
require('lspconfig')['rust_analyzer'].setup{ on_attach=on_attach }
EOF
