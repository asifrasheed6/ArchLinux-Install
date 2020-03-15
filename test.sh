git clone https://www.opencode.net/marianarlt/sddm-sugar-candy
mkdir /usr/share/sddm/themes/sugar-candy
mv sddm-sugar-candy/* /usr/share/sddm/themes/sugar-candy
rm -rf kde-plasma-chili

cp /usr/lib/sddm/sddm.conf.d/default.conf /usr/lib/sddm/sddm.conf.d/default.bak
sed '33c\
Current=sugar-candy
' /usr/lib/sddm/sddm.conf.d/default.bak > /usr/lib/sddm/sddm.conf.d/default.conf
