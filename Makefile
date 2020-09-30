.PHONY ext
ext:
	code --list-extensions

.PHONY install
install:
	sh install_mac.sh
	sh install_extensions_mac
