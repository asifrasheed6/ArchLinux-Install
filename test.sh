tar xvf plasma-chili.tar -C /usr/share/sddm/themes

cp /usr/lib/sddm/sddm.conf.d/default.conf /usr/lib/sddm/sddm.conf.d/default.bak
sed '33c\
Current=plasma-chili
' /usr/lib/sddm/sddm.conf.d/default.bak > /usr/lib/sddm/sddm.conf.d/default.conf

cp /etc/sudoers /etc/sudoers.bak
sed '82c\
%wheel    ALL=(ALL)   ALL
' /etc/sudoers.bak > /etc/sudoers
