/usr/bin/xvfb-run --server-args='-screen 0, 1024x768x24' /usr/local/bin/CutyCapt --url='http://www.bt.no' --out='/home/mno/btfrontpagethumb/data/btfront.png'

/usr/bin/convert -define jpeg:size=1000 /home/mno/btfrontpagethumb/data/btfront.png -auto-orient -thumbnail 300 -gravity north -extent  380x230 -unsharp 0.5 /home/mno/btfrontpagethumb/data/small_bt.png
/usr/bin/convert -define jpeg:size=1000 /home/mno/btfrontpagethumb/data/btfront.png -auto-orient -thumbnail 980 -gravity north -extent  980x593 -unsharp 0.5 /home/mno/btfrontpagethumb/data/large_bt.png
/usr/bin/convert -define jpeg:size=1000 /home/mno/btfrontpagethumb/data/btfront.png -auto-orient -thumbnail 980 -gravity north -extent  980 -unsharp 0.5 /home/mno/btfrontpagethumb/data/full_bt.png

#til btpub2/3 /data

scp /home/mno/btfrontpagethumb/data/small_bt.png mno@btpub2.medianorge.no:/data/external/btfrontthumb
scp /home/mno/btfrontpagethumb/data/small_bt.png mno@btpub3.medianorge.no:/data/external/btfrontthumb
scp /home/mno/btfrontpagethumb/data/small_bt.png mno@btweb3.medianorge.no:/data/external/btfrontthumb
scp /home/mno/btfrontpagethumb/data/small_bt.png mno@btweb4.medianorge.no:/data/external/btfrontthumb

scp /home/mno/btfrontpagethumb/data/large_bt.png mno@btpub2.medianorge.no:/data/external/btfrontthumb
scp /home/mno/btfrontpagethumb/data/large_bt.png mno@btpub3.medianorge.no:/data/external/btfrontthumb
scp /home/mno/btfrontpagethumb/data/large_bt.png mno@btweb3.medianorge.no:/data/external/btfrontthumb
scp /home/mno/btfrontpagethumb/data/large_bt.png mno@btweb4.medianorge.no:/data/external/btfrontthumb

scp /home/mno/btfrontpagethumb/data/full_bt.png mno@btpub2.medianorge.no:/data/external/btfrontthumb
scp /home/mno/btfrontpagethumb/data/full_bt.png mno@btpub3.medianorge.no:/data/external/btfrontthumb
scp /home/mno/btfrontpagethumb/data/full_bt.png mno@btweb3.medianorge.no:/data/external/btfrontthumb
scp /home/mno/btfrontpagethumb/data/full_bt.png mno@btweb4.medianorge.no:/data/external/btfrontthumb




rm /home/mno/btfrontpagethumb/data/btfront.png

