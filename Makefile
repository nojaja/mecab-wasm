PRODUCTS := lib/libmecab.js lib/libmecab.data lib/libmecab.wasm

.PHONY: all
all: $(PRODUCTS)

mecab/dist/libmecab.so:
	cd mecab && ./configure && make clean && make && mv ./src/.libs ../libexec/mecab --prefix .. && export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:../libexec/mecab

mecab-ipadict/dist/sys.dic:
	cd mecab-ipadict && ./configure --with-mecab-config=../mecab/mecab-config --with-dicdir=./dist && make && ../libexec/mecab-dict-index -f euc-jp -t utf-8 && make install

mecab/src/.libs/libmecab.so:
	cd mecab && emconfigure ./configure && emmake make -j9

$(PRODUCTS): mecab/src/.libs/libmecab.so mecab-ipadict/dist/sys.dic build_js.sh
	@bash -x ./build_js.sh
