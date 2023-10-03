DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone https://gitlab.gnome.org/GNOME/mutter -b 45.0
cp -rvf ./debian ./mutter
cd ./mutter
for i in $(cat ../patches/series) ; do echo "Applying Patch: $i" && patch -Np1 -i ../patches/$i || echo "Applying Patch $i Failed!"; done

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
