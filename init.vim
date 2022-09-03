" For exiting to normal mode with 'jk'.
inoremap jk <esc>

" For navigating windows with arrow keys.
nnoremap <left> <C-w>h
nnoremap <right> <C-w>l
nnoremap <up> <C-w>k
nnoremap <down> <C-w>j

" For navigating tabs with arrow keys.
nnoremap <S-left> :tabprevious<CR>
nnoremap <S-right> :tabnext<CR>
nnoremap <S-up> :tabfirst<CR>
nnoremap <S-down> :tablast<CR>

" For navigating buffers with arrow keys. 
nnoremap <C-left> :bp<CR>
nnoremap <C-right> :bn<CR>
nnoremap <C-up> :bf<CR>
nnoremap <C-down> :bl<CR>

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
