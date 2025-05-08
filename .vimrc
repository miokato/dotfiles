" common
syntax on
set clipboard=unnamed "yankするとクリップボード
set laststatus=2 "前回のステータスを常に表示

" backup
set nobackup
set writebackup

" view
set background=light
" colorscheme solarized
set t_Co=256 " ターミナルで256色表示にする
set title
set number


" search 
set incsearch
set hlsearch " サーチ結果をハイライト
set smartcase " 大文字で検索されたら大文字のみ表示
set ignorecase " 大文字小文字を区別しない
set nowrapscan " 検索でファイル末尾まで進むとそこで止まる


" Indent rule, I do mainly using python.
filetype indent on 
set tabstop=4 "タブ幅を半角スペース4つ分にする
set softtabstop=4
set shiftwidth=4 "自動インデントの幅
set expandtab " タブを半角スペースに置き換える


" When insert mode, can type like mac Key bind.
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-h> <BS>
inoremap <C-k> <ESC>d$i
inoremap <C-a> <Home>
" backspace > バックスペースで削除できるものを指定
" indent > 行頭の空白
" eol > 改行
" start > 挿入モード開始位置より手前の文字
set backspace=indent,eol,start 




