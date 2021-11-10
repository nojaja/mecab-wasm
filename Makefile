PRODUCTS := lib/libmecab.js lib/libmecab.data lib/libmecab.wasm

.PHONY: all
all: $(PRODUCTS)

libexec/mecab/mecab-dict-index:
	mkdir -p $(CURDIR)/libexec/mecab && cd mecab && ./configure --prefix=$(CURDIR) --libexecdir=$(CURDIR)/libexec/mecab && make && mv ./src/.libs/* $(CURDIR)/libexec/mecab/

mecab-ipadict/dist/sys.dic: libexec/mecab/mecab-dict-index
	export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$(CURDIR)/libexec/mecab && cd mecab-ipadict && ./configure --with-mecab-config=../mecab/mecab-config --with-dicdir=./dist && make && ../libexec/mecab/mecab-dict-index -f euc-jp -t utf-8 && make install

mecab/src/.libs/libmecab.so:
	cd mecab && emconfigure ./configure && emmake make -j9 && ls $(CURDIR)/mecab/src/.libs/

$(PRODUCTS): mecab-ipadict/dist/sys.dic mecab/src/.libs/libmecab.so build_js.sh
	@bash -x ./build_js.sh
