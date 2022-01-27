#
#!/bin/bash
# © 2021 GitHub, Inc.
#====================================================================
# Copyright (c) 2019-2021 iplcdn <https://iplcdn.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/MuaCat/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#====================================================================

# Banner
date=`date +%d.%m.%Y-%H:%M`
sed -i 's/OpenWrt/Actions-AX6 '$date' By Sepbiy/g' package/lean/default-settings/files/zzz-default-settings
sed -i 's/%D %V, %C/%D %V, '$date' By Sepbiy/g' package/base-files/files/etc/banner

# Modify default IP
#sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate
#sed -i 's/255.255.255.0/255.255.255.0/g' package/base-files/files/bin/config_generate

# Modify default HostName
sed -i 's/OpenWrt/ax6/g' package/base-files/files/bin/config_generate

# Изменить количество подключений
#sed -i 's/net.netfilter.nf_conntrack_max=.*/net.netfilter.nf_conntrack_max=65535/g' package/kernel/linux/files/sysctl-nf-conntrack.conf
#Зафиксируйте количество подключений 
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# Modify the version number
#sed -i "s/OpenWrt /MuaChow build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings
# Set default language
sed -i "s/zh_cn/en/g" package/lean/default-settings/files/zzz-default-settings
sed -i "s/zh_cn/en/g" luci/modules/luci-base/root/etc/uci-defaults/luci-base
sed -i "s/+@LUCI_LANG_zh-cn/+@LUCI_LANG_en/g" package/lean/default-settings/Makefile
sed -i "/po2lmo .\/po\/zh-cn\/default.po/d" package/lean/default-settings/Makefile

# Set Theme bootstrap
sed -i "/uci commit luci/i uci set luci.main.mediaurlbase='/luci-static/bootstrap'" package/lean/default-settings/files/zzz-default-settings

# Set Timezone
sed -i "s@CST-8@'CET-1CEST,M3.5.0,M10.5.0/3'@g" package/lean/default-settings/files/zzz-default-settings
sed -i "s@Asia/Shanghai@'Europe/Warsaw'@g" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i uci set system.ntp.server=''" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i uci add_list system.ntp.server=time.windows.com" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i uci add_list system.ntp.server=1.europe.pool.ntp.org" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i uci add_list system.ntp.server=2.europe.pool.ntp.org" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/i uci add_list system.ntp.server=3.europe.pool.ntp.org" package/lean/default-settings/files/zzz-default-settings

sed -i "/uci commit system/a uci commit ntpclient" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit ntpclient/i uci set ntpclient.@ntpserver[3].hostname='3.europe.pool.ntp.org'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit ntpclient/i uci set ntpclient.@ntpserver[2].hostname='2.europe.pool.ntp.org'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit ntpclient/i uci set ntpclient.@ntpserver[1].hostname='1.europe.pool.ntp.org'" package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit ntpclient/i uci set ntpclient.@ntpserver[0].hostname='time.windows.com'" package/lean/default-settings/files/zzz-default-settings

# Add normal repos
sed -i "/\/etc\/opkg\/distfeeds.conf/d" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"#src\/gz openwrt_core https:\/\/mirrors.cloud.tencent.com\/lede\/snapshots\/targets\/ipq807x\/generic\/packages\" >> \/etc\/opkg\/distfeeds.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"src\/gz openwrt_telephony https:\/\/downloads.openwrt.org\/releases\/packages-21.02\/aarch64_cortex-a53\/telephony\" >> \/etc\/opkg\/distfeeds.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"src\/gz openwrt_routing https:\/\/downloads.openwrt.org\/releases\/packages-21.02\/aarch64_cortex-a53\/routing\" >> \/etc\/opkg\/distfeeds.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"src\/gz openwrt_packages https:\/\/downloads.openwrt.org\/releases\/packages-21.02\/aarch64_cortex-a53\/packages\" >> \/etc\/opkg\/distfeeds.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"src\/gz openwrt_luci https:\/\/downloads.openwrt.org\/releases\/packages-21.02\/aarch64_cortex-a53\/luci\" >> \/etc\/opkg\/distfeeds.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"src\/gz openwrt_base https:\/\/downloads.openwrt.org\/releases\/packages-21.02\/aarch64_cortex-a53\/base\" > \/etc\/opkg\/distfeeds.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"arch aarch64_cortex-a53 20\" >> \/etc\/opkg.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"arch aarch64_cortex-a53_neon-vfpv4 10\" >> \/etc\/opkg.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"arch noarch 1\" >> \/etc\/opkg.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"arch all 1\" >> \/etc\/opkg.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"#option check_signature 1\" >> \/etc\/opkg.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"option overlay_root \/overlay\" >> \/etc\/opkg.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"lists_dir ext \/var\/opkg-lists\" >> \/etc\/opkg.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"dest ram \/tmp\" >> \/etc\/opkg.conf" package/lean/default-settings/files/zzz-default-settings
sed -i "/\/etc\/shadow/a echo \"dest root \/\" > \/etc\/opkg.conf" package/lean/default-settings/files/zzz-default-settings

# create /opt
sed -i "/\/usr\/bin\/ip/a mkdir \/opt" package/lean/default-settings/files/zzz-default-settings

# Отремонтировать ядро и добавить дисплей температуры 
sed -i 's|pcdata(boardinfo.system or "?")|luci.sys.exec("uname -m") or "?"|g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm
sed -i 's/or "1"%>/or "1"%> ( <%=luci.sys.exec("expr `cat \/sys\/class\/thermal\/thermal_zone0\/temp` \/ 1000") or "?"%> \&#8451; ) /g' feeds/luci/modules/luci-mod-admin-full/luasrc/view/admin_status/index.htm



# Удалить неиспользуемые пакеты   
#rm -rf package/lean/luci-app-wrtbwmon
#rm -rf feeds/packages/net/smartdns

# Добавить дополнительные пакеты 
#git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
#git clone https://github.com/kongfl888/luci-app-adguardhome.git package/luci-app-adguardhome
#git clone https://github.com/small-5/luci-app-adblock-plus package/luci-app-adblock-plus
#svn co https://github.com/kenzok8/openwrt-packages/trunk/luci-app-eqos package/luci-app-eqos


#readd cpufreq for aarch64
sed -i 's/LUCI_DEPENDS.*/LUCI_DEPENDS:=\@\(arm\|\|aarch64\)/g' package/lean/luci-app-cpufreq/Makefile

#replace coremark.sh with the new one
cp -f $GITHUB_WORKSPACE/general/coremark.sh feeds/packages/utils/coremark/

./scripts/feeds update -a
./scripts/feeds install -a

#================================================================================================
