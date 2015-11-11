default: build
.PHONY: clean

CC=gcc
CFLAGS=

# name of the helium backup file to extract
BACKUP = backup.ab
# name of the folder to extract to
TARGET = helium

build: ab2tar_cut ab2tar_corr tar2ab_corr tar2ab_cut

ab2tar_cut: ab2tar_cut.c
	$(CC) ab2tar_cut.c -o ab2tar_cut $(CFLAGS)
ab2tar_corr: ab2tar_corr.c
	$(CC) ab2tar_corr.c -o ab2tar_corr $(CFLAGS)
tar2ab_corr: tar2ab_corr.c
	$(CC) tar2ab_corr.c -o tar2ab_corr $(CFLAGS)
tar2ab_cut: tar2ab_cut.c
	$(CC) tar2ab_cut.c -o tar2ab_cut $(CFLAGS)

clean:
	rm -f ab2tar_cut ab2tar_corr tar2ab_cut tar2ab_corr

extract: build $(BACKUP)
	./ab2tar_cut $(BACKUP) b.tmp > /dev/null
	./ab2tar_corr b.tmp b.tar > /dev/null
	mkdir -p $(TARGET)/$(BACKUP)
	tar -xf b.tar -C $(TARGET)/$(BACKUP)
	rm -f b.tmp b.tar
	@echo "extracted to folder: \"$(TARGET)/$(BACKUP)\""
