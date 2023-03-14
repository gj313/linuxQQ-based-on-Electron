#! /bin/bash

pkgname=linuxqq
pkgver=3.1.0_9572
pkgrel=2
pkgdir=linuxqq

# download linuxqq

if [ ! -f linuxqq_3.1.0-9572_amd64.deb ]; then
wget https://dldir1.qq.com/qqfile/qq/QQNT/4b2e3220/linuxqq_3.1.0-9572_amd64.deb
fi

ar -x linuxqq_3.1.0-9572_amd64.deb

echo "  -> Extracting the data.tar.xz..."
if [ -d ${pkgdir} ]; then
rm -rf ${pkgdir}
fi
mkdir -p ${pkgdir}
tar -xvf data.tar.xz -C "${pkgdir}/"

echo "  -> Installing..."
# Launcher
install -d "${pkgdir}/usr/bin/"
sudo cp -r ${pkgdir}/usr/* /usr/
sudo cp -r ${pkgdir}/opt/* /opt/
sudo ln -s "/opt/QQ/qq" "/usr/bin/${pkgname}"

# Launcher Fix
sudo sed -i '3s!/opt/QQ/qq!linuxqq!' "/usr/share/applications/qq.desktop"

# Icon Fix
sudo sed -i '6s!/usr/share/icons/hicolor/512x512/apps/qq.png!qq!' "/usr/share/applications/qq.desktop"

# License
sudo install -Dm644 "/opt/QQ/LICENSE.electron.txt" -t "/usr/share/licenses/${pkgname}/"
sudo install -Dm644 "/opt/QQ/LICENSES.chromium.html" -t "/usr/share/licenses/${pkgname}/"

# Temporary Solution: Remove libvips which comes from package "linuxqq" itself
sudo rm -f "/opt/QQ/resources/app/sharp-lib/libvips-cpp.so.42"

rm -rf ${pkgdir}
