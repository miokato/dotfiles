if !empty(glob("~/.vim/colors/solarized.vim"))
    colorscheme solarized
endif

" common
syntax on
set number
set incsearch
set hlsearch " サーチ結果をハイライト
set smartcase " 大文字で検索されたら大文字のみ表示
set ignorecase " 大文字小文字を区別しない
set t_Co=256 " ターミナルで256色表示にする
set nowrapscan " 検索でファイル末尾まで進むとそこで止まる
set clipboard=unnamed "yankするとクリップボード


" python indent
filetype indent on 
set tabstop=4 "タブ幅を半角スペース4つ分にする
set softtabstop=4
set shiftwidth=4 "自動インデントの幅
set expandtab " タブを半角スペースに置き換える


" Key bind
inoremap <C-p> <Up>
inoremap <C-n> <Down>
inoremap <C-f> <Right>
inoremap <C-b> <Left>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-h> <BS>

